Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE63C282D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:12:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153BE214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QDjxDt1n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ganX7ifr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153BE214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kk48x5kn7QyxA4nQK9+sXh0K5NHIre99Dond0qSscQ4=; b=QDjxDt1n++7AnI
	2NlU7eNCmrn4JNkFFcAA5p/W2PSxB1V215lI5RCVzCnky6Y+MwlsqXoYspV2O3CCdRdx8dfjAgz1L
	jlVSPTfLnXzuJiJIBdae9lbk1MziQjJ9aGy/RsApfRB6lgs5XBjl8IuvUXKFHtnAqc3YGOc8nWzIH
	v5yF9MSJlFsZhAoDLOciadLlzKvm9Jf7svL3VRvjbBK9k2HrUURMTLxXypgENVvI7T3s/gZM/qcZi
	I6ZkfUM5RdbTZdY4pSR/yotDFWGOVVvATLH5Ls6eNPm2//oPvPdGj7QjwD4z2lldiwzLsEGwQKT6U
	hmCUmBQTsaPtovI5mZAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goV3j-0000H0-DY; Tue, 29 Jan 2019 15:12:19 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goV3e-0000FW-3R
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:12:15 +0000
Received: by mail-wm1-x341.google.com with SMTP id f188so18116256wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=vNZ5FJ7cxIMAaxbhIhbHCzmHy341mREO1gfpm3+S9gI=;
 b=ganX7ifrtp5tHj6ni1+LPVWP1E17F8xIGdm7jPsOh7pTgepdccnF2KaBhkLZk0bsEO
 KWM3WIriSYx6AbD3+3QDu0fInI0fAARwj/YG67JXNKsQXT1YU4ea1IWUmKu8f1J2Xb60
 j1vkl34Cro1sm5lCT0LI+i0bbX1fSSeaCyH1Txm6kO12fRVWpId6CtUjApyFniqSdR1T
 I6qO9V48oBkyREa+ezNnhmMABmZUFQdAWNxy09MsCn95ndTOubJbsGD3PdTVsFIjMqJI
 z2QAfgWwQW40O2SFwHt9WMHiHdSMZ31fRoftP6LpgX/BUYRShxF895WPuBArRCheanKS
 OLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=vNZ5FJ7cxIMAaxbhIhbHCzmHy341mREO1gfpm3+S9gI=;
 b=qgI1jSZWf/trhWOS56HeNi3vhyuSHRic0X1YnOuDCI3Y4t06keZH5+aLTQn5oGFdaw
 PhBcZQAo1p7aHFQ5xUwwhWNW5u59bF0SMFgrvcdOZDGYX/yDCHO1BqO8p37SvfQft34+
 Kehj0Qy6elFAsRs6xl/h7pMCgojiDjIOuZPEcUdo7HVw4JQPkXCAkDn2BnSoElr7lA53
 cn6my8jvHX7KyEqotV5WehhZSVb96FHwIxEotyDOEdGAHgpxpMWLccfWcOSVM+kXZ17L
 DhLpgJUmyVudhRni393cR1BQei7wy5oX4V1AZnwki7BESUFOA8w7g+8i4Cil48DjLoeA
 jGiQ==
X-Gm-Message-State: AJcUukfL/6f6Fd1fpDSceR//w8Go9ua/mjQetgHb/Pz1BZD/7fmS88sR
 Qq+F6ZxjFfSuZC2OING9Pcb8Eg==
X-Google-Smtp-Source: ALg8bN6L5HiBonH/xydVY8vwKwxq8H7DS1iyrX1T/hefVcJGQR+A0hsHu4l/9SSJFXhLQwTERu+uTw==
X-Received: by 2002:a1c:2944:: with SMTP id p65mr21261486wmp.20.1548774731567; 
 Tue, 29 Jan 2019 07:12:11 -0800 (PST)
Received: from localhost (aputeaux-684-1-12-29.w90-86.abo.wanadoo.fr.
 [90.86.215.29])
 by smtp.googlemail.com with ESMTPSA id x81sm3069370wmg.17.2019.01.29.07.12.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 07:12:10 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] reset: meson: add g12a compatible string
In-Reply-To: <20190128181316.30814-3-jbrunet@baylibre.com>
References: <20190128181316.30814-1-jbrunet@baylibre.com>
 <20190128181316.30814-3-jbrunet@baylibre.com>
Date: Tue, 29 Jan 2019 16:12:10 +0100
Message-ID: <7hwomno5v9.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_071214_154903_3E0F30B1 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add a compatible for the new g12a SoC family.
>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/reset/reset-meson.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 5242e0679df7..a8f6549b3af4 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -134,6 +134,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
>  	 { .compatible = "amlogic,meson8b-reset" },
>  	 { .compatible = "amlogic,meson-gxbb-reset" },
>  	 { .compatible = "amlogic,meson-axg-reset" },
> +	 { .compatible = "amlogic,meson-g12a-reset" },
>  	 { /* sentinel */ },

Looks like this new compatiable isn't used for anything new in the
driver.  Let's not add a new compatible unless it's needed fo rnew
behavior.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
