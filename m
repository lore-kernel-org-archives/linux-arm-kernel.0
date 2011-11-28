From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Nov 2011 10:44:16 +0000
Subject: [PATCH v2 1/4] ARM: vexpress: Get rid of MMIO_P2V
In-Reply-To: <20111125161500.GD2098@localhost.localdomain>
References: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
 <1322060508-11298-2-git-send-email-pawel.moll@arm.com>
 <20111125161500.GD2098@localhost.localdomain>
Message-ID: <20111128104416.GD9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 04:15:00PM +0000, Dave Martin wrote:
> diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
> index d397a1f..0be2efc 100644
> --- a/arch/arm/plat-versatile/headsmp.S
> +++ b/arch/arm/plat-versatile/headsmp.S
> @@ -28,6 +28,7 @@ ENTRY(versatile_secondary_startup)
>  pen:	ldr	r7, [r6]
>  	cmp	r7, r0
>  	bne	pen
> +ENDPROC(versatile_secondary_startup)

This is wrong.  You're telling the assembler that this function ends here.
It doesn't, it continues on.  Put the ENDPROC at the end of the function.
