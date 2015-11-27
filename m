From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Nov 2015 17:09:36 +0000
Subject: armv7 + lpae broken in 4.1.12+ ?
In-Reply-To: <56588CA6.50500@heeltoe.com>
References: <5657952E.906@heeltoe.com> <20151127093601.GA25781@arm.com>
 <56587CF7.9060302@heeltoe.com>
 <20151127160615.GM8644@n2100.arm.linux.org.uk>
 <56588CA6.50500@heeltoe.com>
Message-ID: <20151127170935.GN8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 12:02:30PM -0500, Brad Parker wrote:
> On 11/27/15 11:06 AM, Russell King - ARM Linux wrote:
> >Please check whether you have CONFIG_AEABI enabled.
> Yes.  That was it - sorry.  I didn't realize that was a config item (but
> with your explanation and a look at the makefile I see what it's doing).  I
> guess I was blissfully unaware that that option even existed.  But not any
> more :-)

I'm surprised, because if you try booting an OABI only kernel with an
EABI userspace, it'll hang after getting to userspace.  Ditto the
other way around, unless you have OABI_COMPAT enabled.  However, I
guess you're not getting that far yet...

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
