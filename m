From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 24 Mar 2016 18:26:18 +0100
Subject: [PATCH 2/3] ARM64: dts: amlogic: add Hardkernel ODROID-C2
In-Reply-To: <CAOi56cVoLrHjeT_BhSZAvj5yZvf8Qkg8y=_zh+kikM+96+LGVg@mail.gmail.com>
References: <1458758013-11890-1-git-send-email-khilman@baylibre.com>
 <1458758013-11890-2-git-send-email-khilman@baylibre.com>
 <8055578.HDz4P7ZJ9W@wuerfel> <56F41C76.8090805@suse.de>
 <CAOi56cVoLrHjeT_BhSZAvj5yZvf8Qkg8y=_zh+kikM+96+LGVg@mail.gmail.com>
Message-ID: <56F4233A.5020904@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.03.2016 um 18:16 schrieb Kevin Hilman:
> On Thu, Mar 24, 2016 at 9:57 AM, Andreas F?rber <afaerber@suse.de> wrote:
>> Am 24.03.2016 um 13:58 schrieb Arnd Bergmann:
>>> On Wednesday 23 March 2016 11:33:32 Kevin Hilman wrote:
>>>> +/ {
>>>> +       compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
>>>> +       model = "Hardkernel ODROID-C2";
>>>> +
>>>> +       chosen {
>>>> +               stdout-path = "serial0:115200n8";
>>>> +       };
>>>> +
>>>> +       memory at 0 {
>>>> +               device_type = "memory";
>>>> +               reg = <0x0 0x0 0x0 0x80000000>;
>>>> +       };
>>>> +};
>>>> +
>>>> +&uart_AO {
>>>> +       status = "okay";
>>>> +};
>>>>
>>>
>>> Shouldn't this also add the serial0 alias?
>>>
>>> It seems that the .dtsi file accidentally sets an alias to a disabled
>>> device, which isn't really valid. Can you fix that when adding the
>>> .dts?
>>
>> Hm, would it be any better to not disable either of the serials and
>> leave the aliases in the .dtsi?
> 
> I'm going to respin, moving the aliases that are actually into the
> .dts that use them, and dropping the unused/disabled serial1.

Carlo and me both agreed to that approach.

However @Arnd, I still don't understand how an alias to a disabled
device hurts? It was not accidental on my part. And I'm pretty sure on
my PowerMac's OpenFirmware I had aliases to disk devices not connected.

Using an alias to a disabled device should be no different from using
the full path to a disabled device. We don't prevent the latter, so why
the former?

If the serial node is disabled, the meson_uart driver won't probe and
won't look up its alias. Who else uses it apart from stdout-path?

The order was intentionally always AO (always-on) bus first, and there
are just two UARTs I'm aware of.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
