Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4DCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:41:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03303218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aC/XwD37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03303218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BAlvfFpQjWOMyQ+6ljJfByk+55np/p+a9q90OTzMJak=; b=aC/XwD37o/6Ko0
	yicHiTp2dZ0Jw5XwcsYNfIy+IJI6SK2Rw8JN6gBVomPm6N/cjuLNn9WnTW6Q38oxzc5bVJo32Em97
	Tb4mUEatWj7EZSWlIcstbRRDqKF3U2vxPtgf6qjnEU0JU+V68jqncRU4RRd997B4tMwdPMo3nzXS7
	y8hUR/K4m0Hp7y0nictTCq1yxMA3KYv173GElADUVnkkWqu9RJNQ6eo/rY48VcOA1s5RpUkCxZYcn
	OpXBNhcEQVyl2mGrjdXk3YbyfTbKBXZp6pGHCvJxBCHITGn8ffMQAZRR0hWciSyGPq93kyouH2l7t
	6zGfS6pQS2gJ2R1VG/+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga642-0002Nr-JL; Thu, 20 Dec 2018 21:41:06 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga63y-0002MM-Pc; Thu, 20 Dec 2018 21:41:04 +0000
Received: by mail-pl1-f194.google.com with SMTP id g9so1472646plo.3;
 Thu, 20 Dec 2018 13:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OzlDUGVZLwA1bPenBZhw8gF2o4JDnMQ6lT/6wPw/zFg=;
 b=Y61PHAd8G1XI7WD5mX1xzbS95z25ytH+tuxUXNDpXOhid+q/dcwrkrJaKulLPb9y2G
 kWD6QR0u3mHoifY5dheTb7aYovI7/TphFQ9M0kKYVSrO5pXoMisD6qKkWCo1Xycve9u/
 oGUWkdf5qfzW7jBM83dq0aXqLA55BrN5V+nCTJ7JVb07XbTVbKD4jX6i1ea2Xq+HYbv6
 UsEfq7253xqBWysIVM79TolvrQlImlkp7d8hoaRst2m+WdT0xLTfvqzQBdC7uBndCdU0
 az5vTNfYnmWksRe208CSJf8VG0yjUVdGtAZ4ICjAe6v/7ZE+GkUYXud86jxUbHeWDbFC
 hWNA==
X-Gm-Message-State: AA+aEWYdF9XaqDmXIgbSasmb6XedFpkDZDGOKtXb7TTlNWb+qx8Ky8Vc
 GCnpMjfCIa0jzAvUtWlRo6RUjt0=
X-Google-Smtp-Source: AFSGD/UFVTsWeOtKla8gn4ybx5gCW+EByIkVajFut8Aul+L32NEp5KzdiETowkB/S7OXnNezF/oMbg==
X-Received: by 2002:a17:902:a710:: with SMTP id
 w16mr25082864plq.95.1545342051999; 
 Thu, 20 Dec 2018 13:40:51 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id q5sm37727187pfi.165.2018.12.20.13.40.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 13:40:51 -0800 (PST)
Date: Thu, 20 Dec 2018 15:40:49 -0600
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 06/15] drm/rockchip: analogix_dp: add support for the
 rk3368 variant
Message-ID: <20181220214049.GA14179@bogus>
References: <20181217123650.6773-1-heiko@sntech.de>
 <20181217123650.6773-7-heiko@sntech.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217123650.6773-7-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_134102_830838_2D708A2C 
X-CRM114-Status: GOOD (  14.61  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, architt@codeaurora.org,
 Heiko Stuebner <heiko@sntech.de>, a.hajda@samsung.com, hjc@rock-chips.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 Laurent.pinchart@ideasonboard.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 17 Dec 2018 13:36:41 +0100, Heiko Stuebner wrote:
> Add the compatible and allow the driver to also not set any crtc input
> on socs that only have one vop. While that was already possible
> because the driver checked against the grf-reg being 0, make that
> var an int as "0x0" is a valid grf address itself. So standardize
> on -1 for "no setting needed".
> 
> The dp controller behaves similar to the one found on rk3288, so we
> don't add a new chip_type to not overly pollute the bridge driver.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../display/rockchip/analogix_dp-rockchip.txt   |  1 +
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 17 +++++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
