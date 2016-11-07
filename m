From: panand@redhat.com (Pratyush Anand)
Date: Mon, 7 Nov 2016 23:03:44 +0530
Subject: [PATCH V3 0/6] ARM64: Uprobe support added
In-Reply-To: <20161107113944.GB28876@MBP.local>
References: <cover.1478068479.git.panand@redhat.com>
 <20161104174951.vj4il3xkdy7a2ln7@localhost>
 <20161104184652.rxllldll4qfe7qdn@localhost>
 <e1593d0d-b63c-cc7b-fcee-753b5bd8f0de@redhat.com>
 <20161107113944.GB28876@MBP.local>
Message-ID: <5cb8b7bc-df6f-8744-b345-4762f2435201@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 07 November 2016 05:09 PM, Catalin Marinas wrote:
>> diff --git a/arch/arm64/kernel/probes/decode-insn.c
>> > b/arch/arm64/kernel/probes/decode-insn.c
>> > index 8a29d29..6bf6657 100644
>> > --- a/arch/arm64/kernel/probes/decode-insn.c
>> > +++ b/arch/arm64/kernel/probes/decode-insn.c
>> > @@ -17,7 +17,6 @@
>> >  #include <linux/kprobes.h>
>> >  #include <linux/module.h>
>> >  #include <linux/kallsyms.h>
>> > -#include <asm/kprobes.h>
>> >  #include <asm/insn.h>
>> >  #include <asm/sections.h>
>> >
>> > So, do you want me to send V4 or a separate topup fixup patch. Please let me
>> > know, will do accordingly.
> Just a separate patch on top of your series would do. Also please test
> your series with CONFIG_KPROBE disabled and I assume this wasn't done
> (just in case there is an interaction we were not aware of).

OK, I tested by disabling CONFIG_KPROBE, and uprobe tests worked fine.

~Pratyush
