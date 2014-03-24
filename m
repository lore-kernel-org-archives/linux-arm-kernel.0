From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Mar 2014 18:23:58 +0100
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <CAGVrzcaY257MAjjmkXDi_fD5TxSanmx9Jpvx-yg7vT3-GUjz3A@mail.gmail.com>
References: <1395670496-17381-1-git-send-email-zhangfei.gao@linaro.org>
 <1395670496-17381-4-git-send-email-zhangfei.gao@linaro.org>
 <CAGVrzcaY257MAjjmkXDi_fD5TxSanmx9Jpvx-yg7vT3-GUjz3A@mail.gmail.com>
Message-ID: <4644970.WiIKNXNpdP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 March 2014 09:32:17 Florian Fainelli wrote:
> > +       priv->tx_skb[tx_head] = skb;
> > +       priv->tx_phys[tx_head] = phys;
> > +       desc->send_addr = cpu_to_be32(phys);
> > +       desc->send_size = cpu_to_be16(skb->len);
> > +       desc->cfg = cpu_to_be32(DESC_DEF_CFG);
> > +       phys = priv->tx_desc_dma + tx_head * sizeof(struct tx_desc);
> > +       desc->wb_addr = cpu_to_be32(phys);
> 
> Don't we need a barrier here to ensure that all stores are completed
> before we hand this descriptor address to hip40_set_xmit_desc() which
> should make DMA start processing it?

I would think the writel() in set_xmit_desc() implies the barrier.

	Arnd
