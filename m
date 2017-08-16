From: jeffy.chen@rock-chips.com (jeffy)
Date: Thu, 17 Aug 2017 06:55:20 +0800
Subject: [PATCH v2 1/3] ASoC: rockchip: Parse dai links from dts
In-Reply-To: <20170816215909.GC109008@google.com>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
 <1502340898-28403-2-git-send-email-jeffy.chen@rock-chips.com>
 <20170816215909.GC109008@google.com>
Message-ID: <5994CD58.7030406@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi matthias,

thanks for your suggestion.

On 08/17/2017 05:59 AM, Matthias Kaehlcke wrote:
> El Thu, Aug 10, 2017 at 12:54:56PM +0800 Jeffy Chen ha dit:
>
>> >Refactor rockchip_sound_probe, parse dai links from dts instead of
>> >hard coding them.
> Mark doesn't seem to be overly convinced that 'rockchip,codec-names'
> is a good idea (https://lkml.org/lkml/2017/8/10/511).
>
> How about using something like this instead:
>
> static const char *dailink_compat[] = {
> 	[DAILINK_MAX98357A] = "maxim,max98357a",
> 	[DAILINK_RT5514] = "realtek,rt5514",
> 	[DAILINK_DA7219] = "dlg,da7219",
> };
i've thought about this too, but i'm working on converting rt5514 
dsp(spi) from codec name matching to of_node, and it would have the same 
compatible with rt5514(i2c)
