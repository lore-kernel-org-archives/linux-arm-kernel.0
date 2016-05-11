From: carlo@caione.org (Carlo Caione)
Date: Wed, 11 May 2016 20:05:02 +0200
Subject: [PATCH v5 3/4] ARM: dts: meson8b: Add MMC nodes
In-Reply-To: <m24ma47a0n.fsf@baylibre.com>
References: <1456596108-1406-1-git-send-email-carlo@caione.org>
 <1456596108-1406-4-git-send-email-carlo@caione.org>
 <m24ma47a0n.fsf@baylibre.com>
Message-ID: <CAOQ7t2ZjezqApQMSmbGQuoo8Lw8Fvrj8E1pfR+Dew=mVqr=eCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 7:57 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Hi Carlo,
>
> Carlo Caione <carlo@caione.org> writes:
>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Enable the MMC for the Meson8b platforms.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>
> [...]
>
>> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
>> index 8bad557..25d795c 100644
>> --- a/arch/arm/boot/dts/meson8b.dtsi
>> +++ b/arch/arm/boot/dts/meson8b.dtsi
>> @@ -187,6 +187,22 @@
>>                                       function = "uart_ao";
>>                               };
>>                       };
>> +
>> +                     mmc0_sd_b_pins: mmc0_sd_b {
>> +                             mux {
>> +                                     groups = "sd_d1_b", "sd_d0_b", "sd_clk_b", "sd_cmd_b",
>> +                                              "sd_d3_b", "sd_d2_b";
>> +                                     function = "sd_b";
>> +                             };
>> +                     };
>
> These pins are added under pinctrl_aobus, but in the pinctrl driver,
> they're under cbus.  If I move this into the pinctrl_cbus node, I get it
> to work on my odroid-c1, and am able to mount/use an MMC rootfs.

Ouch, thank you for pointing this out, I'll fix it in v6.

thanks,

-- 
Carlo Caione
