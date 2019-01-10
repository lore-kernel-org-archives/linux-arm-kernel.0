Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBEFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:49:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DF4206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R8yNVk9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DF4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cmfeKEMdHyuIAfXZ5pmMpbu8DyJLZzKrOee7LpkIzAE=; b=R8yNVk9F3uCt+4
	UbWRE3JRZvq/mA4396mZpEDYmUTy/GELXt1vo3KmTW50ouo8K8cr5tmL8UjWzeFlZWHEB8J+G6+NK
	YealzU2aQoSY4+M/regIaw6Larbc5ZehYK07Th7HnYNBAfBFZ+FvjdzFohrmdZ1nTdc0GhkgNtoNA
	1WdznI/TQZ6DeT2fEL8M5M/yeqFyN6U93dnzgOKQ4ffHGiHAfzN3paCaKIOFQ8XQp5ihqm615jb3K
	8OYg8ysrRG82UezEcDDEy8Shxz7WFT05mtUGvNDBs4Ygz0kwNpUJCGQUsBiZHKqVWHP4eKfgWRwh5
	1jzkH0T5H0t4RWusNaIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghfNz-00051k-8A; Thu, 10 Jan 2019 18:48:59 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghfNv-000519-Pa; Thu, 10 Jan 2019 18:48:57 +0000
Received: from oxbsltgw60.schlund.de ([212.227.220.198]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLi4W-1gzKn51qYy-00Hbu0; Thu, 10 Jan 2019 19:48:43 +0100
Date: Thu, 10 Jan 2019 19:48:41 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Peter Robinson <pbrobinson@gmail.com>
Message-ID: <528752360.347624.1547146121882@email.ionos.de>
In-Reply-To: <CALeDE9Nzibm=GUfUDKm=d8Zu1fR7J0t-UXMAysmBHxN0oKd-Zw@mail.gmail.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <849520506.312349.1546937289972@email.ionos.de>
 <CALeDE9OYZi+LZCtnm3kZQ2g5oJ1BWXgfoX0MBD4X0Bz2Vj9Tng@mail.gmail.com>
 <389675377.186771.1546942833612@email.ionos.de>
 <CALeDE9PPt8yTF1FLioxz0C1kJZDYn1uYH-MoBii2Ewpo-yC3tg@mail.gmail.com>
 <2090321804.324042.1547101471247@email.ionos.de>
 <CALeDE9Nzibm=GUfUDKm=d8Zu1fR7J0t-UXMAysmBHxN0oKd-Zw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:75kPq/TCOiaAYPLTrkFa7jH7sH3rP6ukLeWo1ABUer6dZ68tx88
 9jqET6dz7wgsKxyzyI9r17bqj2JCVwXH2i7ljvKUFsmt2WkQn2bWeb6Obv6C8JwxDVs0uVc
 BeprEyFfe6rdqD7DixsGWbm6KwprNLl8nqy/dyPkpxhQv7gkxh3djWj13es1vmIer0uZEZw
 a6ckFf5OumgElgcF5azUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XAqTSx7bUHQ=:VyPEZrPwxZK1QRYBWpTUu2
 YN0UmsEWvbLNDNgO3jEVrDIDgMOlbenFA1dVNkS2+mc4lE5Y3G7+HDFOg3yGmK9GtzwKwerSQ
 bvEJRAvfDCzZivMfs64/+CEgKLwsbVf/tcgwQbzNS/OWbARNAdUPsvCYdVZhTu5e77TBQ6kHU
 0JP6Ri1j/9zyWDXN6Qb/uzaNJXxPgjgXKGC6IAhhu5ISotQ0yIgSfPmnqOEm5jSop21RGkV+8
 ao3XjWvTWwOvNtCIMf9Bx6SB3HnXeYpirFRAxrePvEnUwP9rdjhudG6Dz5wFFuRDSOlo6ipzh
 K1R8akGScDyrSjIq1bjou/P/wvUEa49TLDjGJ0BhvHcxlQGuNuSTirhOoJJ4IIX9r9Q4+EvPx
 Jlamv2NNJnwKE1JjKZZe1bXFB6gZDqH5xokmzYEc4zZtLV1Y+0ZHHEh0AnKCqWhkV3RJ/2B9R
 KaYf2XPEUTamYpC/hlehCGOKtopq+3MHNNrYU+Ze4bljL31cDlNXs+aDZfJdWOzw6zIsN7XB+
 GAQoPZzOfUYVDY+k/RunK1fFmCYqHrxn33VfnJLA/1v3DYT8RkDbqTLWc4MwBWjw2fktMStGO
 qVUdftaoSuDLL8dpIKdzNIrKkExE94NmEwUdOc13CGO1XKabAuYZZgGpBWeyUvSfmoYoeO6iX
 b1RTsbVgl7D47MJqW/A4dGhBgf4Fb/wD675SqP6ikqzV3K857BCKhidoo0kcPZTA2t2jJvkyu
 XqrLaGuEPQwN47QQPupPvW/epXNilu2S0EvnFq9m2iBw767ADr1BuXIHN9s=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_104856_126092_6FD7E03D 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: devel@driverdev.osuosl.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 mikebrady@eircom.net, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>, nsaenzjulienne@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Peter,

> Peter Robinson <pbrobinson@gmail.com> hat am 10. Januar 2019 um 07:34 geschrieben:
> 
> 
> > > Hi Stefan,
> > >
> > ...
> > >
> > > I get difference results with 5.0-rc1 but neither of the above apps
> > > work either, will follow up based on the rest of the thread there.
> > >
> >
> > My first step with Raspbian is to enable the Camera interface which results into an appending of the following lines to config.txt:
> >
> > start_x=1
> > gpu_mem=128
> >
> > AFAIK a smaller value for gpu_mem wont work. Please provide your settings which results in this crash.
> 
> start_x=1
> gpu_mem=64

even with those settings i'm getting a picture in qv4l2 (v1.12.3) and no crash.

According to dmesg i also have 64M reserved for CMA. How many do you have?

Does your qc4l2 make use of OpenGL (not in my case)?

Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
