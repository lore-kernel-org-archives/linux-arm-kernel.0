Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AA6C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:19:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7646C20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eYHHWhMk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="MsbPrk4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7646C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QDKOUWGi6g5VfTN/YpbEOlGgYz0qTnDBX66PNEG4y9w=; b=eYHHWhMkF/5FWn
	tzSfQIVOaFwrKWL8EroZ+p3d53764v7wMnDi3lAFPtzr++QkTIJEwq6pYVGBlodxZAG+BNCe5ZJh3
	dZQtidtQH2S7iNu8L1tTYI5LHgM3y7ugpEE9Rb0P+onGS4bZITHIHdkXsnJ/FZCqj1W6rUBcM2oH8
	Apt9mZcs3nbxOt38x697eOXBDt87G7ZiYs4c+orSzl5Bss/+g6E31774hV57clKRDPdrU4uWs3DSq
	Mtjz0m4eAFtwJXowLoG5u2X5qdoeJvXhZJlgyfkTpJC2Rk/GBfSs3GwSDmSiTW3WHi358ErGXNLfm
	kNy9dcIcRCeaovARrgYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBuo-0001yo-Ci; Wed, 12 Dec 2018 21:19:34 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqs-0006AB-3O
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:43 +0000
Received: by mail-lj1-x243.google.com with SMTP id k19-v6so17541693lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=A48OpbdKGgcryl+x5xh4bNq7rglByBBPHqorCTR9c8o=;
 b=MsbPrk4tPSWzYEB1IlVNe32G+EC3C5ijCZsXJcY5VcJJD9Ws8nIsTlRV33wgMCXncW
 ayBSJVEk5Nljk06F0gkeYJQ+yxDvJzrPgEyCAqdeRVRpuotgWpoFVeHcgnY5M2/orCbV
 Pix2FXnCoiQyHxsGcBzCuDiCeiSqVgzJyWMBYPxWA3boTcBa0M4LBCykyC0Mb2q13WzG
 btzxpQbBN85kg5JXruxLzd56YZRSTXsMHYjCnjy0De2fMg049ANxAWs81YNfiDUNrDai
 VIl8et6pYXvwKjBY40uPLUaHCP4xRC9N7EwlAGS9gX9GmjPDOKN5Uxb7RReBOnNbgRKp
 lKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=A48OpbdKGgcryl+x5xh4bNq7rglByBBPHqorCTR9c8o=;
 b=ElrrqiqqFtvZSOdip9zXpgVMzrmVps1hhuL1YF+ZCj/PSm6PVPIRKHOKRIKz6y60s0
 Dt3ZtVyfwSJ2jPCVI3DpAJUyKsjo2rlIINB6tjO42gCZspjNlrp350Qi6I37jXm1Km7B
 sEmHMzXysBeE7K6UlTULuXGBNpqybRdwsvg3ZGHIETaF61SRzc6zcfk0TyiwGhUYa66v
 LNgTmfeD6qyvRP0NSoD7pmf5ZktMd1oG1WW5t1DjfVlMom8NnGjbHttYBrEPN9GQcqQ2
 1o8G45MJ9+OoP4/1hqw41F0ndIWcsMpgqouaqIRdc49Cn6UPzr7zL8eemJfP7XSm5cbC
 eg2A==
X-Gm-Message-State: AA+aEWaUM+zQgIghR8zuJ6QRG0DR9G/SMEzomp+WB//mdRO4ULidaoZQ
 okyvawkdClbjC70vKWGI5FnG8qWadpvSlQ==
X-Google-Smtp-Source: AFSGD/VFPPzs7RqRHClUfkCWieLMGAd3ZD6nRzIuuIUlib+SFRuqDBIncBQ0JQ2haip/iJrXyMM5kw==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr12741289ljd.137.1544649318364; 
 Wed, 12 Dec 2018 13:15:18 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id p77-v6sm3820860lja.0.2018.12.12.13.15.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:15:16 -0800 (PST)
Date: Wed, 12 Dec 2018 13:07:32 -0800
From: Olof Johansson <olof@lixom.net>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [GIT PULL 1/3] Rockchip dts32 updates for 4.21 round2
Message-ID: <20181212210732.443fl7n7u2a4yefn@localhost>
References: <7153021.iXIDTOc0j0@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7153021.iXIDTOc0j0@phil>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131531_171982_76EA08DF 
X-CRM114-Status: GOOD (  18.93  )
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

On Wed, Dec 12, 2018 at 09:43:36AM +0100, Heiko Stuebner wrote:
> Hi Arnd, Kevin Olof,
> 
> please find below and in the replies a second round of pull requests
> for 4.21. This includes another pull for 64bit dts changes and a single
> patch from Rob that should go on top of next/dt after merging the dts
> changes, as it converts the board-binding txt to the newer yaml format.
> 
> This pull is also somewhat special for me, as it includes support for the
> BQ Edison2 tablet (including graphics) that was the actual reason for me
> to start looking into trying to get Rockchip support into mainline.
> 
> Funnily enough that was over 5 years ago - so didn't even take "long" :-D .

Nice!

> So please pull.
> Heiko
> 
> The following changes since commit 99935bd4b5b4558beb069222e6d6143fe5830d64:
> 
>   ARM: dts: rockchip: Add all CPUs in cooling maps (2018-11-19 14:45:07 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.21-rockchip-dts32-2
> 
> for you to fetch changes up to 7841b88a8fdddc0e7f3377fc42efe4cb3be1ed8b:
> 
>   ARM: dts: rockchip: Add internal timer support for rv1108 (2018-12-11 20:38:07 +0100)
> 
> ----------------------------------------------------------------
> RV1108 improvements (uart-dma, clocks, interrupt numbers, gmac support
> timer and emmc pins) from its first real-world user.
> RK3188 improvements (OPPv2, cpu node updates) to prepare for a new
> devicetree, the BQ Edison 2 Quad-Core.
> VPU device node for rk3288, right now only the jpeg encoder part
> will be in the kernel but hopefully other codecs will follow.

Merged, thanks.


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
