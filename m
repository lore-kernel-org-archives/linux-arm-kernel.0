From: davem@davemloft.net (David Miller)
Date: Mon, 17 Aug 2015 12:25:48 -0700 (PDT)
Subject: [PATCH 2/5] net: add Hisilicon Network Subsystem hnae
 framework support
In-Reply-To: <1439548222-231611-3-git-send-email-liguozhu@hisilicon.com>
References: <1439548222-231611-1-git-send-email-liguozhu@hisilicon.com>
 <1439548222-231611-3-git-send-email-liguozhu@hisilicon.com>
Message-ID: <20150817.122548.203456335027850542.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kenneth Lee <liguozhu@hisilicon.com>
Date: Fri, 14 Aug 2015 18:30:19 +0800

> diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.c b/drivers/net/ethernet/hisilicon/hns/hnae.c
> new file mode 100644
> index 0000000..fd09768
> --- /dev/null
> +++ b/drivers/net/ethernet/hisilicon/hns/hnae.c
 ...
> +static inline void hnae_list_add(spinlock_t *lock, struct list_head *node,
> +				 struct list_head *head)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(lock, flags);
> +	list_add_tail_rcu(node, head);
> +	spin_unlock_irqrestore(lock, flags);
> +}

Do not declare functions 'inline' in foo.c files, let the compiler decide
on it's own.

This applies to your entire patch series.
