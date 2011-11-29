From: stevenrwalter@gmail.com (Steven Walter)
Date: Tue, 29 Nov 2011 11:28:12 -0500
Subject: [RFC] ARM support for syscall tracing
Message-ID: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently noticed that "perf test" fails tests #2 - #4 on ARM.  In
investigating that failure, I noticed that those tests rely on
FTRACE_SYSCALLS, which was not available on ARM.

It didn't look like too much work to enable HAVE_SYSCALL_TRACEPOINTS, so
that's what I did in the patches that follow.  This is a
request-for-comment because I don't entirely understand some of the
changes I made, so it's quite likely that some parts are either
out-and-out wrong, or at least can be done a better way.

That said, the tests in "perf test" pass except for #1 (kallsyms), and
strace still seems to report sensible values for system calls.

Comments?
