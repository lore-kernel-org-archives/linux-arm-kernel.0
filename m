From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 7 Oct 2009 13:48:00 +0200
Subject: [PATCH 2/9] collie: prepare for gpiolib use
In-Reply-To: <20091007112552.GC6246@n2100.arm.linux.org.uk>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>
	<20091007110805.GA7656@rainbow>
	<20091007112552.GC6246@n2100.arm.linux.org.uk>
Message-ID: <19148.32752.740077.475080@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
> On Wed, Oct 07, 2009 at 03:08:05PM +0400, Dmitry Artamonow wrote:
> > On 23:35 Mon 05 Oct     , Thomas Kunze wrote:
> > > prefix gpio definitions for direct register access with '_' so we
> > > can use the other names for gpio_request & co
> > 
> > Familiar problem - numeric vs bit-shifted gpio defines.
> > I'm facing it here too while converting h3[16]00 to gpiolib,
> > and I'm thinking about dropping bit-shifted defines completely
> > and using GPIO_GPIO(SOME_NUMERIC_GPIO) instead.
> 
> What we did with PXA was to decide not to use definitions for the built-in
> GPIOs - what's the point of:
> 
> #define GPIO0	0
> #define GPIO1	1
> #define GPIO2	2
> ...
> 
A point could be that 'grep GPIO0 ...' would find any usage of that
GPIO in the kernel source while 'grep 0 ...' would be quite
pointless.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
