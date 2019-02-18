Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667CAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:13:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33303217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fWwxiiN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33303217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Soi++K6Zo2K/vW1ZFZQ9m0RjQVBKXWd9D6RTE/lt1nY=; b=fWwxiiN8cA1HWy
	SDAGN+Yrqtg5u5to1CEoQpH4+Tn7T8Ts11Y2OsBqMJf+ZzVvRUqsImGgHXGvIpt6r+vBLayBOyMrk
	X1gm1gthLya39T2d0BwUNQYKDKpRYnDoOF1pMnTwbAaPd23dYvj2RxqYhUX90igVJoSdTXpIGl6A6
	I/Nbn2fbdVt+Ce2LbxiXekHOq1mqqAjSNMBYIc1RTbZLtPzOfC9xuZThNZSPwMZfhsVpvZ15zKK+w
	9TehZpfe2ZANOw0eYpQVixppF3OzwL9MTBmp0lRUxKZzlkPN43kk+Z701Mqm2Lzc4cOIC9u++mC1y
	ojqAbk4tUmf7bdT9R+aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvnPk-0006kf-6e; Mon, 18 Feb 2019 18:13:12 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvnPh-0006kF-2Z
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 18:13:10 +0000
Received: by mail-ot1-f66.google.com with SMTP id n71so29755511ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 10:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=we+gKH7DOYkRwSWSL7l8B1ml0gcVRgfQYVC2BIZpmYA=;
 b=OkmhQZd3omhhFms3V1BkNP2uREiI+rLtExHvGDWaeSbJ5lthdA3KBIjkHzVZwMPP74
 m5MZiROKqhJ/qmQ4q1qjWbkDnrxm/m5HHd6iziizutVOUJj5Q5uhQH8zFCWT+frjXivX
 QymVaW9C5oYfHqNRIqEy6JvaA6loH7SfnROOqHr88gDN+fpak0cLf8Yf118WJPHwbrOJ
 CTEh1lqz2Zmvq5Tnkdgs0D/Inl7y0aJri4kFaqnp3MmnOwcSTmEvQg5D1huj+6a3x0aO
 BevbTNUYIb0dFdZa8iqhpZz7oneLwgwK+cTtIdsovy5X8HZQiA7GotZHATmeR0F5LES1
 Aqmw==
X-Gm-Message-State: AHQUAub39yqjZ7nUmkndGse+Ykjkpej0oy959rmynyTeKFUpx8bLGu2t
 BsnaFeeVMyBSPqm3rhp+4w==
X-Google-Smtp-Source: AHgI3IaAroP3vrcWgzM7b7CUYJE2RPy6uNoG+WscS46+LR3+/5uomEvv7WZUwLbKNZ1HBxHyGnEF2Q==
X-Received: by 2002:aca:7201:: with SMTP id p1mr46211oic.159.1550513587829;
 Mon, 18 Feb 2019 10:13:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id j88sm6106045otj.47.2019.02.18.10.13.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 10:13:07 -0800 (PST)
Date: Mon, 18 Feb 2019 12:13:06 -0600
From: Rob Herring <robh@kernel.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 04/11] dt-bindings: Add ANX6345 DP/eDP transmitter
 binding
Message-ID: <20190218181306.GA14222@bogus>
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-5-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215050957.20755-5-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_101309_163221_6C681825 
X-CRM114-Status: GOOD (  13.59  )
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

On Thu, 14 Feb 2019 21:09:50 -0800, Vasily Khoruzhick wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The ANX6345 is an ultra-low power DisplayPort/eDP transmitter designed
> for portable devices.
> 
> Add a binding document for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../bindings/display/bridge/anx6345.txt       | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
