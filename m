From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 09 Jul 2012 23:21:35 +0200
Subject: [PATCH 7/9] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
In-Reply-To: <CACRpkdbjkLvD13_g=TvCUYjqhZ7ySOiEL51h9eT3YVMO4Vnr3A@mail.gmail.com>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <4FF6994B.9040801@linaro.org> <20120706173957.GA10202@core.coreip.homeip.net>
 <4FFB288D.4080606@linaro.org> <20120709201422.GA12242@core.coreip.homeip.net>
 <4FFB40A4.5060505@linaro.org> <20120709204620.GA12692@core.coreip.homeip.net>
 <4FFB463F.9040201@linaro.org>
 <CACRpkdbjkLvD13_g=TvCUYjqhZ7ySOiEL51h9eT3YVMO4Vnr3A@mail.gmail.com>
Message-ID: <4FFB4B5F.30103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/12 23:03, Linus Walleij wrote:
> On Mon, Jul 9, 2012 at 10:59 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
>> Before we can use any domain allocated IRQ, we need to first create a
>> map between the Hardware IRQ (hwirq) and the Linux Virtual IRQ (virq).
>> We do this with a helper function provided by the AB8500 IRQ domain
>> controller called ab8500_irq_get_virq(). We need to do this for both
>> IRQs which the Power-On-Key driver uses; one for button press, the other
>> for button depress.
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Now since I was fooled by the last patch, thinking you had tested it before
> submitting (obviously not) - please send a test log of some
> cat /dev/input/event* for this one before I ACK it this time.

I did test it, but must have only looked at the one IRQ incrementing.

I can provide a log tomorrow if it makes you feel better. :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
