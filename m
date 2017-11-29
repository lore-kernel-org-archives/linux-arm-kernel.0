From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 29 Nov 2017 19:31:18 +0530
Subject: [PATCH] dmaengine: qcom_hidma: check pending interrupts
In-Reply-To: <1510671301-23223-1-git-send-email-okaya@codeaurora.org>
References: <1510671301-23223-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20171129140118.GF32417@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 09:55:01AM -0500, Sinan Kaya wrote:
> Driver is missing the interrupts if two requests are queued up at the same
> time as the interrupt handler is servicing a request that was just
> delivered.
> 
> The ISR clears the interrupt at the end but it could be clearing the
> interrupt for an outstanding event. Therefore, second interrupt never
> arrives.
> 
> Clear the interrupt first and then check for completions.
> 
> Also, make sure that request start and interrupt clear do not overlap in
> time by using a spinlock.

Applied, thanks

-- 
~Vinod
