From: davem@davemloft.net (David Miller)
Date: Tue, 09 Dec 2014 13:10:53 -0500 (EST)
Subject: [PATCH v7 2/3] net: Add Keystone NetCP ethernet driver
In-Reply-To: <1417556503-22290-3-git-send-email-m-karicheri2@ti.com>
References: <1417556503-22290-1-git-send-email-m-karicheri2@ti.com>
 <1417556503-22290-3-git-send-email-m-karicheri2@ti.com>
Message-ID: <20141209.131053.2026868499542642866.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>
Date: Tue, 2 Dec 2014 16:41:42 -0500

> +static void set_pkt_info_le(u32 buff, u32 buff_len, u32 ndesc,
> +			    struct knav_dma_desc *desc)
> +{
> +	desc->buff_len = cpu_to_le32(buff_len);
> +	desc->buff = cpu_to_le32(buff);
> +	desc->next_desc = cpu_to_le32(ndesc);
> +}

The members of knav_dma_desc are "u32", so you are going to get tons of
static checker warnings from trying to assign cpu_to_le32()'s result
(which is a le32) into them.
