Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AE5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:08:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9549B218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UhsQDi03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9549B218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l+KwVfKuhxqXsUvK4RFT2i0m2Q16rN0J9SW88SOGOt4=; b=UhsQDi03WlPsRG
	aqkcK4WZ6cwcRpNr2LOnXFFT32qxciAqzAiww3suvMBi7eCWT7ltaZ3Y42oVbNZ80A3DAgAK+krV7
	hnJTxb9bfvBGYOt8NTULvFrjG3VqHIu8Qu0bQcmV4WCFbmscp1nE5drtW5nWwC4cg5AIem7RCs7yV
	ZDod2gBZ1ZwY3FzwOBfdGSb0ufwm6RIT8iL12tVuI7WcRNMeARn6GvMWdXBLU9m0e91+r9THRiJi1
	IEoczRxCzHtA1X9crYeVsD5duvrJCr6PcpnEYr1LkcwxAPyMTxMXj4dPGSEig9imvuUvIWH9+jzUG
	fWiqpOEIz/8mcuQ56Cig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grGO0-0004Q1-Dl; Wed, 06 Feb 2019 06:08:40 +0000
Received: from relay1.mentorg.com ([192.94.38.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grGNu-0004Pb-VI
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 06:08:37 +0000
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=svr-ies-mbx-02.mgc.mentorg.com)
 by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
 id 1grGNo-0000sA-2y from Akash_Gajjar@mentor.com ;
 Tue, 05 Feb 2019 22:08:28 -0800
Received: from SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) by
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 6 Feb 2019 06:08:24 +0000
Received: from SVR-IES-MBX-04.mgc.mentorg.com ([fe80::9dd6:2f1c:ad6:d35f]) by
 SVR-IES-MBX-04.mgc.mentorg.com ([fe80::9dd6:2f1c:ad6:d35f%22]) with
 mapi id 15.00.1320.000; Wed, 6 Feb 2019 06:08:24 +0000
From: "Gajjar, Akash" <Akash_Gajjar@mentor.com>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, "Patel, Pragnesh"
 <Pragnesh_Patel@mentor.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: add ROCK Pi 4 DTS support
Thread-Topic: [PATCH v2] arm64: dts: rockchip: add ROCK Pi 4 DTS support
Thread-Index: AQHUpXoUlO0w9mrTYEOKGRvjCFWw06XR5weAgACPxaI=
Date: Wed, 6 Feb 2019 06:08:24 +0000
Message-ID: <1549433303774.70355@mentor.com>
References: <20190106044030.1484-1-Pragnesh_Patel@mentor.com>,
 <CAAEAJfCgFV+wbBM6ER=at8q1t+6AXbvS9NbQLPRw8sJOfMgC2Q@mail.gmail.com>
