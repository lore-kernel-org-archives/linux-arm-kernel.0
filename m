From: stevenrwalter@gmail.com (Steven Walter)
Date: Wed, 30 Nov 2011 09:46:19 -0500
Subject: ARM support for syscall tracing
Message-ID: <1322664382-21793-1-git-send-email-stevenrwalter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I believe I have incorporated all of the suggestions given on the
previous patches.  Unfortunately, NR_syscalls is still a hard-coded
number.  I implemented making it a variable that was exported from
entry-common.o, but there are places that assume that NR_syscalls is a
constant known at compile time:

kernel/trace/trace_syscalls.c:15:
    static DECLARE_BITMAP(enabled_enter_syscalls, NR_syscalls);

However, entry-common.S will check to ensure that a call doesn't get
added to the table without bumping NR_syscalls when needed.  I'm not
sure this can be improved upon without tearing up core kernel code.

Suggestions welcome!
