Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:15:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A78218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dGaXzP52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A78218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eeT/mAQ2zavi6jMy+9Wm+HuMs0YDcBtX8qBFd0YeGNo=; b=dGaXzP52nniSy6
	zXaRUicyAxPo6H2jV5Wjp79K8wbWMYJfkuwn/4yCB6/Hr+FpHbfYn5G4WqriOFztBGO5YHL3+j89c
	dIdiNKiy38CvwalXJdnzjgnQY53vQdA89CkHCHKEeWGoO8OpRwspNfHGc7UR4BGD1Bgz8LzjMA7uG
	SzYHbXIYMc7sR48ikUqhQFQ7CbI13ESshQwljYuf16Y2oodo8kLEoWE+hQVuNQQ6gjnTRGAx/Oh+2
	pn+yJsTwlUxJ4wlhtfH+qRc6jt1RGg3vpTSll6n3pby9MBQpLLaHTekTfzDC2bd+E53AV3RF2PJq5
	tcpc33AlwvkWmNp0/m6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZH66-0008T2-UG; Tue, 18 Dec 2018 15:15:50 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZH63-0008S7-3N
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:15:48 +0000
Received: by mail-oi1-f195.google.com with SMTP id x23so2222748oix.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=R6FiizF1WZO/jYfpHg3Lq2YG0OpoJsKc5a+tOWuKe9M=;
 b=SJGiF/jewvGJQZ9Ep1zq489WiCs2oD0wfBaep9/5J0D6Bf6gZzloE8VJH0G/cbwTS3
 yPrSZx6v9nbeEhTbAKe6ia5mwfYC9uq6s+I8JMOWhNHbXunPZXCih0Rl2zzTn94tpZpg
 rXeRZvdQwBwP1p69s85VSjKwK0Qcv5wA9vPtpOaCpRbANXOnhV8Uea1oCZj6AkMsCx/c
 2cWiBgCU0pH23qDtV1r991vqvtLdiF8gFqiIHW2liav2e8pKgUVYTr14HkX0UZx8OMjl
 QhPUraUSoXJyNkf24bom+Qh5QD7E+KLkYvveTVxpWUQ67HK4CsKe/aq6zQZhIv9aIl6c
 Iu1g==
X-Gm-Message-State: AA+aEWaAKgfGvfIZn8dX/cXXvUIHLErlJpUXNiVqzHRiznf2kuJvyzyX
 M//oCOZc3f2C68YPrb1Juw==
X-Google-Smtp-Source: AFSGD/U+VViOFv01xysi619namV0zfIztq2Q1OIIQsE1SoxVMSJAxcYAiY7owRJpQ8eXZN/HS9/TOA==
X-Received: by 2002:aca:5205:: with SMTP id g5mr8315705oib.149.1545146134892; 
 Tue, 18 Dec 2018 07:15:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l6sm2813042otk.51.2018.12.18.07.15.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 07:15:34 -0800 (PST)
Date: Tue, 18 Dec 2018 09:15:33 -0600
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
Message-ID: <20181218151533.GA2922@bogus>
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218040702.29231-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_071547_163875_B1639E0E 
X-CRM114-Status: GOOD (  17.92  )
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

On Mon, Dec 17, 2018 at 08:07:02PM -0800, Andrey Smirnov wrote:
> Add code needed to support i.MX8MQ variant.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> ---
>  .../bindings/pci/fsl,imx6q-pcie.txt           |  6 +-
>  drivers/pci/controller/dwc/Kconfig            |  4 +-
>  drivers/pci/controller/dwc/pci-imx6.c         | 82 ++++++++++++++++++-
>  3 files changed, 87 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index d514c1f2365f..1a10c313e8d7 100644
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
> @@ -54,6 +55,9 @@ Additional required properties for imx7d-pcie:
>  	       - "apps"
>  	       - "turnoff"
>  
> +Additional required properties for imx8mq-pcie:
> +- fsl,controller-id: Logical ID of a given PCIE controller. PCIE1 is 0, PCIE2 is 1;
> +

Remove this.

If GPR register offset is what you need, then put that into DT. 
Typically, we'd have a property with iomuxc phandle and offset.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
