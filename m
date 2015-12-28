From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 29 Dec 2015 00:45:51 +0100 (CET)
Subject: usb: wrong compatible string for MX23?
Message-ID: <671962377.218806.94ae5d1c-a34e-4695-a401-70265736fafb.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

i was inspired by the discussion about the USB runtime suspend issue on MX28. I
think i've found another issue.
In the dtsi for the MX23 the usb node has the following compatible:

usb0: usb at 80080000 {
        compatible = "fsl,imx23-usb", "fsl,imx27-usb";
...

But in ci_hdrc_imx.c there is only "fsl,imx27-usb" and "fsl,imx28-usb" defined.

So in case of a MX23 board it would fallback to "fsl,imx27-usb", which is IMHO
not correct.

Which way to fix this issue would you suggest:

a) extend ci_hdrc_imx.c and the binding by copying the imx28 platform and name
it imx23

b) rename the compatible string from "fsl,imx23-usb" to "fsl-imx28-usb"

Best regards
Stefan
