Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B82BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:23:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB4320833
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ODIL95Kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB4320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6CW0/yEoyF+Or4Boc3JDbE35s9q9oz68IKLKGj4tfiM=; b=ODIL95KlhmELXh
	y0a9p+9TBVdi809rnKT31ZKlYRBOZvi+zrv7XkfNCKFkOvfMfCtzJjnf/yKm3Q+bKgWHYVao6a1/q
	iOGM9YWGmPZWV+lgrIg/VQeLRn7ETXWVEc53VXwtV8VmTRgcJ+AN1O6Q5OO92bDlEQt1rg/h+fi8B
	MreKZ3Lpj+qLTDSDFpbqd7VMML8s7vNIR9JtX5kKMmF8KkKhivS5kojZ6D6N9g5n/wOj5PpDl7Jyx
	lRarreJWlKctDX/58S8zg7P4zIupC1BRzFKKx19BoYVeWqAWqWumvWw2rkZ8N/2+q3BhW+j6jEHEw
	gIJKKbdT9tQsEs5TYoIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gon1R-0005LI-0n; Wed, 30 Jan 2019 10:23:09 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gon1O-0005Kt-5s
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:23:07 +0000
Received: by mail-qt1-f195.google.com with SMTP id e5so25535036qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JDRB+XL7rhMEpmyQ7BAN1/W5Wq7UEVb34fk02QfLNyI=;
 b=YjUMSmEGZJwfpYwJR3lOO9xqY/gKw+m9UcYFkezWhbDPnvu1z63jjWnE4XrpXBTam+
 WAyw5yjNoGnY2gb+r8hLfX/xxswM+Ml+fGe3QoXComzLmgLxyGNlwAs+EkezMdWL9iAt
 qhEallbilyUMn+V+Aop8HtXqZmUR9KiwNXi/M29AUB9WuNLqBzmBCQLLJtyEtjrXMtRY
 l1kXNbvnHdvVd/pnH8B6DUUr0Q0rv/X5XIBque1M2ofSOcNxTQldh0C4U25U2u0eNBgw
 RXpk0y/j1+YljSu7MfyW3ziKz2wpZ6ot7NkCzUtTVMj8hkQkIDu2nArYZgx7YEwUcsuN
 tP0g==
X-Gm-Message-State: AJcUukeS08efCTe42bLuJYoJqJgacaYDzHQKKkfIV/piZLroeTwA7L3B
 bdwzR53UMypZhplaLl+IFUlQO0EhfyHeEH6jH14=
X-Google-Smtp-Source: ALg8bN4tULtlklTIGBsqpov+y6919cckVjEe+KqGd+DY6f8gJUWP9zWyF0nM/loeUjKhR68lfbD684jk7sBUWp0Uy0Y=
X-Received: by 2002:a05:6214:1087:: with SMTP id
 o7mr28328571qvr.115.1548843785052; 
 Wed, 30 Jan 2019 02:23:05 -0800 (PST)
MIME-Version: 1.0
References: <1548387770-11404-1-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1548387770-11404-1-git-send-email-andy.gross@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:22:48 +0100
Message-ID: <CAK8P3a1WxH0H-3waoOQZ5mnUjLbFX93k+M7pORUJog0huzu53Q@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT Fixes for 5.0-rc3
To: Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_022306_445869_98B879F0 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: Kevin Hilman <khilman@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, arm-soc <arm@kernel.org>,
 linux-arm-msm@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 4:42 AM Andy Gross <andy.gross@linaro.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-fixes-for-5.0-rc3
>
> for you to fetch changes up to 2a81efb0de0e33f2d2c83154af0bd3ce389b3269:
>
>   arm64: dts: add msm8996 compatible to gicv3 (2019-01-24 21:16:16 -0600)
>
> ----------------------------------------------------------------
> Qualcomm ARM64 Fixes for 5.0-rc3
>
> * Fix irq controller compatible for the MSM8996 platforms

Pulled into arm/fixes, thanks!

   Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
