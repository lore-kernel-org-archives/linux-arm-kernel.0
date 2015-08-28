From: horia.geanta@freescale.com (=?UTF-8?Q?Horia_Geant=c4=83?=)
Date: Fri, 28 Aug 2015 11:50:29 +0300
Subject: [PATCH v3] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <BN3PR0301MB0867591B07957C47F30C9711FE6E0@BN3PR0301MB0867.namprd03.prod.outlook.com>
References: <1438941784-38403-1-git-send-email-b18965@freescale.com>
 <55CB4829.40204@freescale.com> <55CE1FFE.2080200@freescale.com>
 <CAOMZO5By_15OCsb7z2pbywPi3n9vKGj=393hWYHVEQ32=jDNaA@mail.gmail.com>
 <BN3PR0301MB08672520CA978383BBF2CF6CFE790@BN3PR0301MB0867.namprd03.prod.outlook.com>
 <55D6073C.1020000@freescale.com>
 <BN3PR0301MB0867591B07957C47F30C9711FE6E0@BN3PR0301MB0867.namprd03.prod.outlook.com>
Message-ID: <55E020D5.4090201@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/28/2015 11:04 AM, Wang Huan-B18965 wrote:
> Hi, Horia,
> 
>> On 8/17/2015 6:42 AM, Wang Huan-B18965 wrote:
>>> Hi, Fabio,
>>
>> Please don't top post.
>>
>>>
>>> 	Based on the analysis and discussion, we prefer to use
>> ls1021a_defconfig and remove LS1021A from imx_v6_v7_defconfig.
>>
>> Alison, when you submit v4 for this patch (adding
>> CONFIG_ARCH_DMA_ADDR_T_64BIT=y as suggested), could you also send a
>> patch removing CONFIG_SOC_LS1021A from imx_v6_v7_config?
> [Alison Wang] I don?t know CONFIG_ARCH_DMA_ADDR_T_64BIT=y is suggested.
> Could you help to explain the suggestion?

Please see
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/072446.html

Instead of having CONFIG_ARCH_DMA_ADDR_T_64BIT=y in the defconfig, I
guess selecting it from Kconfig makes more sense:

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 573536f1bb73..bb417e73af0f 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -563,6 +563,7 @@ config SOC_LS1021A
        select HAVE_ARM_ARCH_TIMER
        select PCI_DOMAINS if PCI
        select ZONE_DMA if ARM_LPAE
+       select ARCH_DMA_ADDR_T_64BIT
        help
          This enables support for Freescale LS1021A processor.

Horia
