Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE42C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:05:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683EF2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lCa0x4mH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g2KOODKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683EF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HkhIUyOVoAMg376BtDrz6PgMy3BqEmVmXnGv3vSlVm0=; b=lCa0x4mHaK45S1
	HxHUxbAiU4zM02X+QmlnagKcdBsESkWo+MlvnfYNPatoBAFaU+zMIJEL+OE1pUnoKoNclLp4I3ywz
	qNxC6D78KydK0NeHf2TKSc01EHpFl+7WWUOCv3JbvM5n3qpxm99ZA/786M149hMn1EUqyNKlaIKp9
	mIkCuio2jw5K42G8wYXBYkZMVn2MxyVtE8/yqAyuunYJmpPvfsoYmMaH/eM5l/l0xWsXAoeRBj2qX
	VvWBt800D2uIMEIb9sRB09hJauT+8mOFeHrxBxReVxPLdZCP7xYRtDHwFrR2qvMjWc9KV6euGxv+g
	5i+GyCKkLUq1s6GkMPcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj03J-0004OG-Dz; Mon, 14 Jan 2019 11:05:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj03H-000409-Ht
 for linux-arm-kernel@bombadil.infradead.org; Mon, 14 Jan 2019 11:05:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vMIgTuKKtjeiDRvyisN/1zQmyYHGWpE9oXgEtAvunPw=; b=g2KOODKJo8FnKXhxc42a5Ea3oJ
 NcxK/4jRIyBQE98o2P/5NBUQQXUII2nO/hRansi6I8MGq0etHQbFXWEqO9LSaZ7AQI6j3ULs/13Zh
 QXZUYtRMvs60vZWq07f81AaOmyS1+taKMnAv9urQTc2eiZRKpWDTwLnDuNkucY8N8XVYtgPpiDDik
 mrNTL54fQ+EVcquLSuPLQoS0KF/poZCANuxSfoiiR2uuI2/ddIc8I061vLd9SlInwNTD8hweOG8E3
 xbQ3Vv1jExEzRnmafDUfl+nYhCJTo8q5JJahLaH/ge9+SsIbYShX0s9hHgmdJLQq7qxxXxBpPwkEw
 Q/QDzjkA==;
Received: from [177.159.251.133] (helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj03C-00032s-7F; Mon, 14 Jan 2019 11:05:02 +0000
Date: Mon, 14 Jan 2019 09:04:56 -0200
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Message-ID: <20190114090456.03071201@coco.lan>
In-Reply-To: <20190114103139.GA31005@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-4-hch@lst.de>
 <20190111175416.7d291e25@coco.lan> <20190114103139.GA31005@lst.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
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
Cc: Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=
 <niklas.soderlund+renesas@ragnatech.se>, Pawel Osciak <pawel@osciak.com>,
 Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
 linux-media@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Em Mon, 14 Jan 2019 11:31:39 +0100
Christoph Hellwig <hch@lst.de> escreveu:

> On Fri, Jan 11, 2019 at 05:54:16PM -0200, Mauro Carvalho Chehab wrote:
> > Em Fri, 11 Jan 2019 19:17:31 +0100
> > Christoph Hellwig <hch@lst.de> escreveu:
> >   
> > > vb2_dc_get_userptr pokes into arm direct mapping details to get the
> > > resemblance of a dma address for a a physical address that does is
> > > not backed by a page struct.  Not only is this not portable to other
> > > architectures with dma direct mapping offsets, but also not to uses
> > > of IOMMUs of any kind.  Switch to the proper dma_map_resource /
> > > dma_unmap_resource interface instead.  
> > 
> > Makes sense to me. I'm assuming that you'll be pushing it together
> > with other mm patches, so:  
> 
> Not really mm, but rather DMA mapping, but yes, I'd love to take it
> all together.

Ah, OK! Anyway, feel free to place it altogether. 

It would be good if you could later send us a stable branch where
you merged, in order to allow us to run some tests with the new
DMA mapping patchset and be sure that it won't cause regressions
to videobuf2.

Thank you!

Mauro

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
