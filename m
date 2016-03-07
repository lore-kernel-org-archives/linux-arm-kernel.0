From: kvalo@codeaurora.org (Kalle Valo)
Date: Mon,  7 Mar 2016 12:39:54 +0000 (UTC)
Subject: [V3] mt7601u: do not free dma_buf when ivp allocation fails
In-Reply-To: <1456442667-19751-1-git-send-email-colin.king@canonical.com>
Message-ID: <20160307123954.8575E60375@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Colin Ian King <colin.king@canonical.com>
> 
> If the allocation of ivp fails the error handling attempts to
> free an uninitialized dma_buf; this data structure just contains
> garbage on the stack, so the freeing will cause issues when the
> urb, buf and dma fields are free'd. Fix this by not free'ing the
> dma_buf if the ivp allocation fails.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks, applied to wireless-drivers-next.git.

Kalle Valo
