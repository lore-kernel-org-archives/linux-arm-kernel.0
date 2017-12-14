From: nbd@nbd.name (Felix Fietkau)
Date: Thu, 14 Dec 2017 11:17:50 +0100
Subject: [PATCH] mt76: fix memcpy to potential null pointer on failed
 allocation
In-Reply-To: <20171214101322.10178-1-colin.king@canonical.com>
References: <20171214101322.10178-1-colin.king@canonical.com>
Message-ID: <946512c8-0a56-5714-5411-279830701283@nbd.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-12-14 11:13, Colin King wrote:
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
Acked-by: Felix Fietkau <nbd@nbd.name>
