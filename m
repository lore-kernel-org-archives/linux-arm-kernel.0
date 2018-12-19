Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE494C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:12:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870A22080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gFtxSdfX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sqpQLKJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870A22080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2WteLQUmDFcO8creoa4rZP3JBdM0iLEct6qk/CuWtdg=; b=gFtxSdfXLI9lFB
	O7EJ0n/uIoGJRCluuKFV+dsbaEVuj62KA53fNAWQ0G4wDJZxstkYRExE4A67BNJOujmWzV+6GCSK0
	OVywvNaWHsvzfXSEjoVBa2N2PHxQ2haEMlAsShcrlOS2PJ359eb8WeoOl7LvhLcgNHAlSup5ECEGS
	2yRhYhX7gY71CFxzbY5auoH56XYv2dgiJZzRXDVgNYxP/SYyqiCRRQmUxo7a/cY1sOaAE0iVZCrtV
	RrfYpdZ+F3Zxv6E9L+7NhHdxAEA1BU88zA7nVuL5KXUxQjVT2YL4P7Q3V3T61dfIXptbPKNWCGe4L
	+K9aBVfmXwetOJNam6tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZSHz-0006jg-EZ; Wed, 19 Dec 2018 03:12:51 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZSHx-0006j4-0E; Wed, 19 Dec 2018 03:12:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5peKips6igA2cfm29XGmOjqLZ3etZ1w6zwOuOvsb2NU=; b=sqpQLKJ2SfYIAdeKqTlaxGhmC1
 KT8NP27uIudDC1Ffb2WdjJcfDsqkkoo/2CDdy19k4tAIADG36fRGfdfrtjU2BXO8nXqbtn1KJDuqZ
 BFLgQcqSOUpaN6QEYeyQgk3pSxEDkhCfQ/4jlmhlpbmWOSjld6QcBP7yqOz3Nki5twe5S4ihqH7PG
 quwFScF1YzjPwje4XBnESf33nquSgQxqX3V/57KqXaAq0dM7nUuMdfrgDv9OENTnvg+lkh5pzdh7o
 MkI4ZSbo/B6VvEpXtvfG9F2SKqXyaw1W4KLG6DsslepiFpoO3VSJR9k2K31GSgEGMSG68N+nZShK5
 N4glaxQQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
 helo=midway.dunlab)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZSHo-0004s5-LB; Wed, 19 Dec 2018 03:12:40 +0000
Subject: Re: [PATCH v6 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
To: Long Cheng <long.cheng@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ryder Lee <ryder.lee@mediatek.com>
References: <1545186022-3712-1-git-send-email-long.cheng@mediatek.com>
 <1545186022-3712-2-git-send-email-long.cheng@mediatek.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <46c746fc-b400-ec6e-d6b1-899c3d594b19@infradead.org>
Date: Tue, 18 Dec 2018 19:12:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1545186022-3712-2-git-send-email-long.cheng@mediatek.com>
Content-Language: en-US
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
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 YT Shen <yt.shen@mediatek.com>, dmaengine@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,
A few small corrections...

On 12/18/18 6:20 PM, Long Cheng wrote:
> diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> index 27bac0b..2c082c9 100644
> --- a/drivers/dma/mediatek/Kconfig
> +++ b/drivers/dma/mediatek/Kconfig
> @@ -1,4 +1,15 @@
>  
> +config DMA_MTK_UART
> +	tristate "MediaTek SoCs APDMA support for UART"
> +	depends on OF && SERIAL_8250_MT6577
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support for the UART DMA engine found on MediaTek MTK SoCs.
> +	  when SERIAL_8250_MT6577 is enabled, and if you want to using DMA,

	  When                                                to use DMA,

> +	  you can enable the config. the DMA engine just only be used

	                             The DMA engine can only be used

> +	  with MediaTek SoCs.
> +


cheers,
-- 
~Randy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
