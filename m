From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jul 2011 15:19:31 -0400 (EDT)
Subject: [PATCH 18/51] ARM: kprobes: Extend arch_specific_insn to add
	pointer to emulated instruction
In-Reply-To: <1310209058-20980-19-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
	<1310209058-20980-19-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1107111515240.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 9 Jul 2011, Tixy wrote:

> --- a/arch/arm/kernel/kprobes.c
> +++ b/arch/arm/kernel/kprobes.c
> @@ -51,6 +51,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	kprobe_opcode_t insn;
>  	kprobe_opcode_t tmp_insn[MAX_INSN_SIZE];
>  	unsigned long addr = (unsigned long)p->addr;
> +	bool thumb;
>  	kprobe_decode_insn_t *decode_insn;
>  	int is;
>  
> @@ -58,6 +59,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  		return -EINVAL;
>  
>  #ifdef CONFIG_THUMB2_KERNEL
> +	thumb = 1;

When using a bool variable, you might want to assign it with "true" or 
"false" rather than "1" and "0".


Nicolas
