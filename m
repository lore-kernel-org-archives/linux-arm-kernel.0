From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 24 Mar 2016 17:57:26 +0100
Subject: [PATCH 2/3] ARM64: dts: amlogic: add Hardkernel ODROID-C2
In-Reply-To: <8055578.HDz4P7ZJ9W@wuerfel>
References: <1458758013-11890-1-git-send-email-khilman@baylibre.com>
 <1458758013-11890-2-git-send-email-khilman@baylibre.com>
 <8055578.HDz4P7ZJ9W@wuerfel>
Message-ID: <56F41C76.8090805@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.03.2016 um 13:58 schrieb Arnd Bergmann:
> On Wednesday 23 March 2016 11:33:32 Kevin Hilman wrote:
>> +/ {
>> +       compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
>> +       model = "Hardkernel ODROID-C2";
>> +       
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +
>> +       memory at 0 {
>> +               device_type = "memory";
>> +               reg = <0x0 0x0 0x0 0x80000000>;
>> +       };
>> +};
>> +
>> +&uart_AO {
>> +       status = "okay";
>> +};
>>
> 
> Shouldn't this also add the serial0 alias?
> 
> It seems that the .dtsi file accidentally sets an alias to a disabled
> device, which isn't really valid. Can you fix that when adding the
> .dts?

Hm, would it be any better to not disable either of the serials and
leave the aliases in the .dtsi?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
