Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0851CC31D64
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 05:01:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DCB20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 05:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RW5+YpjR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR8Fzm/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DCB20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mWn+5rREfC5DtACKfY5gyN0fneHF6OEvl+gCXP93o40=; b=RW5+YpjRqbDr/g
	sV0pQ5YR2prPKf1+60E+oFHMWHUb+JBjCbBLdLT0lgT6S1kDtmqGRgAeld+MhISTx05SJnlcZK+S0
	f7h+pDkMvqYfG1qxHsSExnoJ6bvCywjXq3MUnI4Y6+mNuXPmOqgBXT4moEnGp6U/3TUJM4xw1aY+k
	zvS2wVSzI4tAQjXgdQQ5O72EcODWfJOvjKHmpq8dDwzum26waRTw7aN3MkysHQQBIe2Iny4qSxvzD
	DbzyuoDnsASA5TOdoFu36yo/ORQlYpcJGRRLwblFKliUWdRVRTksXMLK7zj8U1CDFNoKwnWmNkeER
	Y52gwuGFNnL36ibhb17Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glRhz-0000dL-Kh; Mon, 21 Jan 2019 05:01:15 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glRhw-0000ct-Fx; Mon, 21 Jan 2019 05:01:13 +0000
Received: by mail-wm1-x341.google.com with SMTP id t200so9503036wmt.0;
 Sun, 20 Jan 2019 21:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7UYGhJqN6/cb76Fp2fJrdBD+f7IPQnMR74yb5+GYfTQ=;
 b=MR8Fzm/5Zb2JAk+65NamWXbjOQsigDhZbhCEkfV7LyM/BNpQrquXiMpQd2UqcBH1ud
 QFVagPShmgvcsCjw+XzFlbxXQIzH92yvhGucTlFFJSqIE8R0+UsHofy6WYQIEtf8p4y6
 YEsOe0ylIpeN7FBkrlcvHVk6oKiGAYt6nZnm1LuY8GNmMWTv2Vvk5nJBuc8nzTovqNWn
 Usp+2SotSKTmy/yEL9jGJWEluSDDd495jCo5f+iv5qld5wfhFu+gc1gsNcEZkRVqCRaS
 RtbBg8eZmLohD9bcYs4XI8wK998Iwf3dep01lTS8HO07gAYPMwzlNAL561S8bZzCMVvX
 wJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7UYGhJqN6/cb76Fp2fJrdBD+f7IPQnMR74yb5+GYfTQ=;
 b=ghPgOvoIITknlZlbP2GLjItRP+VnESPu7siyCNfzxr/M24glHY38cveWs5+jwz7A9X
 xTEL3aryROtHLG7gH6UvNYfnMxYEopgVBvKtCZdbP4+v7Oy+Rc/pZF4hpYarYCLJLn6o
 0a0qmAhZ9OH9kSgMXWlo+k9AGqwScikipQD3q92hKYwv92OjUAalYBc4Tgd3N9XHuUHE
 Ts5rmb0E2qSfNJQzVY0syLQhbp+uw5vbGbE0GzxL8zTVV/7DiAo9crfBFZJERrJAE82R
 zQJHgdCXYL79qHm2eApgH7GZVWyssWOtchf9sMlqW+iK4hBkEMJn+Uf5bQwavsoNSijB
 Z5rg==
X-Gm-Message-State: AJcUukca04gYzrEcGt7pk4oOTXpXWf4vdECnadbs0nVfGhIAdpRbuWb4
 H9BZM8tXGQ2uLiVeGA3eHOXn3WFUCm/9j1oFm+E=
X-Google-Smtp-Source: ALg8bN6x8x7G5/JGq5Zw35TNiFPDJc7HJqB5j/GxH/n+ipVlXyA0LVTXqTO22o52x4rkK8QVHXgu1TY2LLMQLxZ5woE=
X-Received: by 2002:a1c:ba89:: with SMTP id k131mr22936258wmf.85.1548046870869; 
 Sun, 20 Jan 2019 21:01:10 -0800 (PST)
MIME-Version: 1.0
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
 <1547297008-2740-6-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1547297008-2740-6-git-send-email-stefan.wahren@i2se.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Jan 2019 05:00:59 +0000
Message-ID: <CALeDE9Of0tjUZ=gY_MO-ULbmqOY_+q-iis9MSOWJ_EV_Ae31LA@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: bcm2837-rpi-3-b-plus: Clarify label for
 STATUS_LED
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_210112_527347_ED806AEF 
X-CRM114-Status: GOOD (  16.73  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Gottfried Haider <gottfried.haider@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 12:44 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> The RPI 3 B+ provides control to both LEDs (PWR and ACT). So append
> the first letter of the LED color (like in the schematics) in order
> to clarify this.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested on the RPi3B+

> ---
>  arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> index 7d65013..d3ec6cd 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> @@ -42,7 +42,7 @@
>                 #gpio-cells = <2>;
>                 gpio-line-names = "BT_ON",
>                                   "WL_ON",
> -                                 "STATUS_LED",
> +                                 "STATUS_LED_R",
>                                   "LAN_RUN",
>                                   "",
>                                   "CAM_GPIO0",
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
