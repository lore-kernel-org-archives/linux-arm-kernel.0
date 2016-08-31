From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 31 Aug 2016 21:28:07 +0530
Subject: [PATCH V4 0/3] dmaengine: qcom_hidma: add error reporting
In-Reply-To: <1472656229-12955-1-git-send-email-okaya@codeaurora.org>
References: <1472656229-12955-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20160831155807.GZ9355@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 11:10:26AM -0400, Sinan Kaya wrote:
> Three changes in the error handling area:
> 
> 1. There is a race condition between data transfer callback and descriptor
>    free code. The callback routine may decide to clear the resources even
>    though the descriptor has not yet been freed.
> 
> 2. DMA Engine framework now supports direct error reporting to the client
>    via the callback.
> 
>    Pass the DMA errors to the client by passing a result argument. The HW
>    only supports a generic error when something goes wrong. That's why,
>    using DMA_TRANS_ABORTED all the time.
> 
> 3. The HIDMA driver is capable of error detection. However, the error was
>    not being passed back to the client when tx_status API is called.

Applied all, thanks

-- 
~Vinod
