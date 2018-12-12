Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65B1C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:33:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8779620672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C/nXdJsq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="djJffbJw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="sVzUgy6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8779620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OTsP7Qpt3AuqYQfWaisFhYTzUWP/TKLylad4BkT9hYA=; b=C/nXdJsqyw8LCT
	6vIu/MTdYbucLrjP3Z1Jgbk2L9nCYUPoubYRtg+FdVWKHGefqJevMi5LBh/zXiFdke06MK/t0ylpJ
	Ie2fyXpZVVyZI6qMm1HUxcGMxrFFmKp1bYa2xzZ6xwrcrP9XqSJ4pCEjF4GIUaEqMjQqzGHIc/dDd
	jikSX9njya/sqg2mMnHA8nUbB9d+F11gzZZhp5EDUZedg7LebMZlg1a91RfF7A/kaw6+Y711ioDOE
	YVS8dpo93tSEhjrqYMC6njJQraw62TAneSBAmEXu/3WxZI1Ch0OzBCZN54E3MJsjp08eAlwmyHmWp
	iIS4Ro2vd1cqA1I7BW6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXD3x-0003ot-Hd; Wed, 12 Dec 2018 22:33:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXD3U-0003Ar-7j
 for linux-arm-kernel@bombadil.infradead.org; Wed, 12 Dec 2018 22:32:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wi2YUUlP6mRKIejs9eBJwmgE+4wUHCKv+7WuMQrRggA=; b=djJffbJw5XWVyD/tKzPb4Ju6j
 E2LWFVpDrGy+8mrYjmKc7C5M2nQj8/GsPRqlnTksLnvtXEl8VJrfcSo28t/FDDi33YeG+Rnpd5uBy
 tlvrB/yNrKcLZfiJDWRFFsQrMf3w5WaSP0XHcpUv+sHF7GbLE0HfrxRDidrC318A478Hp3KAeb+59
 xxrGObB8yModXF+b2Kb0NYPhHHM7D+R03xhIGDqE0bsxvYrauXa/GUlGWJm31kdtE7tm7E5DmYuOZ
 LUmcTm77xvAUXFI0T9LseMjkHfuvlLPpmDGc0s9nDP5Ig645Y1iyc551Qq2sSQPKMDqBMgnlj0jP9
 bwC1EQ6lg==;
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCnm-0003wD-MU
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:16:24 +0000
Received: by mail-lj1-x244.google.com with SMTP id g11-v6so15106ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wi2YUUlP6mRKIejs9eBJwmgE+4wUHCKv+7WuMQrRggA=;
 b=sVzUgy6VI4R8RQYgffgBtY5umERPH/HoCusAKNiYWLgpBHeIj4mqa+EQMnxCwYGPcZ
 6O5byu0/bpbBHuuQnsbF4Ogkjh11nIq8JeIGXwXjqPUd7DDuvLZ8k3OqNPwoQmLQmajr
 hwJMTM/j2V1ZpGNF+aqmzNAdZuH5KFwB3+dgWQtAgjb5v3KxZ2TYQkE/aXAu0bVBgw0w
 JSfhRrFkTy/e4IHfuBUM/ZjnQT2Lkbj/lOz6S2MFYpwlYHDd9bGe0/t7fY9Y+Tr7jDBT
 edDuQy5C1PynqLojGgMXjzZYRM03imV3tl7v9vV8KD2mozg86yDGoaf+x/L2h9ZrN5IW
 Owvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wi2YUUlP6mRKIejs9eBJwmgE+4wUHCKv+7WuMQrRggA=;
 b=WR7+8BltJJ0ifPY0+A2D2N7J2BH0S0hSpxKC/4BZmX2Vle4jlAfAYXWqMIJ3UAylpa
 J8KIepXkSv07XG9l/nSi+4DgY1z/PHaaWRsmKmi53GxsfoTgkxiwLlGDGnGemX5RUH6C
 vHR9Qe6viQIQ7A4o/abduhvfDa2gXQjNqEytXVY3R3GRNDRLiZEHcjJ387xYJeYiMb8O
 7QYzZBcW4B/JsCJkAl507QsK8oeln5Ebn+9JskD/W3AwTZGuJaf15pvARxcBzLJRd/Pl
 xeta64ifQPkz1UpZvGZXl8TM6HEiEmFitvt6zyBwHiGLFyDrggJjnCWGUBUo1gRGyEAh
 Lt4A==
X-Gm-Message-State: AA+aEWYbmK6RLpfsWA36wT5+B/JLhoEkWoXGM6Z1AjmA+WAzcWPGL+K7
 km2sa86jln5yo5WHIFDBSIZtig==
X-Google-Smtp-Source: AFSGD/UfkPX95RrEzDSdo+LRYJel6aawPpIzjZk06bMbr3yR/S+XGnrRlc8EKw48fVOVgEFQo8mK0w==
X-Received: by 2002:a2e:9a16:: with SMTP id
 o22-v6mr13334853lji.112.1544652970357; 
 Wed, 12 Dec 2018 14:16:10 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id h3sm3954lfj.25.2018.12.12.14.16.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:07 -0800 (PST)
Date: Wed, 12 Dec 2018 13:42:30 -0800
From: Olof Johansson <olof@lixom.net>
To: Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.21
Message-ID: <20181212214230.stbka7njol6qgvpj@localhost>
References: <cover.1544126077.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544126077.git.horms+renesas@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_221622_764008_3138B0E0 
X-CRM114-Status: GOOD (  19.26  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Simon,

On Thu, Dec 06, 2018 at 01:57:02PM -0800, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM64 based SoC defconfig updates for v4.21.
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.21
> 
> for you to fetch changes up to fe16bcd6d44f1a2bccc4618119463d9d23a6ae92:
> 
>   arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE (2018-11-16 06:56:49 -0800)
> 
> ----------------------------------------------------------------
> Renesas ARM64 Based SoC Defconfig Updates for v4.21
> 
> * Enable in arm64 defconfig:
>   - Renesas R-Car Gen3 PCIe PHY driver
>   - Renesas R-Car thermal driver
>   - ASoC simple SCU sound card support
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE
> 
> Simon Horman (2):
>       arm64: defconfig: Enable R-Car thermal driver
>       arm64: defconfig: Enable scu-simple-card driver

This patch enables the sound driver as a built-in. We normally try to keep all
non-critical drivers (i.e. drivers not needed to reach a rootfs) as modules to
avoid the defconfig kernel from bloating up too much.

Would you mind respinning this with the sound driver as a module instead?

For PCIe I can see the argument that you might have rootfs on nvme or otherwise
attached to that bus, so static there is fine.


Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
