Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC2C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:41:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D842084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="elHUvdYx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dYoLjN9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D842084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bKQQaoX7eb6dERvGTlfxrxiwSOeAQqEjhNR3KpgRfjU=; b=elHUvdYxGEZLX1
	DUJIvLargortQgbSv33VWwGKdFpqO/deDtVcanATejAcWbWcX9IWeQkBqDC9RIntZ7DMEwEDIFq/4
	29w/OZoyPB8NlOB/sKtJHR5yoRP2LtIV+3diW8DA3EbSEGl93El78sqiQn2IrZGsy9jCSilirlYKW
	P6JUjZUiKdEkXm++6e78ekYEKoxh6ckkKQx2N9sppufn/IP2spgloBuZdOP+RijoS7lFkGQQNIhui
	vmLXzJ14IQ9GxaUqyPy4pQHx17jRWroN5bk5/LRdlO2lYpn5eBUJnt3wFnTOqHpJX+PQ0S4dopVI0
	4zZSGKBKKr6sPK/5jamA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsuc-0002Al-5m; Wed, 13 Feb 2019 11:41:10 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsuU-00027O-T8
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:41:07 +0000
Received: by mail-wm1-x343.google.com with SMTP id x7so2093411wmj.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=37gNnip2pUO7WpshWw5fCnmuyn0lJdQR0BJGyefQAvc=;
 b=dYoLjN9TrUKPATAOQ2Er/MGKi76DiyZzIxu6I1xrWyopW/fXA6dW6F36PyuTCDGWDC
 q7V0kkGzY13yLOSEHpleaAeH0LVR96z10queTPnCzTnMcGeceiiX0ujvp8WgHewdBAfq
 H5wKGQk8IwmswEueq7gEwfrFW9iIzB0P/cN3QS02sZJ/nMILrGE6qrpXrKdaM4GNl+xA
 Vbu3lO2O3YIJnS/E/JZ/+YbDC27KmrF4SmCcg3eCh300Z4yEwzYt5NEytM9hfZ1jG9vS
 6dc3MQvPuy/QFZ6CfvotvARpETcVBH/3eOra/UF8Q3gnptSeK7WC19rCz5rbGNH7iv3I
 KYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=37gNnip2pUO7WpshWw5fCnmuyn0lJdQR0BJGyefQAvc=;
 b=V0aMKKDJWwaXnYSIkMbeNwL3NakS6QtRpKfY8mWLflfXjfkubCZTUuu+qgwZfaQM7Z
 8eJ1MgpLBOqCau9wyWtf4CGaS9FJp7Uzjva+YVV2ZfxNHKvJ8gJMBkAH7OJK0TWpkQtS
 fBNt/Fy6E6/NaPi0wxmG4kcCG8tVUFY+wdpE50KLtKZRGtSWlXjcKm3pVw5mx9GnPI8y
 JIPSM5Dv3cv4lHtaBOW/fAj2t3sEyFrd57dpXjgfYhWMfi3EwQLyW8E6iJu9f8t2XyIu
 rPZ57sFIoFnUHkAoBDJIWF4S8lVxCXId1+yCTSYDz6S47ebmCDrDdyv6Cm7sxSLJNHr/
 WmrQ==
X-Gm-Message-State: AHQUAuZ3V4YfLUXn+jxtTF+aNG1Zgce1JNmtn7Be7HVllza7aVBugZ/U
 cVTR58E8PUlAH6MO9PWzR0z39f3OHkJBB8jC4se4ow==
X-Google-Smtp-Source: AHgI3Ia3tlOX9B0Wc9itABeYo3VSlGbnUbRzEf1NckYvIhP1mEo5Xcjffa+PtDTuCksXTOIn8kFhY4+DSSlplDk5w2A=
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr11419wme.137.1550058060914; 
 Wed, 13 Feb 2019 03:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20190213095835.17448-1-jbrunet@baylibre.com>
