Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BDDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:48:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC2F21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y6rGzDzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC2F21B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nwAkSVBVZnIfDjrBBs72cPDjsMqQ0FoRL9Ub3A8p4To=; b=Y6rGzDzKmHDH0t
	aE/rd3rRM6piDY3R//1sXTtbBXcrzCo7HM9517UdI/UzyvCEsAYeq7MtFJhrYmy0dlABJy1J4HQ5c
	wF+SGBwZYPBlMzW9ODfr84x4ofU4qD3LHcTt4Gnla17ft1MiN4lVgB2j+AUL2UrNrsNn+d6EZ1iNv
	1zmzVlum+Rr1DSrVLZ4ZvCyE68O7KO8QT07U1mhK+LmAIWPq7WEU9Fm5cQ7w/4g8pmP/WxT7y/dRd
	gnGXh7VimUe7ES96GysmJJYlZ8c8PvEHyGIMEp6FClOGJyUDRperdFneSfxFtoWbLOgg6BMLbhPqJ
	f8o346mCH4LlWeHuRXNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugfN-0004lC-Nf; Fri, 15 Feb 2019 16:48:45 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugfK-0004kr-Jf
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:48:44 +0000
Received: by mail-qk1-f196.google.com with SMTP id y140so6055179qkb.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ooc108qYAWSdQZJDyZ8FXFSE7/YTGNyq97Y/bWgr4RI=;
 b=s9bfuSrKA+514ui3N5Mi1Myg7UsKItqcb7TksGyckSU+4WXOEL8PNheCnwzzpgn6zu
 S8VZrnMNFrUAJ8XkcNoEapAdfeXy0uUYz90OIYrh1yNVTTRiZjXNJsXk8nZwkttt+C2a
 RSr7sxN8tEQip9SfJSUQhHCnwQAv5vcq38UtSY4lduJUc1owbAUL618KIMfm1CNZ1a4V
 4HECy8Bc9Ew2DaVDjSGUL1izCZabswTWFxwoDUUcl8WAF/pZJ50bITyFpBlByB078Ycy
 v7M/cq1sDcyJaC0EkGka82RoAZGeEryklxUWxHsfKqHHJ0AoBlFkfNgZBCCDTdPryknT
 400Q==
X-Gm-Message-State: AHQUAuZu4qeuCs4N1vJvwX7xkWQDdOrft8CRTTdhe/T1LGwBDFR8vK8C
 HLVzxXMDoCGBK0Oca0wXTTc4FUcmiZnR6c1XExZaSw==
X-Google-Smtp-Source: AHgI3Ib5lNzfBwZFKRI5G/j4FFWW75kEO1z/5beQcdVnlvziY6aV9W38dMaW5ExxIPaaKNkiWaUihgNIyaHwMRBBWTY=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr7347617qkf.107.1550249321752; 
 Fri, 15 Feb 2019 08:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-7-thierry.reding@gmail.com>
In-Reply-To: <20190208150935.32108-7-thierry.reding@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:48:25 +0100
Message-ID: <CAK8P3a2vDG97hP80i6rknqFnDdpoCGMBpmoy2Gp-jUWnGJ5VCg@mail.gmail.com>
Subject: Re: [GIT PULL 6/9] ARM: tegra: Core changes for v5.1-rc1
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_084842_645465_5DFD08CB 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> Hi ARM SoC maintainers,
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-arm-core
>
> for you to fetch changes up to 1c6279b49d3ffff38357e93d112512fecf3711a7:
>
>   ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+ (2019-01-16 13:22:04 +0100)
>
> Thanks,
> Thierry
>
> ----------------------------------------------------------------
> ARM: tegra: Core changes for v5.1-rc1
>
> This contains three fixes for resume from LP1 on Tegra30.
>

Pulled into arm/soc?

Should these bugfixes have been marked Cc:stable?

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
