Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889F8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:36:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5844420B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iAkJoKkA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwYcQWON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5844420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=27j1p/qJZWXLCFi7s9IYjCtZG+H87Ee2qRhu5QoB13c=; b=iAkJoKkAiCp1/h
	tICFjkBZJ4RXLm7+HLzUAPnpBBp8x80Jos/8S/hcdra1L/DoqYmhTIHtNi8l/RQl4uOcdqajPaV8q
	v2pgPrNTfP7ZpCzSSHbYtSJI6rC9uPHRcjJ1GUL71ynikqBhuhAO7AB/BZQwBqSDRexp43ZnowPQ3
	ZCbX9KZdfvuz8Ipx04J+aaBYgNYyY9I/0yARqgSCFNHDeHCHZW4+BO0nKSGCBxzq1FKDkQHDK0EnN
	vIBfga0PFT+gEgh4J1EdFpFFTBWwWv3Lym71Div4Nhk2TUls6D/SnbDkor4B0kF1/nUpv7rij5OQU
	1i9Y9y1JsMsouYgdlXLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpK10-0006h9-Nc; Thu, 31 Jan 2019 21:36:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpK0v-0006gU-Hw; Thu, 31 Jan 2019 21:36:53 +0000
Received: from localhost (unknown [64.22.249.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DFD0D20B1F;
 Thu, 31 Jan 2019 21:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548970609;
 bh=yzcBI/0W24G8x1f5Xr7NzrPSRHBlzH6cM6XBb1PH/E0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CwYcQWONddNQY/fG6Ssf7+ZHJeTZIt7kJrFIKQljHYXDtt9ecaDAX37L+VfRQn8Ad
 JQqt7DvgSEHAJLcuitY7wZWbYQOQNbMMqNYso5BKaxX421pFqFqX5Pe2J5AwX/GrAC
 q0FUJ/3cd+K4JYK8trBbktRwTyEG8+gQiuLG8wn8=
Date: Thu, 31 Jan 2019 15:36:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v2 1/2] PCI: mediatek: Use resource_size function on
 resource object
Message-ID: <20190131213647.GP229773@google.com>
References: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
 <1548921713-5355-2-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548921713-5355-2-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_133649_628697_49957D2E 
X-CRM114-Status: GOOD (  19.14  )
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

On Thu, Jan 31, 2019 at 04:01:52PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> scripts/coccinelle/api/resource_size.cocci complain about the
> following warning:
> 
> pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
> 
> Use resource_size(mem) instead of mem->end - mem->start to eliminate the
> complain. Since the MMIO window size for both MT2712 and MT7622 are all
> 0x1000_0000, this change also fix the AHB2PCIe window size smaller than
> HW MMIO window size issue by change the values of fls(size) from
> fls(0xfff_ffff) to fls(0x1000_0000).

Good, I'm glad this actually fixes a bug.  The warning was actually
useful!

Since that's the case, the *bug* is the important thing (not the
warning), and the subject line should be about the bug fix.  The fact
that it also happens to remove a warning is really just incidental.

You say "the AHB2PCIe window size smaller than HW MMIO window size
issue" as though it should be familiar to us.  But it's not :)

So the changelog needs to start by explaining what the AHB2PCIe window
size issue is, mention what user-visible problem that causes, then
explain how you're fixing it by using resource_size().

Then you can mention that this also incidentally removes a coccinelle
warning.

Bjorn

> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 55e471c..01126b8 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	struct resource *mem = &pcie->mem;
>  	const struct mtk_pcie_soc *soc = port->pcie->soc;
>  	u32 val;
> -	size_t size;
>  	int err;
>  
>  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> @@ -706,8 +705,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		mtk_pcie_enable_msi(port);
>  
>  	/* Set AHB to PCIe translation windows */
> -	size = mem->end - mem->start;
> -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> +	val = lower_32_bits(mem->start)
> +	      | AHB2PCIE_SIZE(fls(resource_size(mem)));

Nit: I think it's more typical to put the "|" on the first line.

>  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
>  
>  	val = upper_32_bits(mem->start);
> -- 
> 2.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
