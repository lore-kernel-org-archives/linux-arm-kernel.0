Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AB7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:25:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC15320866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g1l3i4cl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC15320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GxAcNlTsQ/mr3UpZoDXNd/SNOh/of/GnGjn15UETrTQ=; b=g1l3i4cl96G4Yd
	ECqGXEiYBAfKuV5r80Mnf18ZN4tLBkZoGwEunGv0zIObAKEyWMDy3OXERlCHhi0wfeDZp7KZMRDYl
	ASw2OeKbnT1jmsWDD7gRR+hl/v/1wcZBiDpIfSYwECkrntkJkJdMNRVRMxNqKf1jIITmbQ6gxMCOQ
	c9SAmm8jnkdsXVwIp8YN/3lN+rIKjsoMo1fP7acS+1h0rlNHbtev+6YGDhF+lDk5cqIukmcqvOwov
	1r9USjFZOS+eNO+onfun8xEcvOKLDORyPzsVheORhBWGnv9bOXeqdS0Fgv0S3ZufLmhG9wEYeIEz7
	R24aeN6Pa9TZ9F/jM3cA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiNc-0001zK-LJ; Wed, 16 Jan 2019 10:25:04 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiNZ-0001fL-O0
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:25:03 +0000
Received: by mail-qt1-f195.google.com with SMTP id d19so6512985qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 02:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LmsvamTKgo+58LgedZq1GakVrL3Oa2JR2r8mNl8nyVI=;
 b=AEJNhcBdgRf/xUHdQwF5by4jJLzGUr7omQd5DDiwi9ghorfJjYQIiNUQ8ggsLVvL8W
 g5HczqJYjPOJvQ/bTYEcN0slmG15bPYy440wt0Wq4o4q0n+TpybHlbzlhDWo9aLmewhV
 LVZRwyJtMgXuycNozGHmSAPOmTQ0OIF75YA6VS3KnLBXfKQMOmwz4/9AJG1jR7dTbiry
 M6Tg2NGqOZ8sI9IdU3ZwUd3REGFlt6Rv0kDjewJNIE1OSD2DMIAQaQ7/YFbfhNEWkTS9
 WYxHK75jEuBWe76HWa0QOfq42gSiMaS8A9RJY62W3uDUL3pgS3H/W45wDY8VshsvS7bl
 O6UQ==
X-Gm-Message-State: AJcUukcABBixnNUzRPTR2GdCjeBsHWNtzpWteSZAAi23e7aO8QwTkvq+
 TqMZiA8BVNyF6zmFHreAqL0tiXPnbkhnDnpT8Ds=
X-Google-Smtp-Source: ALg8bN7TPbSuZQ+urcPiZwntG9alwIAaqb+En/OZwB7UWwOChTvYfu39fhAsU8v0s7alyqMW/8JP2hpa18mO9YsbWWc=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr6344298qtl.343.1547634300459; 
 Wed, 16 Jan 2019 02:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de>
 <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
In-Reply-To: <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 11:24:43 +0100
Message-ID: <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com>
Subject: Re: remove block layer bounce buffering for MMC
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_022501_809426_9ACE6E8C 
X-CRM114-Status: GOOD (  17.80  )
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
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Linus Walleij <linus.walleij@linaro.org>, Nicolas Pitre <nico@fluxnic.net>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Ben Dooks <ben-linux@fluff.org>, linux-omap <linux-omap@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 11:27 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> +Linus Walleij (recently made a cleanup of the mmc bounce buffering code).
>
> On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi everyone,
> >
> > this series converts the remaining MMC host drivers to properly kmap the
> > scatterlist entries it does PIO operations on, and then goes on to
> > remove the usage of block layer bounce buffering (which I plan to remove
> > eventually) from the MMC layer.
> >
> > As a bonus I've converted various drivers to the proper scatterlist
> > helpers so that at least in theory they are ready for chained
> > scatterlists.
> >
> > All the changes are compile tested only as I don't have any of the
> > hardware, so a careful review would be appreciated.
>
> Thanks for posting this. I will have a look as soon as I can, but
> first needs to catch up with things since the holidays.

Linus probably knows more here, but I have a vague recollection of
the MMC bounce buffer code being needed mostly for performance
reasons: when the scatterlist is discontiguous, that can result in
a request being split up into separate MMC commands, which due
to the lack of queued commands combined with the need for
garbage collection on sub-page writes results in a huge slowdown
compared to having larger bounce buffers all the time.

We had discussed finding a different way to do this (separate
from the bounce buffering), but I don't know if that ever happened,
or if this is even the code that you are changing here.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
