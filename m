From: yao.qi@arm.com (Yao Qi)
Date: Mon, 24 Jul 2017 12:52:12 +0100
Subject: [PATCH 00/11] ARMv8.3 pointer authentication userspace support
In-Reply-To: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
Message-ID: <46daaf0b-6b90-61cc-a25f-4177641d1613@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/17 17:01, Mark Rutland wrote:
> * Should the kernel remove PACs when unwinding user stacks?
>
>   This is simple to do, but it's arguably placing a policy in the kernel as to
>   what we expect user stacks to look like. Regardless, userspace will have to
>   perform this when unwinding with DWARF.

I am not sure what do you mean.  Do you mean stripping a PAC from a
pointer during unwinding, so that user space can unwind the program
without being aware of PAC?  Can kernel remove PAC from all instruction
pointers?  Note that user space debugger may try to unwind in coredump,
so if the contents dumped into coredump including PAC bits, debuggers
still have to be aware of PAC (unless kernel can remove all PAC bits
during coredump too).

IMO, kernel needs to tell the truth to reflect the process/task state
to the user space, and leave the user space to consume.
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
