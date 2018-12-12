Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA192C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A310420811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hFacUwls";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hhqVtW1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A310420811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Opg6PRn6arzP+3KHjSRPa7PwX4AZjr5ZcNBOx3F2lJI=; b=hFacUwlsiROSpR
	rMcSP3Y4ugN2IAuFtG+ehNe0qJwCOmTZYTv63BXasnOijsBex9xYBrx74YhihYAUkx6Cx14wD11Gu
	n8kb+SrqdrGZyeArOXR8HtJrSIGuq0CltCpLWL8V4RWmrayI2CEAS4sKxuFRHQP3mt3BZkU5tqO8h
	9vny2fdzbem93b2QvzjrD2/BbnO/YiOEmj8Mze6cUSYb6Ue1b/Whbb1KMf2z5GiZovbdZ0B5EjMeO
	2i1fCRwjzZnw5Idk8+A6XCe2R4FfmwoiQ0ULyPZgL90Hfs99xE2ki7Qe33DM2PqMvgnHi28tbb6Wv
	ql0dvXX1LtCXnATe3X7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBri-0007Z3-J6; Wed, 12 Dec 2018 21:16:22 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqU-00050g-M6
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:11 +0000
Received: by mail-lj1-x241.google.com with SMTP id c19-v6so17606132lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nJQE7odjoT0vDvgNSD+M0i1h+g356x+vaYUpeGJ+wZU=;
 b=hhqVtW1x2132l4ROlvgIN564ciibbn13pa0lHftG3kcStFzCgjIw/2HwGTxuQ9HJqU
 s6Wk/LqTqfea5edm21iAc1BmRMJzZwkHgqFXbIrQVNwo8C0jHSzwbfkhH8uY/l7e/5eI
 n4M2pAgG/tJpT3nDCyWe+dTeCFt63lLrTDWNRJmM1zPajz7nXRKYlFh5KhMXdDj1OVXg
 OTl1fuXZiMP/MapwwnGYZZjM9r0uwFnRRbTbFM0zbd1bCcEdz9kA48NE0bqC52CRJnCg
 HfUDXn/fzDMp/HwrAVpLqiups1XCmKNTJA3izC0ID7UNYv/LfH4gRL1DsjqMTzJDVBX7
 C2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nJQE7odjoT0vDvgNSD+M0i1h+g356x+vaYUpeGJ+wZU=;
 b=K0p0h15+UbHV/0+dDy+kgSZdmEcx+3Ef+koP11pzzNT9meONiHGutKVgH9wUYQV5K1
 Lcn3Yyb/pCvxM6ssdQVzMWkgjT2348DGnn6NcxtSaFT184BUjTxFsPjP1mDHXpMKwbYc
 ZfsOvSCLj7b0HmXhZvxo/ixjDNt263M4qV7m5Qxpr5UqzdwsTgNtkeYKN4K057WROKoH
 fHECZrdNQEhcaqWbWne2oWoIiGqN0w9fMAYW4khD9V2BrThyBzldiXf8q3YdLEvmkMsO
 7GA9w+wPffgHlEgIDJPoExORZG4Z2Kz2D623wr3UhgCZ3hVRBwmk+7Uu3vfYiVbV4+s7
 536w==
X-Gm-Message-State: AA+aEWYiptN0+cZGjl9YtZscejnYP1iYhCE/TFBTGNvmqW2rRyTZ4T0X
 tkhBTqjj9CI1TR0odNfwq/7oKw==
X-Google-Smtp-Source: AFSGD/WBjz/6OWgWTijrcxvGRE+4wHX3j56q812JT4zjZPZZyBnuhiaFUXypIorP08xRscoWDPqA2Q==
X-Received: by 2002:a2e:4601:: with SMTP id
 t1-v6mr14382760lja.111.1544649294134; 
 Wed, 12 Dec 2018 13:14:54 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id d15-v6sm3458382lja.38.2018.12.12.13.14.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:14:52 -0800 (PST)
Date: Wed, 12 Dec 2018 12:52:51 -0800
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL 2/4] ARM: dts: exynos: Pull for v4.21
Message-ID: <20181212205251.lmbteairsojqvnge@localhost>
References: <20181209114911.25194-1-krzk@kernel.org>
 <20181209114911.25194-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209114911.25194-3-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131507_322790_8CAB2F63 
X-CRM114-Status: GOOD (  15.90  )
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

On Sun, Dec 09, 2018 at 12:49:09PM +0100, Krzysztof Kozlowski wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.21
> 
> for you to fetch changes up to 57b13b8b34002ce8f1d822ea05f0a84e5bc3a64a:
> 
>   ARM: dts: exynos: remove display-port node from Arndale (2018-12-06 19:47:15 +0100)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.21
> 
> 1. Add missing properties and nodes for PMIC clocks in multiple DTS
>    files.
> 2. Add UHS-I bus speed support to Odroid XU3/XU4/HC SD card and bump the
>    maximum clock frequency to 200 MHz for SD and eMMC.
> 3. Update cooling maps to include all CPU devices in multiple DTS files.
> 4. Enable quirks for Exynos3250 DWC.
> 5. Add JPEG CODEC node to S5Pv210.
> 6. Add opp-suspend to devfreq OPPs on Exynos4 boards to fix resuming
>    from suspend to RAM.
> 7. Remove eDP from Arndale board as it does not work and breaks also
>    DSI.

Merged, thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
