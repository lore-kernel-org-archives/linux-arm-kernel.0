From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Wed, 6 Apr 2016 10:11:40 +0200
Subject: [PATCH 2/2] PCI: imx6: Add reset-gpio-active-high boolean
 property to DT
In-Reply-To: <CAOMZO5AnN4_RrA4bksWNmioAP1PCBT1Ax4of_OnoCvG+VXgDUQ@mail.gmail.com>
References: <1459514508-8557-1-git-send-email-ynezz@true.cz>
 <1459514508-8557-3-git-send-email-ynezz@true.cz>
 <CAOMZO5AnN4_RrA4bksWNmioAP1PCBT1Ax4of_OnoCvG+VXgDUQ@mail.gmail.com>
Message-ID: <20160406081140.GR20367@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <festevam@gmail.com> [2016-04-05 12:46:53]:

> > @@ -546,9 +549,14 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
> >
> >         /* Fetch GPIOs */
> >         imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> > +       imx6_pcie->gpio_active_high = of_property_read_bool(np,
> > +                                               "reset-gpio-active-high");
> 
> You need to document reset-gpio-active-high property in
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt.

Is something like this fine?

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 3be80c6..23ecb47 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -19,6 +19,11 @@ Optional properties:
 - fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
 - fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
 - fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
+- reset-gpio: Should specify the GPIO for PHY reset. Its not polarity aware
+  and defaults to active-low reset sequence (L=reset state, H=operation state).
+- reset-gpio-active-high: If present then the reset sequence using the GPIO
+  specified in the "reset-gpio" property is reversed (H=reset state,
+  L=operation state).

-- ynezz
