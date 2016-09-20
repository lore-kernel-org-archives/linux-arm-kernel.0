From: ladis@linux-mips.org (Ladislav Michl)
Date: Tue, 20 Sep 2016 14:15:21 +0200
Subject: [PATCH] ARM: dts: Add power button support for igepv5
In-Reply-To: <20160919230826.aubqvj2km4wg6gz7@atomide.com>
References: <20160909210729.20184-1-tony@atomide.com>
 <31409234-3185-5348-2d37-effb7769c92a@osg.samsung.com>
 <CAMVEqEkKrw2eH3L6+te5MZLqxBT2jUiRO-KNuS+9nuNYvihCRA@mail.gmail.com>
 <20160919230826.aubqvj2km4wg6gz7@atomide.com>
Message-ID: <20160920121521.GA32519@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 04:08:26PM -0700, Tony Lindgren wrote:
> * Pau Pajuel <ppajuel@gmail.com> [160919 01:13]:
> > Hello Tony,
> > 
> > 2016-09-14 3:26 GMT+02:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> > > Hello Tony,
> > >
> > > On 09/09/2016 05:07 PM, Tony Lindgren wrote:
> > >> Add power button support for igepv5.
> > >>
> > >> Cc: Agust? Fontquerni i Gorchs <afontquerni@iseebcn.com>
> > >> Cc: Enric Balletbo Serra <eballetbo@gmail.com>
> > >> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > >> Cc: Pau Pajuel <ppajuel@gmail.com>
> > >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >> ---
> > >
> > > I don't have a schematics for this board, but the patch looks good to me.
> > Patch has an errata. Power button is GPIO_ACTIVE_LOW instead GPIO_ACTIVE_HIGH.
> 
> Oops sorry about that, here's an incremental fix.

And here's another nitpick ;-)

8< -----------------------
>From 209f676512b5265ab4e9b4efa5a44c281ec2fc71 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Tue, 20 Sep 2016 14:09:03 +0200
Subject: [PATCH 2/2] ARM: omap5-igep0050.dts: Use tabs for indentation

Cc: Agust? Fontquerni i Gorchs <afontquerni@iseebcn.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Pau Pajuel <ppajuel@gmail.com>
Fixes: b118c6a6ffa1 ("ARM: dts: Add power button support for igepv5")
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 arch/arm/boot/dts/omap5-igep0050.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
index 139c8f7..44be08a 100644
--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -20,7 +20,7 @@
 	};
 
 	gpio_keys {
-                compatible = "gpio-keys";
+		compatible = "gpio-keys";
 		pinctrl-0 = <&power_button_pin>;
 		pinctrl-names = "default";
 
-- 
2.1.4
