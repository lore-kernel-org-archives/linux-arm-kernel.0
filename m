Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FB0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455F1214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u2D4AxAv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hhWqCMTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455F1214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F8sEj3OL2WLYyqDegvnGJHDh3AO9M5e8Qno6K3Ca8Ns=; b=u2D4AxAv2+KG4I
	X43JlvVoYIvuTBffz6i5NPxOnI5DXtveFBLCweqF0iELmIfsWLWL+2JshwAm+YrFBzjFK73FTl9GZ
	Nbio/CDH/XFiMe18rAPNw42Jlz6muEssi+6PxeO0AvHqFf8ynkaKb/Xw1O9ZeH4IkkV3H1mo8c/tQ
	gzUoJDcYWqqlQpyLUJqNbEV7RFjy1l86w7dgOiaEaBrgXg1ZkPSBm+dZw21aSesIrL21JO+aBjUqd
	EbYo/F4OfoSWtdgEaNOlXb9sTJNKRy6rvVv1QNSG08R0KWXigx/XgRxI/MrxFMjyHpBRZcprQdWCA
	TDEcirtNs2L/L2uklCmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcAZo-0008EE-6E; Wed, 26 Dec 2018 14:54:28 +0000
Received: from smtprelay2.synopsys.com ([198.182.60.111]
 helo=smtprelay.synopsys.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcAZj-0008Cs-OW
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 14:54:25 +0000
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
 by smtprelay.synopsys.com (Postfix) with ESMTP id E175110C1BEF;
 Wed, 26 Dec 2018 06:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1545836050; bh=XZ0M6aTbiLnN7vLP04AKdrFw1dNv86ioIh/1pCAt8W8=;
 h=Subject:To:CC:References:From:Date:In-Reply-To:From;
 b=hhWqCMTBI1CH9WrWTEzxW59J47p1gL/oR6rzlErGrOVqPCtDy14V3J1TRcWooKKw9
 Ey5t2OqBxFK5crLaUJOUXrFXIuPXMLvh9QVAdGp039H6Ym1BDnHcnWOArE7h1qhpak
 GFVkq+HNIuzr/ihTa25/X+NaR31YzREBYILevnpGRbBC03piN2jtNdMN7hxSHWEEJh
 1thJYcnySGaxl1spJZnIM6Qu2A39H6xZ2TRfeR+p1svRbJkY6VgnGQGhMLUZy71Zd6
 SMMJThMnkg6U8AblSQknojTfp44dA5wGE/H/ayJChC20FTo2tjGCXUVqbS9z5mfzTT
 M1lthW2B6Kz7w==
Received: from US01WEHTC2.internal.synopsys.com
 (us01wehtc2.internal.synopsys.com [10.12.239.237])
 by mailhost.synopsys.com (Postfix) with ESMTP id 7E6A32370;
 Wed, 26 Dec 2018 06:54:08 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 06:54:08 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 15:54:06 +0100
Received: from [10.225.2.45] (10.225.2.45) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Wed, 26 Dec 2018 15:54:05 +0100
Subject: Re: [PATCH 21/21] PCI: designware: Remove superfluous shifting in
 definitions
To: Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-22-andrew.smirnov@gmail.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <341608b2-fd7c-54b0-b5c5-7d8e6b9e55e5@synopsys.com>
Date: Wed, 26 Dec 2018 14:49:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221072716.29017-22-andrew.smirnov@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.225.2.45]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_065423_800242_6E2590BE 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 21/12/2018 07:27, Andrey Smirnov wrote:
> Surrounding definitions no longer use explicit shift, so "<< 0" here
> serve no purpose. Remove them. No functional change intended.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0de653284fca..636689fd4ee7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -63,14 +63,14 @@
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> -#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
> -#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
> -#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
> +#define PCIE_ATU_REGION_INDEX2		0x2
> +#define PCIE_ATU_REGION_INDEX1		0x1
> +#define PCIE_ATU_REGION_INDEX0		0x0
>  #define PCIE_ATU_CR1			0x904
> -#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
> -#define PCIE_ATU_TYPE_IO		(0x2 << 0)
> -#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
> -#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
> +#define PCIE_ATU_TYPE_MEM		0x0
> +#define PCIE_ATU_TYPE_IO		0x2
> +#define PCIE_ATU_TYPE_CFG0		0x4
> +#define PCIE_ATU_TYPE_CFG1		0x5
>  #define PCIE_ATU_CR2			0x908
>  #define PCIE_ATU_ENABLE			BIT(31)
>  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> 

Agree.

Acked-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
