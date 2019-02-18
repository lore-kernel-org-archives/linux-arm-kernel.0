Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B45C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:27:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84CC21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XzNCDwzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84CC21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OzzAMNp/lBNgvyn+bI/+MgiuF+hprzOPGm23Z7QCTg0=; b=XzNCDwzvyxy0uw
	Ww+4YhYWnpZJOcTJTPSbesx88Kc5M/v4T2XXhk5/NdCZIK1zEYVo3I8oamtjsT970cjU6YTwOeB8O
	EufbFPMzCRRgh9mg1X0gfPkQgvntTMKYbrHBGI9zHqlYoXitAvPjlXQk91Lp+f+aqs+71jNBQ+Toz
	irTqiEK3oDQE4V8yGcl+XHn3joCcLXg+CSBYx7ATtCmUGESPOIKZzST6xf5PNxK4MM3XBDnlPQF4Z
	lgLrPeJrS2UpV523SNocrPA3EYfmI/3rXoT/6x24xb1HFvJGc3Vv1wS0Z6njScEhzhZGouf/p1sBm
	UTA8ETDBgCTb0E5S91MQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvndX-0005IZ-5W; Mon, 18 Feb 2019 18:27:27 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvndU-0005I9-B8
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 18:27:25 +0000
Received: by mail-ot1-f67.google.com with SMTP id s5so29859461oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 10:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jTr/lvlD8lTV7TFbQU/kmoUeUTy60AUoqMdDz8Zxoik=;
 b=DbseyGT+1QvEJeJyxKhu2EKLaIFqqrasx7HdXvixzjbxPM7576bBxyi+p5fEwf1ZCY
 odXza5bTg41VWII09pMY9g7D64V2wLpHL6RolUeiDX5LHkZmiea0oA/YtD+ioGyuj/Ux
 yg887XilmB45e9lKQT2DuCiOfvP7TqaH1X+mra6zMNRZnSwtXehPVRkjyqXiqFryZuKQ
 T2zOPjVGLikAlsQG4R3w5AFPZuylWUDkgii1qiGeQvMet27EKROjXtioE7yJmg6k1Xr5
 oD3EAMyrbodgMygpcxwL0rG4BtQj88U5r5UCid+SMPbD8Y1jAdUFBx2W8M1tjMKPvHj9
 SiMQ==
X-Gm-Message-State: AHQUAuYO9jJ+mszazxXR8PqPyz1UZ6vbqLUiiIkzw2nNg/F4IVBw8En1
 7pj1/6SOgEKP1CE2mKjkWw==
X-Google-Smtp-Source: AHgI3IZXcub3KLsUnUXUDNICmGs3zhIxlB/zspdl4SBim4hJxR2A6pOpzZxbtqs7s4XTWECTA6p68w==
X-Received: by 2002:a9d:77c5:: with SMTP id w5mr8828113otl.69.1550514443397;
 Mon, 18 Feb 2019 10:27:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l5sm5735567oil.15.2019.02.18.10.27.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 10:27:22 -0800 (PST)
Date: Mon, 18 Feb 2019 12:27:21 -0600
From: Rob Herring <robh@kernel.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: Add Guangdong Neweast
 Optoelectronics CO. LTD vendor prefix
Message-ID: <20190218182721.GA5241@bogus>
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-10-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215050957.20755-10-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_102724_380974_20457EEC 
X-CRM114-Status: GOOD (  12.27  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
 dri-devel@lists.freedesktop.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
 Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 21:09:55 -0800, Vasily Khoruzhick wrote:
> Add vendor prefix for Guangdong Neweast Optoelectronics CO. LTD
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
