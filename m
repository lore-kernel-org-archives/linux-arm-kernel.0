Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:37:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6192070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="My6DwYQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6192070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nyz88RO0EXsUlbLoJtziKiTxaUh7QCXKZvuzFmgRuIA=; b=My6DwYQjk13iW1
	+aqzCmTidp/e8IM+zxLZsvZKMKsTgHYw0rlxxC/Mp20xlwCWBBraaJGTtVQLsRKTpWyNJ8ir07Ce5
	1fkIj+EfGxR+Hhnn9AB8xLz2ZUsobM5xKtvkbgU7tIq+T2OBLZFYtwPhyH/lHzVMxQ9eynjgwxw4g
	c3g/yWvh0EGRVtOyusfwfuPOZ601F78EbnWtj001H7fHUlfkDHXgGvRndMYNHhxVAvnzDANi0kcsX
	p63NKo7HMZqrNNCt6z+XUV5N5ZXmWWOyX0AopM8vJPxhIS4pLg+bpXztA5eChNrtsoIkkHzsDY93y
	wO9ZBnW+zbBfKvDMu+4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga60v-0008LQ-49; Thu, 20 Dec 2018 21:37:53 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga60r-0008Cd-6I; Thu, 20 Dec 2018 21:37:50 +0000
Received: by mail-oi1-f194.google.com with SMTP id x202so3122115oif.13;
 Thu, 20 Dec 2018 13:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gbvNThyT64pYn4IIm/cn4nFNr9QjP3ZU05gDPrkLym0=;
 b=ghFkGQ0tYx45RQAJCRn3wzuz7bkHY+2dndoYAwHAaHiUSAjE8tvO0NelnCf2N7zAFG
 t7A5weYQY2FJpqB3MPFitJXs1QBKNIX8GQqugYVGn14LOeRFor0p1v/lV9yGrQ3jKgSa
 wEFU2wnZ34FUaf5XM36CxI0FZ68rlOztZM4lGOm1ydMTN0UcJNj13xckeQzSvgaKBq+3
 +m6PznUdnK/xgBedm3Ed5DVHaXTulPbs3fR9Ps+Z1GhzuUTqcMAG1FtSbnTqVl9L7X+c
 mWIch99AEcTHUk8LiSbKqZYc5TerKQymh6nCr4rxDf1zz1mAM5ZHYdP1/B9kE6asrEyZ
 1d1g==
X-Gm-Message-State: AA+aEWa1RwjJTgbHdPJJ/+sRtlBWZNNDzYT+Bjz0TwHbBxE8JdZXVPEK
 JgDVRclQJBAB+vCdc3rrhx0K1KU=
X-Google-Smtp-Source: AFSGD/Uwn7+frecMmY+aLrX0P+YMRhbZnL9LwE0udLaXT3qWXnrtdD/VWdR/eAF19NHPXf4MItwhVw==
X-Received: by 2002:aca:ac3:: with SMTP id k64mr286268oiy.78.1545341858244;
 Thu, 20 Dec 2018 13:37:38 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id m3sm10405386ote.64.2018.12.20.13.37.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 13:37:37 -0800 (PST)
Date: Thu, 20 Dec 2018 15:37:35 -0600
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 01/15] clk: rockchip: add clock ids for dphy rx and tx
 channels on rk3368
Message-ID: <20181220213735.GA9546@bogus>
References: <20181217123650.6773-1-heiko@sntech.de>
 <20181217123650.6773-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217123650.6773-2-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_133749_224443_D4D5BC2F 
X-CRM114-Status: GOOD (  11.36  )
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

On Mon, 17 Dec 2018 13:36:36 +0100, Heiko Stuebner wrote:
> Add the clock ids so that they can be exported from the clock driver
> and referenced in the rk3368 devicetree.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  include/dt-bindings/clock/rk3368-cru.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
