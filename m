From: andy@warmcat.com (Andy Green)
Date: Mon, 30 Aug 2010 14:56:28 +0100
Subject: iMX31 power management
In-Reply-To: <201008301444.21510.thomas.nemeth@betatech.fr>
References: <201008301444.21510.thomas.nemeth@betatech.fr>
Message-ID: <4C7BB88C.1010202@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/10 13:44, Somebody in the thread at some point said:

Hi -

>      I'm currently struggling trying to make suspend to RAM work for the
>      iMX31 processor. As the pm functions were not implemented, I added
>      a pretty straightforward pm "driver".
>
>      It works to a point. The processor seems really sleeping. But where
>      the heck is Prince Charming ? It does not want to wakeup else :( I
>      can't make the DOZE mode, State Retention mode and Deep Sleep mode
>      to work. Does anybody know how ?
>
>      I added in attachment the code I adapted from 2.6.22 so that it
>      integrates better with current kernels.

I ported this similar stuff from the Freescale tree to 2.6.32 last 
December, it sleeps and wakes fine (using stop clock) on that txtr board 
since then.

http://git.warmcat.com/cgi-bin/cgit/txtr-kernel/commit/?h=txtr-tracking&id=34685e9c378c865885ad6a8f2fc06fc36ad48482

There was no enable_irq_wake(); platform support at that time so I guess 
maybe there is now and you need to make sure your wake interrupts are 
marked as wake sources?

-Andy
