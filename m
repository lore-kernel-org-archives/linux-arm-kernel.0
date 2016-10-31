From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 31 Oct 2016 14:34:05 -0600
Subject: [PATCH V2 6/6] arm64: Add uprobe support
In-Reply-To: <41cc70043792e65cbc3b4cc4ad7fbf6379afa550.1474960629.git.panand@redhat.com>
References: <cover.1474960629.git.panand@redhat.com>
 <41cc70043792e65cbc3b4cc4ad7fbf6379afa550.1474960629.git.panand@redhat.com>
Message-ID: <20161031203405.lql3w5c7nnhvupi5@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2016 at 01:18:00PM +0530, Pratyush Anand wrote:
> +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
> +		unsigned long addr)
> +{
> +	probe_opcode_t insn;
> +
> +	/* TODO: Currently we do not support AARCH32 instruction probing */
> +	if (test_bit(TIF_32BIT, &mm->context.flags))
> +		return -EINVAL;

This should be -ENOTSUPP.

-- 
Catalin
