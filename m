From: sean@nyekjaer.dk (=?UTF-8?Q?Sean_Nyekj=C3=A6r?=)
Date: Thu, 3 Aug 2017 08:03:24 +0200
Subject: [PATCH] arm64: dts: marvell: armada-3720-espressobin: Add vqmmc
 regulator for SD slot
In-Reply-To: <20170802193440.21226c2a@xps13>
References: <20170729104411.3602-1-sean@nyekjaer.dk>
 <20170802193440.21226c2a@xps13>
Message-ID: <CAKv0xJx-Jrr8gh30SeFb3A3zRXo2YDG8KtNp7vp25qTqtMfd9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 August 2017 at 19:34, Miquel RAYNAL
<miquel.raynal@free-electrons.com> wrote:
> Hi,
>
> On Sat, 29 Jul 2017 12:44:11 +0200
> Sean Nyekjaer <sean@nyekjaer.dk> wrote:
>
>> By adding this regulator, the SD cards are usable at higher speed
>> protocols such as SDR104.
>>
>> This patch was tested with an SDHC card compatible with UHS-I.
>>
>> Signed-off-by: Sean Nyekjaer <sean@nyekjaer.dk>
>
> The patch does the job, but does not apply as is.
Try applying  "[PATCH] arm64: dts: marvell: Add microsd card
definition for the ESPRESSObin" first :-)

Br
Sean
>
> Tested-by: Miquel Raynal <miquel.raynal@free-electrons.com>
>
> Regards,
> Miqu?l
>
>> ---
>>
>> This patch depends on "[PATCH] arm64: dts: marvell: Add microsd card
>> definition for the ESPRESSObin"
>>
>>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 15
>> ++++++++++++++- 1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
>> b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts index
>> 2dadd77e08eb..d5ab5b47f8d4 100644 ---
>> a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts +++
>> b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts @@ -60,6
>> +60,19 @@ device_type = "memory";
>>               reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
>>       };
>> +
>> +     vcc_sd_reg1: regulator {
>> +             compatible = "regulator-gpio";
>> +             regulator-name= "vcc_sd1";
>> +             regulator-min-microvolt = <1800000>;
>> +             regulator-max-microvolt = <3300000>;
>> +
>> +             gpios = <&gpionb 4 GPIO_ACTIVE_HIGH>;
>> +             gpios-states = <0>;
>> +             states = <1800000 0x1
>> +                       3300000 0x0>;
>> +             enable-active-high;
>> +     };
>>  };
>>
>>  /* J9 */
>> @@ -82,7 +95,7 @@
>>       wp-inverted;
>>       bus-width = <4>;
>>       cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
>> -     no-1-8-v;
>> +     vqmmc-supply = <&vcc_sd_reg1>;
>>       marvell,pad-type = "sd";
>>       status = "okay";
>>  };
>
>
>
> --
> Miquel Raynal, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
