From: thomas.nemeth@betatech.fr (Thomas Nemeth)
Date: Mon, 30 Aug 2010 16:41:39 +0200
Subject: iMX31 power management
In-Reply-To: <4C7BB88C.1010202@warmcat.com>
References: <201008301444.21510.thomas.nemeth@betatech.fr>
	<4C7BB88C.1010202@warmcat.com>
Message-ID: <201008301641.41957.thomas.nemeth@betatech.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi 30 ao?t 2010, Andy Green a ?crit?:
> On 08/30/10 13:44, Somebody in the thread at some point said:
>
> Hi -

    Hi Andy.


> >      I added in attachment the code I adapted from 2.6.22 so that
> > it integrates better with current kernels.
>
> I ported this similar stuff from the Freescale tree to 2.6.32 last
> December, it sleeps and wakes fine (using stop clock) on that txtr
> board since then.

    I did this piece of code because it wasn't in 2.6.34 mainline :)
    Should we make something to have it marged ?


> http://git.warmcat.com/cgi-bin/cgit/txtr-kernel/commit/?h=txtr-tracki
>ng&id=34685e9c378c865885ad6a8f2fc06fc36ad48482
>
> There was no enable_irq_wake(); platform support at that time so I

    I wasn't aware of that function. It indeed may be of a great help.
    I've seen that a lot of drivers use directly set_irq_wake(). Is
    there a "prefered" way of using this facility ?

    I think the set_wake() field in the irq_chip structure from
    arch/arm/plat-mxc/irq.c should be created, didn't it ?


> guess maybe there is now and you need to make sure your wake
> interrupts are marked as wake sources?

    In a more recent version of my pm.c source file, I have :
       __raw_writel(0, MXC_CCM_WIMR);
    in mx31_pm_prepare(), in order to enable all interrupts to wake the
    processor up. But to no use :(


    Thanks a lot.


Thomas.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100830/9e6cd356/attachment.sig>