In-Reply-To: <20190213095835.17448-1-jbrunet@baylibre.com>
From: Maxime Jourdan <mjourdan@baylibre.com>
Date: Wed, 13 Feb 2019 12:40:50 +0100
Message-ID: <CAMO6nay=xXnxks==Zj_uPAE6o9_V=DsLkJOkkLRR1duPxg324Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: axg-audio: unexpose controller inputs
To: Jerome Brunet <jbrunet@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_034102_987726_7B9DC6FB 
X-CRM114-Status: GOOD (  14.18  )
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
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 10:59 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Remove the bindings ID of the clock input of the controller. These
> clocks are purely internal to the controller, exposing them was a
> mistake. Actually, these should not even be in the provider and have
> IDs to begin with.
>
> Unexpose these IDs before:
>  * someone starts using them (even if there no valid reason to do so)
>  * the actual clocks are removed. The fact that they exist is just the
>    result of an ugly hack. This will be resolved in CCF when we can
>    reference DT directly in parent table.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg-audio.h              | 20 ++++++++++++++++++++
>  include/dt-bindings/clock/axg-audio-clkc.h | 20 --------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
> index 7191b39c9d65..644f0b0fddf2 100644
> --- a/drivers/clk/meson/axg-audio.h
> +++ b/drivers/clk/meson/axg-audio.h
> @@ -60,6 +60,26 @@
>  #define AUD_CLKID_MST5                 6
>  #define AUD_CLKID_MST6                 7
>  #define AUD_CLKID_MST7                 8
> +#define AUD_CLKID_SLV_SCLK0            9
> +#define AUD_CLKID_SLV_SCLK1            10
> +#define AUD_CLKID_SLV_SCLK2            11
> +#define AUD_CLKID_SLV_SCLK3            12
> +#define AUD_CLKID_SLV_SCLK4            13
> +#define AUD_CLKID_SLV_SCLK5            14
> +#define AUD_CLKID_SLV_SCLK6            15
> +#define AUD_CLKID_SLV_SCLK7            16
> +#define AUD_CLKID_SLV_SCLK8            17
> +#define AUD_CLKID_SLV_SCLK9            18
> +#define AUD_CLKID_SLV_LRCLK0           19
> +#define AUD_CLKID_SLV_LRCLK1           20
> +#define AUD_CLKID_SLV_LRCLK2           21
> +#define AUD_CLKID_SLV_LRCLK3           22
> +#define AUD_CLKID_SLV_LRCLK4           23
> +#define AUD_CLKID_SLV_LRCLK5           24
> +#define AUD_CLKID_SLV_LRCLK6           25
> +#define AUD_CLKID_SLV_LRCLK7           26
> +#define AUD_CLKID_SLV_LRCLK8           27
> +#define AUD_CLKID_SLV_LRCLK9           28
>  #define AUD_CLKID_MST_A_MCLK_SEL       59
>  #define AUD_CLKID_MST_B_MCLK_SEL       60
>  #define AUD_CLKID_MST_C_MCLK_SEL       61
> diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
> index fd9c362099d9..eafb0de8466b 100644
> --- a/include/dt-bindings/clock/axg-audio-clkc.h
> +++ b/include/dt-bindings/clock/axg-audio-clkc.h
> @@ -7,26 +7,6 @@
>  #ifndef __AXG_AUDIO_CLKC_BINDINGS_H
>  #define __AXG_AUDIO_CLKC_BINDINGS_H
>
> -#define AUD_CLKID_SLV_SCLK0            9
> -#define AUD_CLKID_SLV_SCLK1            10
> -#define AUD_CLKID_SLV_SCLK2            11
> -#define AUD_CLKID_SLV_SCLK3            12
> -#define AUD_CLKID_SLV_SCLK4            13
> -#define AUD_CLKID_SLV_SCLK5            14
> -#define AUD_CLKID_SLV_SCLK6            15
> -#define AUD_CLKID_SLV_SCLK7            16
> -#define AUD_CLKID_SLV_SCLK8            17
> -#define AUD_CLKID_SLV_SCLK9            18
> -#define AUD_CLKID_SLV_LRCLK0           19
> -#define AUD_CLKID_SLV_LRCLK1           20
> -#define AUD_CLKID_SLV_LRCLK2           21
> -#define AUD_CLKID_SLV_LRCLK3           22
> -#define AUD_CLKID_SLV_LRCLK4           23
> -#define AUD_CLKID_SLV_LRCLK5           24
> -#define AUD_CLKID_SLV_LRCLK6           25
> -#define AUD_CLKID_SLV_LRCLK7           26
> -#define AUD_CLKID_SLV_LRCLK8           27
> -#define AUD_CLKID_SLV_LRCLK9           28
>  #define AUD_CLKID_DDR_ARB              29
>  #define AUD_CLKID_PDM                  30
>  #define AUD_CLKID_TDMIN_A              31
> --
> 2.20.1
>

Acked-by: Maxime Jourdan <mjourdan@baylibre.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
