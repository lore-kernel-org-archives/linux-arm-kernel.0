From: v.narang@samsung.com (Vaneet Narang)
Date: Tue, 03 Apr 2018 18:28:04 +0530
Subject: [PATCH v2] arm/stacktrace: stop unwinding after an invalid
 address.
In-Reply-To: <1521630645-46715-1-git-send-email-maninder1.s@samsung.com>
References: <1521630645-46715-1-git-send-email-maninder1.s@samsung.com>
 <CGME20180321111139epcas5p4d5b75f4e1b572ae4e55aef737cd6d8e9@epcms5p3>
Message-ID: <1166142499.594566.1522760284362.JavaMail.jboss@ep1ml501>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?
Hi Russell,


>__dabt_usr+0x44/0x60
>0xb6748ea4
>^^^^^^^^

>--- a/arch/arm/kernel/stacktrace.c
>+++ b/arch/arm/kernel/stacktrace.c
>@@ -92,6 +92,9 @@ static int save_trace(struct stackframe *frame, void *d)
> 
> 	regs = (struct pt_regs *)frame->sp;
>
>+	if (!__kernel_text_address(regs->ARM_pc))
>+		return 1;
>+
> 	trace->entries[trace->nr_entries++] = regs->ARM_pc;
 
?
Any Inputs or Comments on this patch to avoid storing user space entries 
during unwind.
?
Regards,
Vaneet Narang
-------------- next part --------------
A non-text attachment was scrubbed...
Name: rcptInfo.txt
Type: application/octet-stream
Size: 1636 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/79f28a2f/attachment-0001.obj>
