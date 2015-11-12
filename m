From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 12 Nov 2015 13:15:46 +0000
Subject: [PATCH] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <5644836B.2050608@hurleysoftware.com>
References: <1447251455-22731-1-git-send-email-chris.brandt@renesas.com>
 <5644836B.2050608@hurleysoftware.com>
Message-ID: <HK2PR06MB0561F3180FECBCEA5B9D670C8A120@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think below is required as well.
>
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -34,7 +36,7 @@
>   * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
>   */
>  #undef MODULES_VADDR
> -#define MODULES_VADDR	(((unsigned long)_etext + ~PMD_MASK) & PMD_MASK)
> +#define MODULES_VADDR	(((unsigned long)_edata_loc + ~PMD_MASK) & PMD_MASK)
>  #endif


Thank you!
Somehow I missed that file when I was moving from one tree to another when preparing my commits.

I'll update and resubmit the patch.

Chris
