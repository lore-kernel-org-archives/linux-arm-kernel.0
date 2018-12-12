Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE4C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:28:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C175020672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fz4z1Vx6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="R9wK0CXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C175020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iNXHS3W4OJrV7ukzG7T7Gy2EDaOzyCFhXyPiUfSNpFg=; b=Fz4z1Vx6tqiN5v
	81WA0PLkASnUh+D3VJtsuxOrB8ieotF8MUTAx8Uf2HrlAxmuy7o5ufMOGMwIez0FrzsYjqw51xKmi
	xlgvBH7RjN1llUi80Tu5wGhAZ3HmLwxELAQmZ5LAGvbC7KmCITErsq7Ce7AR9WNawnSlS3yx53XPa
	87FmafUE682vXglfMo8J5SH9/ziJx2SOP5M2xC2wSF1eIDbQrLhEAwW3jX0KAzgXfCG+v9rE97LfK
	jMu2iqnFCi+KFDwsyuRUmXG3bmz3SElbOtXnHjnzR+Y5/sFhChjsPnAmTwkh2vp+0+SNMTUfqsGYh
	UVIRb6zq0QrS1+fxY/eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCze-0000Q9-Jt; Wed, 12 Dec 2018 22:28:38 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoO-0007Dc-HQ
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:04 +0000
Received: by mail-lj1-x243.google.com with SMTP id k19-v6so17674993lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kccThfX5CLSTWdYtZnbv5QYn/EnfwbjiIG9EWgyHhOc=;
 b=R9wK0CXfIOMeMdj5eEUf05BsUNdL0feIGFCcyCrl+rCusYjr8+48FXxBbxSgiOrLhS
 cGvYd3zBUyEmHQbKaNWD9HSgQy95zsVK7hkbe9dnq90xgWo84sVtthyzOUdVoaIZpEBl
 HBiUI+9R4r7qUcbXS1rigtyhoxjV6BVy08f1o1V959RIPMIykLfx8odWwxjvzznstXRk
 x8FN2OLR31P+Qd0z6VFbns1uHfR63kF3Z02Hc4H6515kHJ8CznGHVPF1Vp375KKClUw/
 XNVKJFr7u68Jjav1PJogw4OCehUATf6n+EX6JMvhe/Os2PN01v+4k9zOpttRLPrqL41I
 idOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kccThfX5CLSTWdYtZnbv5QYn/EnfwbjiIG9EWgyHhOc=;
 b=N62eDaJu6nk38mhrtvlqseMX5KRikWapd1UU5cHdYmo1sgMFVsfrlQcI9PywNX7dSq
 wAtlsM2NpI1Qs2o/Qw7S/FZ8gPGQPGDrTLbaAK02Ecz85OyhQSx3N24sr5vlBxdCODXa
 QNimqrJIemYK5KojV/plDePrlYIWAItLgvnfOINaIK9GuA85Z+Nz+0jNHpDkTwAX7NqX
 3PbuKIm/+nVqHD5CqmzSmqWj7v50WpYmx05WkHUslQYTAYnf7yYoZ9zW+K18KSth9OSR
 LaywJpHsO4pv/bsGe6hs+g2l0FIM5Sf4jZZEpekhcWagHNx1vVgYma+QyNPSJlD/3joX
 6WVw==
X-Gm-Message-State: AA+aEWYyARiVvf7kjHQnsVgcB59gG6Nidzz+Ypp2FkU0oBr6H2htCCvA
 seUbTKYmGrbejBVFFharrX6B4A==
X-Google-Smtp-Source: AFSGD/U3xivvWD8mzw3FAzb4A2hF+KZp9Z6MXVMeAyc0KHK6ChfBYjcaVtK/+mPOt4mfmPTgHtk2Jw==
X-Received: by 2002:a2e:20c3:: with SMTP id
 g64-v6mr14623938lji.101.1544653008634; 
 Wed, 12 Dec 2018 14:16:48 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id a62sm3431lfa.37.2018.12.12.14.16.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:47 -0800 (PST)
Date: Wed, 12 Dec 2018 13:52:29 -0800
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL 4/4] ARM: samsung: SoC/mach for 4.21
Message-ID: <20181212215229.6x5bpkdfhbtzafgp@localhost>
References: <20181209114911.25194-1-krzk@kernel.org>
 <20181209114911.25194-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209114911.25194-5-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141700_726370_82A3EDD0 
X-CRM114-Status: GOOD (  14.10  )
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
Cc: linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, arm@kernel.org, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 09, 2018 at 12:49:11PM +0100, Krzysztof Kozlowski wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.21
> 
> for you to fetch changes up to cafbc79e327f44411b8bd8bdc101b9e6c65ab42a:
> 
>   ARM: exynos: Remove secondary startup initialization from smp_prepare_cpus (2018-11-18 15:12:50 +0100)
> 
> ----------------------------------------------------------------
> Samsung mach/soc changes for v4.21
> 
> Just cleanups of: legacy way of setting external wakeup interrupts, old
> power management debugging functions and duplicated secondary startup
> initialization.
> 
> ----------------------------------------------------------------
> Bartlomiej Zolnierkiewicz (2):
>       ARM: exynos: Remove no longer needed s3c_pm_check_*() calls
>       ARM: samsung: Limit SAMSUNG_PM_DEBUG config option to non-Exynos platforms
> 
> Krzysztof Kozlowski (2):
>       ARM: s5pv210: Remove legacy setting of external wakeup interrupts
>       ARM: exynos: Remove legacy setting of external wakeup interrupts
> 
> Pankaj Dubey (1):
>       ARM: exynos: Remove secondary startup initialization from smp_prepare_cpus

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
