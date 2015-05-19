From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 15:43:14 +0800
Subject: [PATCH v2] arm, imx6, dts: add DT for aristainetos2 board
In-Reply-To: <555AE192.8010700@denx.de>
References: <1431334974-27531-1-git-send-email-hs@denx.de>
 <20150518113135.GD1071@dragon> <555AE192.8010700@denx.de>
Message-ID: <20150519074314.GT1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 09:09:06AM +0200, Heiko Schocher wrote:
> >>@@ -0,0 +1,124 @@
> >>+/*
> >>+ * support fot the imx6 based aristainetos2 board
> >>+ *
> >>+ * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or modify
> >>+ * it under the terms of the GNU General Public License version 2 as
> >>+ * published by the Free Software Foundation.
> >>+ *
> >>+ */
> >
> >GPL/X11 dual licence is suggested for new DTS files.  See
> >arch/arm/boot/dts/imx6sl-warp.dts for an example.
> 
> Ok, I ask the customer, if this is OK for him ...

The dual license get non-Linux users be able to use the DTS file.

[...]

> >>+&i2c3 {
> >>+	atmel: atmel_mxt_ts at 4b {
> >
> >Node name should be generic.
> 
> So, what name do you prefer?

The node name with the example in bindings doc
Documentation/devicetree/bindings/input/atmel,maxtouch.txt seems
perfectly fine to me.

[...]

> >>+&i2c3 {
> >>+	atmel: atmel_mxt_ts at 4d {
> >>+		compatible = "atmel,maxtouch";
> >>+		reg = <0x4d>;
> >>+		interrupt-parent = <&gpio2>;
> >>+		interrupts = <9 8>;
> >>+	};
> >
> >It seems the touch device is identical between
> >imx6dl-aristainetos2_4.dts and imx6dl-aristainetos2_7.dts.  Why don't
> >you put it into imx6qdl-aristainetos2.dtsi?
> 
> They have different i2c addresses ...

Okay, I missed that.

Shawn
