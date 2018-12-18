Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AABC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:58:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA17217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c4SdtL3L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q4VY3U0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA17217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LdCNJOpZ4tIkEO5Ex5tbYpEX9IX5CHDb0BzxWcfVJKo=; b=c4SdtL3LzyvMbY
	tVVC7hF7uliTv8o2h7BRc019jIawUwTDng2wzOK/d0/gju/unwEIqEGunh9sdD4Jj8PbTNWwqb6A0
	TPw7YCC0effMZesX7RQXJu3bXvZTHxXb16WX7LcDh8x3GdDggon5RCJBA4/MeN9H8XgB6ikwjYHyE
	HsRmMmV0y96oHk6FSEHf1DRAPUbvKvYCZkcGUS+V4SEvw8evtARP+/lZJ/z0UqyBPXmJBmZjU1tPS
	uTD8DYuUkiyTgOvVddr0qxGWtxWiwrxCDNhPKGJz/c+/ti1OKAvN1HH4748bgv7+iX/oCXTfcCVO4
	+G+6WltauCPDdg1UN8Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZOJQ-0004eW-FB; Tue, 18 Dec 2018 22:58:04 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZOJM-0004bD-TU
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:58:02 +0000
Received: by mail-vs1-xe42.google.com with SMTP id v205so11093306vsc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z8QDZS3SLQDa78wDpVTjE/nkR7G+tyQalFf3NKwIqeg=;
 b=Q4VY3U0djmtasgtiR76z8sMvPrARRHFPLCu6ZGJOWJRCKJ83S0+WJk/1lmre73iMxO
 Kp+oEK6EIVsoZzzKrFgDKDxKBrEk+ggP8s+ytLEdBViWFhKdWO0b+/AfysNXDeanAHYr
 BVByiF7sMu6saoQ5lNr8Mx0wnL5+6ki/LfYfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z8QDZS3SLQDa78wDpVTjE/nkR7G+tyQalFf3NKwIqeg=;
 b=Q6mCQr3g10WalZyBlw/kch6qCMgDR5hziuDqOhDkKNXr5cYW48W/UwtinYuRtRsJpI
 aUG0Bq+ZIdwk4+KMvJ7Kt8SRoHBtKA7Ba/KP37q4pA+AdShywnB7EOgSjwuM6Ntr8qkC
 8M4t70fZ8PuUxvbooAKe3Ddmvkv57kvWbXwZZReBC51BhT+U+6D1L8fLDKhg9AxPz5oV
 8MbbozBAPw0+V7Uj1EAh/uRYYzYU0TqPqI65ItI47hwee5y/mq4/zWWPGSuqG9i+qqgB
 UUiUGwwBeIlJ9lvikNDhaPIfo7XoEeYEvYg9zqCAYJEEUgY0lMFmd7xAL6ifhZ7SzTsi
 DOPw==
X-Gm-Message-State: AA+aEWbiIsjFToU8c2gKydPfjR57t6OOjBquzjViPnIwxC0jfxJ1T81b
 pOM6o68fglFEGPl01h83Bh/hDPGE3FM=
X-Google-Smtp-Source: AFSGD/VLma8YNe0vtUkmq7V3/4FvFn123oubZg9718fMbjcnI0N30aIxWH4Zlt0cTUDz3tkcuFhBGg==
X-Received: by 2002:a67:3d92:: with SMTP id p18mr9240277vsi.51.1545173869703; 
 Tue, 18 Dec 2018 14:57:49 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com.
 [209.85.217.44])
 by smtp.gmail.com with ESMTPSA id k77sm6272748vkd.17.2018.12.18.14.57.48
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 14:57:49 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id h78so11086985vsi.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:57:48 -0800 (PST)
X-Received: by 2002:a67:f943:: with SMTP id u3mr2019253vsq.149.1545173868481; 
 Tue, 18 Dec 2018 14:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-7-jcrouse@codeaurora.org>
In-Reply-To: <20181218183241.12830-7-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Dec 2018 14:57:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VRv82aHfd1dQ_8mjtFFu-u_=JxNGz1qYG+5apTsmBz2Q@mail.gmail.com>
Message-ID: <CAD=FV=VRv82aHfd1dQ_8mjtFFu-u_=JxNGz1qYG+5apTsmBz2Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Jordan Crouse <jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_145800_955833_3C22927C 
X-CRM114-Status: GOOD (  15.53  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Dec 18, 2018 at 10:33 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Add the nodes to describe the Adreno GPU and GMU devices.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
> v7: Updated the GMU compatible string and removed interrupt-names
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 122 +++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 233a5898ebc2..4779014e4a05 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> @@ -1349,6 +1350,127 @@
>                         };
>                 };
>
> +
> +               gpu@5000000 {

Repeating my comments from v6:

nit that you're adding an extra blank line here that you don't need.
Given the quantity of outstanding dts patches though, it's almost
certain that Andy will need to manually resolve conflicts when
applying this patch so presumably he can fix up when he lands.

In any case, feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>


> +                       compatible = "qcom,adreno-630.2", "qcom,adreno";
> +                       #stream-id-cells = <16>;
> +
> +                       reg = <0x5000000 0x40000>, <0x509e000 0x10>;
> +                       reg-names = "kgsl_3d0_reg_memory", "cx_mem";
> +
> +                       /*
> +                        * Look ma, no clocks! The GPU clocks and power are
> +                        * controlled entirely by the GMU
> +                        */
> +
> +                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                       iommus = <&adreno_smmu 0>;
> +
> +                       operating-points-v2 = <&gpu_opp_table>;
> +
> +                       qcom,gmu = <&gmu>;
> +
> +                       gpu_opp_table: opp-table {
> +                               compatible = "operating-points-v2-qcom-level";

I believe that the consensus from the v2 comments at
<https://patchwork.kernel.org/patch/10727121/> are that this should
be:

compatible = "operating-points-v2-qcom-level", "operating-points-v2";

...same with the other one below...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
