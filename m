Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D51C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:32:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5B92087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G/QtZ3Zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5B92087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xfFwEYYbAjcoS+K70H+NGh2ZRSz8botJvOBk0oKzNvM=; b=G/QtZ3ZcjYfdyi
	OskwZH0Q9LeKi0evTkl36jLyxxxdmp7WouQ0jwE785oAbUTD227DK29gDg/qaW0DXIY5D9kc5ZGNY
	6gyxD6KV1bTgOeV6FVtVFy7l2pUDgurGVZYn6FpyHP7VLdyZ8+JBYaewEXdccuFCBd6QfzFREJCf7
	lSx4gHcEeVr+yjdw06PVYb/JGFzAggwotgrLQtyRwRHWhjIzYf9OYuYHWavtTxDqHtJQBAkZO2EPw
	mSD8DvPpS7J2oISHcCT+/8gISTTA3sbbssjjm6WlM1bq09oD4+c4tvnPnCLYpzX3ITYtyv9QYDZY9
	ObzPDhCidbwqpS1oFDOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosmU-0001EX-7z; Wed, 30 Jan 2019 16:32:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosmR-0001Dn-1Z; Wed, 30 Jan 2019 16:32:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EFA4EBD;
 Wed, 30 Jan 2019 08:32:02 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A45243F589;
 Wed, 30 Jan 2019 08:32:00 -0800 (PST)
Date: Wed, 30 Jan 2019 16:31:55 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: Mediatek: Use resource_size function on resource
 object
Message-ID: <20190130163155.GA5847@e107981-ln.cambridge.arm.com>
References: <1546409033-20412-1-git-send-email-honghui.zhang@mediatek.com>
 <20190130123347.GB30991@e107981-ln.cambridge.arm.com>
 <20190130155853.GE229773@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130155853.GE229773@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_083203_088230_18154DA4 
X-CRM114-Status: GOOD (  19.96  )
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
Cc: youlin.pei@mediatek.com, ryder.lee@mediatek.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianjun.wang@mediatek.com,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 09:58:53AM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 30, 2019 at 12:33:47PM +0000, Lorenzo Pieralisi wrote:
> > On Wed, Jan 02, 2019 at 02:03:53PM +0800, honghui.zhang@mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > drivers/pci/pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
> > > 
> > > Generated by: scripts/coccinelle/api/resource_size.cocci
> > > 
> > > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > index e307166..0168376 100644
> > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > @@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > >  	struct resource *mem = &pcie->mem;
> > >  	const struct mtk_pcie_soc *soc = port->pcie->soc;
> > >  	u32 val;
> > > -	size_t size;
> > >  	int err;
> > >  
> > >  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> > > @@ -706,8 +705,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > >  		mtk_pcie_enable_msi(port);
> > >  
> > >  	/* Set AHB to PCIe translation windows */
> > > -	size = mem->end - mem->start;
> > > -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> > > +	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(resource_size(mem)));
> > 
> > checkpatch warns on this line, please make sure patches pass it before
> > posting them.
> 
> I didn't actually run checkpatch myself, so I don't know why it
> complained.

WARNING: line over 80 characters
#35: FILE: drivers/pci/controller/pcie-mediatek.c:708:
+	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(resource_size(mem)));

I do run it as a sanity check.

> The patch you merged moves "mem_size = resource_size(mem)" higher up,
> away from the previous location and its use, which makes it a little
> harder to read.

That's because it was how the original code (which as you pointed out
is likely buggy) was written.

Anyway patch dropped waiting for a v2 consistent with your review -
apologies for missing some key review points.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
