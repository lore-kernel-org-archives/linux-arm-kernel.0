From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Nov 2015 16:06:15 +0000
Subject: armv7 + lpae broken in 4.1.12+ ?
In-Reply-To: <56587CF7.9060302@heeltoe.com>
References: <5657952E.906@heeltoe.com> <20151127093601.GA25781@arm.com>
 <56587CF7.9060302@heeltoe.com>
Message-ID: <20151127160615.GM8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 10:55:35AM -0500, Brad Parker wrote:
> That all makes sense. I'm using a linaro toolchain (which I'll admit I
> grabbed because I was lazy)
> 
> gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/bin/arm-linux-gnueabihf-
> 
> It seems really odd.  I would have thought "gnueabihf" would be EABI, so
> a 64 bit arg should be in r2,r3; but it's not.  It's in r1, r2.
> 
> could something in my .config cause this?  (I'd be surprised if that were the case, but...).
> 
> I'm happy to try a better toolchain if you can point me to one (binary).

It doesn't matter what toolchain you have.  We don't rely on how the
toolchain happened to be configured to build the kernel, we explicitly
state to the compiler what we want it to do.

Many people tend to be under the incorrect impression that they need
specific compilers to build the kernel in certain ways.  This is untrue,
and has been untrue for the last 20 years.

If you have CONFIG_AEABI disabled, you will get an OABI kernel, or an
error from the toolchain if the toolchain doesn't support it.  If you
have CONFIG_AEABI enabled, you will get an EABI kernel, or an error
from the toolchain if the toolchain doesn't support it.

As I said in my previous reply, LPAE really ought to depend on AEABI
being enabled.

Please check whether you have CONFIG_AEABI enabled.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
