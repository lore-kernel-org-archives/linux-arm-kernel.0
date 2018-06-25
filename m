From: arend.vanspriel@broadcom.com (Arend van Spriel)
Date: Mon, 25 Jun 2018 09:43:51 +0200
Subject: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
In-Reply-To: <E1fX7yK-0000OC-HA@stardust.g4.wien.funkfeuer.at>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <a7011fe78d171658742406bf01d50b7e3d7eaf1d.camel@aosc.io>
 <E1fX7yK-0000OC-HA@stardust.g4.wien.funkfeuer.at>
Message-ID: <5B309D37.80207@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/24/2018 6:34 PM, Harald Geyer wrote:
> Icenowy Zheng writes:
>> >? 2018-03-15?? 16:25 +0000?Harald Geyer???
>>> > >+&mmc1 {
>>> > >+	pinctrl-names = "default";
>>> > >+	pinctrl-0 = <&mmc1_pins>;
>>> > >+	vmmc-supply = <&reg_aldo2>;
>>> > >+	vqmmc-supply = <&reg_dldo4>;
>>> > >+	mmc-pwrseq = <&wifi_pwrseq>;
>>> > >+	bus-width = <4>;
>>> > >+	non-removable;
>>> > >+	status = "okay";
>>> > >+
>>> > >+	rtl8723bs: wifi at 1 {
>>> > >+		reg = <1>;
>>> > >+		interrupt-parent = <&r_pio>;
>>> > >+		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
>>> > >+		interrupt-names = "host-wake";
>>> > >+	};

[...]

>> >- This device node has no binding. The "host-wake" interrupt is part of
>> >  Broadcom SDIO Wi-Fi binding, rather than a generic one.
> I think the general mmc and interrupts bindings apply. And the mmc binding
> clearly states that for sub-nodes a compatible string is optional.
>
> However I just realized that the 'interrupt-names' property is not part
> of the general interrupts binding, so I guess at least this property should
> be removed.

Indeed. If the device just used the SDIO interrupt this is not needed. 
The Broadcom device can use either SDIO interrupt or a so-called 
out-of-band host-wake interrupt, which is what the above represents.

Regards,
Arend
