From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 8 Nov 2017 11:23:59 +0530
Subject: [PATCH v2] dmaengine: dmatest: warn user when dma test times out
In-Reply-To: <1509627210-16904-1-git-send-email-awallis@codeaurora.org>
References: <1509627210-16904-1-git-send-email-awallis@codeaurora.org>
Message-ID: <20171108055358.GO3187@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 08:53:30AM -0400, Adam Wallis wrote:
> Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
> introduced a bug (that is in fact documented by the patch commit text)
> that leaves behind a dangling pointer. Since the done_wait structure is
> allocated on the stack, future invocations to the DMATEST can produce
> undesirable results (e.g., corrupted spinlocks). Ideally, this would be
> cleaned up in the thread handler, but at the very least, the kernel
> is left in a very precarious scenario that can lead to some long debug
> sessions when the crash comes later.
> 
> This bug has also been captured at
> https://bugzilla.kernel.org/show_bug.cgi?id=197605

I have made it 

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197605

> Signed-off-by: Adam Wallis <awallis@codeaurora.org>

and applied. Thanks

-- 
~Vinod
