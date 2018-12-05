Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1263AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:14:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF64A20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LZUulA+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF64A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:References:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZUkUTpn18kxgX8EHtb0rDxVYLm3WQJw9yUc5fEhyluo=; b=LZUulA+VXicF3g
	rzyhCZpZ+w4GnnUDqzAzansF6IvW75mEGC6rAkuk4qmNbfP+UPBE2h8V+iUykCsy2bRwfEBfzOU/I
	8h+dxvgfT4pIijrjXA9V+AbPwBrZWpY/ijFlpLktiZY8ZlHJBJMuI1VvsNcmR6X10/nemcZP8dqfR
	PzHf9vtJhZvkLhccjqowqr7jPzNipeERBIWiB2zdskTWnJs78w8NsLha7vPbOqVB1CDQndxSOTtI3
	Xk3DjUUZW05WTgzVRsvAdL6lVqqnnVWxyPjOQwuCRO97cc/RNt04iZHqcmKw3sY/JbY9Yoy/fabZE
	1iL/F7W1vQI7DzPmk+fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUMhX-0006SK-3a; Wed, 05 Dec 2018 02:14:11 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUMhT-0006Gz-8x
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 02:14:09 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 05 Dec 2018 11:13:53 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 97FD160062;
 Wed,  5 Dec 2018 11:13:53 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 5 Dec 2018 11:13:53 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id F258140377;
 Wed,  5 Dec 2018 11:13:52 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
 by yuzu.css.socionext.com (Postfix) with ESMTP id B7A94120304;
 Wed,  5 Dec 2018 11:13:52 +0900 (JST)
Date: Wed, 05 Dec 2018 11:13:52 +0900
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 2/2] PCI: uniphier: Add UniPhier PCIe host controller
 support
In-Reply-To: <20181204151227.GA29926@e107981-ln.cambridge.arm.com>
References: <1543377866-16634-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20181204151227.GA29926@e107981-ln.cambridge.arm.com>
Message-Id: <20181205111351.00E3.4A936039@socionext.com>
MIME-Version: 1.0
X-Mailer: Becky! ver. 2.70 [ja]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_181407_494715_B91E7932 
X-CRM114-Status: GOOD (  16.28  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Rob Herring <robh+dt@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lorenzo,

On Tue, 4 Dec 2018 15:12:27 +0000 <lorenzo.pieralisi@arm.com> wrote:

> On Wed, Nov 28, 2018 at 01:04:26PM +0900, Kunihiko Hayashi wrote:
> 
> [...]
> 
> > +static void uniphier_pcie_irq_ack(struct irq_data *d)
> > +{
> > +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > +	u32 val;
> > +
> > +	val = readl(priv->base + PCL_RCV_INTX);
> > +	val &= ~PCL_RCV_INTX_ALL_STATUS;
> > +	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
> > +	writel(val, priv->base + PCL_RCV_INTX);
> > +}
> > +
> > +static void uniphier_pcie_irq_mask(struct irq_data *d)
> > +{
> > +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > +	u32 val;
> > +
> > +	val = readl(priv->base + PCL_RCV_INTX);
> > +	val &= ~PCL_RCV_INTX_ALL_STATUS;
> > +	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
> > +	writel(val, priv->base + PCL_RCV_INTX);
> > +}
> > +
> > +static void uniphier_pcie_irq_unmask(struct irq_data *d)
> > +{
> > +	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > +	u32 val;
> > +
> > +	val = readl(priv->base + PCL_RCV_INTX);
> > +	val &= ~PCL_RCV_INTX_ALL_STATUS;
> 
> I have noticed this operation is carried out on ACK/MASK/UNMASK,
> what's its purpose ?

Thanks for pointing out. This is wrong.

The register PCL_RCV_INTX has 3 parts of bits.

#define PCL_RCV_INTX_ALL_ENABLE         GENMASK(19, 16)
#define PCL_RCV_INTX_ALL_MASK           GENMASK(11, 8)
#define PCL_RCV_INTX_ALL_STATUS         GENMASK(3, 0)

In the mask/unmask operation,
We should use PCL_RCV_INTX_ALL_MASK to represent 'mask bits',
not PCL_RCV_INTX_ALL_STATUS.
And the ack operation is effective by writing 1 to 'status bits'.

Thank you,

---
Best Regards,
Kunihiko Hayashi



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
