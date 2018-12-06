Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4444C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:11:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9505020989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qEBrdAFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9505020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Z5Orc0L2IR8PQLWH5FuJtGhgsq4ckpFRHIo7du7MVJQ=; b=qEBrdAFXv3D5cxP5X4IVZ9mwKK
	QKzYU/sz2grERg99StUvaFH/+IW8jPdM3GV6+bEpBJg12xtvSZ1RA1KZhnGZUB3rfcBRa1VSom4Bn
	SiakG+F3hPrMT1vYiiukRrgSrWe3olJcr2oSjRG9/M9TLMkPVMoDRVOq5IGZju5XhQaUUgsYI5dI5
	R9/90yWS3MU63jneEOIlS7jE0TT+cOzQTl6OA9BFLGWkW3Gy5H2mLBuFVt41VwFUH6Tn5Hl9Lvfpr
	ZpuG2QSpJKQ1CLahEGm5ltar9DUPVnsEGJNFPOPJ0tremQmp9l/sAHr/l9YFXVZXTemxcfhRht9Bl
	WKNw/S5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUokW-00066a-Sc; Thu, 06 Dec 2018 08:11:08 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUokP-000654-FS
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 08:11:06 +0000
Received: from tarshish (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 7E2B744011A;
 Thu,  6 Dec 2018 10:10:43 +0200 (IST)
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
User-agent: mu4e 1.0; emacs 25.2.2
From: Baruch Siach <baruch@tkos.co.il>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Robert Hancock <hancock@sedsystems.ca>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
In-reply-to: <20181206074555.19579-1-andrew.smirnov@gmail.com>
Date: Thu, 06 Dec 2018 10:10:43 +0200
Message-ID: <87o99zjcsc.fsf@tkos.co.il>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_001101_748444_4959F41C 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Trent Piepho <tpiepho@impinj.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, bhelgaas@google.com,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrey,

Adding Robert Hancock who reported[1] on a PCIe MSI issue with i.MX6.

Andrey Smirnov writes:

> Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
> produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
> to pcieport driver. This, in turn, results in a PCIE bus that is
> capable of enumerating attached PCIE device, but lacks functional
> interrupt support.

Robert, does that fix your issue?

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Assuming this is a reasonable dependency, shold this be done to more
> than just i.MX6 driver?
>
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 2b139acccf32..44ededbeab85 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -92,6 +92,7 @@ config PCI_IMX6
>  	bool "Freescale i.MX6 PCIe controller"
>  	depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
>  	depends on PCI_MSI_IRQ_DOMAIN
> +	depends on PCIEPORTBUS

This effectively disables PCIe in imx_v6_v7_defconfig, since
CONFIG_PCIEPORTBUS is not enabled there. Maybe do 'select' instead?

>  	Select PCIE_DW_HOST
>
>  config PCIE_SPEAR13XX

baruch

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/614800.html

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
