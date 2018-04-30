From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 30 Apr 2018 08:35:47 -0700
Subject: [PATCH] ARM64: dts: meson-axg: enable AP6255 wifi module
In-Reply-To: <30de15b8-4cc4-7f97-d134-7af75cb6ace1@amlogic.com>
References: <20180423145729.14368-1-yixun.lan@amlogic.com>
 <7h7eos1n68.fsf@baylibre.com>
 <30de15b8-4cc4-7f97-d134-7af75cb6ace1@amlogic.com>
Message-ID: <CAOi56cXKmv_Us1wDcMOYbdjFzZcLVu_t210Yrv891wKi22hV8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 6:56 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> On 04/28/18 03:09, Kevin Hilman wrote:
>> Yixun Lan <yixun.lan@amlogic.com> writes:
>>
>>> The Meson-AXG S400 board is shipped with AP6255 wifi module,
>>> which is actually using the brcmfmac 43455 driver.
>>>
>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>> ---
>>>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 44 ++++++++++++++++++-
>>>  1 file changed, 43 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>>> index f67d4e47e641..b3e1bdca32bb 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>>> @@ -51,7 +51,16 @@
>>>
>>>      sdio_pwrseq: sdio-pwrseq {
>>>              compatible = "mmc-pwrseq-simple";
>>> -            reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
>>> +            reset-gpios = <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;
>>
>> You didn't mention this GPIO change in the changelog.  Is it
>> intentional?
>
> Yes, the 'sdio_pwrseq' is used by wifi driver till now
> previous the reset-gpio is wrongly configured (copy & paste error),
> according to the schematics, it's GPIOX_7 which need to be fixed here.
>
> to be clean, in s400 board
>  GPIOX_6 is WIFI_WAKE_HOST pin
>  GPIOX_7 is WIFI_PWREN pin
>
> do you want me to put a note into the commit message? and resend this patch?

OK, thanks for the explanation.

I'd prefer the GPIO pin fix as a separate, standalone patch.

Thanks,

Kevin
