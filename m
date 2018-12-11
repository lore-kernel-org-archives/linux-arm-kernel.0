Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC6C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:24:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB052081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jjDemLej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB052081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2WikeSSDAfszF3JcXJkr9BioadeH/5X0QD34ybVoJiU=; b=jjDemLejkquyUM
	OVngDLfK2j8CR2cNozr1B+1F1yMAe4PSkqxf72a4dNDh0GmMTqW0Kko4QL24i2+3M2Wi6DHPUWgey
	8R1p4vIErSe0OLKUr0OGrJ9JKH/wO9vO1DwWtFKp7OeX/+sFxhiyvdMlV8d7H5s9W0jdtEZOLsfby
	zSU77V9AsHTL5EKbPVtpPbsEvZqg0KrVJyJEfi0qt+7b6q1JHEuLyB78iXnXvmyB/WS9E9HxB3rWt
	JeNCbgYCJJZ7k3OwmSm6o3DSvUu4hV9roRgnVtaOXVsvPpc+BxWmLg3vDQe7OkepXlRR6mDzuMIyR
	kPFnrGiN8eZpEJoY/5Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWix6-0002es-Ci; Tue, 11 Dec 2018 14:24:00 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWix3-0002eI-B0
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:23:58 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 932EC8027;
 Tue, 11 Dec 2018 14:23:49 +0000 (UTC)
Date: Tue, 11 Dec 2018 06:23:43 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
Message-ID: <20181211142343.GO6707@atomide.com>
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
 <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
 <20181211131336.GD9507@n2100.armlinux.org.uk>
 <b88f7a3f-ed0e-c6d7-6e18-afc2378524bf@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b88f7a3f-ed0e-c6d7-6e18-afc2378524bf@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_062357_410948_09B2EF49 
X-CRM114-Status: UNSURE (   8.71  )
X-CRM114-Notice: Please train this message.
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, Kishon <kishon@ti.com>,
 linux-omap <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181211 13:47]:
> On 11/12/2018 15.13, Russell King - ARM Linux wrote:
> > The only thing I can think of doing is adding into omap_hsmmc:
> > 
> > 	mmc->max_seg_size = min(mmc->max_req_size,
> > 				min(dma_get_max_seg_size(host->rx_chan->device->dev),
> > 				    dma_get_max_seg_size(host->tx_chan->device->dev)));
> > 
> > to limit the maximum segment size to that of the device _and_ dma
> > engine's capabilities.
> 
> Make sense.
> 
> > Doing this solves the problem for me.

OK sounds good to me too.

Thanks,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
