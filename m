From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Oct 2014 01:26:06 -0700
Subject: [PATCH] tracing/syscalls: ignore numbers outside NR_syscalls'
 range
In-Reply-To: <1414620418-29472-1-git-send-email-rabin@rab.in>
References: <1414620418-29472-1-git-send-email-rabin@rab.in>
Message-ID: <20141030082606.GA7945@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 11:06:58PM +0100, Rabin Vincent wrote:
> ARM has some private syscalls (for example, set_tls(2)) which lie
> outside the range of NR_syscalls.  If any of these are called while
> syscall tracing is being performed, out-of-bounds array access will
> occur in the ftrace and perf sys_{enter,exit} handlers.

While this patch looks like good caution, having syscalls outside of
NR_syscalls seems like a receipe for a disaster.  Can you try to fix
that issue as ell, please?
