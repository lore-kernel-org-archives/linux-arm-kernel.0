From: sophian.yoma@gmail.com (yoma sophian)
Date: Fri, 17 Feb 2017 18:57:15 +0800
Subject: some question about arm stacktrace.c
Message-ID: <CADUS3okcFOUUKV0yxyXJXEr54UzHzTFSEsrhqvXjPaNybDFLVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
I found in commit 07b403415884e961920f55e6db462dff15d9df5a,
we add below modification in function, save_trace,

+       regs = (struct pt_regs *)frame->sp;
+
+       trace->entries[trace->nr_entries++] = regs->ARM_pc;
+

what makes me curious is with framepointer enabled, a simple function
prologue looks like this:
     mov    ip, sp
     stmdb    sp!, {fp, ip, lr, pc}
     sub    fp, ip, #4
and  simple function epilogue looks like this:
    ldm    sp, {fp, sp, pc}

it seems ARM only save pt_regs while entering usr_entry in entry-armv.S.
if above are correct, I cannot tell the reason why we use (struct
pt_regs *) to map fram->sp to get pc counter for each frame when
backtrace.

thanks for your help in advance,
