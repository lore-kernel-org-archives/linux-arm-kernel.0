From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 20 Jun 2016 08:46:02 +0000
Subject: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <20160620080334.GL5809@piout.net>
References: <1465359311-14544-1-git-send-email-wenyou.yang@atmel.com>
 <1465359311-14544-2-git-send-email-wenyou.yang@atmel.com>
 <20160608202651.GA23604@rob-hp-laptop> <20160608203810.GF2466@piout.net>
 <B256D81BAE5131468A838E5D7A24364101650C3632@penmbx01>
 <20160617135448.GI5809@piout.net>
 <B256D81BAE5131468A838E5D7A24364101650C5253@penmbx01>
 <20160620080334.GL5809@piout.net>
Message-ID: <B256D81BAE5131468A838E5D7A24364101650C547F@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre & Nicolas,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: 2016?6?20? 16:04
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Rob Herring <robh@kernel.org>; Alan Stern <stern@rowland.harvard.edu>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Ferre, Nicolas
> <Nicolas.FERRE@atmel.com>; Pawel Moll <pawel.moll@arm.com>; Mark Brown
> <broonie@kernel.org>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar
> Gala <galak@codeaurora.org>; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> usb at vger.kernel.org
> Subject: Re: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
> suspend
> 
> On 20/06/2016 at 03:16:35 +0000, Yang, Wenyou wrote :
> > > Sure, what I mean is that you can try to get the regmap for the SFR in every
> case.
> > > Depending on whether you were able to get it, you can decide to call
> > > ohci_at91_port_suspend/resume or not (just test for sfr_regmap != NULL).
> >
> > I don't think so. The SFR includes a lot of miscellaneous functions, more than
> this one.
> >
> 
> I know but this is irrelevant to this discussion. If you need to use the SFR from
> another driver you will simply get it from that other driver.
> 
> I that case, you will try to get "atmel,sama5d2-sfr". It is only present on sama5d2
> so you have enough information to know whether or not you can use it to
> suspend/resume.

I understand what your meaning :).
Use "atmel,sama5d2-sfr" compatible to distinguish whether forcibly suspend USB port via SFR or not.

I am not sure if it is a better solution.

Nicolas, could you give your opinion?

> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com


Best Regards,
Wenyou Yang