In-Reply-To: <CAAEAJfCgFV+wbBM6ER=at8q1t+6AXbvS9NbQLPRw8sJOfMgC2Q@mail.gmail.com>
Accept-Language: en-US, en-IE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_220835_054996_44FADBE1 
X-CRM114-Status: GOOD (  17.51  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Tom Cubie <mr.hipboi@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ezequiel,

Yes, we have plan to add Rock Pi4 board support in u-boot mainline. =

But Core bits which has to come from the SoC vendor. Community can work on =
rest of the peripherals. =

You can access LPDDR4 drivers and timing parameters from kever yang's githu=
b repo.
https://github.com/keveryang/u-boot/tree/rockchip =


Regards,
Akash Gajjar

________________________________________
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Sent: Wednesday, February 6, 2019 2:53 AM
To: Patel, Pragnesh; Gajjar, Akash
Cc: Heiko Stuebner; Enric Balletbo i Serra; linux-arm-kernel; Manivannan Sa=
dhasivam; Tom Cubie
Subject: Re: [PATCH v2] arm64: dts: rockchip: add ROCK Pi 4 DTS support

Hello Pragnesh and Akash,

Thanks for your work on this board!

Do you plan to add U-Boot support as well?

Thanks again,
Eze

On Sun, 6 Jan 2019 at 01:42, <Pragnesh_Patel@mentor.com> wrote:
>
> From: Akash Gajjar <Akash_Gajjar@mentor.com>
>
> ROCK Pi 4 is RK3399 based SBC from radxa.com. board has a 1G/2G/4G lpddr4=
, CSI,
> DSI, HDMI, OTG, USB 2.0, USB 3.0, 10/100/1000 RGMII Ethernet Phy, es8316 =
codec,
> POE, WIFI (for Model B only), PCIE M.2 support on board.
>
> This patch enables
> - HDMI Display
> - Console
> - MMC, EMMC
> - USB 2.0, USB-3.0
> - Ethernet
>
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> Signed-off-by: Pragnesh Patel <Pragnesh_Patel@mentor.com>
> ---
> changes in v2
> - hdmi regulator name correction
> - replace gpio pin number with appropriate macro
>
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-rock-pi-4.dts    | 606 ++++++++++++++++++
>  3 files changed, 612 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
>
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docume=
ntation/devicetree/bindings/arm/rockchip.yaml
> index b12958bda09c..b45296e1c20e 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -317,6 +317,11 @@ properties:
>            - const: radxa,rock
>            - const: rockchip,rk3188
>
> +      - description: Radxa ROCK Pi 4
> +        items:
> +          - const: radxa,rockpi4
> +          - const: rockchip,rk3399
> +
>        - description: Radxa Rock2 Square
>          items:
>            - const: radxa,rock2-square
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/=
rockchip/Makefile
> index de0c406c20cc..3fab0a3e4eeb 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-gru-scarlet-inx=
.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-gru-scarlet-kd.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-puma-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-roc-pc.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-rock-pi-4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-rock960.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-rockpro64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-sapphire.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm=
64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> new file mode 100644
> index 000000000000..8a8006d49c97
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> @@ -0,0 +1,606 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
> + * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +       model =3D "Radxa ROCK Pi 4";
> +       compatible =3D "radxa,rockpi4", "rockchip,rk3399";
> +
> +       chosen {
> +               stdout-path =3D "serial2:1500000n8";
> +       };
> +
> +       clkin_gmac: external-gmac-clock {
> +               compatible =3D "fixed-clock";
> +               clock-frequency =3D <125000000>;
> +               clock-output-names =3D "clkin_gmac";
> +               #clock-cells =3D <0>;
> +       };
> +
> +       vcc12v_dcin: dc-12v {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc12v_dcin";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <12000000>;
> +               regulator-max-microvolt =3D <12000000>;
> +       };
> +
> +       vcc5v0_sys: vcc-sys {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc5v0_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               vin-supply =3D <&vcc12v_dcin>;
> +       };
> +
> +       vcc3v3_pcie: vcc3v3-pcie-regulator {
> +               compatible =3D "regulator-fixed";
> +               enable-active-high;
> +               gpio =3D <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pcie_pwr_en>;
> +               regulator-name =3D "vcc3v3_pcie";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               vin-supply =3D <&vcc5v0_sys>;
> +       };
> +
> +       vcc3v3_sys: vcc3v3-sys {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc3v3_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               vin-supply =3D <&vcc5v0_sys>;
> +       };
> +
> +       vcc5v0_host: vcc5v0-host-regulator {
> +               compatible =3D "regulator-fixed";
> +               gpio =3D <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&vcc5v0_host_en>;
> +               regulator-name =3D "vcc5v0_host";
> +               regulator-always-on;
> +               enable-active-high;
> +               vin-supply =3D <&vcc5v0_sys>;
> +       };
> +
> +       vcc5v0_typec: vcc5v0-typec-regulator {
> +               compatible =3D "regulator-fixed";
> +               enable-active-high;
> +               gpio =3D <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&vcc5v0_typec_en>;
> +               regulator-name =3D "vcc5v0_typec";
> +               regulator-always-on;
> +               vin-supply =3D <&vcc5v0_sys>;
> +       };
> +
> +       vcc_lan: vcc3v3-phy-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc_lan";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +
> +       vdd_log: vdd-log {
> +               compatible =3D "pwm-regulator";
> +               pwms =3D <&pwm2 0 25000 1>;
> +               regulator-name =3D "vdd_log";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <800000>;
> +               regulator-max-microvolt =3D <1400000>;
> +               vin-supply =3D <&vcc5v0_sys>;
> +       };
> +};
> +
> +&cpu_l0 {
> +       cpu-supply =3D <&vdd_cpu_l>;
> +};
> +
> +&cpu_l1 {
> +       cpu-supply =3D <&vdd_cpu_l>;
> +};
> +
> +&cpu_l2 {
> +       cpu-supply =3D <&vdd_cpu_l>;
> +};
> +
> +&cpu_l3 {
> +       cpu-supply =3D <&vdd_cpu_l>;
> +};
> +
> +&cpu_b0 {
> +       cpu-supply =3D <&vdd_cpu_b>;
> +};
> +
> +&cpu_b1 {
> +       cpu-supply =3D <&vdd_cpu_b>;
> +};
> +
> +&emmc_phy {
> +       status =3D "okay";
> +};
> +
> +&gmac {
> +       assigned-clocks =3D <&cru SCLK_RMII_SRC>;
> +       assigned-clock-parents =3D <&clkin_gmac>;
> +       clock_in_out =3D "input";
> +       phy-supply =3D <&vcc_lan>;
> +       phy-mode =3D "rgmii";
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&rgmii_pins>;
> +       snps,reset-gpio =3D <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +       snps,reset-active-low;
> +       snps,reset-delays-us =3D <0 10000 50000>;
> +       tx_delay =3D <0x28>;
> +       rx_delay =3D <0x11>;
> +       status =3D "okay";
> +};
> +
> +&hdmi {
> +       status =3D "okay";
> +
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&hdmi_cec>;
> +};
> +
> +&i2c0 {
> +       clock-frequency =3D <400000>;
> +       i2c-scl-rising-time-ns =3D <168>;
> +       i2c-scl-falling-time-ns =3D <4>;
> +       status =3D "okay";
> +
> +       rk808: pmic@1b {
> +               compatible =3D "rockchip,rk808";
> +               reg =3D <0x1b>;
> +               interrupt-parent =3D <&gpio1>;
> +               interrupts =3D <21 IRQ_TYPE_LEVEL_LOW>;
> +               #clock-cells =3D <1>;
> +               clock-output-names =3D "xin32k", "rk808-clkout2";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pmic_int_l>;
> +               rockchip,system-power-controller;
> +               wakeup-source;
> +
> +               vcc1-supply =3D <&vcc5v0_sys>;
> +               vcc2-supply =3D <&vcc5v0_sys>;
> +               vcc3-supply =3D <&vcc5v0_sys>;
> +               vcc4-supply =3D <&vcc5v0_sys>;
> +               vcc6-supply =3D <&vcc5v0_sys>;
> +               vcc7-supply =3D <&vcc5v0_sys>;
> +               vcc8-supply =3D <&vcc3v3_sys>;
> +               vcc9-supply =3D <&vcc5v0_sys>;
> +               vcc10-supply =3D <&vcc5v0_sys>;
> +               vcc11-supply =3D <&vcc5v0_sys>;
> +               vcc12-supply =3D <&vcc3v3_sys>;
> +               vddio-supply =3D <&vcc_1v8>;
> +
> +               regulators {
> +                       vdd_center: DCDC_REG1 {
> +                               regulator-name =3D "vdd_center";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <750000>;
> +                               regulator-max-microvolt =3D <1350000>;
> +                               regulator-ramp-delay =3D <6001>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_cpu_l: DCDC_REG2 {
> +                               regulator-name =3D "vdd_cpu_l";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <750000>;
> +                               regulator-max-microvolt =3D <1350000>;
> +                               regulator-ramp-delay =3D <6001>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_ddr: DCDC_REG3 {
> +                               regulator-name =3D "vcc_ddr";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8: DCDC_REG4 {
> +                               regulator-name =3D "vcc_1v8";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1800000>;
> +                               };
> +                       };
> +
> +                       vcc1v8_codec: LDO_REG1 {
> +                               regulator-name =3D "vcc1v8_codec";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc1v8_hdmi: LDO_REG2 {
> +                               regulator-name =3D "vcc1v8_hdmi";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcca_1v8: LDO_REG3 {
> +                               regulator-name =3D "vcca_1v8";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1800000>;
> +                               };
> +                       };
> +
> +                       vcc_sdio: LDO_REG4 {
> +                               regulator-name =3D "vcc_sdio";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3000000>;
> +                               regulator-max-microvolt =3D <3000000>;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
3000000>;
> +                               };
> +                       };
> +
> +                       vcca3v0_codec: LDO_REG5 {
> +                               regulator-name =3D "vcca3v0_codec";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3000000>;
> +                               regulator-max-microvolt =3D <3000000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v5: LDO_REG6 {
> +                               regulator-name =3D "vcc_1v5";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1500000>;
> +                               regulator-max-microvolt =3D <1500000>;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1500000>;
> +                               };
> +                       };
> +
> +                       vcc0v9_hdmi: LDO_REG7 {
> +                               regulator-name =3D "vcc0v9_hdmi";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <900000>;
> +                               regulator-max-microvolt =3D <900000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_3v0: LDO_REG8 {
> +                               regulator-name =3D "vcc_3v0";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3000000>;
> +                               regulator-max-microvolt =3D <3000000>;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
3000000>;
> +                               };
> +                       };
> +
> +                       vcc_cam: SWITCH_REG1 {
> +                               regulator-name =3D "vcc_cam";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_mipi: SWITCH_REG2 {
> +                               regulator-name =3D "vcc_mipi";
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       vdd_cpu_b: regulator@40 {
> +               compatible =3D "silergy,syr827";
> +               reg =3D <0x40>;
> +               fcs,suspend-voltage-selector =3D <1>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&vsel1_gpio>;
> +               regulator-name =3D "vdd_cpu_b";
> +               regulator-min-microvolt =3D <712500>;
> +               regulator-max-microvolt =3D <1500000>;
> +               regulator-ramp-delay =3D <1000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +               vin-supply =3D <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +
> +       vdd_gpu: regulator@41 {
> +               compatible =3D "silergy,syr828";
> +               reg =3D <0x41>;
> +               fcs,suspend-voltage-selector =3D <1>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&vsel2_gpio>;
> +               regulator-name =3D "vdd_gpu";
> +               regulator-min-microvolt =3D <712500>;
> +               regulator-max-microvolt =3D <1500000>;
> +               regulator-ramp-delay =3D <1000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +               vin-supply =3D <&vcc5v0_sys>;
> +
> +               regulator-state-mem {
> +                       regulator-off-in-suspend;
> +               };
> +       };
> +};
> +
> +&i2c1 {
> +       i2c-scl-rising-time-ns =3D <300>;
> +       i2c-scl-falling-time-ns =3D <15>;
> +       status =3D "okay";
> +};
> +
> +&i2c3 {
> +       i2c-scl-rising-time-ns =3D <450>;
> +       i2c-scl-falling-time-ns =3D <15>;
> +       status =3D "okay";
> +};
> +
> +&i2c4 {
> +       i2c-scl-rising-time-ns =3D <600>;
> +       i2c-scl-falling-time-ns =3D <20>;
> +       status =3D "okay";
> +};
> +
> +&i2s0 {
> +       rockchip,playback-channels =3D <8>;
> +       rockchip,capture-channels =3D <8>;
> +       status =3D "okay";
> +};
> +
> +&i2s1 {
> +       rockchip,playback-channels =3D <2>;
> +       rockchip,capture-channels =3D <2>;
> +       status =3D "okay";
> +};
> +
> +&i2s2 {
> +       status =3D "okay";
> +};
> +
> +&io_domains {
> +       status =3D "okay";
> +
> +       bt656-supply =3D <&vcc_3v0>;
> +       audio-supply =3D <&vcc_3v0>;
> +       sdmmc-supply =3D <&vcc_sdio>;
> +       gpio1830-supply =3D <&vcc_3v0>;
> +};
> +
> +&pmu_io_domains {
> +       status =3D "okay";
> +
> +       pmu1830-supply =3D <&vcc_3v0>;
> +};
> +
> +&pinctrl {
> +       pcie {
> +               pcie_pwr_en: pcie-pwr-en {
> +                       rockchip,pins =3D <2 RK_PD2 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> +               };
> +       };
> +
> +       pmic {
> +               pmic_int_l: pmic-int-l {
> +                       rockchip,pins =3D <1 RK_PC5 RK_FUNC_GPIO &pcfg_pu=
ll_up>;
> +               };
> +
> +               vsel1_gpio: vsel1-gpio {
> +                       rockchip,pins =3D <1 RK_PC1 RK_FUNC_GPIO &pcfg_pu=
ll_down>;
> +               };
> +
> +               vsel2_gpio: vsel2-gpio {
> +                       rockchip,pins =3D <1 RK_PB6 RK_FUNC_GPIO &pcfg_pu=
ll_down>;
> +               };
> +       };
> +
> +       usb-typec {
> +               vcc5v0_typec_en: vcc5v0-typec-en {
> +                       rockchip,pins =3D <1 RK_PA3 RK_FUNC_GPIO &pcfg_pu=
ll_up>;
> +               };
> +       };
> +
> +       usb2 {
> +               vcc5v0_host_en: vcc5v0-host-en {
> +                       rockchip,pins =3D <4 RK_PD1 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> +               };
> +       };
> +};
> +
> +&pwm2 {
> +       status =3D "okay";
> +};
> +
> +&saradc {
> +       status =3D "okay";
> +
> +       vref-supply =3D <&vcc_1v8>;
> +};
> +
> +&sdmmc {
> +       bus-width =3D <4>;
> +       cap-mmc-highspeed;
> +       cap-sd-highspeed;
> +       cd-gpios =3D <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> +       disable-wp;
> +       max-frequency =3D <150000000>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&sdmmc_clk &sdmmc_cd &sdmmc_cmd &sdmmc_bus4>;
> +       status =3D "okay";
> +};
> +
> +&sdhci {
> +       bus-width =3D <8>;
> +       mmc-hs400-1_8v;
> +       mmc-hs400-enhanced-strobe;
> +       non-removable;
> +       status =3D "okay";
> +};
> +
> +&tcphy0 {
> +       status =3D "okay";
> +};
> +
> +&tcphy1 {
> +       status =3D "okay";
> +};
> +
> +&tsadc {
> +       status =3D "okay";
> +
> +       /* tshut mode 0:CRU 1:GPIO */
> +       rockchip,hw-tshut-mode =3D <1>;
> +       /* tshut polarity 0:LOW 1:HIGH */
> +       rockchip,hw-tshut-polarity =3D <1>;
> +};
> +
> +&u2phy0 {
> +       status =3D "okay";
> +
> +       u2phy0_otg: otg-port {
> +               status =3D "okay";
> +       };
> +
> +       u2phy0_host: host-port {
> +               phy-supply =3D <&vcc5v0_host>;
> +               status =3D "okay";
> +       };
> +};
> +
> +&u2phy1 {
> +       status =3D "okay";
> +
> +       u2phy1_otg: otg-port {
> +               status =3D "okay";
> +       };
> +
> +       u2phy1_host: host-port {
> +               phy-supply =3D <&vcc5v0_host>;
> +               status =3D "okay";
> +       };
> +};
> +
> +&uart2 {
> +       status =3D "okay";
> +};
> +
> +&usb_host0_ehci {
> +       status =3D "okay";
> +};
> +
> +&usb_host0_ohci {
> +       status =3D "okay";
> +};
> +
> +&usb_host1_ehci {
> +       status =3D "okay";
> +};
> +
> +&usb_host1_ohci {
> +       status =3D "okay";
> +};
> +
> +&usbdrd3_0 {
> +       status =3D "okay";
> +};
> +
> +&usbdrd_dwc3_0 {
> +       status =3D "okay";
> +       dr_mode =3D "otg";
> +};
> +
> +&usbdrd3_1 {
> +       status =3D "okay";
> +};
> +
> +&usbdrd_dwc3_1 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +};
> +
> +&vopb {
> +       status =3D "okay";
> +};
> +
> +&vopb_mmu {
> +       status =3D "okay";
> +};
> +
> +&vopl {
> +       status =3D "okay";
> +};
> +
> +&vopl_mmu {
> +       status =3D "okay";
> +};
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--
Ezequiel Garc=EDa, VanguardiaSur
www.vanguardiasur.com.ar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
