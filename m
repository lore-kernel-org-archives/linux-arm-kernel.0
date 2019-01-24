Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A40C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:41:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502A121855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CnTHifk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502A121855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hBkdHFsu5wpFqC48f+U6kopz7OtfQiba/Y1rMWtDAvI=; b=CnTHifk90rVuMQ
	f/3sxchB8HtjASI3Iwsx7dhChuXP+AwgcYNxHsz7rMvN1HYjKpBQfVwKgo/dRcUahZk3b8ZnZxth/
	WbWYCjLCpsNbC/Y5Ac/PjS8faot5HOfhLwMit0lCvI8GqBWBNEBLrHCynk7XHwGHnCCZGcW9ZVLsA
	A+4O0eJWHreEG1KDxTyr1sRunB5rijElVvaeu3w6WFqaCpn301DRmjFPtHLqObPRMtuOLGYTrR59k
	D4NV8PzbfFylY1XNx5hVHFqQ7OO3ryt2Hz0cgQrtDjt4AOTRbXLsiKSNJkQn+A969Im3ivd7q7KM1
	V+dtCTFrDBfvFRjWAKjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmeJc-0006gA-Pe; Thu, 24 Jan 2019 12:41:04 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmeJZ-0006fp-Ck
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 12:41:02 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 602812078C; Thu, 24 Jan 2019 13:40:59 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id F1FF82074E;
 Thu, 24 Jan 2019 13:40:58 +0100 (CET)
Message-ID: <45abf365151956ca8d0a746791fdb8cc09fd5c48.camel@bootlin.com>
Subject: Re: [PATCH] Revert "media: cedrus: Allow using the current dst
 buffer as reference"
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 24 Jan 2019 13:40:59 +0100
In-Reply-To: <20190124103226.GA20129@kroah.com>
References: <20190124095542.22321-1-paul.kocialkowski@bootlin.com>
 <20190124103226.GA20129@kroah.com>
Organization: Bootlin
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_044101_571978_749D33EA 
X-CRM114-Status: GOOD (  13.03  )
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
Cc: devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Thu, 2019-01-24 at 11:32 +0100, Greg KH wrote:
> On Thu, Jan 24, 2019 at 10:55:42AM +0100, Paul Kocialkowski wrote:
> > This reverts commit cf20ae1535eb690a87c29b9cc7af51881384e967.
> > 
> > The vb2_find_timestamp helper was modified to allow finding buffers
> > regardless of their current state in the queue. This means that we
> > no longer have to take particular care of references to the current
> > capture buffer.
> > ---
> >  drivers/staging/media/sunxi/cedrus/cedrus_dec.c   | 13 -------------
> >  drivers/staging/media/sunxi/cedrus/cedrus_dec.h   |  2 --
> >  drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c | 10 ++++------
> >  3 files changed, 4 insertions(+), 21 deletions(-)
> 
> No signed-off-by?  :(

Woops, sorry about that. Will fix in v2!

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
