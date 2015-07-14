From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jul 2015 22:50:08 +0200
Subject: [PATCH] ARM: orion5x: fix legacy orion5x IRQ numbers
In-Reply-To: <1436883958.13048.5.camel@dolka.fr>
References: <5583DD23.90505@arm.com> <1436710916.5657.169.camel@dolka.fr>
 <1436883958.13048.5.camel@dolka.fr>
Message-ID: <4168769.RaQL1yKSFF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 July 2015 16:25:58 Benjamin Cama wrote:
> Hi everyone,
> 
> I finally nailed it: my attempt at copying Russell's patch for dove did
> not work because MULTI_IRQ_HANDLER was not set. It is not in the
> defconfig; maybe it should be now? I hesitated to put it as a
> dependency for PLAT_ORION_LEGACY, but as the platform is globally
> broken without it, I added it.
> 
> What do you think?
> 

I think it makes sense the way you did here.

See also my patch at

http://git.kernel.org/cgit/linux/kernel/git/arnd/playground.git/commit/?h=multiplatform-4.2-next&id=44b55cab3bd74739e4c39205d41e1b2ed8953155

I'd be happy if we could just merge that one, along with the other
plat-orion multiplatform patches at
http://git.kernel.org/cgit/linux/kernel/git/arnd/playground.git/log/?h=b1f5b2f1a738d7f78b94856bfe7a1a7d4da1fbd1

I did not manage to get them merged before my parental leave and
certainly won't be able to do it before I get back to work, but maybe
someone else can have a look. I think the five patches should all
be fine there, they mainly need testing on real hardware.

	Arnd
