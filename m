From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 19 Jun 2013 08:12:02 -0400
Subject: [PATCH 1/1] arm: add bandgap DT entry for OMAP5
In-Reply-To: <51C18990.8000109@ti.com>
References: <1371609398-26454-1-git-send-email-eduardo.valentin@ti.com>
 <51C18990.8000109@ti.com>
Message-ID: <51C1A012.7050809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-06-2013 06:36, Benoit Cousson wrote:
> Hi Eduardo,
> 
> On 06/18/2013 09:36 PM, Eduardo Valentin wrote:
>> Add bandgap device DT entry for OMAP5 dtsi.
>>
>> Cc: "Beno??t Cousson" <b-cousson@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: linux-omap at vger.kernel.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> Signed-off-by: J Keerthy <j-keerthy@ti.com>
>> ---
>>   arch/arm/boot/dts/omap5.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>> ---
>>
>> Benoit,
>>
>> Sorry for this very late request, but can you please consider
>> these patches for 3.11 still?
>>
>> I completely forgot to send these on my "Enable TI SoC thermal driver" series.
>>
>> All best,
>>
>> Eduardo
>>
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index 2ad63c4..5ede6e1 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -615,5 +615,13 @@
>>   			interrupts = <0 80 0x4>;
>>   			ti,hwmods = "wd_timer2";
>>   		};
> 
> missing blank line
> 
>> +		bandgap {
> 
> You must use the first address in that case. Otherwise DT will affect a random number and provide a non-standard device name. That does not really matter in theory, but it will looks ugly in the /sys/devices list.
> 
>> +			reg = <0x4a0021e0 0xc
>> +				0x4a00232c 0xc
>> +				0x4a002380 0x2c
>> +				0x4a0023C0 0x3c>;
>> +				interrupts = <0 126 4>; /* talert */
> 
> Not well aligned and should use the macros.
> 
>> +			compatible = "ti,omap5430-bandgap";
>> +		};
>>   	};
>>   };
>>
> 
> I did the update for you :-)
> 
> Here is the version I've just applied.
> 
> Benoit
> 
> 
>>From f0160bb93467e22f2f8bc77591dcd7e35cdee999 Mon Sep 17 00:00:00 2001
> From: Eduardo Valentin <eduardo.valentin@ti.com>
> Date: Tue, 18 Jun 2013 22:36:38 -0400
> Subject: [PATCH] ARM: dts: Add bandgap DT entry for OMAP5
> 
> Add bandgap device DT entry for OMAP5 dtsi.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Signed-off-by: Benoit Cousson <benoit.cousson@linaro.org>
> ---
>  arch/arm/boot/dts/omap5.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index accab62..47693c9 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -696,5 +696,14 @@
>  				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};
> +
> +		bandgap at 4a0021e0 {
> +			reg = <0x4a0021e0 0xc
> +			       0x4a00232c 0xc
> +			       0x4a002380 0x2c
> +			       0x4a0023C0 0x3c>;
> +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +			compatible = "ti,omap5430-bandgap";
> +		};
>  	};
>  };
> 

Looks good to me.

Tks Benoit!

-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/b1b0fdd5/attachment.sig>
