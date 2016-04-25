From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Mon, 25 Apr 2016 15:15:57 +0100
Subject: [PATCHv3 1/5] efi/runtime-wrappers: detect FW irq flag corruption
In-Reply-To: <571E25B1.8070305@arm.com>
References: <1461591994-14918-1-git-send-email-mark.rutland@arm.com>
 <1461591994-14918-2-git-send-email-mark.rutland@arm.com>
 <571E25B1.8070305@arm.com>
Message-ID: <20160425141557.GA2829@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Apr, at 03:12:01PM, Robin Murphy wrote:
> >+static void efi_call_virt_check_flags(unsigned long flags, const char *call)
> >+{
> >+	unsigned long cur_flags;
> >+	bool mismatch;
> >+
> >+	local_save_flags(cur_flags);
> >+
> >+	mismatch = !!((cur_flags ^ flags) & ARCH_EFI_IRQ_FLAGS_MASK);
> 
> nit: the assignment itself is already a conversion to bool, so the
> excitement is redundant here.

This was intentional. I asked Mark to make this change so that it's
explicit for the developer that we're performing the type conversion. 
