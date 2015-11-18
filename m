From: davem@davemloft.net (David Miller)
Date: Wed, 18 Nov 2015 13:52:50 -0500 (EST)
Subject: [PATCH V2 net-next 1/5] net:hns: Add support of Hip06 SoC to
 the Hislicon Network Subsystem
In-Reply-To: <1447786347-147518-2-git-send-email-salil.mehta@huawei.com>
References: <1447786347-147518-1-git-send-email-salil.mehta@huawei.com>
 <1447786347-147518-2-git-send-email-salil.mehta@huawei.com>
Message-ID: <20151118.135250.2066223916643044258.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Salil <salil.mehta@huawei.com>
Date: Wed, 18 Nov 2015 02:52:23 +0800

> @@ -387,19 +409,23 @@ static void hns_rcb_ring_get_cfg(struct hnae_queue *q, int ring_type)
>  	struct rcb_common_cb *rcb_common;
>  	struct ring_pair_cb *ring_pair_cb;
>  	u32 buf_size;
> -	u16 desc_num;
> -	int irq_idx;
> +	u16 desc_num, mdnum_ppkt;
> +	int irq_idx, is_ver1;

Please use "bool" and true/false for boolean conditions like is_ver1.

Please audit your entire submission for this problem.
