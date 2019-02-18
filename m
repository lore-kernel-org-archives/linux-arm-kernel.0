Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25BAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:33:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2172217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="in5zKgpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2172217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eF9eDWv+xsza45SEd6YKRlkHwaLs3D4nLXzyKZhxREU=; b=in5zKgpOQxvjhl
	tYhDGBfe8XX2FkJ8dVexhZkPYUeI+5o9qBCg/1ZrFXAjRuKzJcoOD86LJehsG7a+iAgJILSqVMjFK
	9usHZgoTqpkKdMdcj7Xv2HoAFu0Yr49nr5XpoEYKkSZZhzdRgzYsdU92ivgLZ1pzyxe/8aZfT7Gvs
	fp19z0KYetKFcbiMecoD00IIhQgcgnIWfb0UT0FkFNnY9Eej3LAl/9q6qRvMml/j1vd7JjsAFM/6I
	eeMQr4JK0iNWZnPAPwSIP6PZT2camWcRMWtjTFJRm4DMxKwW3TgwxtZ1mxMd1YUQvxWzbTDf6MfuZ
	QpmRpIZywwMETIg3p7HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvnj0-0007s3-GE; Mon, 18 Feb 2019 18:33:06 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvniy-0007rd-3S
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 18:33:05 +0000
Received: by mail-ot1-f66.google.com with SMTP id i20so29980709otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 10:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=d5I23BRielCpwTZwniIHSL4oHXFOZKXVQK0yJbHPArg=;
 b=AQIRdKwvWPZyh98KWJernwd46D21OIe+A7gXwIFEI8KciiyetaQLAcUipn+GvSUCq3
 xK93XLWnJnX6VD7/fPDbnHbvCsMqYVFhF+lWcfGInk5r96csn0WjZcXS/bgDlZrunY5c
 enPVynbULj2L1ODqYMOx/u52X2mQD298TzVczKVPISEhPshc4A5ZxqJ9pymgzUf8hq5N
 GXvHmgvQt2mSCEbvtR1wqSInKd+n/kbhohEbKoWp2DGxbqbX5SCtSbWoo2aQg+SlM88F
 vf0KyjXgZPxlOcz3tvA9//SU2oRUdFWvbwt43HoCBWenas7dB/RYlvjxG5H2jnUP6sZq
 VypA==
X-Gm-Message-State: AHQUAubJ7giLZ89kyHE7BKgg0nupVHH4b46IhOBNS3XKA/HCAjDmShsr
 yOSc1CYXaqRClSuZpTo6Qg==
X-Google-Smtp-Source: AHgI3IYf1C1/J6oSXYGKubSh78za/1/BNjv9pUqiqyCwLusyspeyfgF91FCYvandVwiciYb3snmH7g==
X-Received: by 2002:a05:6830:14d6:: with SMTP id
 t22mr16166134otq.255.1550514783143; 
 Mon, 18 Feb 2019 10:33:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id k23sm357759oih.33.2019.02.18.10.33.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 10:33:02 -0800 (PST)
Date: Mon, 18 Feb 2019 12:33:01 -0600
From: Rob Herring <robh@kernel.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 10/11] drm/panel: simple: Add NewEast Optoelectronics
 CO., LTD WJFH116008A panel support
Message-ID: <20190218183301.GA5480@bogus>
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-11-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215050957.20755-11-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_103304_144772_AFACB4CA 
X-CRM114-Status: GOOD (  18.38  )
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

On Thu, Feb 14, 2019 at 09:09:56PM -0800, Vasily Khoruzhick wrote:
> This commit adds support for the NewEast Optoelectronics CO., LTD
> WJFH116008A 11.6" 1920x1080 TFT LCD panel.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../display/panel/neweast,wjfh116008a.txt     |  7 ++++
>  drivers/gpu/drm/panel/panel-simple.c          | 39 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt b/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
> new file mode 100644
> index 000000000000..d76579f9f55e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
> @@ -0,0 +1,7 @@
> +NewEast Optoelectronics CO., LTD WJFH116008A 11.6" 1920x1080 TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "neweast,wjfh116008a"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

We already established that this goes thru a standard eDP connector. We 
should describe that and everything associated with it.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
