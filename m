From: thomas.nemeth@betatech.fr (Thomas Nemeth)
Date: Mon, 30 Aug 2010 17:25:50 +0200
Subject: iMX31 power management
In-Reply-To: <4C7BC89C.8000506@warmcat.com>
References: <201008301444.21510.thomas.nemeth@betatech.fr>
	<201008301641.41957.thomas.nemeth@betatech.fr>
	<4C7BC89C.8000506@warmcat.com>
Message-ID: <201008301725.50732.thomas.nemeth@betatech.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi 30 ao?t 2010, Andy Green a ?crit?:
> On 08/30/10 15:41, Somebody in the thread at some point said:
> >      I did this piece of code because it wasn't in 2.6.34 mainline
> > :) Should we make something to have it marged ?
>
> Yeah if it works for more than just my board ^^

    I'm trying to make it work at least on mine too ;)


> >> guess maybe there is now and you need to make sure your wake
> >> interrupts are marked as wake sources?
> >
> >      In a more recent version of my pm.c source file, I have :
> >         __raw_writel(0, MXC_CCM_WIMR);
> >      in mx31_pm_prepare(), in order to enable all interrupts to
> > wake the processor up. But to no use :(
>
> I recall having to fix something in the Freescale code, it might be
> worth checking through the patch I pointed to because I don't think
> it's just the freescale code any more.  I had a quick look and see if
> I did anything in the mach-*.c file but I didn't see anything
> relevant.

    Except using local_irq_*() in your code, it looks a lot like what I
    already have. The mxc_ccm_modify_reg() function is also present in
    your code although not used everywhere MXC_CCM_CCMR is modified.


> How're you provoking the suspend?  What worked for me was echo mem >
> /sys/power/state.

    I did that too. And also with "standby" instead of "mem".


> BTW we go 30mA from battery with clock stop suspend on iMX31 and

    30mA is also what we get (with WinCE) though it should be ten
    percent of that.


> everything else left up, so that's not so wonderful.  However the
> resume was well under 500ms, so the waking touchpad gesture can be
> seen and processed by the resumed driver in an unbroken fashion.

    That's a good news :)


Thomas.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100830/c03f29ca/attachment.sig>
