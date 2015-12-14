From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 14 Dec 2015 14:56:41 +0100
Subject: [PATCH v2 13/14] ARM: dts: dove: add DT GPU support
In-Reply-To: <1450099862.3163.38.camel@pengutronix.de> (Lucas Stach's message
 of "Mon, 14 Dec 2015 14:31:02 +0100")
References: <1449661707-30532-1-git-send-email-l.stach@pengutronix.de>
 <1449661707-30532-13-git-send-email-l.stach@pengutronix.de>
 <1450099862.3163.38.camel@pengutronix.de>
Message-ID: <87twnlw2ue.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,
 
 On lun., d?c. 14 2015, Lucas Stach <l.stach@pengutronix.de> wrote:

> Dove maintainers,
>
> can you please tell me if you prefer the DT changes to go along with the
> rest of the etnaviv series through the DRM tree, or plan on picking this
> separate?

I prefer to take the DT change in the mvebu tree. I was waiting for
acknowledgment on this series from the DRM maintainers to be sure that
the binding was OK. However, the fact that Rob Herring already acked the
binding is a good point for me.

Gregory


>
> Regards,
> Lucas
>
> Am Mittwoch, den 09.12.2015, 12:48 +0100 schrieb Lucas Stach:
>> From: Russell King <rmk+kernel@arm.linux.org.uk>
>> 
>> Add DT support for the Vivante GC600 GPU on Marvell Dove platforms.
>> These nodes default to being disabled unless a platform decides they
>> should be enabled.
>> 
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/dove.dtsi | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
>> index cd58c2e62757..ea1d999ca7a7 100644
>> --- a/arch/arm/boot/dts/dove.dtsi
>> +++ b/arch/arm/boot/dts/dove.dtsi
>> @@ -33,6 +33,12 @@
>>  		marvell,tauros2-cache-features = <0>;
>>  	};
>>  
>> +	gpu-subsystem {
>> +		compatible = "marvell,dove-gpu-subsystem";
>> +		cores = <&gpu>;
>> +		status = "disabled";
>> +	};
>> +
>>  	i2c-mux {
>>  		compatible = "i2c-mux-pinctrl";
>>  		#address-cells = <1>;
>> @@ -776,6 +782,16 @@
>>  				#address-cells = <1>;
>>  				#size-cells = <1>;
>>  			};
>> +
>> +			gpu: gpu at 840000 {
>> +				clocks = <&divider_clk 1>;
>> +				clock-names = "core";
>> +				compatible = "vivante,gc";
>> +				interrupts = <48>;
>> +				power-domains = <&gpu_domain>;
>> +				reg = <0x840000 0x4000>;
>> +				status = "disabled";
>> +			};
>>  		};
>>  	};
>>  };
>
> -- 
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
