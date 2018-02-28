From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Wed, 28 Feb 2018 20:36:30 +0800
Subject: [PATCH] soc: rockchip: power-domain: remove PM clocks
In-Reply-To: <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
Message-ID: <5A96A24E.80401@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thanks for you reply.

On 02/28/2018 08:17 PM, Geert Uytterhoeven wrote:
> Hi Jeffy,
>
> On Wed, Feb 28, 2018 at 12:11 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> Currently we are adding all of the attached devices' clocks as pm clocks
>> and enable them when powering on the power domain.
>>
>> This seems unnecessary, because those clocks are already controlled in
>> the devices' drivers with better error handling.
>>
>> Tested on my chromebook minnie(rk3288) and chromebook kevin(rk3399).
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>
> Thanks for your patch!
>
> Just wondering: so you prefer to handle the clocks explicitly in all drivers,
> instead of delegating this task to Runtime PM?
hmmm, i think we should control PM clks here, but not all clocks...at 
least some of the clocks are not required to be enabled while pd power 
on(waste power?).

and seems the drivers might have better control for error 
handling(decide to ignore or fail to probe or else).

also Runtime PM seems optional(could be disabled in config), and some 
devices(or even chips) don't have PM.

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
>
>
