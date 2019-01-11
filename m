Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF2DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:53:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EC82084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gk22RU4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EC82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/JnOe1jex7gM0kf16F+FN3fzVr4yeFiXEJBFvonRXsk=; b=Gk22RU4yoIWNEx
	rx6PVZ8qT/Be0ntkRww6LVL4qyZwGiVpMtvESUub29ufqWjzYWKo8+NI6NoCCpqRD/GlWBp96bsVd
	csYKSnN+4F++Qoa3/HVXZO2v9hMunxDiGnh+SUeHd2Ch3XNdZ7HxZHe0XO4DT6CCH7GHI40wTfDFl
	bujrK5vJ58kwK3JtjrXnYUAXux9TOSd7B8F78XMNfJcyKfvK+Zih6aRc5S2RXYeKkzUQl8Q5kIsh3
	wGNMr6qSItXEAAn0j7TYy4ho520Axe4ZM81ryLSayIBsy9wBOCuUZAcr9fRh7veSb7icQiH9zAcXG
	eP359qZ/Xf9DJKKJiurw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2rd-0000fZ-IJ; Fri, 11 Jan 2019 19:53:09 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2ra-0000et-5r
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 19:53:07 +0000
Received: by mail-ot1-f67.google.com with SMTP id v23so14154125otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 11:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+2TD2oZRzwkC+aydOSsmZyCcfz+f8jQPAtzrx0HUfqM=;
 b=SMCy2bL+adpQbt9sTk2fvHdlKCCE6uET6xJTLJu3yrHItB3AjfKmozFOOcy3NL3bmX
 mbRc1awpHUyhsDCfZKh9P7pkvjYVCNxaRfU26jletC5wKiu7xdorst7w7PNZ89kisCNi
 mJ5kGgMTPUTbmh62i3bZG2GCcf5SzHvltg/Xwfn6ZLEd36wRVeOfTRe1Ucpao3gO3uKI
 WzXBgVta8je3+sddl05VO+x+ce9P87utjADoIems47ofSFgYNBY7/nEwcqkvOyNbt4DD
 wX+QZJE3uSuwxBnwzPLf4wxj7WHtUOsCAOpQyJlRBorT/JA9Wx13rCqAsGB415PRkI81
 rDeQ==
X-Gm-Message-State: AJcUukfeBR3RFa9Y15fXTclNlCm6XQeuoA03HDw9+D6KJGlx04IQtcW2
 EqEDFUvnSP5/QqLeFjGcnraNJtxdDw==
X-Google-Smtp-Source: ALg8bN7EzkRi1yi2nyRqFZbexKquii1ImncHMr18M7iKOeoBY5A61qbjzYXDOgcIZKa7dSRptWs7WQ==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr10995137otl.259.1547236384002; 
 Fri, 11 Jan 2019 11:53:04 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l108sm35408545otc.23.2019.01.11.11.53.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 11:53:03 -0800 (PST)
Date: Fri, 11 Jan 2019 13:53:02 -0600
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v4 4/4] PCI: imx6: Add support for i.MX8MQ
Message-ID: <20190111195302.GA18985@bogus>
References: <20190104165335.13205-1-andrew.smirnov@gmail.com>
 <20190104165335.13205-5-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104165335.13205-5-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_115306_212671_6A975B1F 
X-CRM114-Status: GOOD (  17.76  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 08:53:35AM -0800, Andrey Smirnov wrote:
> Add code needed to support i.MX8MQ variant.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>,
> Cc: devicetree@vger.kernel.org,
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.txt           |  3 +-
>  drivers/pci/controller/dwc/Kconfig            |  4 +-
>  drivers/pci/controller/dwc/pci-imx6.c         | 77 ++++++++++++++++++-
>  3 files changed, 79 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index d514c1f2365f..920ca93870a8 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -9,6 +9,7 @@ Required properties:
>  	- "fsl,imx6sx-pcie",
>  	- "fsl,imx6qp-pcie"
>  	- "fsl,imx7d-pcie"
> +	- "fsl,imx8mq-pcie"
>  - reg: base address and length of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> @@ -45,7 +46,7 @@ Additional required properties for imx6sx-pcie:
>    PCIE_PHY power domains
>  - power-domain-names: Must be "pcie", "pcie_phy"
>  
> -Additional required properties for imx7d-pcie:
> +Additional required properties for imx7d-pcie and imx8mq-pcie:
>  - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
>  - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
>    IP block
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 6aafec3fad00..83ea318ad989 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -89,8 +89,8 @@ config PCI_EXYNOS
>  	select PCIE_DW_HOST
>  
>  config PCI_IMX6
> -	bool "Freescale i.MX6/7 PCIe controller"
> -	depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
> +	bool "Freescale i.MX6/7/8 PCIe controller"
> +	depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || ((ARM || ARM64) && COMPILE_TEST)

Since you added the ifdef around the abort handler, I think you can drop 
"(ARM || ARM64)" and enable building other arches.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
