From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 13 Nov 2017 07:52:00 -0500
Subject: [PATCH] dmaengine: dmatest: move callback wait queue to thread
 context
In-Reply-To: <1510335864-25997-1-git-send-email-awallis@codeaurora.org>
References: <1510335864-25997-1-git-send-email-awallis@codeaurora.org>
Message-ID: <ed768b4f-7bcb-24a2-5fee-82f9f5954122@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2017 12:44 PM, Adam Wallis wrote:

> Cc: stable at vger.kernel.org
Hmm, I think I would need to submit a v2 of this patch removing the
stable at vger.kernel.org since this is dependent on my WARN patch in dma
linux-next tree...however, I don't know what the SHA of that patch will be until
it's in Linus' tree.

Any thoughts on that Vinod?

> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=197605
> Reviewed-by: Sinan Kaya <okaya@codeaurora.org>
> Suggested-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---
>  drivers/dma/dmatest.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 47edc7f..2573b6c 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
