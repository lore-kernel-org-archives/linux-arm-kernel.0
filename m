Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486B6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:10:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B10E20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XyF2DInK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="04U7TLMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B10E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zYkovKPlhqjQ7FHYdCQidVVZx/3w42CGw8kW7usQZYE=; b=XyF2DInKoeeBiM
	LLsZ12aWlWdRzIz73pqqmX8DuY6J9QE67d3bpoBYi2+Hn5ypUp7bUqXV6gfXqGeNndUENG36eLzWR
	eNIjI78K+qCDVgLOC+yjaX7pXzUy5p2h5ChVH6uyzJ5FlICXPw/rXC1uAR/4kSWWwMDifyigA9m4G
	9Q8DfsNL4iXfewXcEL5Zuq2Kw6XeRDN3ZXYP7RoD0pnGT/kqKKVlYSyzguTeCpZkvTIqvMkh4zGKz
	bfqX3KRiQZQ1j54PsCCH3p7syz3dJSA5lZtug8Y0XCRa/vZsRuhHR37/zBI1xOWjzVQdwg2QRV0J8
	fbGyRn9vAl2Q0UvyUZ6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsrQ-0003IW-Dx; Sat, 01 Dec 2018 00:10:16 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSseU-00022z-2h
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:56:56 +0000
Received: by mail-lf1-x142.google.com with SMTP id v5so5314905lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9BTLI9KdekzGBFjuz0VS8JAP6tu9kXP75NinWyl6zmE=;
 b=04U7TLMYZZ4SibxMM8NQo2vkzqlhaYsTIkMkEMsDQm5flZ7EjBenVSkN4z+UKT6CQI
 HByV72MLCRGbg3+5fOAlMgzlDtLaLoiMin2zTgIRyx6LAoQa/KcaGcLL0ScZH4QuFfL/
 1y1kvM1bhozIiWK0cPnRkh9Ojx0Ajc7OXmYdrNAUwrFf3+AUgm4KMCoA9eqQhHeWo79c
 P3HnXyXDHkNoVnrGhvivmGvsVQEmiey3b52anNlQVm08K78TVKK9kW6VP9Juhjna0ufm
 PHeRKB07JZffFhRIT82QPJMflcDs7xZcCU8Cvo7N+3xq1o8v39hTJ6iDggnqCzjEZMhY
 EtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9BTLI9KdekzGBFjuz0VS8JAP6tu9kXP75NinWyl6zmE=;
 b=L0pPCWjFc2TlC1mz+4eIpTgkGOTCWvO+L6GA6gA3QoRyd97sOZSgnA7RAmKc3bt4kZ
 WBmTqcXqNbeorOaxkZjxOIQcORDrGxvjp1M339PaCkHMmBLVu5KOAvmBWL+DLPqW6urE
 HWG2K1EHLHDzLnjf8Lev4RuvpBduPGt0Oy7XYMWXlwEdpgTwjLBQOyR+2yikxBZPja9T
 57ENhL7Ebn0njeTD2liLSgo/N0dyaKO4MXBJu8hG5abKPV/RwYep2fabUnOGX7May2pp
 yLisTV0Wnah7pF6WAZeYZ0ycZidMtgbR8TtWWU/Rjrd+Pjn3OwjmSkPbo0SppnxbIkch
 rRrw==
X-Gm-Message-State: AA+aEWa8zCOEbdq87ybzpp3taOB1ON4cMV+jI0ZfjsTo0okVhW5lOjhB
 Bc9vTibUjUUlQfZsWI+5EQYZJw==
X-Google-Smtp-Source: AFSGD/U7IGu23mf+fYfgkihIVgfnKvEjRls30dsWSEML6LhHjK2PCm+XqRWtHJqSlx3Oz/9MnGFq4A==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr4730907lfg.13.1543622200846; 
 Fri, 30 Nov 2018 15:56:40 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id e82sm1061720lfg.34.2018.11.30.15.56.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:56:39 -0800 (PST)
Date: Fri, 30 Nov 2018 15:04:16 -0800
From: Olof Johansson <olof@lixom.net>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [GIT PULL 3/3] Rockchip dts64 updates for 4.21
Message-ID: <20181130230416.ord6cimpadbsdknp@localhost>
References: <49803144.2ZsBJmaiIN@phil>
 <34315565.W3E18QRAdZ@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34315565.W3E18QRAdZ@phil>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155654_141449_ED5E7F86 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: linux-rockchip@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 11:07:16AM +0100, Heiko Stuebner wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git v4.21-rockchip-dts64-1
> 
> for you to fetch changes up to cdd46460fe278e04d8ee665d975aa2962036838f:
> 
>   arm64: dts: rockchip: Add all CPUs in cooling maps (2018-11-19 14:45:35 +0100)
> 
> ----------------------------------------------------------------
> New dts for Gru-Scarlet (tablet device), default backlight brightness
> for all Gru devices, rk3399 spi dma properties, some improvements for
> the rk3399-sapphire board (fan, chosen, backlight), hs200 mode for the
> emmc on the rock64 and declaring all cpu cores in the cooling maps
> instead of just cpu0.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
