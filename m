Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2483FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:57:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E506E206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rb0TcE2I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d7e9Ny3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E506E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ww2FliRkV/Nn/1ehkzpMiUmxqFyA0COIJ33e8kBhu7g=; b=rb0TcE2I86gn9a
	PPHWyMhc/6FyEvqpew8eejOc/ip5LiXFHoFZKUJhKHmzqTW4w69hY5hA0UNmp8Z758ZLcXdt9F94R
	biIyajgMGbaMdQ0l0T2zPZ/b8OyZTbkSsht+uGbQdWNdm/oJnSlqPI0rom8bay4wgLypitjwwqEC3
	7XxlqfJTEtb1b//VT4SZ5Oyay0Hqc6JVxpaWwmMamVUMMxrrogWjmy2QcPpMIbHhAGI74IUsMuD/z
	30c/sZhcw9kAVKrudHVtTmW7RJGgDzn3tTfO5JL9Mn12ecmWRPUo4iRbpvTTtm2Rr6AQUHIf24wzj
	vKgP9inPwh/pYLkKGLpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghMmk-00038i-VI; Wed, 09 Jan 2019 22:57:18 +0000
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghMmg-00038F-VM
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 22:57:17 +0000
Received: by mail-vk1-xa43.google.com with SMTP id 197so2065264vkf.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 14:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vsdxCcv8/JRksb9dNzq/93JGI+gwRbu29X95bcXC4uc=;
 b=d7e9Ny3U0XW/TAHbTgfSveFPDeGV/DsF6KuOKQ//6bO/ZNw4xyopfnAhAOq3UJdzl5
 uPYAcVIMnKkd6Ol01MD0GrJhTr8VIhWdty506jIGRZw1Y41jrwGITcDOFu9FruGmJbvl
 GQyW+lrPlZ7TR+S2wliwcksi8Fc8tqaUJ8ZU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vsdxCcv8/JRksb9dNzq/93JGI+gwRbu29X95bcXC4uc=;
 b=BeKi1IsvBaFX3B2PXaRjqmFEzbbCxaiuFh6EtUnblx75obyKt9KHLEEUxtQoIfdkR1
 s/AsoO9oGqvTtu4UCOqzVd6EOfw4R/iagT763QKZMpVRriWV2nhkkhnRWf8wONMl0cet
 lKLHlPuFtOIPMJtlNQFXFBnT9T459mX9ljSyxBeLsScYBplLyMoBK3SzCUTV0JAyf/Us
 diNelc3zNOr35M1InN9kRW6AKFdr6Wj+QO/Ap6h5T1RYLisP60S4b2ldG1R4ADq6UWs3
 5EsinGfRE0EjrnRVGvZ4rLs5gigfkMvm2l3AYdKPT5VFsNE8WSS0tkFnWuPnwL9UtbfN
 i9Qw==
X-Gm-Message-State: AJcUukfXe8QTgXxzaVA0QWELNwgLgCJaQZb/tNe8h4VRZgIlQ8BgOxuZ
 OzyGAs0jODrd0jwdGJDZWYJBGY3yWX8=
X-Google-Smtp-Source: ALg8bN5ehjaMUlsEQy33+EJWHOoVAodf/cvx8sfY80j9FiDy/+s0beSY47FXRYdn6tglXuC2f4tIJg==
X-Received: by 2002:a1f:6306:: with SMTP id x6mr2987934vkb.26.1547074633354;
 Wed, 09 Jan 2019 14:57:13 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com.
 [209.85.221.170])
 by smtp.gmail.com with ESMTPSA id n15sm28470686uao.18.2019.01.09.14.57.11
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 14:57:11 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id y14so2054910vky.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 14:57:11 -0800 (PST)
X-Received: by 2002:a1f:e807:: with SMTP id f7mr2951324vkh.16.1547074630978;
 Wed, 09 Jan 2019 14:57:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <5f400b3a15cab5dd071e4a129d38cb21e7123b78.1547054308.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <5f400b3a15cab5dd071e4a129d38cb21e7123b78.1547054308.git.saiprakash.ranjan@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 9 Jan 2019 14:57:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UgFwVdsTuaQhVA9q18Ns8n278A4mx=TrvuOW3mmZm84A@mail.gmail.com>
Message-ID: <CAD=FV=UgFwVdsTuaQhVA9q18Ns8n278A4mx=TrvuOW3mmZm84A@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm845: Remove the duplicate header
 inclusion
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>, 
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_145715_788945_EB048FD5 
X-CRM114-Status: GOOD (  13.57  )
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
 Rajendra Nayak <rnayak@codeaurora.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, David Brown <david.brown@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Jan 9, 2019 at 9:48 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Remove the duplicate inclusion of qcom,gcc-sdm845.h
> mistakenly introduced by commit 6e17f8140521 ("arm64:
> dts: sdm845: add prng-ee node").
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 03683179b8f7..8dced99f875e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -12,7 +12,6 @@
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> -#include <dt-bindings/clock/qcom,gcc-sdm845.h>

This was on my TODO list, but you beat me to it.  This could land any
time and is completely separate from the other patches in this series.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
