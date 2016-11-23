From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Wed, 23 Nov 2016 21:18:29 +0530
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <583478FB.4020008@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
Message-ID: <20161123154829.GA2489@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 22, 2016 at 04:57:31PM +0000, Vladimir Murzin wrote:

> I used defconfigs

Which defconfig was used ?

multi_v7_defconfig, MMU & SMP disabled - thus spake the compiler,

kernel/built-in.o: In function `kimage_free_entry':
memremap.c:(.text+0x4dafc): undefined reference to
`arch_phys_to_idmap_offset'
memremap.c:(.text+0x4db04): undefined reference to
`arch_phys_to_idmap_offset'
kernel/built-in.o: In function `kimage_alloc_page':
memremap.c:(.text+0x4dbc0): undefined reference to
`arch_phys_to_idmap_offset'
memremap.c:(.text+0x4dbc8): undefined reference to
`arch_phys_to_idmap_offset'
memremap.c:(.text+0x4dc1c): undefined reference to
`arch_phys_to_idmap_offset'
kernel/built-in.o:memremap.c:(.text+0x4dc30): more undefined
references to `arch_phys_to_idmap_offset' follow

multi_v7_defconfig & MMU disabled, stderr was more verbose and was
unhappy with Kconfig dependencies,

warning: (SOC_IMX31 && SOC_IMX35 && SOC_VF610 && REALVIEW_DT) selects
SMP_ON_UP which has unmet direct dependencies (SMP && !XIP_KERNEL &&
MMU)
warning: (SOC_IMX31 && SOC_IMX35 && SOC_VF610 && REALVIEW_DT) selects
SMP_ON_UP which has unmet direct dependencies (SMP && !XIP_KERNEL &&
MMU)

Ulterior motive here is to try !MMU on Cortex A

Regards
afzal
