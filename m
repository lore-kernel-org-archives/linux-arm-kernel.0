From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Nov 2011 23:50:32 +0000
Subject: [PATCH 1/1 v5] arm: fault.c: Port OOM changes into do_page_fault
In-Reply-To: <1321986690-6079-1-git-send-email-consul.kautuk@gmail.com>
References: <1321986690-6079-1-git-send-email-consul.kautuk@gmail.com>
Message-ID: <20111126235032.GC9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 01:31:30PM -0500, Kautuk Consul wrote:
> Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
> (mm: retry page fault when blocking on disk transfer) and
> commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
> (x86,mm: make pagefault killable)
> 
> The above commits introduced changes into the x86 pagefault handler
> for making the page fault handler retryable as well as killable.
> 
> These changes reduce the mmap_sem hold time, which is crucial
> during OOM killer invocation.
> 
> Port these changes to ARM.
> 
> Without these changes, my ARM board encounters many hang and livelock
> scenarios.
> After applying this patch, OOM feature performance improves according to
> my testing.
> 
> Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>

Thanks.  I think this is fine.  Please put it in the patch system so it's
not forgotten, and I'll get to it sometime during the next week.  Thanks.
