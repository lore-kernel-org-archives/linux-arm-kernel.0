Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4B8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4102192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U2I+RZsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4102192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xgCQ4w7hiKtLQUsRUhPlUxDF21R/wT1B/lUGy3eKBQI=; b=U2I+RZsQ3xvxq5
	cY5VMNzv4fJAicsHughpDO3QL1XynmkWBdw1RnaFY5ZDwZnENGyst0hwzhpRCFcDeM0ns+8ibyX3y
	ThIUASiOyx2YzsJrHViw4VkkqoNcXlQn8B6VPNGskfuY2m3PkdnQz94XvxRwsxCMqKW45dyfhEka6
	gX3rUXWQ9EyMoL/SP1L2JXEyuGs2S3mgIYG0lXinnEy8azlcUz6V4h2kacgNdQgZSxS4KxIkJCHlt
	B1z3W0wbX8o9HwsVnj0+VSwieOSK45ywbkbJe6BMmxymy7YaklhwhY3EfbcAZwtnLi08ScjdjqMWL
	tilxGhv/3QOatG+4X11g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufuf-0004Ao-NX; Fri, 15 Feb 2019 16:00:29 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufu9-0002jf-8l
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:00:19 +0000
Received: by mail-qt1-f195.google.com with SMTP id y4so11357837qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YpVzP9kdDCuEe8ZJvld+w9pheSBC5BIslIPsLpg4a44=;
 b=ROWMQRhSs7Y3L1jVKqdSek4Z6UWncZ8bY/tBR9jQn4J21T7MJm1DMwpC+AsQRjrP80
 QImzg358L5K8ZK8ma+OwmcazXf5Eu0YbbhZLQsBNZ7/5JPmMM40ctv72OB8R5mQJIYzr
 9L1UI6rQEHbGwyVzPtu24F3o/+tQheJlic/+Fir0dfasWNFLvpv1emVA6mYAtXhajGnZ
 DZiZrYcEX1PCJ9jWxNbLgj01sKg1o2Wg61Ora8xXxpzGMD9Urx51T+HXARymC5DVO7Ru
 hRht74zZE/kImzYlYSK1eJVeSvSSEtfv52dJc/01mzlr2yMWh4eeE8AU4DqcP0xV6Orl
 Qj0g==
X-Gm-Message-State: AHQUAuYOalgH+ALY8L1jUW2XUNvfcau3Gz9z7k+BncOa4V295cGPJUoV
 56BQCiyAUgyvws14Nez0M+qWPe+wGohZRRzIDIo=
X-Google-Smtp-Source: AHgI3IaUvl0vHvm2sK4y0OZDCteVzglabacER6/sXCtFFISYv5hUfWdEwEhq5AjU80mKtcModU9EB5or2giNX/uFEic=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr7979677qtl.343.1550246396406; 
 Fri, 15 Feb 2019 07:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20190201191720.20464-1-krzk@kernel.org>
In-Reply-To: <20190201191720.20464-1-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:59:40 +0100
Message-ID: <CAK8P3a3rr+==e5iZm_9hscE6ar18rCnmC69NWrV1ZEjxu9H=ew@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] ARM: defconfig: Samsung for v5.1
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075957_696234_440028B4 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 8:17 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-5.1
>
> for you to fetch changes up to 25c390ec22167f896dbf5fb61b869ad05ce273ff:
>
>   ARM: s5pv210_defconfig: Enable cpufreq (2019-01-13 10:31:17 +0100)
>
> ----------------------------------------------------------------
> Samsung defconfig changes for v5.1
>
> Enable more drivers in s5pv210 defconfig for Aries family of mobile
> devices (e.g. Samsung Galaxy S).

Pulled into arm/defconfig, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
