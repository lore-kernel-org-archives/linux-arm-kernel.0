Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1198C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:42:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD7A20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J+XBAVhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD7A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x4Y/PNFru+/rEooU5O8OB9tB2Io4S62AX7n55T3w+pM=; b=J+XBAVhC6A4IYo
	sV18J3X0lS56Uq5p6Q7pqwnztIxDN3vZUQ4hfcaHF3Cqdpu9caEuEj0J2kU9eelByLC/BHqSO3Vmq
	E+lXpHeD5GNNOpJxaJ5P+Q6q6DtPiF3PcuGWBmHDu/0rz31PKT+FqZGcwobtOLjme7LUqHG+GI4hW
	tv2V5l0cMVj71euBn5QJ/hzbQtTZXEXMlgYBct1p8VH2h5277lpLjroptxmmUR6LVx+ZEZPoj8czj
	88chSy4EBQgN9ZfluKrwE9Pfu3u9ZErv3sabRgRvjzKzsvtNkVm3e+sacfGLJyTClxNFiwzjppP3A
	PVMX+zLrJ3oKFt3/cwRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga65B-0002go-Gu; Thu, 20 Dec 2018 21:42:17 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga656-0002fb-RU; Thu, 20 Dec 2018 21:42:14 +0000
Received: by mail-oi1-f194.google.com with SMTP id a77so3155613oii.5;
 Thu, 20 Dec 2018 13:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5YsEhyaUPRZXg/JZZlbqLdZiJRNmQFO+ziEMYQYfyvo=;
 b=i0AKtAvNxqUn9WXAlLwIv9AbUlCp1yJQvMnIDFHBMH7+vpCE6mY4mkOogULn9b3wsA
 LYutWfDqZdTq0pVPIHp/RCjWZqMJYiUznK4PRMleg0pnyNTpQypXFFxCzK8yVzOLEVbb
 JbXJKlc08hL3tL9j1ltWHDkr4mWbYOZnaFyGCg+kM9HFOcOAZfLEyNUnHoyuI375LlYk
 JH6FHpFqbB8hgrssWrk1XDYsWe8i2tLOigQP4LD+GGa78OqA9em4K6lAcqslk1mxlAve
 3rBAxOWxbAYExdTlV7quiGj6g+rG+g9clu2uGb/gDEEeTbvVQKVjTCOr79hkj5dQnXSg
 l4rg==
X-Gm-Message-State: AA+aEWZ2PTOVYNJhiA8ARtvFuYrLtbO559vAQHFMa0OvpxCkHNpqk7rw
 HIkOL8H5dWhCQsVd/jTWAQ==
X-Google-Smtp-Source: AFSGD/VV1VdaqkMb24ABWv2itXTSQrD2vxZU0AokEdO6vky4wcTCLiw0ujWoS+/Cy3CBdCC/Usg1xg==
X-Received: by 2002:a05:6808:493:: with SMTP id
 z19mr316745oid.46.1545342122097; 
 Thu, 20 Dec 2018 13:42:02 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id u18sm10224498otk.1.2018.12.20.13.42.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 13:42:01 -0800 (PST)
Date: Thu, 20 Dec 2018 15:42:00 -0600
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 07/15] drm/rockchip: dw-mipi-dsi: add support for
 rk3368-variant
Message-ID: <20181220214200.GA15833@bogus>
References: <20181217123650.6773-1-heiko@sntech.de>
 <20181217123650.6773-8-heiko@sntech.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217123650.6773-8-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_134212_885463_18B4AA8C 
X-CRM114-Status: GOOD (  12.55  )
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

On Mon, 17 Dec 2018 13:36:42 +0100, Heiko Stuebner wrote:
> Add the compatible and grf values and allow the driver to also
> not select a specific crtc input on systems with only one vop.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../display/rockchip/dw_mipi_dsi_rockchip.txt |  1 +
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 25 +++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
