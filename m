Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594CAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:06:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B13621741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OUF5DQmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B13621741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i4Bqxl1kZTnjUrrKWSUIk1ycyBOYSGktTlemFYPDRYU=; b=OUF5DQmRkhde5U
	8q0QCdkc91VlycJlBLERoj5LnBUdqE044jyHL+9vHzD0Bx0FOzR+i5zDBnyp9IrQSCUZ+XW12wwHT
	pc8dbewoXQHePnqHIuw8Nrx4he4kujPTKFU+dyZ+H0fPzBUA46KNQkEUKy6rOVmkIeJWdmsiraD1n
	gCP1bNbos7h+oE1Vujl0ioFcu7r10xcVWfweN8mkXW7S8dNC7NvI6mN+7GDnfUjJZWwlR6LRZSCtC
	YFb23OzfH8xXjSvpwCMskv+zfv6a6DKA9SVVPiMRTZ7jY6vWvHI5RSueFfkke5qZ4EkeKLnuR/5E3
	HHWuYi+T0TLIwzFj0OyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0pl-0004ss-Al; Thu, 20 Dec 2018 16:06:01 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0pi-0004rb-8v
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 16:05:59 +0000
Received: by mail-qt1-f196.google.com with SMTP id t33so2361809qtt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 08:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hno3ZhCttvnOQ3UmgTypd/WYPZP6DDabEhv9cR0+BWk=;
 b=miMaZK+Q+HmFcKNhkzr7IQw4PR6Dtui6XaLLcR5inYpAwQF450FMkDPaTzRUpVIN14
 fFkSM9i7Xsp+mwLk3poA2uaVgSoNTTXSbrRrNTTLl6YFn9ZOy8EZhyuFVCRC6yFAaR+G
 +34BcVvIHQ444VHiwDShFriGCF7tI2eEAJRtpaguM7ABxtl7AvKpR4W0RFCM/0gQR5gC
 ej71L5vlW6x8NvcBPBOUzltsTi+4MqX/6Laqn0hnJ8hUndUmjdzZF+3L3bpaDWfeswSS
 +qhbiKUPI/Fc7Uq2iiTasaQ8/hQdNbW6MBvi1s2YzWKAUe/IdmdUpeCdeTKDpgqyt4pS
 SzVw==
X-Gm-Message-State: AA+aEWaBBNWpQ+rjxLpSGDLfcyTxclyiUpQK79bTaHCBKlJntg47UnWB
 xGVgPYN8xHN4SXdd2bx5UrXpJaBo0kBQUDNwX+E=
X-Google-Smtp-Source: AFSGD/Ve52DpeKFXrBrhrFFaF1A0MvGMdUmQI290o1b/ObRZQZyAi/VlqGOWM1h6Ksriju699yDG2WIEcPdCH06VjS0=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr26498068qte.212.1545321946894; 
 Thu, 20 Dec 2018 08:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20181218201003.12806-1-krzk@kernel.org>
In-Reply-To: <20181218201003.12806-1-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 17:05:30 +0100
Message-ID: <CAK8P3a1DAGStWYN7_BS6t7ud9_at4nJLWjPtoyDphYXKAjnKXg@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] ARM: dts: exynos: Second round for v4.21
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_080558_321979_2D83E39C 
X-CRM114-Status: GOOD (  13.34  )
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

On Tue, Dec 18, 2018 at 9:10 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The following changes since commit 57b13b8b34002ce8f1d822ea05f0a84e5bc3a64a:
>
>   ARM: dts: exynos: remove display-port node from Arndale (2018-12-06 19:47:15 +0100)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.21-2
>
> for you to fetch changes up to 8ac686d7dfed721102860ff2571e6b9f529ae81a:
>
>   ARM: dts: exynos: Specify I2S assigned clocks in proper node (2018-12-13 21:56:07 +0100)
>
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.21, part 2
>
> 1. Add missing CPUs in cooling maps for Odroid X2 (missed in previous
>    round of fixups).
> 2. Fix clock configuration in audio subsystem on Odroid XU3/XU4.

Pulled into next/dt, thanks!

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
