From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 27 Jul 2018 23:42:08 +0800
Subject: [PATCH v3.1 10/10] arm64: dts: allwinner: a64: Enable HDMI output
 on A64 boards w/ HDMI
In-Reply-To: <20180727140032.go6f3dwzxrzfstzj@flea>
References: <20180726171257.6688-1-icenowy@aosc.io>
 <20180726171257.6688-11-icenowy@aosc.io>
 <20180727125615.ju23ecgm6y4rz7p5@flea>
 <8DF4600E-DFE4-47CD-B541-FFDD903A65FB@aosc.io>
 <20180727140032.go6f3dwzxrzfstzj@flea>
Message-ID: <7e1dcd8796e417924072f14b2a50af73@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018-07-27 22:00?Maxime Ripard ???
> On Fri, Jul 27, 2018 at 09:26:11PM +0800, Icenowy Zheng wrote:
>> 
>> 
>> ? 2018?7?27? GMT+08:00 ??8:56:15, Maxime Ripard 
>> <maxime.ripard@bootlin.com> ??:
>> >On Fri, Jul 27, 2018 at 01:12:57AM +0800, Icenowy Zheng wrote:
>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> >b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> >> index 1b9b92e541d2..1b972bade9f6 100644
>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> >> @@ -62,6 +62,21 @@
>> >>  	chosen {
>> >>  		stdout-path = "serial0:115200n8";
>> >>  	};
>> >> +
>> >> +	connector {
>> >> +		compatible = "hdmi-connector";
>> >> +		type = "a";
>> >> +
>> >> +		port {
>> >> +			hdmi_con_in: endpoint {
>> >> +				remote-endpoint = <&hdmi_out_con>;
>> >> +			};
>> >> +		};
>> >> +	};
>> >> +};
>> >> +
>> >> +&de {
>> >> +	status = "okay";
>> >>  };
>> >>
>> >>  &ehci0 {
>> >> @@ -82,6 +97,17 @@
>> >>
>> >>  };
>> >>
>> >> +&hdmi {
>> >> +	hdmi-supply = <&reg_dldo1>;
>> >> +	status = "okay";
>> >> +};
>> >> +
>> >> +&hdmi_out {
>> >> +	hdmi_out_con: endpoint {
>> >> +		remote-endpoint = <&hdmi_con_in>;
>> >> +	};
>> >> +};
>> >> +
>> >>  &i2c1 {
>> >>  	pinctrl-names = "default";
>> >>  	pinctrl-0 = <&i2c1_pins>;
>> >> @@ -99,6 +125,10 @@
>> >>  	};
>> >>  };
>> >>
>> >> +&mixer1 {
>> >> +	status = "okay";
>> >> +};
>> >> +
>> >>  &mmc0 {
>> >>  	pinctrl-names = "default";
>> >>  	pinctrl-0 = <&mmc0_pins>;
>> >> @@ -238,6 +268,10 @@
>> >>  	status = "disabled";
>> >>  };
>> >>
>> >> +&tcon1 {
>> >> +	status = "okay";
>> >> +};
>> >
>> >Is it working or not on the pine64?
>> 
>> Not tested yet, as my main A64 device is Pine A64-LTS now.
> 
> It was last reported as broken, so it's better to leave it out of that
> patch until someone figures it out.

Sorry, I did find a bug. Although after fixing it HDMI on Pine A64+
works fine.

Will fix the bug when sending v3.2 (resending after rc1).

> 
> Thanks!
> Maxime
