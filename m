Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:57:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D7F20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IpJokt8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D7F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s0Sf8bEM2O9+EWPnsfsDHkxCXQLK7bpTXNCYoCNRQO8=; b=IpJokt8dg1DvjQ
	5JEXzAoJ/PESOmLbVm+nildECzWQXIYhpFdEKVhUkdDBlHPvmz+6LTbhDIFDRrYi3bM/aVtnmOynO
	tg+a/D1rOnp6PfI6zG4IWuzjmULhy512AktKg5luVWvSkPpkT0773rmiJ+O6u6PQGCuDX08jCNDXb
	abRNjgKyApqlHtsV04BwKdBAEY5X6XNuGVSVEWFYhflyGU1iUcpAZwIC+1Nb2wjm8lo8+1jZz5Gxi
	2O3xx1V/HSAmF9Db3kIrlVG3USesm0mEMBgDD6Rxt69PZi55ZTRQSZGoD8HnoMW0la1xjgpw6Mz1A
	nQ42DRyJEVoJ1Opv4POg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0hV-0000YZ-29; Thu, 20 Dec 2018 15:57:29 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0hS-0000Y6-8R
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:57:27 +0000
Received: by mail-qk1-f195.google.com with SMTP id a1so1273882qkc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3+uO6G8aNCnK/AZsnQVOZoyUwaZLmsIgVwVIrS2fz0c=;
 b=uWa6LhBa/0RRu8LjY0ck7BVhK1HW+T5mWKyHxf5I1/M8YGg98gDld+bIWFAKgtzZS7
 x953gKn72/s5gWu2QeBo000IS6VJy5J4pHR5kg5kwtlDe5PWRsuPyGH575esqrlf2z8w
 sXOb7BbcfL+3O+FphdMqnEXFUR74htpL9QaHUWgJ33xe+ESQVs8kccQk4B/QdKqZo8qf
 FzfoiIt/FBXCGY4f1aQkQpHMY5EfiVNaZ29aehyPS+UTtpaqqaUkrTcOjKqj8UIK1LWx
 kt9b35wT0gTT/46YHqX8UNLAW4dfdj3NHNtT/fgoqweUwavwQu3yQz2ZiE4wnVE57sUW
 s9Ww==
X-Gm-Message-State: AA+aEWbxMqyKKYHHMuF6x4ZspqAAO83bC37Yj0MSOxVMCZ/tuP5Dt73c
 5j0bEu46ukv5jQEYEvIrC8qP6vitFOOLFKZXTxM=
X-Google-Smtp-Source: AFSGD/XYtYRImeBz4LLPoeaUMcOSRpu6eA7WLfQgpEJXZ5iBHlMvKk1wpBqsHLsgEDJGXtJVmwYXSRPmvQ1eRps0jBc=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr23657709qkm.343.1545321434858; 
 Thu, 20 Dec 2018 07:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20181219095546.GA2302@wens.csie.org>
In-Reply-To: <20181219095546.GA2302@wens.csie.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:56:57 +0100
Message-ID: <CAK8P3a2j7Hu7yK1wPELFr0Ke5MDFBgVnn7WjoQW+Xsv12d3weg@mail.gmail.com>
Subject: Re: [GIT PULL] Allwinner DT changes for 4.21 - Round 2
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_075726_296883_98BB83AB 
X-CRM114-Status: GOOD (  10.49  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 10:55 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi Arnd, Olof,
>
> This is a late pull request for 4.21. There are two patches, as shown
> in the tag's body. The first is a fix for content sent in the first
> pull request for 4.21. The second is a patch from a series that had
> been posted over a month ago, and the driver bits were merged today.
> We'd like to have both patches included for 4.21.

Pulled into next/dt, thanks!

        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
