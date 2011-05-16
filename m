From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 10:25:19 +0100
Subject: [PATCH 1/1] ARM: thumb: Fix thumb mode compilation problems.
In-Reply-To: <20110513195858.3C00140CD1@eskimo.mtv.corp.google.com>
References: <20110513195858.3C00140CD1@eskimo.mtv.corp.google.com>
Message-ID: <20110516092519.GL30539@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 12:58:58PM -0700, Vadim Bendebury wrote:
> diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
> index b5349b2..bcbfbab 100644
> --- a/arch/arm/mach-tegra/headsmp.S
> +++ b/arch/arm/mach-tegra/headsmp.S
> @@ -48,7 +48,8 @@ ENTRY(v7_invalidate_l1)
>  ENDPROC(v7_invalidate_l1)
>  
>  ENTRY(tegra_secondary_startup)
> -	msr	cpsr_fsxc, #0xd3
> +	mov     r0, #0xd3
> +	msr     cpsr_fsxc, r0

You should use the setmode assembly macro for this.  See
arch/arm/include/asm/assembler.h
