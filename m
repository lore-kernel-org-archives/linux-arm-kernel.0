Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731DCC2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:59:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1326320879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="prRKCex9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yUFsRucj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1326320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h6AkidgDSEpSbA/tvTHCCAc818RosuK1kA0NkYfoMA4=; b=prRKCex9U7DcYn
	x+PsObfmi5kmjk/tBYgb9brbkob3xGFr8kqkFa2h4cKmvdx7cifhjZsASJ6gKd4pDMK+dPcVXobzK
	fKKjwVbx1InbWcDiJ54aVaCHHP3cuF0RxMCVmA2TFV6AOpyC96HaxMwfcoIeGuTY7t2338qMPGSwX
	xkoaWmjnlNMGQ5asq2qUjwYNbm/fDq057IT0UDQ8UVp4KPKtEm7n3+SL0YN9K21yMby4Yet3TO//v
	TTK2PDQEY/lPBO9Igl8zjkP0NH8gxcvqPDxIUaaGpIFyfWJKJtz/PZOw1Y9BiZfBqE0Z5m0/Engds
	7LPAT++j9Ly3WCgzrdUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbzG-0003aI-5V; Mon, 21 Jan 2019 15:59:46 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbz8-0003Sz-1O; Mon, 21 Jan 2019 15:59:42 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0LFxT0r107484;
 Mon, 21 Jan 2019 09:59:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1548086369;
 bh=ZHPYsL2xkgsk70zv70n70ayT4Gz6Ev9RUwViMeg/gGo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=yUFsRucjWrwpgVJzsPIsThNEoPsOzkv1qN9wfkyx/DGd0/e1B17HSyWiQE7cJLSAC
 BzBpLY79TYpW8IXDT8l7KzukDCH5lxCB9PmqL45sFI9TbWTdAQVUOrE09e/qQfFI7G
 /gIgdMxb9eaZqSKZfUX7Zp0kScmz6ji5q935vEfs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0LFxTLh067437
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 09:59:29 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 09:59:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 09:59:29 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0LFxT47030421;
 Mon, 21 Jan 2019 09:59:29 -0600
Date: Mon, 21 Jan 2019 09:59:29 -0600
From: Bin Liu <b-liu@ti.com>
To: <min.guo@mediatek.com>
Subject: Re: [PATCH v4 5/6] usb: musb: Add musb_clearb/w() interface
Message-ID: <20190121155929.GC30080@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, min.guo@mediatek.com,
 Rob Herring <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, tony@atomide.com,
 hdegoede@redhat.com
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
 <1548073351-13739-6-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548073351-13739-6-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_075938_307112_19B92FC6 
X-CRM114-Status: GOOD (  17.35  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 hdegoede@redhat.com, tony@atomide.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 chunfeng.yun@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Min,

On Mon, Jan 21, 2019 at 08:22:30PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> Delete the const attribute of addr parameter in readb/w/l hooks, these
> changes are for implementing clearing W1C registers.
> Replace musb_readb/w with musb_clearb/w to clear the interrupt status.
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
> new patch based on v3:
> ---
>  drivers/usb/musb/musb_core.c | 32 +++++++++++++++++++++++---------
>  drivers/usb/musb/musb_core.h |  8 ++++++--
>  drivers/usb/musb/musb_io.h   |  8 +++++---
>  drivers/usb/musb/musbhsdma.c |  3 +++
>  drivers/usb/musb/sunxi.c     |  4 ++--
>  drivers/usb/musb/tusb6010.c  |  2 +-
>  6 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 2fe5225..5ef8848 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c

[snip]

> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index b2394a7..7bf91cb 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
> @@ -286,6 +286,9 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
>  
>  	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
>  
> +	/* clear pending interrupts by manual */
> +	musb_clearb(musb->mregs, MUSB_HSDMA_INTR);
> +

Make musb_clearb/w() return the value of the _read() instead of
_write(), so that we don't have to read twice here. The value of
_write() is not used anyway.

The change above can be:

	int_hsdma = musb_clearb(mbase, MUSB_HSDMA_INTR);

Please see my comments in 6/6 for details.

Regards,
-Bin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
