Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24137C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:12:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64C72171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N94Hc5+n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gBG+QYJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64C72171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Gkjk3woRHJFxCbwrYn6Y083/qG4f17kjG/tcvnmm88=; b=N94Hc5+nrs4imH
	FE0ggeR5LafsIuvCom7VxAgBDxKnV6AjnIVTiU/jL2ehc+8SortpsFfhQzqg9sumcHtMXF9cK4/mZ
	na9TdGB0NDLF0UN/E1VLqslrJBSL7nMuqY230/vC+LyFKGC8GLRnWjks2fi5q7M6qHzKXt7o8f6r5
	oeDwvL1IT0Ar8uqF7Q8KoiqE1mMNduG2AopT5+UnF6SCDwXLcEYdSkYBU9wuQC5WiGUEa/eoSih4r
	jJy14KnpcO0Mls1ZZc9uplw8ltYM4ZIxjoEiGJ8xk+xR6hXKnEhpy+jbBJBhHJTAmDUGDf6Q2t/QB
	RJ7WgdHICHOxi0yYu5CA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcAqt-0006TH-Ls; Wed, 26 Dec 2018 15:12:07 +0000
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]
 helo=smtprelay.synopsys.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcAqq-0006Rr-4E
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 15:12:05 +0000
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
 by smtprelay.synopsys.com (Postfix) with ESMTP id C03AC10C1C2B;
 Wed, 26 Dec 2018 07:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1545837111; bh=VonFTQBI7qyVRKUU+7Mzb4gN+SOefkbi+3FMWmwmJHo=;
 h=Subject:To:CC:References:From:Date:In-Reply-To:From;
 b=gBG+QYJYRCsU4TJPaqCb7INqcIg/H8elFWLfdQQxW6pxji63Nkan0YfpIg4H2ng1Y
 CkhBMcRfZsx5RxpFiA+REXzlzDiMFRdhLsc9LOxzqVmjOq/+Su02N2qV9A/XOQ+m9D
 BIW3OIh28Co4fyIHdlUy85+X2uGTALdZyv3A13UM9e5M8QSuZLwJuaWvVYXW3zJsDA
 Csr4YlG6Z6Q18nrdj/pOfUWuUMoOFarMKQhAJHNdDrdD4/nY9Bb3zUp07Z/0kCCuza
 24UIf58LL/AWQ6Dohq+/1i/HIJHhc4trq6AEecNrmlupdNhW0Ao6280P8Nro+gKRg1
 in4ZHAKvYkqHw==
Received: from us01wehtc1.internal.synopsys.com
 (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
 by mailhost.synopsys.com (Postfix) with ESMTP id 782A951B0;
 Wed, 26 Dec 2018 07:11:51 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 07:11:51 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 16:11:48 +0100
Received: from [10.225.2.45] (10.225.2.45) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Wed, 26 Dec 2018 16:11:48 +0100
Subject: Re: [PATCH 20/21] PCI: designware: Make use of GENMASK/FIELD_PREP
To: Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-21-andrew.smirnov@gmail.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <bbd87777-2eaa-bc99-acb3-104ded96246d@synopsys.com>
Date: Wed, 26 Dec 2018 15:07:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221072716.29017-21-andrew.smirnov@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.225.2.45]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_071204_179235_7BA2F386 
X-CRM114-Status: GOOD (  13.89  )
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
> Convert various mult-bit fields to be defined using
> GENMASK/FIELD_PREP. This way bit field boundaries are defined in a
> single place only as well as defined in a way that makes it easier to
> verify them against reference manual. No functional change intended.
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
>  drivers/pci/controller/dwc/pcie-designware.h | 29 +++++++++++---------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 348e91b6daa2..0de653284fca 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -11,6 +11,7 @@
>  #ifndef _PCIE_DESIGNWARE_H
>  #define _PCIE_DESIGNWARE_H
>  
> +#include <linux/bitfield.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/irq.h>
>  #include <linux/msi.h>
> @@ -30,11 +31,12 @@
>  
>  /* Synopsys-specific PCIe configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710
> -#define PORT_LINK_MODE_MASK		(0x3f << 16)
> -#define PORT_LINK_MODE_1_LANES		(0x1 << 16)
> -#define PORT_LINK_MODE_2_LANES		(0x3 << 16)
> -#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
> -#define PORT_LINK_MODE_8_LANES		(0xf << 16)
> +#define PORT_LINK_MODE_MASK		GENMASK(21, 16)
> +#define PORT_LINK_MODE(n)		FIELD_PREP(PORT_LINK_MODE_MASK, n)
> +#define PORT_LINK_MODE_1_LANES		PORT_LINK_MODE(0x1)
> +#define PORT_LINK_MODE_2_LANES		PORT_LINK_MODE(0x3)
> +#define PORT_LINK_MODE_4_LANES		PORT_LINK_MODE(0x7)
> +#define PORT_LINK_MODE_8_LANES		PORT_LINK_MODE(0xf)
>  
>  #define PCIE_PORT_DEBUG0		0x728
>  #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
> @@ -45,11 +47,12 @@
>  
>  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
>  #define PORT_LOGIC_SPEED_CHANGE		BIT(17)
> -#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
> -#define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
> -#define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
> -#define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
> -#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
> +#define PORT_LOGIC_LINK_WIDTH_MASK	GENMASK(12, 8)
> +#define PORT_LOGIC_LINK_WIDTH(n)	FIELD_PREP(PORT_LOGIC_LINK_WIDTH_MASK, n)
> +#define PORT_LOGIC_LINK_WIDTH_1_LANES	PORT_LOGIC_LINK_WIDTH(0x1)
> +#define PORT_LOGIC_LINK_WIDTH_2_LANES	PORT_LOGIC_LINK_WIDTH(0x2)
> +#define PORT_LOGIC_LINK_WIDTH_4_LANES	PORT_LOGIC_LINK_WIDTH(0x4)
> +#define PORT_LOGIC_LINK_WIDTH_8_LANES	PORT_LOGIC_LINK_WIDTH(0x8)
>  
>  #define PCIE_MSI_ADDR_LO		0x820
>  #define PCIE_MSI_ADDR_HI		0x824
> @@ -75,9 +78,9 @@
>  #define PCIE_ATU_UPPER_BASE		0x910
>  #define PCIE_ATU_LIMIT			0x914
>  #define PCIE_ATU_LOWER_TARGET		0x918
> -#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
> -#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
> -#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
> +#define PCIE_ATU_BUS(x)			FIELD_PREP(GENMASK(31, 24), x)
> +#define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23, 19), x)
> +#define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
>  #define PCIE_ATU_UPPER_TARGET		0x91C
>  
>  #define PCIE_MISC_CONTROL_1_OFF		0x8BC
> 

I wasn't aware of the existence of FIELD_PREP(), seems to be quite handy :)

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
