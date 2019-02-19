Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2185DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:14:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E822321738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iv0Lh0Ba";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSYmEGKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E822321738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pkNVWz0RAicVvTqj/6yhbOgKhfbGO5U/ADKAh29uJ7w=; b=iv0Lh0BaDg1SAS
	SHzI/13rt+/cq38e04bQ068jnfhapPOveicxIEb8MDvt4XyydE7niytjvbigQjo4SiCQKfeZSUowT
	quzFo6iA1PN/JkCqQNCIuD/cGAnPmtBXawvWAiXkkkzkO/N1hk72LCuMQTKJ3oQHzlNV0r51fiUHH
	6iPnyZbDI4p705//i/KaRTa4vTSYENJWUqUnavTTfra8H2Nly32Q9TrPvEeDO/rjTkyI6a3tO6iwB
	g909QaS20q+n8Ucj0xh/zezXgnF5N9cgSk6+jVfK9UZN13iltQqDEkvjYF/usD31m9f2qIBRo2w5/
	TYiAbEsu5hCNlbIbFQSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw4II-0002RF-23; Tue, 19 Feb 2019 12:14:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw4I9-0002Oa-Pb; Tue, 19 Feb 2019 12:14:36 +0000
Received: from localhost (unknown [106.200.226.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5E29721738;
 Tue, 19 Feb 2019 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550578469;
 bh=EY856DV7lAODzYu3bfky+EDHLw6CXkeDEgbonfZiCBY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VSYmEGKxMYGhZtgnhm2hTBfKINXtd5BDc81wvLbqMafcHn3wi3Sf5iwTLRvvGt3MX
 Sx08BBYygSVzgT8zIQCFHgY7Sh2L8d3QJRUrEWcfV9aoReYKDirshy7zRFtwdSkZ3m
 ZcatYaOy67OrYjsn14TN3XVkO4XZUoLLKb0C46/E=
Date: Tue, 19 Feb 2019 17:44:20 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH v10 1/3] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Message-ID: <20190219121420.GZ21884@vkoul-mobl>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
 <20190204072154.GJ4296@vkoul-mobl>
 <1550112296.7678.5.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550112296.7678.5.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_041430_023742_98298336 
X-CRM114-Status: GOOD (  11.61  )
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
 Nicolas Boichat <drinkcat@chromium.org>,
 Zhenbao Liu <zhenbao.liu@mediatek.com>, linux-serial@vger.kernel.org,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 YT Shen <yt.shen@mediatek.com>, dmaengine@vger.kernel.org,
 Ryder Lee <ryder.lee@mediatek.com>, linux-mediatek@lists.infradead.org,
 Sean Wang <sean.wang@mediatek.com>, Jiri Slaby <jslaby@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14-02-19, 10:44, Long Cheng wrote:
> On Mon, 2019-02-04 at 12:51 +0530, Vinod Koul wrote:

> > > +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> > > +{
> > > +	/* just for check caps pass */
> > > +	return 0;
> > > +}
> > 
> > please remove, this is not a mandatory fn
> 
> Can't remove it. Before the mail, i had explained it. in 8250 uart
> framework, will check the function..

I think you should fix the 8250 uart to handle driver not having a
pause. Keeping a dummy pause is just wrong and sets wrong expectations
for uart..

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
