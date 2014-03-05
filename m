From: obi@saftware.de (Andreas Oberritter)
Date: Wed, 05 Mar 2014 14:26:01 +0100
Subject: [PATCH 1/1] ARM: EXYNOS: Map SYSRAM address through DT
In-Reply-To: <CAK9yfHz6wJPdC=DjgaiNOsPHY8k9zaB+p3-ahpwOOcPQtoWEHw@mail.gmail.com>
References: <1392876308-4748-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHz6wJPdC=DjgaiNOsPHY8k9zaB+p3-ahpwOOcPQtoWEHw@mail.gmail.com>
Message-ID: <531725E9.5010307@saftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.03.2014 09:23, Sachin Kamat wrote:
>> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> index d2e3f5f5916d..3ca3fb6aa5f4 100644
>> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> @@ -28,6 +28,11 @@
>>                 bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
>>         };
>>
>> +       sysram at 02020000 {
                  ^
>> +               compatible = "samsung,exynos4210-sysram";
>> +               reg = <0x02025000 0x1000>;
                          ^
>> +       };
>> +

Shouldn't these two addresses match?

Regards,
Andreas
