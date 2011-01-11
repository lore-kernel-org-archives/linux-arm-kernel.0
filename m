From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 10:40:51 +0000
Subject: [RFC] arm: Defer lookup of machine_type and vet of atags to
	setup.c
In-Reply-To: <20110111015409.18291.87166.stgit@localhost6.localdomain6>
References: <20110111015409.18291.87166.stgit@localhost6.localdomain6>
Message-ID: <20110111104051.GA11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 07:15:53PM -0700, Grant Likely wrote:
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 6bd82d2..9c0e938 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -87,11 +87,6 @@ ENTRY(stext)
>  	movs	r10, r5				@ invalid processor (r5=0)?
>   THUMB( it	eq )		@ force fixup-able long branch encoding
>  	beq	__error_p			@ yes, error 'p'
> -	bl	__lookup_machine_type		@ r5=machinfo
> -	movs	r8, r5				@ invalid machine (r5=0)?
> - THUMB( it	eq )		@ force fixup-able long branch encoding
> -	beq	__error_a			@ yes, error 'a'
> -	bl	__vet_atags
>  #ifdef CONFIG_SMP_ON_UP
>  	bl	__fixup_smp
>  #endif

Don't forget to update the comments as well - there's two of them.
