From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 11 Jun 2010 11:23:56 +0200
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <201006111718.47426.jeremy.kerr@canonical.com>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<201006111557.12249.jeremy.kerr@canonical.com>
	<19473.61547.684572.647641@ipc1.ka-ro>
	<201006111718.47426.jeremy.kerr@canonical.com>
Message-ID: <19474.172.742782.972629@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > Using a mutex in clk_enable()/clk_disable() is a bad idea, since that
> > makes it impossible to call those functions in interrupt context.
> 
> Do we do this at the moment? I know at least one implementation of clk_enable 
> uses a mutex for locking.
> 
You are probably talking about the Freescale i.MX51 kernel, that won't
even boot, if you enable CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_SPINLOCK,
CONFIG_DEBUG_LOCKDEP and CONFIG_DEBUG_SPINLOCK_SLEEP.
The mutex in the clock implementation is one of the reasons.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
