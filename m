Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD83C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:11:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA562183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gXmvlhe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA562183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gsu3sIvSz3nZQwftSv3UCqvUi862wkxAFeJKtisdWQ0=; b=gXmvlhe28sCL8b
	mfBn/mfQWWRQ4GoTFVxCclseFxtF7UCPb+/L6gSW7A87QZchXlY2nobKo9Ryyl8bYfJxz+7qu08Rl
	AQ1lPDTYHX3mq1ySxOsfWN1lDEHpODHOGhlgsBqfN5fOYkJBgYfeLlCyVAe+oaVc9HjtssvrfQh1a
	hFe1WB4TjGaBZqJ7X7X/WMdFKCBA2WRozccV3rQTadneEuoft6HmYMhO6ntVnQ1rHO/GL4K6l1sPa
	UBIc8iZtHLOFtIO0K832ZS1NRZ6zug8qwMQ0YEy6jy3HJg0b5u8kEO0gvyjlY/TfO55gF8SMOLY88
	kld2HagYdGa0L6wfsfRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTXA-0000pW-Bj; Wed, 20 Feb 2019 15:11:40 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTX6-0000oq-80
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:11:39 +0000
Received: by mail-qt1-f196.google.com with SMTP id y4so27501254qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 07:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WEEPtxp2Y5ETsK7WypMIxYWNL9klWIeujbQUbiSChoA=;
 b=VUYlqA2vqKiG9DYCjjfWKfXc7niNKm5b03U1vWfxLdekA3w/nJtPjihI3Wy+yr0w64
 J1Pu+50N1tahrgecoxS3fzI4NWJ6F5tH1zcg+r0xuCWHat9rF9Ga0DDxNR7x/2Bf16+j
 We+gBwxfUmGpnjY8W/Hhevec/f9m0aQsVFsiaiWp2ikGwIbnBukOIpWxaxpmuL0kz8RY
 ovcTjFko2xNS8ljMgxu+dMboRkgShLKupFeRdGLMxo9DNUQcSHUgJZlMc4EkdnSCmPUQ
 L0Smw8uS+53oIu7r5ISFPIG7i/HPqEs5bZr0VNd36R9JQK0BIzPNd5d7o2TzCYRyY5JK
 zq1Q==
X-Gm-Message-State: AHQUAuZKRpMirw666TiEUOaqa38GIvntAOkXt5TAh3aMaqsFRjJPDPHn
 48bMVKAJbs2pFrMbf26Veick/1QrTYcAweiuGO4=
X-Google-Smtp-Source: AHgI3IZMvoSZ2OHJb3c4jDm41Od5dyIXeWsOpBdmcvqIcFOSNL+hKjF5qoDXdNpMuOFHuO9pWttlANvGB8Lcotegpr0=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr27002924qtb.319.1550675495036; 
 Wed, 20 Feb 2019 07:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20190219185214.5544-1-krzk@kernel.org>
In-Reply-To: <20190219185214.5544-1-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Feb 2019 16:11:16 +0100
Message-ID: <CAK8P3a06-C5TpkSnnvgFTbiXX6FdcOU4RMFVr62YAxm+LEtrbA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: exynos: Second pull for v5.1
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_071137_670702_2F59F1C6 
X-CRM114-Status: GOOD (  13.80  )
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

On Tue, Feb 19, 2019 at 7:52 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit ec33745bccc8f336957c751f4153421cc9ef5a54:
>
>   ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid X2/U3 (2019-01-25 20:18:10 +0100)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.1-2
>
> for you to fetch changes up to 625c731d1b2af487fc6be10b9a505699c045813a:
>
>   ARM: dts: exynos: Add support for secondary DAI to Odroid XU4 (2019-02-18 20:52:25 +0100)
>
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v5.1, part 2
>
> 1. Enable ADC on Odroid HC1 board.
> 2. Fix clkout register failure on Exynos3250.
> 3. Allow using earlycon on Arndale board.
> 4. Disable ARM PMU on Odroid XU3 Lite because it is locked by Trusted
>    Firmware.
> 5. Add support for secondary DAI to Odroid XU3 and XU4 boards.


Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
