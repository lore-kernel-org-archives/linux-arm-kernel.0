From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Wed, 1 Dec 2010 23:01:47 +0200
Subject: [PATCH] Kconfig: add new symbol MIGHT_HAVE_PCI
In-Reply-To: <1291217412-9435-1-git-send-email-ulli.kroll@googlemail.com>
References: <1291217412-9435-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <AANLkTi=Myb9=dF0K=EKCeuTcL_kzY4wd+FkDQHYWsZSs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> ?config PCI
> - ? ? ? bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
> + ? ? ? bool "PCI support" if MIGHT_HAVE_PCI
> ? ? ? ?help
> ? ? ? ? ?Find out whether you have a PCI motherboard. PCI is the name of a
> ? ? ? ? ?bus system, i.e. the way the CPU talks to the other stuff inside

This used to enable PCI support for all KS8695-based boards.  (ARCH_KS8695)


> --- a/arch/arm/mach-ks8695/Kconfig
> +++ b/arch/arm/mach-ks8695/Kconfig
> @@ -4,6 +4,7 @@ menu "Kendin/Micrel KS8695 Implementations"
>
> ?config MACH_KS8695
> ? ? ? ?bool "KS8695 development board"
> + ? ? ? select MIGHT_HAVE_PCI
> ? ? ? ?help
> ? ? ? ? ?Say 'Y' here if you want your kernel to run on the original
> ? ? ? ? ?Kendin-Micrel KS8695 development board.

Where-as this only enables it for the KS8695 Development board (MACH_KS8695)....


Regards.
  Andrew Victor
