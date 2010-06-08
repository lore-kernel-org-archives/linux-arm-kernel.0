From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 08 Jun 2010 16:01:55 +0100
Subject: [PATCH 2/2] pxa: modify the pxa2xx-ac97 file for pxa168
In-Reply-To: <AANLkTimZjKvAAcK9xiXng7wJ0tVBJrmTIvMgyzrS7HqH@mail.gmail.com>
References: <4C0E21A1.4000909@gmail.com>
	<AANLkTimNwtScfKYVc4qPZFEP6GYklPoHLgr2AE7yquQL@mail.gmail.com>
	<AANLkTimZjKvAAcK9xiXng7wJ0tVBJrmTIvMgyzrS7HqH@mail.gmail.com>
Message-ID: <1276009315.3003.346.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-06-08 at 22:49 +0800, Wan ZongShun wrote:
> 2010/6/8 Eric Miao <eric.y.miao@gmail.com>:
> > 2010/6/8 Wan ZongShun <mcuos.com@gmail.com>:
> >> In order to allow the sharing of the pxa2xx-ac97 driver file with pxa168,
> >> we have to do a little change to pxa2xx-ac97 file.
> >>
> >> All private register addresses were located in mach/include/ac97.h.
> >
> > This is not the right way to go, as suggested already. I hope the ac97
> > driver is more self-contained. i.e. having a platform device for:
> >
> >  - where the registers are mapped from
> >  - drcmr channel numbers can be encoded within dma resource
> >  - ac97 register definitions are not exposed everywhere
> >
> 
> Got it, so I should put above to platform_device and remove regs-ac97.h,
> any private bit definition should be removed to driver directory as
> driver _only_.
> 

...and could you also CC Mark on any ASoC related changes too.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
