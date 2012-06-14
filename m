From: marex@denx.de (Marek Vasut)
Date: Thu, 14 Jun 2012 03:34:05 +0200
Subject: MXS getting AUART to work with DT.
In-Reply-To: <4FD7EFFC.8010204@grid-net.com>
References: <4FD7EFFC.8010204@grid-net.com>
Message-ID: <201206140334.06092.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Subodh Nijsure,

> Hi,
> 
> I am testing my mx28 hardware with arm-soc/for-next branch. I have made
> additions shown below to my dt file.
> 
> What I see is only ttyAPP0 device gets created but not the ttyAPP1, do
> folks who know DT much better than I, see any issues with this DT
> definition below?

Last time I checked, it wasn't that easy to get AUART flipped over to DT. Did 
someone do that already?

> 
> auart0_pins_a: auart0 at 0 {
>          reg = <0>;
>          fsl,pinmux-ids = <0x3000 0x3010 0x3020 0x3030>;
>          fsl,drive-strength = <0>;
>          fsl,voltage = <1>;
>          fsl,pull-up = <0>;
> };
> auart1_pins_a: auart1 at 0 {
>          reg = <0>;
>          fsl,pinmux-ids = <0x3040 0x3050>;
>          fsl,drive-strength = <0>;
>          fsl,voltage = <1>;
>          fsl,pull-up = <0>;
> };
> auart0: serial at 8006a000 {
>           pinctrl-names = "default";
>           pinctrl-0 = <&auart0_pins_a>;
>           status = "okay";
> };
> auart1: serial at 8006c000 {
>            pinctrl-names = "default";
>            pinctrl-0 = <&auart1_pins_a>;
>            status = "okay";
>   };
> 
> -Subodh

Best regards,
Marek Vasut
