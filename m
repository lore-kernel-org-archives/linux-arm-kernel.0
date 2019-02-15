Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:39:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F85F222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uUlM6C08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F85F222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BOQntyVBan5s2Fp2e2cpUFX13cWE3nxKschL6O18RMY=; b=uUlM6C08eEUk8z
	4R7N/0HOfcSQ3G7iWHg8lLeScWEik0+OeVBMPCDitM1sfbwNlvUeTbgP20glhMNrG3c1xw8FYxQQD
	MAE/bAlsaf/jC7soAp8adQtGGCoEEp7SNzi42+HhQM/YJOnSEnt9VzJl1UKOPxubB635ergnTWyN8
	U711Ac1sGH8wJdTBTyoHzlzUTUGlpP3/P92L3okcF25mqiAmWH53aVlKQCIVn6aqVovFKhzVrK2zE
	V2pr4rbfvawJm8RbuyFxtvoyHX+c8U92hWmydYvT9LJ+FHVm6JvFk86xauXPorylyCZj9KHqRj0Wv
	u4OCwV2cH7MBoZPLO3Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugWE-0007yF-3k; Fri, 15 Feb 2019 16:39:18 +0000
Received: from mail-qt1-f171.google.com ([209.85.160.171])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugWB-0007xs-Kh
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:39:17 +0000
Received: by mail-qt1-f171.google.com with SMTP id y20so11467607qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DnjvNs79nsKCq8O4x29rBtDMFnxwX+SSKivYIz8I1Qs=;
 b=hB9QO5eZaEnz4hGnZMycKN4puzZklK1kpW+kPG/fttCs18xkg+CdXf7MUzUPXXROuu
 bzow8Ey0r9XYS8wQL5upewcLGA/jpZt+/+fvvQVqI05F5V8yjE4rt25AZuTbiQ63CMOh
 k93KWw0Obs3ork6g7ks89IddfURDqAQ4E1D7HG+xauBUNYVWcJ6JY0mV1ODCHeolLxj2
 wuvC3xiam7w2ItMJzB+GhWfocuFXoV15smtPIYisIXpia/iU4IWkJ8ngItqPWUf/fpk1
 u6p1mdxSbsJIdqVoxjZuWrb3940AQUkY7UfETngDSWmcyJHi7w+UpqZHCKS0SOItWUqA
 WORA==
X-Gm-Message-State: AHQUAubquEIIqzcPyXEnav/lM8TYEMLdSEksklLiHT/dXIcT0eYdSKae
 F4Jmq3OmUFQUkfhtkXMaAzoAHVJ7m4aMvU/EcE4=
X-Google-Smtp-Source: AHgI3Iaa3101FZg18LE37CONVRQZsCk7O4gu0luFnzt1ugXpbeZu4GTy+dDW4eu3euBu6OFWjhYxmRWgfjSjgb3pNXU=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr8353629qta.152.1550248753436; 
 Fri, 15 Feb 2019 08:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20190212112126.572-1-shawnguo@kernel.org>
 <20190212112126.572-7-shawnguo@kernel.org>
In-Reply-To: <20190212112126.572-7-shawnguo@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:38:56 +0100
Message-ID: <CAK8P3a149udLq=Auz48=+0-i3m_iMvPbB=nBMFtR7xDU12PO7g@mail.gmail.com>
Subject: Re: [GIT PULL 7/7] i.MX MAINTAINERS update for 5.1
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_083915_678086_ABD65713 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 12:22 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-maintainers-5.1
>
> for you to fetch changes up to 17ffc1193a4b5610400c43623a43115f3d2e15a6:
>
>   MAINTAINERS: imx: Change Fabio's email address (2019-01-22 14:02:38 +0800)
>
> ----------------------------------------------------------------
> i.MX MAINTAINERS update for 5.1:
>  - Add all files matching "imx" and "mxs" to the IMX entry, so that we
>    can get copied on all IMX related changes without explicitly listing
>    so many files and folders.
>  - Update Fabio's email address.

Pulled into arm/soc, thanks!

I briefly considered adding it to the 5.0-fixes branch instead, as we often
do for MAINTAINERS updates, but it sounds like Fabio's old address
is still able to receive email and he just prefers the new one, so I assume
there is no rush here.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
