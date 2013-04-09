From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 11:21:24 +0200
Subject: linux-next: build warning after merge of the final tree (probably
 arm-soc tree related)
In-Reply-To: <20130409190900.97dcf3a70a9c0ad727b8bc4b@canb.auug.org.au>
References: <20130409190900.97dcf3a70a9c0ad727b8bc4b@canb.auug.org.au>
Message-ID: <201304091121.24372.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Stephen Rothwell wrote:
> After merging the final tree, today's linux-next build (arm defconfig)
> produced these warnings:
> 
> arch/arm/mach-cns3xxx/Kconfig:2:warning: choice value used outside its choice group
> arch/arm/mach-bcm2835/Kconfig:2:warning: choice value used outside its choice group
> arch/arm/Kconfig:287:error: recursive dependency detected!
> arch/arm/Kconfig:287:   choice <choice> contains symbol ARCH_CNS3XXX
> arch/arm/Kconfig:366:   symbol ARCH_CNS3XXX depends on ARCH_MULTI_V6
> arch/arm/Kconfig:933:   symbol ARCH_MULTI_V6 depends on ARCH_MULTIPLATFORM
> arch/arm/Kconfig:292:   symbol ARCH_MULTIPLATFORM is part of choice <choice>

Thanks for the notification, I think git rerere picked up a wrong conflict resolution
again that I did earlier. I'll fix it when I do the next pulls today.

	Arnd
