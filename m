From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Aug 2013 09:44:25 +0200
Subject: [RFC v1 5/5] ARM: mvebu: add board init for Armada 1500
In-Reply-To: <52115262.70402@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308172108.38824.arnd@arndb.de> <52115262.70402@gmail.com>
Message-ID: <201308190944.26177.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 August 2013, Sebastian Hesselbarth wrote:
> > Note that we should really change the common code to do both the of_clk_init()
> > and the l2x0_of_init() automatically, but that needs to be done with some care,
> > in order to not break any of the existing platforms. Would you be able to do
> > one of the two? We can then get the next person that wants to add a platform
> > to do the last one ;-)
> 
> Scary but that reduces armada-1500.c to MACH descriptor and DT
> compatible only ;) I don't expect any weird hacks required for
> it anyway.

You will need the .smp_ops pointer once you add SMP support. Other than that,
if your machine descriptor only has the pointer to the compatible strings,
you can actually build without a machine descriptor (as we do on arm64).
The string is used only in /proc/cpuinfo then.

	Arnd
