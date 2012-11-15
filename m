From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Thu, 15 Nov 2012 09:10:31 -0600
Subject: [PATCH] ARM: OMAP4: hwmod data: ipu and dsp to use parent clocks
 instead of leaf clocks
In-Reply-To: <alpine.DEB.2.00.1211141542280.16047@utopia.booyaka.com>
References: <1352860750-20100-1-git-send-email-omar.luna@linaro.org>
 <alpine.DEB.2.00.1211141542280.16047@utopia.booyaka.com>
Message-ID: <CALLhW=6uwCzAwPLNbjOwVKWVW5KOui=UXZdTUm7HMp=3cZrCNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14 November 2012 09:44, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Tue, 13 Nov 2012, Omar Ramirez Luna wrote:
>
>> This prevents hwmod _enable_clocks...omap2_dflt_clk_enable path
>> from enabling modulemode inside CLKCTRL using its clk->enable_reg
>> field. Instead is left to _omap4_enable_module though soc_ops, as
>> the one in charge of this setting.
>>
>> According to comments received[1] for related patches the idea is
>> to get rid of leaf clocks in future. So remove these two while at it.
>>
>> [1] http://lkml.org/lkml/2012/8/20/226
>>
>> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
>
> Does this one belong as part of the "OMAP: iommu: hwmod, reset
> handling and runtime PM" series?  Looks like applying this one separately
> might cause these clocks not to be disabled by either the clock code's
> disable-unused-clocks code, or the hwmod code?

You are right, if applied right now, without the others it will break
the current clocks iommu code uses.

I will put it along with the other series or wait for the acceptance
of the other patches first.

Thanks,

Omar
