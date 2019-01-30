Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A39FC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:59:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A62207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hf7UT5gs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBajxy6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A62207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=di75fvO1IoIqSvHyq0xhF1owyzgaulO7wQaOkUM+3VI=; b=hf7UT5gsI8SadC
	XvGTRp1Wiuh6WyUh2a9Gwj6AJzoEqRUiMEbmagxAsS6rOEg3jqYa9Pt0L0BgUI+qQhAc5FGby29jr
	Cvtne1PHTzf+SP9XsN2TZZbpTWpH2qD3Sqf6OzOMPDsSMh8rG/Q26ni39MTGCvzRJmeIp0rdlHP+f
	dUH42Vm4e8RXW1WH/b59IjaOrbslTszqJ0jW2Wnqied/UjUodYVmWY+GrIw/3CEOX1qQ020PR5gyn
	4Fm1Z4KFSY83mMZKDC3MvCfm4hXR0Z9x1Ih81IBfokBTI8UYTaoSKCOmFB3qETZ/irAPODfH9F8NC
	SPVTyYobYEx2cHutDSeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosGZ-0001Cq-5S; Wed, 30 Jan 2019 15:59:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosGV-0001Bv-A0; Wed, 30 Jan 2019 15:59:05 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5B4FC207E0;
 Wed, 30 Jan 2019 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548863942;
 bh=sWdaExTiKujbd8IQNRc7yOGDcun7jZXiCntXA8mOtJE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vBajxy6GsV28qbzKmLhMEJZFwtFeXmnbdu4P6syzmfyY1OgxZoev0sY6iXvF8mx9+
 Mpa34EYffI9U8KzGYStLDqczFYo47xutzziTS9AVHkHfg+r8eIhobw818xuzEbO+Mk
 ydEiKzz3fX3M2NaFPXS0Eizq6OOu/MmdMGfDTbVA=
Date: Wed, 30 Jan 2019 09:58:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: Mediatek: Use resource_size function on resource
 object
Message-ID: <20190130155853.GE229773@google.com>
References: <1546409033-20412-1-git-send-email-honghui.zhang@mediatek.com>
 <20190130123347.GB30991@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130123347.GB30991@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_075903_365502_E26DA3DF 
X-CRM114-Status: GOOD (  15.64  )
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

On Wed, Jan 30, 2019 at 12:33:47PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 02, 2019 at 02:03:53PM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > drivers/pci/pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
> > 
> > Generated by: scripts/coccinelle/api/resource_size.cocci
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index e307166..0168376 100644
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
> > @@ -706,8 +705,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  		mtk_pcie_enable_msi(port);
> >  
> >  	/* Set AHB to PCIe translation windows */
> > -	size = mem->end - mem->start;
> > -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> > +	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(resource_size(mem)));
> 
> checkpatch warns on this line, please make sure patches pass it before
> posting them.

I didn't actually run checkpatch myself, so I don't know why it
complained.

The patch you merged moves "mem_size = resource_size(mem)" higher up,
away from the previous location and its use, which makes it a little
harder to read.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
