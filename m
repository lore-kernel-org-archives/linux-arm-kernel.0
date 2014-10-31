From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 31 Oct 2014 08:52:15 +0100
Subject: [PATCH 06/17] gpio: mvebu: add suspend/resume support
In-Reply-To: <CACRpkda-8p=e_12vpUNt3_Y0EVPDArEKJUi63B8CGemNwVuQ0w@mail.gmail.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>	<1414151970-6626-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkda-8p=e_12vpUNt3_Y0EVPDArEKJUi63B8CGemNwVuQ0w@mail.gmail.com>
Message-ID: <54533FAF.7010505@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


> 
>> +       switch (mvchip->soc_variant) {
>> +       case MVEBU_GPIO_SOC_VARIANT_ORION:
>> +               mvchip->edge_mask_regs[0] =
>> +                       readl(mvchip->membase + GPIO_EDGE_MASK_OFF);
>> +               mvchip->level_mask_regs[0] =
>> +                       readl(mvchip->membase + GPIO_LEVEL_MASK_OFF);
>> +               break;
> 
> You are assigning index [0] twice, why? There must be some
> reason, and it should be stated in a comment. If the first read
> is necessary for hardware reasons, don't assign it but
> discard the result.

Maybe I missed something but for me these 2 registers are different:
one is the _EDGE_ mask and the other the _LEVEL_ mask.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
