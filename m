From: vapier@gentoo.org (Mike Frysinger)
Date: Thu, 3 Nov 2011 18:16:33 -0400
Subject: [PATCH 0/3] Change ARCH_NR_GPIO into a Kconfig variable
In-Reply-To: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <201111031816.37427.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 November 2011 13:00:44 Peter De Schrijver wrote:
> This patchset converts ARCH_NR_GPIO to a Kconfig variable as suggested by
> Russel King. It also converts some platforms to the new model.
> 
> Peter De Schrijver (3):
>   ARM: ARCH_NR_GPIO: Make ARCH_NR_GPIO a Kconfig variable
>   ARM: mach-shmobile: Use CONFIG_ARCH_NR_GPIO
>   ARM: mach-ux500 Use CONFIG_ARCH_NR_GPIO
> 
>  arch/arm/Kconfig                           |   10 ++++++++++
>  arch/arm/include/asm/gpio.h                |    4 ++++
>  arch/arm/mach-shmobile/include/mach/gpio.h |    2 --
>  arch/arm/mach-ux500/include/mach/gpio.h    |    5 -----
>  4 files changed, 14 insertions(+), 7 deletions(-)

i'm not sure how this is an improvement.  we go from declaring the define in 
the right mach-specific subdir (arch/arm/mach-xxx/include/mach/gpio.h) to an 
arm-global file (arm/Kconfig).  i'd think the ideal would be to keep all the 
mach cruft in the mach-xxx/ subdir.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111103/925403fb/attachment.sig>
