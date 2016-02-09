From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 9 Feb 2016 12:02:00 +0000
Subject: [PATCH v3 0/3] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <1455010262-28894-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455010262-28894-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <HKXPR06MB0565C2168EFA7CFF79C323DA8AD60@HKXPR06MB0565.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 Feb 2016, Ard Biesheuvel wrote:

>Ard Biesheuvel (3):
>  ARM: move .vectors and .stubs sections back into the kernel VMA
>  kallsyms: remove special lower address limit for CONFIG_ARM
>  kallsyms: remove --page-offset command line option
>
> arch/arm/kernel/entry-armv.S  | 3 +--
> arch/arm/kernel/vmlinux.lds.S | 6 ++++--
> scripts/kallsyms.c            | 8 --------
> scripts/link-vmlinux.sh       | 4 ----
> 4 files changed, 5 insertions(+), 16 deletions(-)


The linker script split (XIP vs non-XIP) has been applied, so now there's a vmlinux-xip.lds.S. So, you'd think you would need to mirror these changes in there (since the breakage of XIP_KERNEL is what started this).

Chris
