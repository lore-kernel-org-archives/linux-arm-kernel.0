Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4822C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:12:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AA12084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mk2WJPh+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLEsEPnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AA12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8z8dsBT3XK9P9iD7vtD2JsVa91gZdTPsQ+oXF/SZFtg=; b=Mk2WJPh+rRFhch
	8AMSPUjsU2H1U1b61cE8qmteyWw5hIs26x46Yq/vU5totRYSLLgDF5nZPQWNF/Eb8Dim4auxXpA1P
	sI6RaCPX2gz6xxT7ENTDPH6L3gD+uSpf+tyMXsq/ONGHR9RwihEMBdSrS+ZzsqlFqEg2YgJZsiKJA
	daIgeZ9FiOXtD0fwsQAXXnhxoyrvtbZBpU6KFOSqW3ZcVcfzHm2ZvZkiXDHCjBsntn/j53a9bVcnS
	JMetk5QV4Av/riRzMltylMm34lepD4+fpQreQbS/cffvjvEq1cfRdU9+G+c3wdF/W5uiZvDolwtY7
	y1yv7ETRgTugqtQXo/OA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUV6r-00042J-Jp; Wed, 05 Dec 2018 11:12:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUV6o-00041n-7c
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:12:51 +0000
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D7C812146D
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544008358;
 bh=C0jvGcRv9UsknAfqJvNP6eKG2uaCJg4zqUAFO82b+Bg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qLEsEPnX+hXifi6BDQiOidDW31UpPvnvsS4dFFyTplbFR1dzJotGP5teg0JOpCTlV
 1Y+nFt8dFxbF9ZMaw0MrF2AYKhNx18C86khs5zLzOu0mVGlz1jS9y/EydRJZrwFdmD
 6ev3YmUyQvxcvqlmChsuodLeD3U8A8lW7dGeqk40=
Received: by mail-lj1-f177.google.com with SMTP id n18-v6so17945786lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 03:12:37 -0800 (PST)
X-Gm-Message-State: AA+aEWaWxZTnPnXCNDskqkW2Mi+/MD3E47IEDv0IOVdevMkgCKbtLV5b
 rJ2xXXGVRavLwKaqc5Fbw2yzErEcEzp5hWxofXo=
X-Google-Smtp-Source: AFSGD/VMb9KbVgESvp5zxEfhj/1neNJwfismfRKxsLCGZtkFWzg2gWmmAGY2Xdf6Qv9Ig57K09txvVLS+5EGzmM0DUY=
X-Received: by 2002:a2e:990e:: with SMTP id
 v14-v6mr17184219lji.60.1544008355906; 
 Wed, 05 Dec 2018 03:12:35 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181205110625eucas1p10c7b3137fb77ae51a211c4f040c4eb6f@eucas1p1.samsung.com>
 <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <1544007956-28889-6-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1544007956-28889-6-git-send-email-l.luba@partner.samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 5 Dec 2018 12:12:24 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd8eErBf4a4x2bAQUnCenOsM+omJoVJ3FrakcTT6KWedg@mail.gmail.com>
Message-ID: <CAJKOXPd8eErBf4a4x2bAQUnCenOsM+omJoVJ3FrakcTT6KWedg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm: dts: exynos4: opp-suspend in DMC and leftbus
To: l.luba@partner.samsung.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_031250_303614_9550185D 
X-CRM114-Status: GOOD (  15.30  )
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
Cc: mark.rutland@arm.com, anton@enomsg.org, len.brown@intel.com, pavel@ucw.cz,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
 <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 myungjoo.ham@samsung.com, devicetree@vger.kernel.org, keescook@chromium.org,
 linux-pm@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, tony.luck@intel.com,
 gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com, kgene@kernel.org,
 ccross@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 at 12:06, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Mark the state for devfreq device while entring suspend/resume process.
>
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>

I already applied v2:
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/commit/?h=next/dt

Best regards,
Krzysztof

> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>  arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index b6091c2..4429b72 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -298,6 +298,7 @@
>                         opp-400000000 {
>                                 opp-hz = /bits/ 64 <400000000>;
>                                 opp-microvolt = <1150000>;
> +                               opp-suspend;
>                         };
>                 };
>
> @@ -367,6 +368,7 @@
>                         };
>                         opp-200000000 {
>                                 opp-hz = /bits/ 64 <200000000>;
> +                               opp-suspend;
>                         };
>                 };
>         };
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 51f72f0..908c0c4 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -432,6 +432,7 @@
>                         opp-400000000 {
>                                 opp-hz = /bits/ 64 <400000000>;
>                                 opp-microvolt = <1050000>;
> +                               opp-suspend;
>                         };
>                 };
>
> @@ -520,6 +521,7 @@
>                         opp-200000000 {
>                                 opp-hz = /bits/ 64 <200000000>;
>                                 opp-microvolt = <1000000>;
> +                               opp-suspend;
>                         };
>                 };
>
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
