Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C56EC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:25:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB5A2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bz4/PkfZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dGOTS9Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB5A2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ZXqmuQiqPqzZfEWP3MveiVpF4c3c2ksrIAgDIidq5I=; b=Bz4/PkfZ0vgbFO
	cy0cmML2fh6Fjtvem2SQzcksbqzg6socRgf3Hax1XcKc5cIYwKNl6Ssazs3aHtQE8cIODBXNKrxDU
	hub9nGbH0KrUruL6DvFspO27hV9coNOv6gWTPRp47I9rtzBdfNPkHToBk2FNWttRABDiNMq1oOsjp
	+BPAWMbRPwJ65nTfIhdN6cheap/9ehX7rIjsBSps4D1F5ULqpLOxy0nZP3H82Y7Zg19gvv3PwI21n
	2QVbnhbcYgHoFCLHdVLSuBagToy/AK4vbx2Ibj/tpDD9ZmvIpO6JgyTQ+xG0a74GR07CQnrC4tIg1
	vISt6eCe462GqeWpZbXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCWy-0007ED-Jh; Mon, 28 Jan 2019 19:25:16 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCWn-0006mk-FF
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:25:08 +0000
Received: by mail-ua1-x942.google.com with SMTP id u19so6021645uae.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 11:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SQY6Zal4DC++bZdpHMJ7+qGiQeQDdJgSt9Ldg8BCEd8=;
 b=dGOTS9QnfoLXq3htIaA2MOdWKp89qLma1tYgvj6HIyPsZf4W1jCkx+tQ5ihMRiL5+z
 JqXwHGGPw4ii0fGorBIzgldXhPBvJWppIMTCgV1PAtU6YMCXjhccosonhG/pNky/ONpV
 UwlXnXR4Px8LDRKrJxelCejHJVQj1OotokYg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SQY6Zal4DC++bZdpHMJ7+qGiQeQDdJgSt9Ldg8BCEd8=;
 b=Yp+4l/Ln1/AksT7KOtPQnnpH3qDUM8vDBF3NnDGvJEv7COQTsaVAsC8Pt6BLVB/I0Q
 NY9/ku0PuyOFl1aTO96eGt+sR7fbrZZnqrzg2mdStmluD+uUtcjQYSTl3FImcgJU6bhX
 GlIEUrGACVvycnQq3jE5ib+tt1QhE3xvhYUt6X+Q8tyATylLN1Zbqmn703QY19RdE+Eg
 NPM6/Db9DS9fR+Dl/F4IeNgnRMEDhzup5d7yoEnc3eUnrrbJyG9KNt/hID4HvRrvEzmq
 QAjYtZZu8m6xi5qlU37vRnlhLzA9HLSQez9pwabY7PR86YEeIViAZKy5p6B0iJidsW9v
 gCpg==
X-Gm-Message-State: AHQUAubgI+zRlNGQ39zEIdoaR2pjLLJL8sbTSCNU7spE26d3horTJGrf
 1RfEpp3aetSiu/QGSX8yDdE9Mks26z0=
X-Google-Smtp-Source: AHgI3IbjPa1DZd/MEbeEFlk/O7a82GThDMDyYFHX/PhiqG6aJvX8GxHqeLtsMb+HhvXUqH21FhTklQ==
X-Received: by 2002:ab0:694f:: with SMTP id c15mr3993715uas.43.1548703503463; 
 Mon, 28 Jan 2019 11:25:03 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com.
 [209.85.217.48])
 by smtp.gmail.com with ESMTPSA id p8sm90126474vke.27.2019.01.28.11.25.02
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 11:25:02 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id x64so10454311vsa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 11:25:02 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr10141181vsk.111.1548703502172; 
 Mon, 28 Jan 2019 11:25:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <d0370bc569491d11827a6eb12a75a236c3d60a0e.1548419933.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <d0370bc569491d11827a6eb12a75a236c3d60a0e.1548419933.git.saiprakash.ranjan@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Jan 2019 11:24:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XjVU=stq9U+tBtJpAiQa+6hDKi8+F5LOX4bq68-wQNaA@mail.gmail.com>
Message-ID: <CAD=FV=XjVU=stq9U+tBtJpAiQa+6hDKi8+F5LOX4bq68-wQNaA@mail.gmail.com>
Subject: Re: [PATCHv5 7/7] arm64: dts: qcom: sdm845: Remove the duplicate
 header inclusion
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_112505_936884_47791CF9 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Tingwei Zhang <tingwei@codeaurora.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Andy Gross <andy.gross@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, Jan 28, 2019 at 11:16 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Remove the duplicate inclusion of qcom,gcc-sdm845.h
> mistakenly introduced by commit 6e17f8140521 ("arm64:
> dts: sdm845: add prng-ee node").
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e49f71d00854..eafe8e47471e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -12,7 +12,6 @@
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> -#include <dt-bindings/clock/qcom,gcc-sdm845.h>

You can probably stop sending this one.  It's in Andy's tree now.  See
commit ea0edd7e63f4 ("arm64: dts: qcom: sdm845: Remove the duplicate
header inclusion").

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
