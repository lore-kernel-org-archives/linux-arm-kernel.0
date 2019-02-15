Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82245C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:26:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EB52192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kmAQ6r1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EB52192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xqYX1Ad2q3apStRAnjNSTo3xItZJAtCx/A0t9TMtvkc=; b=kmAQ6r1YgyWnpd
	iuEaautshRAZuy+Rkelr2YUIPvyZ5fWMmOSfyvOa/DoExsKiRCfsmCBqpUaL1wAQW+974F6RLLUng
	QpaJJHyQkX89D2eWMcJ8T+iMx/mQzNhsI/R6fTQKndB3Nl/hVXN0U7JkoVLU4wt0bWqUqHJq8ywkI
	43Ilx5QaE0E9/65ur1MvIJZTSDpHiu/Jvqp0BB9OTc1EgnqXsvVXsA6czuzg/FHzKNDrDjHSdpkX6
	9sk7mvuMiLrOTtu0C7vUbs1DZGFcRr7hNlkcFbScKL3ViC21sw4uCdKk8xces57gyWhD8lYxWuElG
	sV1ASI8QM2oO/A0SQy7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugJL-0000gk-JT; Fri, 15 Feb 2019 16:25:59 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugJI-0000gP-MU
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:25:58 +0000
Received: by mail-qk1-f194.google.com with SMTP id w204so6038371qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A8V914NAm+9ho9sRkD0V2A986MJDmKm2/TvXSdAg2v8=;
 b=M4CUjAlLpxMKsvu0feQMJQCk4iMRSou2QTStUeM9hwajLrlCfI7behFDiP6eCj4Qx8
 fSuH+bCmEFtV9x/eRAbw+iQ7JqlPtyswYnwcrTxKMizwRJY00gZ9D05ThBDrXqi7I571
 TDbpNvB+slVD/OI+TCh5jpWEOZrBj7hEuklTkZeYqYYED5TOLPPcg7sVlKq9JHGph1SJ
 Xu/GWwelBDq2rPINh/JAPXULyhkLDs4SkWILauZgUnYrWfxzJG2HxRlxvfGcvb9Dumvy
 0c+KgKpZOouR30vQ4OIOxEcjIlXjZ404uhHiJxH+p8I1nqgJu8gpYiXXI1Tyrx6CO22o
 lsfw==
X-Gm-Message-State: AHQUAuYxPkHZ3Nk1smWUdScpHLoGP4epIyXHW5qCBpQZDuIdjK1w8xI+
 W3i1tKkrvznVX01qpV9P3CcYEWC47s1xt9fi62jigg==
X-Google-Smtp-Source: AHgI3IZrriYMO/bi0ma6XqXPLC2krsM3IDY8pPI7dO/HJ7joXSuTRS8m1nfWvat9rjV8zTTMrx71NZdXhbGaZJd7MMo=
X-Received: by 2002:a05:620a:12a5:: with SMTP id
 x5mr7668117qki.291.1550247955869; 
 Fri, 15 Feb 2019 08:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-5-thierry.reding@gmail.com>
In-Reply-To: <20190208150935.32108-5-thierry.reding@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:25:39 +0100
Message-ID: <CAK8P3a2tSaHsAOarZ8NHO-N4ZcLQL2rD2ti1rAe4meidWbVNEw@mail.gmail.com>
Subject: Re: [GIT PULL 4/9] soc/tegra: Changes for v5.1-rc1
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_082556_733361_ECB32707 
X-CRM114-Status: GOOD (  10.39  )
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

> ----------------------------------------------------------------
> soc/tegra: Changes for v5.1-rc1
>
> This contains a couple of miscellaneous fixes for minor issues and a
> largish rework of the PMC driver to make it work on systems where the
> PMC has been locked down and can only be accessed from secure firmware.

Pulled into arm/drivers.

> ----------------------------------------------------------------
> Jon Hunter (1):
>       soc/tegra: pmc: Make tegra_powergate_is_powered() a local function
>
> Joseph Lo (1):
>       soc/tegra: fuse: Fix typo in tegra210_init_speedo_data
>
> Mikko Perttunen (1):
>       soc/tegra: pmc: Support systems where PMC is marked secure
>
> Thierry Reding (6):
>       soc/tegra: pmc: Use TEGRA186_ prefix for GPIO names
>       soc/tegra: pmc: Sort includes alphabetically
>       soc/tegra: pmc: Add missing kerneldoc
>       soc/tegra: pmc: Pass struct tegra_pmc * where possible
>       soc/tegra: pmc: Make alignment consistent
>       soc/tegra: pmc: Explicitly initialize all fields
>
> Timo Alho (1):
>       soc/tegra: fuse: Fix illegal free of IO base address

Should that last one have been marked 'Cc:stable' ?

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
