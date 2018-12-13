Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027DEC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:37:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FB720849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jydzrdXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FB720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zQiANUgpvbqWWxCnPeCJ9dVcj9e9yM/g3hFtE16Xwuc=; b=jydzrdXsf50uW59OCj8zW/rQq9
	rjPlHofBToJzskPl1eiA3fENNAmcOescMbllNJjmq9Dr0LcW5MKIO4tBWRF5rz5wAh30Ot3G5V2y0
	8YNLvlaSgBhDrduIgJMCxKo9GXLA0xYmCMwHdZkoJFalIQU497vTg89xVy3k/A+Y4xphRvi8zaWxR
	YNB7h1/Y0s6tus1xzHFigeU8JjW8jSye4EsNg0ekNxFlDjNB8O4FT+FMce9oGhnnZnVxWGCgPozQL
	gG36adu8o0P24BBhfbrswG69E0pGm9klslF+zbqbdFARRQbACEv87CothA/rNo9EkYeOLhJHVIb3k
	lmASoWUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKcG-00063p-EU; Thu, 13 Dec 2018 06:37:00 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKcB-00062n-Jh
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:36:58 +0000
Received: from tarshish (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id B92F744083B;
 Thu, 13 Dec 2018 08:36:39 +0200 (IST)
References: <1544681043-3792-1-git-send-email-hongxing.zhu@nxp.com>
User-agent: mu4e 1.0; emacs 25.2.2
From: Baruch Siach <baruch@tkos.co.il>
To: Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH] PCI: imx: make msi work without pcieportbus
In-reply-to: <1544681043-3792-1-git-send-email-hongxing.zhu@nxp.com>
Date: Thu, 13 Dec 2018 08:36:39 +0200
Message-ID: <874lbi6ih4.fsf@tkos.co.il>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_223655_880968_F69F2F76 
X-CRM114-Status: GOOD (  16.22  )
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
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Richard,

Thanks for debugging this issue. One question below.

Richard Zhu writes:
> MSI_EN of iMX PCIe RC would be asserted when
> PCIEPORTBUS driver is selected.
> Thus, the MSI works fine on iMX PCIe before.
> Make a double check on this bit, and assert it
> when it is not set and MSI is supported.
> Otherwise, the MSI wouldn't be triggered although
> the EP is present and the MSIs are assigned.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 26087b3..6c3e56b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -74,6 +74,7 @@ struct imx6_pcie {
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> +#define PCI_MSI_CAP				0x50
>  #define PCIE_RC_LCR				0x7c
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
> @@ -926,6 +927,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
>  	int ret;
> +	u16 val;
>  
>  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>  	if (!imx6_pcie)
> @@ -1070,6 +1072,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	ret = imx6_add_pcie_port(imx6_pcie, pdev);
>  	if (ret < 0)
>  		return ret;
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		val = dw_pcie_readw_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS);
> +		if ((val & PCI_MSI_FLAGS_ENABLE) == 0) {
> +			val |= PCI_MSI_FLAGS_ENABLE;

Why not assert the PCI_MSI_FLAGS_ENABLE flag unconditionally here?

> +			dw_pcie_writew_dbi(pci, PCI_MSI_CAP +
> +					PCI_MSI_FLAGS, val);
> +		}
> +	}
>  
>  	return 0;
>  }

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
