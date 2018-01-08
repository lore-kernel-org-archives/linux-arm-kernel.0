From: kvalo@codeaurora.org (Kalle Valo)
Date: Mon,  8 Jan 2018 17:28:58 +0000 (UTC)
Subject: mt76: fix memcpy to potential null pointer on failed allocation
In-Reply-To: <20171214101322.10178-1-colin.king@canonical.com>
References: <20171214101322.10178-1-colin.king@canonical.com>
Message-ID: <20180108172858.9D82A60215@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Ian King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the allocation of skb fails and returns NULL then the
> call to skb_put will cause a null pointer dereference. Fix this by
> checking for a null skb and returning NULL.  Note that calls to
> function mt76x2_mcu_msg_alloc don't directly check the null return
> but instead pass the NULL pointer to mt76x2_mcu_msg_send which
> checks for the NULL and returns ENOMEM in this case.
> 
> Detected by CoverityScan, CID#1462624 ("Dereference null return value")
> 
> Fixes: 7bc04215a66b ("mt76: add driver code for MT76x2e")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers-next.git, thanks.

364bea50dbea mt76: fix memcpy to potential null pointer on failed allocation

-- 
https://patchwork.kernel.org/patch/10111747/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
