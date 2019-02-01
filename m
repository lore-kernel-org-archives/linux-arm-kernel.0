Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEDDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:48:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EFC20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OqEuE8hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EFC20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D1XmubFdM44CjjXWGuAFJxjW2431iMnDUec6Pmo9O/M=; b=OqEuE8hqYx4100
	TKTaQOd6VdzRmV0qBVSNuE2M3IiFy3Ng3YCT9EJBQVdiYdIg9j1nuMbGJOakKcvKAEQ0UfJfoho07
	vvkBkb1VcT5eYErFu7oLYiLaRQF8+ae7td4HVPmA9L9S1pwmZxmlkfBoj09yQ/3R/4KALWzxONu1i
	/xTnDEIDuQQA2RpQqEdh8CzNpgYmX+cXII60PTORiDbb7cW+GxnYpPmVtJ7qqdKwc8TAsGkz7IpfJ
	yNio7qaXRTOQfZaf3x1BGUBHksxs2mxNg51UJmorHyN1sI5DXCO4wRmVuMc+mgrlykVBTUehy96OS
	S2PeuCr8XBbYlPc1PftA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpOs8-0001xZ-JC; Fri, 01 Feb 2019 02:48:04 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpOs4-0001wa-7S; Fri, 01 Feb 2019 02:48:02 +0000
X-UUID: 5effbbbd3a304995bb22f0623d896cbb-20190131
X-UUID: 5effbbbd3a304995bb22f0623d896cbb-20190131
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1218113656; Thu, 31 Jan 2019 18:47:51 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 18:47:49 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 1 Feb 2019 10:47:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 10:47:46 +0800
Message-ID: <1548989266.4980.39.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/2] PCI: mediatek: Use resource_size function on
 resource object
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 1 Feb 2019 10:47:46 +0800
In-Reply-To: <20190131213647.GP229773@google.com>
References: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
 <1548921713-5355-2-git-send-email-honghui.zhang@mediatek.com>
 <20190131213647.GP229773@google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_184800_278011_B4D86120 
X-CRM114-Status: GOOD (  25.65  )
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
Cc: youlin.pei@mediatek.com, lorenzo.pieralisi@arm.com, poza@codeaurora.org,
 fred@fredlawl.com, linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, jianjun.wang@mediatek.com,
 ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-31 at 15:36 -0600, Bjorn Helgaas wrote:
> On Thu, Jan 31, 2019 at 04:01:52PM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > scripts/coccinelle/api/resource_size.cocci complain about the
> > following warning:
> > 
> > pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
> > 
> > Use resource_size(mem) instead of mem->end - mem->start to eliminate the
> > complain. Since the MMIO window size for both MT2712 and MT7622 are all
> > 0x1000_0000, this change also fix the AHB2PCIe window size smaller than
> > HW MMIO window size issue by change the values of fls(size) from
> > fls(0xfff_ffff) to fls(0x1000_0000).
> 
> Good, I'm glad this actually fixes a bug.  The warning was actually
> useful!
> 
> Since that's the case, the *bug* is the important thing (not the
> warning), and the subject line should be about the bug fix.  The fact
> that it also happens to remove a warning is really just incidental.
> 
> You say "the AHB2PCIe window size smaller than HW MMIO window size
> issue" as though it should be familiar to us.  But it's not :)
> 

Oh, My bad.

The HW design assigned a bus address range(typically start from
0x2000_0000 to 0x2fff_ffff for both mt2712 and mt7622) for PCIe usage.
This means, when CPU or other HW access address in this range, PCIe RC
HW should response to this access. Normally it will translate those
access request to TLPs and send to EP side. Tt's like the total memory
resource which could be allocated by EP's BAR and RC's itself BAR.

Although those address range is available for allocated, but it should
be enabled by this PCIE_AHB_TRANS_BASE register, what size should be
enabled is determined by AHB2PCIE_SIZE bits in this register.

In previous code we did not enable the full size of HW assigned address
range, if the EP's BAR requested size is bigger than the size we enabled
and smaller than the HW available size. The access request from CPU
which address is bigger than the address we enabled but smaller that HW
available address, then RC will block those request and those request
will never get to EP side by TLPs.

Previous code never run into a system error in production because even
half of those range(128MB) is bigger enough for typical EP device's BAR
request(4MB).

But all those HW assigned bus range should be enabled. And it's Okay to
do that. RC will never forward a request to EP when this request is not
suitable for EP's BAR range.


> So the changelog needs to start by explaining what the AHB2PCIe window
> size issue is, mention what user-visible problem that causes, then
> explain how you're fixing it by using resource_size().
> 
> Then you can mention that this also incidentally removes a coccinelle
> warning.
> 

Okay, thanks for your advise.

> Bjorn
> 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 55e471c..01126b8 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  	struct resource *mem = &pcie->mem;
> >  	const struct mtk_pcie_soc *soc = port->pcie->soc;
> >  	u32 val;
> > -	size_t size;
> >  	int err;
> >  
> >  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> > @@ -706,8 +705,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  		mtk_pcie_enable_msi(port);
> >  
> >  	/* Set AHB to PCIe translation windows */
> > -	size = mem->end - mem->start;
> > -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> > +	val = lower_32_bits(mem->start)
> > +	      | AHB2PCIE_SIZE(fls(resource_size(mem)));
> 
> Nit: I think it's more typical to put the "|" on the first line.

Okay, will update this in next version.

Thanks for your comments.

> 
> >  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> >  
> >  	val = upper_32_bits(mem->start);
> > -- 
> > 2.6.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
