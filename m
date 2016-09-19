From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Sep 2016 16:08:26 -0700
Subject: [PATCH] ARM: dts: Add power button support for igepv5
In-Reply-To: <CAMVEqEkKrw2eH3L6+te5MZLqxBT2jUiRO-KNuS+9nuNYvihCRA@mail.gmail.com>
References: <20160909210729.20184-1-tony@atomide.com>
 <31409234-3185-5348-2d37-effb7769c92a@osg.samsung.com>
 <CAMVEqEkKrw2eH3L6+te5MZLqxBT2jUiRO-KNuS+9nuNYvihCRA@mail.gmail.com>
Message-ID: <20160919230826.aubqvj2km4wg6gz7@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pau Pajuel <ppajuel@gmail.com> [160919 01:13]:
> Hello Tony,
> 
> 2016-09-14 3:26 GMT+02:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> > Hello Tony,
> >
> > On 09/09/2016 05:07 PM, Tony Lindgren wrote:
> >> Add power button support for igepv5.
> >>
> >> Cc: Agust? Fontquerni i Gorchs <afontquerni@iseebcn.com>
> >> Cc: Enric Balletbo Serra <eballetbo@gmail.com>
> >> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> >> Cc: Pau Pajuel <ppajuel@gmail.com>
> >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> ---
> >
> > I don't have a schematics for this board, but the patch looks good to me.
> Patch has an errata. Power button is GPIO_ACTIVE_LOW instead GPIO_ACTIVE_HIGH.

Oops sorry about that, here's an incremental fix.

Regards,

Tony

8< -----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 19 Sep 2016 16:02:12 -0700
Subject: [PATCH] ARM: dts: Fix igepv5 power button GPIO direction
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It should be GPIO_ACTIVE_LOW instead of GPIO_ACTIVE_HIGH as
pointed out by Pau Pajuel <ppajuel@gmail.com>.

Cc: Agust? Fontquerni i Gorchs <afontquerni@iseebcn.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Pau Pajuel <ppajuel@gmail.com>
Fixes: b118c6a6ffa1 ("ARM: dts: Add power button support for igepv5")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-igep0050.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -27,7 +27,7 @@
 		power-button {
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
-			gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-- 
2.9.3
