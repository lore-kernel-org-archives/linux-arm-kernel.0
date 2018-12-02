Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF233C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:10:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CBA20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dir5eZhZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=boundarydevices-com.20150623.gappssmtp.com header.i=@boundarydevices-com.20150623.gappssmtp.com header.b="ZEtCj6o7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CBA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=boundarydevices.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nT0/f5MywtvUpLuA0fxeOrBE8G1V6jNoXgzdqJYI2lg=; b=Dir5eZhZj79Cju
	TnIVOhgSrC61Hqz/JQWsJ5Q/5QXAj/6SzpiPI6MtD3Zur72mY87MFbOs5bQaRJ/DdF/vF2QZgdCkQ
	olVP+KHIUC8HSmC19FMQol/IDRJoB4jQJtVZ3o9BEjRvuMaHGoo0yIy9F11haCBv0VzfAFriX6D1/
	FPyCUkQ5jjxKnaBl3VDJs/4ZXJP/5ekpbe0hgat4fCFO0sT1RrhA4t/zuGrz6SB78qj79W1e2FeJO
	HZ09yuwK0RgLko3T1Bpwm5yEcni1xGGYiJxApV1CDVvvo1Xg1XlHu9PEcZKd1ED23nXeYjoXhXlVO
	K58o3La2HrgQMPTR5QKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTX82-0007km-9J; Sun, 02 Dec 2018 19:10:06 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTX7y-00079z-0k
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 19:10:04 +0000
Received: by mail-qk1-x744.google.com with SMTP id o125so6123770qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 11:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boundarydevices-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IVqTnj1Upvuezre69d1s5iZL5AzSsSRMuLnf5lm103w=;
 b=ZEtCj6o7FNKXmGtJkiQyi57fr3UQs/eEk1Q9AIV5jjWpmXnV6OFbH0upcyc/IsCR3t
 1dj29XHEclwnpJNot3cmLyao1RYfowBugNLtI0OsfoUAhOgFGqEeF0GjM1VEZ5I/5S6+
 ulDa/A3LdIizuymTj6bXG3yrwxSRzdaRJGX3voZH6EGaFIrfNvM7Vut0EGdtDTDPHrx/
 2mxx0J7ZbgkAKHKKv2bANyQlDXA6m39mLeJ4fGLsj1/PbCRNrOEME8/XNipRb2sz55Ih
 SWTNj3RMWEqH3fBBb+CsVwGLHhn8OWoEG37E168FlAYcdL24lLFfInWy0TjgAEUHomfG
 W3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IVqTnj1Upvuezre69d1s5iZL5AzSsSRMuLnf5lm103w=;
 b=Azs/xZRSh6PBqpi4fnXdGwFv2wW4ziGKSdFxq72FYYiOhW67YoDxX7YuDtC0sNCpei
 9pc2z5YShqCZP5ysNjjZFqgP1tsKIvsN9lCuBZtQEMMGKdllTsoCjLmZ+RNxaus0353E
 M9kNjtGsRGzWqb5W1eYrnDpRi5ukGYGT5e6uk5E38k1KUpdgru9mwWPDcpx7s9syTr0S
 0u80CvFrSOyFjL1H91xk6UVPaow4WawHaPrBSj2fkRo+1KgOk5P8W97A+tC47+i4jzbo
 umpqMUZ4ziHJ+oOlrn7lqbl4bUiJ91gvwEmbZRvXs6mfe+MbOagJSesral+pYTIlMqZL
 +iVg==
X-Gm-Message-State: AA+aEWa1fah0y0V6qqGdUtriUEDUeLPsTyjd72KXo9BA0k3GMQaSRZs5
 SbiMLyHMgoYd1IXdqFYqdb6tnc8Y30AESGCPP1AUtg==
X-Google-Smtp-Source: AFSGD/W0ZtFIIYCVP7/zCe+t4pewWkyh5wogieO8AQEspgV0Pjj0zHISLf5yn6sLs6VqoYdDXpwuIlfbhwWUCdtMwwM=
X-Received: by 2002:a37:3388:: with SMTP id z130mr11777622qkz.51.1543777790391; 
 Sun, 02 Dec 2018 11:09:50 -0800 (PST)
MIME-Version: 1.0
References: <1543542470-4813-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1543542470-4813-1-git-send-email-festevam@gmail.com>
From: Gary Bisson <gary.bisson@boundarydevices.com>
Date: Sun, 2 Dec 2018 20:09:39 +0100
Message-ID: <CAAMH-ysdpxBpGLpqNo9vhoMtkvtJsu440dRw2HvGfvwYW=36Rg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-nitrogen7: Fix the description of the
 Wifi clock
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_111002_600416_86A17979 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, Nov 30, 2018 at 2:48 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> According to bindings/regulator/fixed-regulator.txt the 'clocks' and
> 'clock-names' properties are not valid ones.
>
> In order to turn on the Wifi clock the correct location for describing
> the CLKO2 clock is via a mmc-pwrseq handle, so do it accordingly.
>
> Fixes: 56354959cfec ("ARM: dts: imx: add Boundary Devices Nitrogen7 board")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  arch/arm/boot/dts/imx7d-nitrogen7.dts | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
> index 4fb7e84..9ba9084 100644
> --- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
> +++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
> @@ -87,13 +87,17 @@
>                 compatible = "regulator-fixed";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
> -               clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
> -               clock-names = "slow";
>                 regulator-name = "reg_wlan";
>                 startup-delay-us = <70000>;
>                 gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
>                 enable-active-high;
>         };

Actually the whole regulator should be changed into a pwrseq as it is
really a WL_EN signal.

> +
> +       usdhc2_pwrseq: usdhc2_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
> +               clock-names = "slow";

Shouldn't the name be "ext_clock"?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/core/pwrseq_simple.c#n121

Regards,
Gary

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
