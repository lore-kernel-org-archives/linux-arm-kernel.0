Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAABDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:39:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7FB218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gGFJ8nbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7FB218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wgjw5SVHgL/wzyBgFDUCnkXcyhdb6+qmXMnES0TVKFE=; b=gGFJ8nbPHmBvkU
	bpeoeMVEOh0QWir6DTpSoiaGJz3tecNxOzWVoySsp9MrsfLsM+i3g94iaVbTAL5oPBhptrjMBOXoT
	a7NeR+KbvXAyLP5h24PYmt2jM/TpR0qjrP8ATdWarMteVXgG5aLQswftjdcLPw7oDi9nUSojmaKaS
	SCui6qX3gpoE0Svb3ljkxlR39E81UdKx/ak3nzI3tKaWmMbkKdwyK5p74ArAfywI3R3waw0gNxHVm
	xRE7vrfk9OETscGS67Dq7kZ1y2lc7TapytRglDGkZRAtIiNjdGVQNwWD9aXpNglCArlZkOOuyHMNG
	Zpfyo9NklmeZh3pRnN0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga62W-0000pw-V2; Thu, 20 Dec 2018 21:39:32 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga62T-0000oX-6f; Thu, 20 Dec 2018 21:39:30 +0000
Received: by mail-ot1-f68.google.com with SMTP id 32so3297333ota.12;
 Thu, 20 Dec 2018 13:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qYfUlyfdTFSzvnhly1xQ2zw/wrNbkf8eZk1/fJIxbQI=;
 b=ZRUZKj0YaoVpBHNORNi0BppsDVOJ9cMMWhCpPD27FvUetdKs1masxqe2WMPXsED+43
 un7huw06bK6dKlyI1TI0KxoN0s/ubiKFurhYDMGEEnA1wAOGzXs7+OceGplWiAweRiMN
 DbNp6p/rJDYQkFgfNpUggcMugCHBoJ5REUQbvNsKGJ+Jmm87GdPE9WauBa0J85wzxCZP
 kvFg6Pa3AAx8yj30drE14FjdTRtVefLkx3alFOYtxhTqwL9rxOBXnXmsJ8i5cBiY56lo
 UJOq0+3DspABtodrBzM9yIj9vm+2JGX53hULNoVTVqW94QBHuaQ3WTEPSPwBbqYAK5kT
 jSuA==
X-Gm-Message-State: AA+aEWacOGaRY+whG/9h9Go5gySkYKLqWzaQtNqEqrPauxgIb+j5Ki/r
 jpWGLjEpLkkzxpr25tpSEQ==
X-Google-Smtp-Source: AFSGD/Wx5he7Hc4IYcf1wiaeOKq8aeMnwf8oCv9slWCZfPCBUZ3IsE326wI28P/TWaNKZSLK82HN4w==
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr18432795otb.21.1545341958313; 
 Thu, 20 Dec 2018 13:39:18 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id m25sm10487093otq.32.2018.12.20.13.39.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 13:39:17 -0800 (PST)
Date: Thu, 20 Dec 2018 15:39:15 -0600
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 05/15] drm/rockchip: dw_hdmi: add support for rk3368
Message-ID: <20181220213915.GA10254@bogus>
References: <20181217123650.6773-1-heiko@sntech.de>
 <20181217123650.6773-6-heiko@sntech.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217123650.6773-6-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_133929_240820_1231EED0 
X-CRM114-Status: GOOD (  11.41  )
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
 a.hajda@samsung.com, hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Laurent.pinchart@ideasonboard.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 01:36:40PM +0100, Heiko Stuebner wrote:
> The rk3368 only has one vop block and thus the dw_hdmi does not need to
> do the source selection.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../display/rockchip/dw_hdmi-rockchip.txt         |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c       | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
