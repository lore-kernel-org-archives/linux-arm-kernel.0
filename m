From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 11 Aug 2010 11:07:29 +0200
Subject: colibri PXA320 and UCB1400 - touch screen troubles
In-Reply-To: <AANLkTimL7kt0-Do9VQUQvktHfsvdKjm_NJ-eDbxcAu2m@mail.gmail.com>
References: <AANLkTimZeDeS+44=BfchT0gwK5NDLhzLSX1vua8oFBQp@mail.gmail.com>
	<201008111042.52631.marek.vasut@gmail.com>
	<AANLkTimL7kt0-Do9VQUQvktHfsvdKjm_NJ-eDbxcAu2m@mail.gmail.com>
Message-ID: <201008111107.29839.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 11. srpna 2010 10:54:08 Yuri Ludkevich napsal(a):
> 2010/8/11 Marek Vasut <marek.vasut@gmail.com>
> 
> > Dne St 11. srpna 2010 09:43:30 Yuri Ludkevich napsal(a):
> > 
> > Hi, it looks like the IRQ was misdetected probably. Check the following
> > two patches (and possibly the vpac270 source file, the "Audio and
> > Touchscreen" section will give you an idea how to force IRQ line to the
> > driver).
> 
> BTW do you know which GPIO used for UCB1400 interrupt?

Please keep the lists CCed. And no, I have no idea which GPIO it is, but if you 
check the Colibri 320 datasheet (available from toradex website) and the kernel 
source for pxa320 colibri, you should be able to get quite a small set of GPIOs 
and you can try which of these it is (echo "GPIO_NUMBER" > 
/sys/class/gpio/export ; echo "in" > /sys/class/gpio/gpioGPIO_NUMBER/direction ; 
cat /sys/class/gpio/gpioGPIO_NUMBER/value ). You can use the thing in braces for 
multiple GPIOs too ... first export them all and set direction and then read 
them (in a loop for example). Of course, when you touch the panel, the GPIO will 
toggle and so it will do when you release the pen.

Cheers
> 
> > http://git.kernel.org/?p=linux/kernel/git/marex/pxa-
> > 
> > linux-2.6.git;a=commitdiff;h=417eb54b3aba8f9aa1707fa1dae606ccaeb94599;hp=
> > 94616fcb8d6e5e51391f34463afafaad3bd20da6
> > 
> > http://git.kernel.org/?p=linux/kernel/git/marex/pxa-
> > 
> > linux-2.6.git;a=commitdiff;h=ced7f2ca8e8d99ec35ff34841c6e6a307a115fa0;hp=
> > 417eb54b3aba8f9aa1707fa1dae606ccaeb94599
> > 
> > Thanks for fast reply!
> 
> I  had seen vpac270 couple minuts ago source - as  I understand I need to
> know which GPIO is used for irq to specify it in ucb1400_data  structure..
> But Toradex does not provide any schematics...

http://www.toradex.com/Products/Colibri_Modules/Colibri_PXA320 The do, but not 
the module schematics unfortunatelly. You can use the way outlined above, it 
should do what you need and should be easy.

Cheers
> 
> With best regards, Yuri.
