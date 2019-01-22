Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED5C37124
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:10:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A9221721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c7KZjRfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A9221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FwXZVt1sO+ghcpxR4lBxGaplBWII4LPGwxeQdhm7CtA=; b=c7KZjRfnzgW0T1
	h6/XS/EXH9bAB1K7aSlaZoZqK5QNG4PPQw40+cueVP611GkcwYSX1pQP267sA0rKC3xbKRl+61wt4
	uKcWiK8lztSh+0pv/zQO6C0jG6UlmDNvaLakIz8/F8G8LbD9JD2gpwT2GT8+i8KV1cmebqEg773ap
	c6D3FGJiMUejC3eByTIVjI38dcGog68TE9P2k8voxm04WSm/OnSvt6p5RLeFcHNc+VGO9/USHeMHu
	YzuHBj9kPJC+TB47AI2D9vIibpx4RZQ7ohUV//V/01TPOikwDJavvmkkD86kA9W+7QP1qXOZQ6g24
	rYO6PX0eYmJ7H+viUsmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gljdy-0007Dy-81; Tue, 22 Jan 2019 00:10:18 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gljdv-0007DE-ED
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 00:10:16 +0000
Received: by mail-ot1-f67.google.com with SMTP id s5so22092513oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 16:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EfZC0VAj6Y+cZhl1NaUQWilAbKYR4kf4ei+g9fCWmgA=;
 b=qmB2yQJNaXRwBRy4BttzyqaE2yOGr4eJEun8XYb8zr6I3ZXpVfDXFMxLE36jHO8cd/
 67+MReicIuUE1iGqHvyrQTxexLqYWJ/bAKL/3kpu0q3V6jglcne5g1RAfrTlyDwO5nEl
 HkYR5H8AyeEn6HxgW1hma76Aca6AhEt/DpbCuC+k4CwZWrtf++jshVkH45uGT/rnSnKs
 7MP1nWo8LBxdvnTCvsjXcHrPYhVH8cd3lQJe1PGyzPOiwePCyfzcMbX26jGYiTnqtUi+
 CPBngGZSprb2kUlENId23p6RRwUCPliYc8H/6UYUslL7jW5nVOz1OBHUdxD51Hvz5dZ/
 /zjA==
X-Gm-Message-State: AJcUuke5xy+alpHxq5IvnZTEwxal8EeQg84XaL9n2+96pgKcMEzVCpDH
 T4adkJ+G4Hx+D7mLPM6FYQ==
X-Google-Smtp-Source: ALg8bN7sx3ZCStWsbGDx/KbHLSJDDP8GPLomahRsm4xBDZGGjuAoeqwukFBth+AiGKth58noj3A33A==
X-Received: by 2002:a9d:1296:: with SMTP id g22mr19371916otg.305.1548115813104; 
 Mon, 21 Jan 2019 16:10:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n185sm6912065oih.18.2019.01.21.16.10.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 16:10:12 -0800 (PST)
Date: Mon, 21 Jan 2019 18:10:11 -0600
From: Rob Herring <robh@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH RESEND v1 4/4] dt-bindings: imx8-clock: add a53 and a72
 clock id
Message-ID: <20190122001011.GA15952@bogus>
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
 <1547207400-28307-5-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547207400-28307-5-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_161015_482844_9CB6AA20 
X-CRM114-Status: GOOD (  15.51  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 11:56:09AM +0000, Aisheng Dong wrote:
> Add a53 and a72 clock id, as there's still no users, we update
> IMX_LSIO_MEM_CLK base to start from 6 to allow a53 and a72 clock
> id to be continued with a35 clk.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  include/dt-bindings/clock/imx8-clock.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
> index 4236818..2f1aa2f 100644
> --- a/include/dt-bindings/clock/imx8-clock.h
> +++ b/include/dt-bindings/clock/imx8-clock.h
> @@ -13,10 +13,12 @@
>  
>  /* CPU */
>  #define IMX_A35_CLK					1
> +#define IMX_A53_CLK					2
> +#define IMX_A72_CLK					3

All 3 cores in one chip? If not maybe these should be split or define 
them as cpu cluster x clocks.

>  
>  /* LSIO SS */
> -#define IMX_LSIO_MEM_CLK				2
> -#define IMX_LSIO_BUS_CLK				3
> +#define IMX_LSIO_MEM_CLK				6
> +#define IMX_LSIO_BUS_CLK				7
>  #define IMX_LSIO_PWM0_CLK				10
>  #define IMX_LSIO_PWM1_CLK				11
>  #define IMX_LSIO_PWM2_CLK				12
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
