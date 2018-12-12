Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C45C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F13A2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b2sjpJeH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="JCYSSMOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F13A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nGWPFMBwiejUpFf+MEuSjZvoAg98hDJZ9MCyOd+HoT8=; b=b2sjpJeHrUNo4n
	u8FQdkyqUnYnZVhXGNfgp0S4w+Q3A4KFbGPon4cnxZ8iHoPEAhD2RP+o7c5HfBnalG0+W9QCU3hg5
	7tm9UumjbVyKjD6PMR3GqJpz1kZpUH3FsF1U0Jjqxcil/7HfLdgwFEqEEA+h7I0WIGbDdma5B77Mv
	7Pl1TxpuU8tAISlvoXBQ5uqdKw70xbkVRYb4X2r+KYZi3QvlCYmOW80SYVopwyiwz5Y+7pl+3PbbI
	EL1QeZfgj3MQtjlfNQUYmCIPysfy5RBjFbw4dK9w3EW5qQdrkeahwgH+ZLiAs0YTgkLSNNw+/KSBA
	E5inQ1Aq/0bE0XpdmiNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCqC-0000u0-W2; Wed, 12 Dec 2018 22:18:53 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoA-00077E-J1
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:00 +0000
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so17674803lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AZpJqy+USIaSuTPgZu2Fn6o/BaHHKk+tNlBnO0NFfNs=;
 b=JCYSSMOao9ZNBy9FbwJ0OTx50+zUt5DaQwttdKWD1+ZlfWYRFLUPDJjxsULG0V60bz
 FASrN1PsgqmY+me6dlL56J2WOBMO41gUM9KhJExS4Yz5nnnQYoxZSOg5Vihm3xlf/0yw
 8e4NWDHJf6d0DRO4zVqg4gFlWSna43VOtWeVdoJaQ/kd6pEmAJBDq5JoefRmlkT+F6c1
 TdPHCguZO1QCh3198Iq/AgkJ5J7B8j6TVf0t2K3Yl08tJqCmZlSUYkNel9q9lMHhXRKR
 MR6v9DobnKeJVnQoCGCa+tyFNX3jMAzepCqmEJc/knQ6eOSLKtE/vELzlVAqrvsPn9LY
 fx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AZpJqy+USIaSuTPgZu2Fn6o/BaHHKk+tNlBnO0NFfNs=;
 b=Eoiave3JaOVRLGogX6Mx8jC4IuL6LDMNb99pPK4D3+BAf0qftdT66qIGouuQy9o++n
 UszPEQahG+jAd3hSocle9K1k729P6vOauYXJmhq1ORXKePyccRX29H4xD011B7dRcA5u
 a/Pz669hGCAIu6N54Q4pr7HSF8/c/JFdS8OcxWBbJoQPRpVHY2r8xUMyaB78HjbVADq4
 dQ4KAQcXLlOpzHYgyqxEjUxq+1IzusAfsiWQfaaArngQx3PKVkLAKxEsMzXEgWM3AabB
 1jdLS+m75T+RODcFXtFjVa8L/sY5zZhgy/X+auoO3Lnu3ElgH/tYSYxjqsPhUyr5club
 MHwg==
X-Gm-Message-State: AA+aEWYZAdRbhJsqpLfXNUZGJ8fGibkd2CjlrxMbb9MD4RHjBxqCXx1O
 867AKqtJCeil7lHPigwI1LX9pA==
X-Google-Smtp-Source: AFSGD/V15HwTxSpeUcRgpCF4wjR5xtZHFbAaOohjov9EDClbPNEU1yvgYfeqXWdyyuVuw3xlomfGWA==
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr3495148ljj.43.1544653002371; 
 Wed, 12 Dec 2018 14:16:42 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id p21sm5531lfj.10.2018.12.12.14.16.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:39 -0800 (PST)
Date: Wed, 12 Dec 2018 13:51:11 -0800
From: Olof Johansson <olof@lixom.net>
To: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [GIT PULL] DaVinci SoC updates for v4.21
Message-ID: <20181212215111.b7mxbzywsvizrt6n@localhost>
References: <127f9656-0cb5-36a9-f3fe-226730986ad7@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <127f9656-0cb5-36a9-f3fe-226730986ad7@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141646_903297_F103E674 
X-CRM114-Status: GOOD (  14.43  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 ARM-SoC Maintainers <arm@kernel.org>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 07:49:44PM +0530, Sekhar Nori wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.21/soc
> 
> for you to fetch changes up to a2ce9a67051bbbcc961aca2e06dcadd9b72d72fa:
> 
>   ARM: davinci: da850-evm: remove unnecessary include (2018-12-06 16:19:50 +0530)
> 
> ----------------------------------------------------------------
> DaVinci SoC updates for v4.21
> -----------------------------
> 
> This set of patches moves DaVinci one step closer to
> not relying on at24 platform data by relying on nvmem
> cell lookups instead.
> 
> Once other dependencies are merged, for v4.22, plan is
> to merge another series of patches removing at24
> platform data.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
