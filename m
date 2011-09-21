From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 21 Sep 2011 11:55:36 +0200 (CEST)
Subject: [PATCH 53/57] sound: irq: Remove IRQF_DISABLED
In-Reply-To: <s5hsjnqxlxb.wl%tiwai@suse.de>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-54-git-send-email-yong.zhang0@gmail.com>
	<s5hsjnqxlxb.wl%tiwai@suse.de>
Message-ID: <alpine.LFD.2.02.1109211154280.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Sep 2011, Takashi Iwai wrote:

> At Wed, 21 Sep 2011 17:28:54 +0800,
> Yong Zhang wrote:
> > 
> > Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
> 
> Hm, this id hits a different commit:
>     commit c58543c869606532c2382f027d6466f4672ea756
>     Author: David S. Miller <davem@davemloft.net>
>     Date:   Tue Oct 13 00:49:09 2009 -0700
> 
>     sparc64: Set IRQF_DISABLED on LDC channel IRQs.
> 
> You mean commit e58aa3d2d0cc01ad8d6f7f640a0670433f794922?

Yeah.
 
> > We run all interrupt handlers with interrupts disabled
> > and we even check and yell when an interrupt handler
> > returns with interrupts enabled (see commit [b738a50a:
> > genirq: Warn when handler enables interrupts]).
> > 
> > So now this flag is a NOOP and can be removed.
> > 
> > Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Do you want to merge by yourself or shall I take it to sound git tree?
> Since IRQF_DISABLED isn't used, it can be applied safely in 3.1-based
> tree, right?

Yes, please go ahead. I'll pick up the leftovers.

Thanks,

	tglx
