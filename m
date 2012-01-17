From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 17 Jan 2012 10:02:23 +0000
Subject: DaVinci unbanked GPIO IRQs broken
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE0BF403DA89@Cloud.RL.local>
References: <70E876B0EA86DD4BAF101844BC814DFE0BF403DA89@Cloud.RL.local>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317926BB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Mon, Jan 16, 2012 at 17:08:30, Jon Povey wrote:
> Sorry, last email had some lies, I had testing errors:
> 
> Jon Povey wrote:
> > But I did try reverting the genirq change too, and
> > the interrupt handler still wasn't called
> 
> This was incorrect, interrupt DOES work with genirq reverted on 3.2.
> 
> > 3.2 vanilla: oops requesting irq
> > 3.2 + your patch: no oops, isr is not run
> 
> These are still the case
> 
> > 3.2 + reverted genirq: no oops, isr is not run
> 
> This was incorrect, real result is: no oops, isr WORKS.
> (with or without your patch).

I was able to reproduce this on the EVM using v2.6.38 (works)
and v3.2 + my patch (doesn't work). I just started poking some
registers to see what is happening. Will keep you updated
on any progress.

Thanks,
Sekhar
