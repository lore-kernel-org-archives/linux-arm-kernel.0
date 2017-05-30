From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 30 May 2017 15:40:00 +0200
Subject: [PATCH v6 1/4] gpio: mvebu: Add limited PWM support
In-Reply-To: <CACRpkdYPp6pBemTT_a4V6a-Qbk2475qOOxWJOhfVaEz=cojOvA@mail.gmail.com>
 (Linus Walleij's message of "Mon, 24 Apr 2017 11:18:30 +0200")
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
 <20170414154056.32055-2-ralph.sennhauser@gmail.com>
 <CACRpkdYPp6pBemTT_a4V6a-Qbk2475qOOxWJOhfVaEz=cojOvA@mail.gmail.com>
Message-ID: <87tw42tqdr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ralph and Linus,

I resurrect this thread following the series post by Richard Genoud:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/509461.html

 On lun., avril 24 2017, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
> <ralph.sennhauser@gmail.com> wrote:
>
>> From: Andrew Lunn <andrew@lunn.ch>
>>
>> Armada 370/XP devices can 'blink' GPIO lines with a configurable on
>> and off period. This can be modelled as a PWM.
>>
>> However, there are only two sets of PWM configuration registers for
>> all the GPIO lines. This driver simply allows a single GPIO line per
>> GPIO chip of 32 lines to be used as a PWM. Attempts to use more return
>> EBUSY.
>>
>> Due to the interleaving of registers it is not simple to separate the
>> PWM driver from the GPIO driver. Thus the GPIO driver has been
>> extended with a PWM driver.
>>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> URL: https://patchwork.ozlabs.org/patch/427287/
>> URL: https://patchwork.ozlabs.org/patch/427295/
>> [Ralph Sennhauser:
>>   * Port forward
>>   * Merge PWM portion into gpio-mvebu.c
>>   * Switch to atomic PWM API
>>   * Add new compatible string marvell,armada-370-xp-gpio

The fact that Richard managed to run the code on Armada 38x draw my
attention on the documentation that need to be amend.

And it makes me realized that I missed the bad naming of the compatible
string. We don't use family name for the compatible string, but the name
of the first SoC compatible with. So in this case we should use
"marvell,armada-370", as it is still in rc and not yet deployed. What
about fixing the name now?

I can send a patch for it if you want and fix the dts that are still in
my mvebu branch.

Thanks,

Gregory


>>   * Update and merge documentation patch
>>   * Update MAINTAINERS]
>> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
>> Tested-by: Andrew Lunn <andrew@lunn.ch>
>> Acked-by: Thierry Reding <thierry.reding@gmail.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> Patch applied.
>
> Yours,
> Linus Walleij

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
