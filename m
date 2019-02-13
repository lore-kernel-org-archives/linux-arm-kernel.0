Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9A1C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:40:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FC6222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WiUnh9Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FC6222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZyQHsidcbfDKK1qA/LdWRgGmuQnuCgG+OBwUGdfwBqA=; b=WiUnh9MliSuvxz
	+oG3OOrgU7sU+FyvstmSLILKmog4rWaJw71oNfY3jdvALs9ZoQ97IwYEjRTKsGggXy1MfCgZ/jO8X
	mj/cUEQxyFDJUhITi7LfaYyBiQUFzjjhYqD3Kx+Uq003KPOr+FBpLVnQRTdDaGyR1cFOp//qpM6z4
	dSVRAFtpFKFlRsBi5vxLgTD1PeG1rI/S9CxBOG3AbalF+dQy9xDXXhrOJxPZjVLmMVEk6vhBe8Wih
	vw4JEbZxE84JxdEHsEZtHDfAo4eFNlfc1q5Beob6F58aeQq+97jePWOE42V4OU7mXbVi4OPyIdL3E
	il+SuUtgjF9fhYHmIxPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtxaM-0005xm-41; Wed, 13 Feb 2019 16:40:34 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtxaD-0005l4-2E
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 16:40:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFA61A78;
 Wed, 13 Feb 2019 08:40:22 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0A823F675;
 Wed, 13 Feb 2019 08:40:21 -0800 (PST)
Date: Wed, 13 Feb 2019 16:40:19 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: Re: [PATCH] PCI: xilinx-nwl: Fix Multi MSI data programming
Message-ID: <20190213164019.GD2280@e107981-ln.cambridge.arm.com>
References: <1550067939-9859-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550067939-9859-1-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_084025_361112_7D5D3624 
X-CRM114-Status: GOOD (  15.85  )
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
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 07:55:39PM +0530, Bharat Kumar Gogada wrote:
> The current Multi MSI data programming fails if a
> end point is connected with switch.
> 
> Fix Multi MSI data, by programming data with required alignment.

I have no idea what this means. If you are fixing a bug describe
it properly and provide a Fixes: tag with the commit you are fixing.

Thanks,
Lorenzo

> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 81538d7..36669c5 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -484,7 +484,7 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  
>  	mutex_lock(&msi->lock);
>  	bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> -					 nr_irqs, 0);
> +					 nr_irqs, nr_irqs - 1);
>  	if (bit >= INT_PCI_MSI_NR) {
>  		mutex_unlock(&msi->lock);
>  		return -ENOSPC;
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
