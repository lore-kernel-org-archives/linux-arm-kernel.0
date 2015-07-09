From: weigelt@melag.de (Enrico Weigelt, metux IT consult)
Date: Thu, 9 Jul 2015 19:02:20 +0200
Subject: [PATCH 0/6] mmc: sdhci-esdhci-imx: fix cd/wp regression
In-Reply-To: <20150709132736.GG23464@tiger>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
 <20150709075032.GD23464@tiger>
 <20150709092949.GB3917@shlinux1.ap.freescale.net>
 <20150709132736.GG23464@tiger>
Message-ID: <559EA91C.6010408@melag.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.07.2015 um 15:27 schrieb Shawn Guo:

 > Oh, crap!  I thought it's been there with only v4.2-rc1, and did not
> know v4.1 is already broken.  In that case, reverting 8d86e4f isn't
> the best option.  I suggest you rebase the dts series on top of
> v4.2-rc1, and send it via mmc tree.

Yeah, I already stumbled across that. Fortunately, I dont need it at
all, so I just removed it from dts:


diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi
b/arch/arm/boot/dts/imx53-tqma53.dtsi
index 2dea6dc..3c545e3 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -41,7 +41,6 @@
         pinctrl-0 = <&pinctrl_esdhc2>,
                     <&pinctrl_esdhc2_cdwp>;
         vmmc-supply = <&reg_3p3v>;
-       wp-gpios = <&gpio1 2 0>;
         cd-gpios = <&gpio1 4 0>;
         status = "disabled";
  };


--mtx

https://www.facebook.com/MELAG.Medizintechnik

[http://www.melag.de/fbbanner.png]<https://www.facebook.com/MELAG.Medizintechnik>

MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f?r einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschlie?lich f?r denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d?rfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt?mlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte l?schen Sie in diesem Fall diese Nachricht und alle Anh?nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
