From: catalin.crenguta@gmail.com (Catalin Crenguta)
Date: Mon, 16 Nov 2015 11:43:43 +0200
Subject: Freescale IMX6 active cooling
Message-ID: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm trying to use a GPIO Fan to cool down a Riotboard (I.MX6 Solo).
I've read [0], investigated the driver which provides the on-die
temperature ( fsl,imx6q-tempmon [1]) but it seems to provide the
temperature by creating a thermal zone (relevant dts: [2][3][4]).
I don't know how I should proceed:
1) Should I research how can I attach a cooling device to this already
existing thermal zone? (I believe it involves modifying the existing
driver by adding new device tree handles)
2) Should I create another thermal zone, use the existing driver to
get the temperature and bind to a cooling device?
3) Should I modify the existing driver to not create a thermal zone
and move the creation in the device tree using the of-thermal driver ?

Best regards,
Catalin Crenguta

[0] http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/thermal/thermal.txt
[1] http://lxr.free-electrons.com/source/drivers/thermal/imx_thermal.c
[2] http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx6dl-riotboard.dts
[3] http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx6dl.dtsi
[4] http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx6qdl.dtsi
