Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F896C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:56:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007B121019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GSpSDUPL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxOt14X6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007B121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=esWD7qgJ0cTvBoHje3I5KHlhMRbl6332LWZVaVpas7g=; b=GSpSDUPLQMHi2F
	ukJoz80vFSYWd3oy6n5js4E56Mru03THfnLzLVW/6xigDzthgtDrWS1r32PLwZhFC5zBLforfzhNo
	jXvJBShov1kLiq005AZ18QWtxPqYjOvaG9Hkfn9L88CDsOpIz3/ctHAwl7RLVxIZeHV6OXnitNNOB
	BQvaisghqSZKoVG+O8RRJOqKj5MfUvnC8AfOnqbScMlPHPtkmn1m1n5ISJEsskh1IhG7uLdnjCCkx
	1y3M32SsuTaOMKvbaRORn+x3eDUTW/uAK/BGGeAPkfTAX+63N9OeHI86fZENDfbVugKIoXxBjbXzv
	cvXefhEEKgjIlwDyYcWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKtZ-0007ZU-Dw; Wed, 23 Jan 2019 15:56:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKtW-0007Yv-Dq
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:56:51 +0000
Received: from localhost (unknown [106.200.229.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1314A21019;
 Wed, 23 Jan 2019 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548259009;
 bh=G3Ca8GuuS5k8n1POXOFs0XWw+9mQk5SNjXGrgF/Voj0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QxOt14X63mduhbkXQbIOlowO+iDCT3P5NJDSZcWYq2f7S5b5vWew+iNKteVSXDj1/
 NDYSTFdRVVunMuLOYC0rvzxIXh0ZxJXGlLtSPxS09MvhiYHAR5Lz+1uRqBAzbztl8V
 sLte/PdvW7921O5vt+dHbY5gHUXoDg3Ex6/XDOw8=
Date: Wed, 23 Jan 2019 21:25:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH v3 4/5] dma: imx-sdma: add an index for imx8mq multi sdma
 devices
Message-ID: <20190123155517.GR4635@vkoul-mobl>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190123152310.11680-1-angus@akkea.ca>
 <20190123152310.11680-5-angus@akkea.ca>
 <1548257514.28802.3.camel@pengutronix.de>
 <d5f73096cf62ef379e27c11e024c52ff@www.akkea.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d5f73096cf62ef379e27c11e024c52ff@www.akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_075650_480621_9BC8F144 
X-CRM114-Status: GOOD (  15.40  )
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 23-01-19, 08:42, Angus Ainslie wrote:
> On 2019-01-23 08:31, Lucas Stach wrote:
> > Hi Angus,
> > 
> > Am Mittwoch, den 23.01.2019, 08:23 -0700 schrieb Angus Ainslie (Purism):
> > > On i.mx8mq, there are two sdma instances, and the common dma framework
> > > will get a channel dynamically from any available sdma instance
> > > whether
> > > it's the first sdma device or the second sdma device. Some IPs like
> > > SAI only work with sdma2 not sdma1. To make sure the sdma channel is
> > > from
> > > the correct sdma device, use an index to match.
> > > 
> > > Based on MLK-16104-2 by Robin Gong <yibin.gong@nxp.com>
> > 
> > This relies on the probe order of the devices (which should be treated
> > as random) for the match to find the right device. This is not
> > acceptable upstream.
> > 
> > The DT "dmas" property already specifies the correct SDMA device to use
> >  for a consumer, so the filter function should really match the OF node
> > of the SDMA device with the node specified in the dmas phandle in order
> > to pick the right SDMA engine.
> > 
> 
> Thanks Lucas, I'll fix it for rev 4

And fix the subsystem name, it is 'dmaengine: ...' not 'dma: ...'. git
log of the subsystem should give you good clue of the tags to be used..

Thanks

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
