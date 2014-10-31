From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 31 Oct 2014 09:14:35 +0100
Subject: [PATCH 06/17] gpio: mvebu: add suspend/resume support
In-Reply-To: <54533FAF.7010505@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkda-8p=e_12vpUNt3_Y0EVPDArEKJUi63B8CGemNwVuQ0w@mail.gmail.com>
 <54533FAF.7010505@free-electrons.com>
Message-ID: <20141031091435.2149346d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 31 Oct 2014 08:52:15 +0100, Gregory CLEMENT wrote:

> >> +       switch (mvchip->soc_variant) {
> >> +       case MVEBU_GPIO_SOC_VARIANT_ORION:
> >> +               mvchip->edge_mask_regs[0] =
> >> +                       readl(mvchip->membase + GPIO_EDGE_MASK_OFF);
> >> +               mvchip->level_mask_regs[0] =
> >> +                       readl(mvchip->membase + GPIO_LEVEL_MASK_OFF);
> >> +               break;
> > 
> > You are assigning index [0] twice, why? There must be some
> > reason, and it should be stated in a comment. If the first read
> > is necessary for hardware reasons, don't assign it but
> > discard the result.
> 
> Maybe I missed something but for me these 2 registers are different:
> one is the _EDGE_ mask and the other the _LEVEL_ mask.

Good that you looked at it Greg because I must admit I did not
understand the comment from Linus :-)

I read things again and both the variable *and* the register offset are
different. I guess it's probably due to a -ENOTENOUGHCOFFEE :-)

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
