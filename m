From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Apr 2018 15:02:01 +0100
Subject: [PATCH] ARM: Assume maintainership of ARM reference designs
In-Reply-To: <CACRpkdaL13zAOa1YQuWx+Y=2jCT6NfB60g_Dxg5mVp7NebY_Yw@mail.gmail.com>
References: <20180412131426.18011-1-linus.walleij@linaro.org>
 <20180412131737.GF16141@n2100.armlinux.org.uk>
 <20180412131845.GG16141@n2100.armlinux.org.uk>
 <CACRpkdaKc28xe1_iBd07qRsGig_yc0Kfm+ZRj8+t+Wd32uMK7w@mail.gmail.com>
 <20180412135201.GH16141@n2100.armlinux.org.uk>
 <CACRpkdaL13zAOa1YQuWx+Y=2jCT6NfB60g_Dxg5mVp7NebY_Yw@mail.gmail.com>
Message-ID: <20180412140201.GI16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 03:59:20PM +0200, Linus Walleij wrote:
> On Thu, Apr 12, 2018 at 3:52 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >  The Versatile Express
> > CT9x4 is still part of the boot farm, and just about works with
> > certain kernels, but I'm pretty sure there's a cache latency bug
> > there (I carry patches privately to fix it, but it doesn't appear to
> > completely solve it.)
> 
> So there is a bug in it! I thought it was only my board.

I'm not sure if it's a hardware bug or not...  This patch seems to
help immensely, but doesn't completely solve the problem:

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 5814460e0549..56308c1c0208 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -174,7 +174,7 @@
 		cache-unified;
 		cache-level = <2>;
 		arm,data-latency = <1 1 1>;
-		arm,tag-latency = <1 1 1>;
+		arm,tag-latency = <2 2 1>;
 	};
 
 	pmu {

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
