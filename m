Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BB0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 11:51:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8473C21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 11:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pzwuYwXu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZHW/4OC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8473C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7wVsac4oNZCKf0uxUVoMbPY9y5b7MOVQHiHNXgtPThM=; b=pzwuYwXuYzIFPA
	uc9wqz0RRlQhum6jWRpZHAbaKrfDLsgw87700zB6SB7rbw10uGPay/QaRA4Qmlcw2ZtMkRT5Q0JPD
	ey0bZpU761GY9sjPgNguEPPrmXdsbGz0m/ULihf1fVo/0TmfWin0HC3NDYmt+nFqWR97EbSD7+wEE
	x88Xw58vhsnMJDZWdKeNVCpGWDaICbWcMMnXmZby3ONAoLjrRI2EXy9niw8smiaNkxeLQNBnaQd/i
	+8YFewWLTD/BH5E5fbeeqF1Zw1lUhgurF2ULnJmeioL47mUm0baS98fFcQ9WljI4lTJwneGtaQ4La
	EDNYC5rpe7W6HUVSiYZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gblFN-0002bc-E7; Tue, 25 Dec 2018 11:51:41 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gblFJ-0002Zy-6O
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 11:51:38 +0000
Received: by mail-qt1-x843.google.com with SMTP id r14so14985154qtp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YPDHPbo2gf0hTx7S7PT2m4ixMuzj8dX+0mQ8VulgblE=;
 b=VZHW/4OCnVH9IoTjBVsLirWnvsKZfs7/IZ42xZCiwGU7PI2wRBuTBytIxrKPnbf3A1
 aKV3E78iba0FfO5NgG7P6MLM5/KjjqqzHCdg9agqDdsGtF8I7Waa97AvddOOqseZWkjt
 Otf2NTRULt+IVHDbqPIXby6tfNnLoBPlMEB2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YPDHPbo2gf0hTx7S7PT2m4ixMuzj8dX+0mQ8VulgblE=;
 b=hKPnfUzaG/d0oGXkXMLmuwUfASxZCHPdDBja4UAaxKeqfB1iSCtAFdedZ2dhK8TDs4
 kWcbLnj6/uuc3K6gNAc39Y8WvzXkc2rOGsWdnmEHfFk9iIz5RhSdGM8BrKez90ZLH26k
 sh8UjF9yShMAzW+8UdRjdTzHvV9K03IJtTEs5AyZl8wmkf6rK9tyakbUXGrHYYAzQyqA
 LzUASL3WsyT4FmFlE+5tgiIq3EP2xBfHPm4eu+72diO+Ycav85lvgSEbiTCO9BkLdA62
 Otbc/T8N9lztephetg6TLjsQ6FrXQbhpiARhdS+huAg058/aNK9oZGxeryKR4cKOlMXb
 OFQg==
X-Gm-Message-State: AJcUukcCiFQc51hKYivJx/xo5IcMC/NhgnhYprRUEsM9F42DXOfM2b3U
 Ok8E3PrqdEdHAoXRsmjTOV43HsukoO/UInlh5Wykhw==
X-Google-Smtp-Source: ALg8bN6bd6KUW9olgIUGuMhSQ/G0dYVkeMKuX5jFTsLKIafhEcInIDfhB7xRtXbvf6BUdA3qvfj4jk8VqRwg3vl+SDs=
X-Received: by 2002:a0c:d0d7:: with SMTP id b23mr15023403qvh.67.1545738685952; 
 Tue, 25 Dec 2018 03:51:25 -0800 (PST)
MIME-Version: 1.0
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
 <1545397111-24183-3-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1545397111-24183-3-git-send-email-qii.wang@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Tue, 25 Dec 2018 19:51:14 +0800
Message-ID: <CANMq1KB_GaNr3CKO9OQmpKY5UZNpOKORFhQV3n7SrQNhF+FpQA@mail.gmail.com>
Subject: Re: [PATCH 2/6] i2c: mediatek: speeds is replaced by macros
 definitions
To: qii wang <qii.wang@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_035137_241935_454D7ED6 
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 srv_heupstream@mediatek.com, wsa@the-dreams.de,
 Leilk Liu <leilk.liu@mediatek.com>, lkml <linux-kernel@vger.kernel.org>,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 8:59 PM qii wang <qii.wang@mediatek.com> wrote:
>
> Different speeds have been defined by macros,
> so we use macros definitions.
>
> Signed-off-by: qii wang <qii.wang@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index a74ef76..7396449 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -456,7 +456,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>
>         control_reg = readw(i2c->base + OFFSET_CONTROL) &
>                         ~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
> -       if ((i2c->speed_hz > 400000) || (left_num >= 1))
> +       if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >= 1))
>                 control_reg |= I2C_CONTROL_RS;
>
>         if (i2c->op == I2C_MASTER_WRRD)
> @@ -465,7 +465,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>         writew(control_reg, i2c->base + OFFSET_CONTROL);
>
>         /* set start condition */
> -       if (i2c->speed_hz <= 100000)
> +       if (i2c->speed_hz <= I2C_DEFAULT_SPEED)
>                 writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
>         else
>                 writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
> --
> 1.7.9.5
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
