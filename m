From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Nov 2014 14:26:59 +0100
Subject: [PATCH 06/17] gpio: mvebu: add suspend/resume support
In-Reply-To: <54533FAF.7010505@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkda-8p=e_12vpUNt3_Y0EVPDArEKJUi63B8CGemNwVuQ0w@mail.gmail.com>
 <54533FAF.7010505@free-electrons.com>
Message-ID: <CACRpkdaMrLBejKShTZoHW8BZb9AJguGJ96eEMp+eo3kmH=yDwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 8:52 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Linus,
>>> +       switch (mvchip->soc_variant) {
>>> +       case MVEBU_GPIO_SOC_VARIANT_ORION:
>>> +               mvchip->edge_mask_regs[0] =
>>> +                       readl(mvchip->membase + GPIO_EDGE_MASK_OFF);
>>> +               mvchip->level_mask_regs[0] =
>>> +                       readl(mvchip->membase + GPIO_LEVEL_MASK_OFF);
>>> +               break;
>>
>> You are assigning index [0] twice, why? There must be some
>> reason, and it should be stated in a comment. If the first read
>> is necessary for hardware reasons, don't assign it but
>> discard the result.
>
> Maybe I missed something but for me these 2 registers are different:
> one is the _EDGE_ mask and the other the _LEVEL_ mask.

Yeah haha I must have had a bad perception day :D

Yours,
Linus Walleij
