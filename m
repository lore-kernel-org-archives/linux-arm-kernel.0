From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Dec 2014 10:50:40 +0000
Subject: [PATCH] ARM: display machine model in cpuinfo
In-Reply-To: <20141215104548.GB462@leverpostej>
References: <1418566387-16468-1-git-send-email-zajec5@gmail.com>
 <20141215104548.GB462@leverpostej>
Message-ID: <20141215105040.GF11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 10:45:48AM +0000, Mark Rutland wrote:
> On Sun, Dec 14, 2014 at 02:13:07PM +0000, Rafa? Mi?ecki wrote:
> > This may be useful to display hardware model in the /proc/cpuinfo. It
> > definitely helps to identify the device and there are some archs already
> > doing that (arm64, m32r, mips).
> 
> Not true for arm64, if you look in linux-next.
> 
> I'm rather wary of exposing this kind via cpuinfo because it's
> completely arbitrary in nature and not guaranteed to be in any way
> useful (I have seen dtbs where the model string is misleading due to
> copy+paste and no modificiation).

I wonder what's wrong with reading it from
/sys/firmware/devicetree/base/model if that exists, if not falling back
to reading it from /proc/cpuinfo.

Even better of course to use /sys/firmware/devicetree/base/compatible

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
