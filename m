Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97203C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688D4206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vCPiK0F6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FvdIPB0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688D4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CP6wi179q7WJbSWf7RqSP7b05meRNO96qmkWOxab1es=; b=vCPiK0F6rJuzU8
	zNZGC4MkE7RbkEhADmX29lYtN+EKnBPhuJwIyCIuXFlW1ybyoE7G/bB+H0cx4BGAMxChy2+C/MPaI
	mCcM7g+2pB7krvgkYhF+NOcIre6QaVQDsGDaUAO85okmezEQt3nfL4/tYTamvkb2qb2Y2nsXotDGx
	ZEszqzGHfbs5SS+GBRvMaaCVmlZtNAHr+YrH0K75hZACAkkb+CN4ZZr8yJ27fGYpsYwBhZ/CDhHTn
	WsBuLMi9ORocmkyCH1p9j0LLTevXdbadvQkZWVMg642AVZjo6BEkA7lXYYg5kKR0ia7Az5VwkUIKO
	7yqNY1MGwM3ixShxP80g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghNEy-00046Q-BC; Wed, 09 Jan 2019 23:26:28 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghNEu-00045q-Bi
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 23:26:26 +0000
Received: by mail-ua1-x943.google.com with SMTP id p9so3005628uaa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 15:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nEobjsRjQW1Qhb95tY/P1G513nyuu7ZvoRPJF9hVBOk=;
 b=FvdIPB0CTV3eVi4wj7UdAvdLzn0tbdt+GI8h2s0RG0JRxvf9dqrrlvjvIp4xUbcqki
 p8684iGmy2Rekvw0VM/06/Q/CLjZB8DsBCBjrKoS2ddnN4l8GR/iDIWK+r5DsG5s5ASy
 aACN8iPzA7SYFj+faMO1FkyXxSL6fVgT5HwG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nEobjsRjQW1Qhb95tY/P1G513nyuu7ZvoRPJF9hVBOk=;
 b=lrVHjj8VBV5Dzf3OnpwJFNULSYSRs9fn6CR89rBj+0g8RK3Mb8SEqYGOQbeRh7nRFR
 Sx2fctdz61wFtJuwBrA2J+WxDxZVbpBwY+4Olb5eItNuw1Sef47BGyx/9ylcz/S1GBHJ
 PTEA04pCqTN95DE4TMbqDgoBhFFaYKUCXzhG9Y4ujqaGhEJ3hZ3szN7GJPFBjH10ZOER
 T7yVDtUNsQmzUKnK8XZu1dyuf6qYFmlsIa7/nD5GgtXFSe0Y0i8cFcBS4FL/zPgY9Zs7
 f5neWDMredsnTd84l6vXNSig2vw25SPNQ3Qtro8m2+Dms+5glC40RxnC5mWmlMifvwCQ
 UfCg==
X-Gm-Message-State: AJcUukcKCMysb2crtr4SvBmd0CAtbfgLGDOVODUxm1lq6VM8Oqu3roYT
 k8LqXWfsiMC0wVA+/bew1Jylrxc7xDc=
X-Google-Smtp-Source: ALg8bN4tAg2cVDiDj4R3uSA4ZuuHI9IDFRIZW0t3S+CutbEcSM/fMm5i83ouK+Ssv+fsuJHIOkXX6g==
X-Received: by 2002:ab0:3356:: with SMTP id h22mr3109274uap.69.1547076382580; 
 Wed, 09 Jan 2019 15:26:22 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com.
 [209.85.217.54])
 by smtp.gmail.com with ESMTPSA id e67sm36224760vsd.32.2019.01.09.15.26.22
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 15:26:22 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id p74so5912234vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 15:26:22 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr3363306vsj.144.1547075892583; 
 Wed, 09 Jan 2019 15:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
 <20181208170216.32555-7-georgi.djakov@linaro.org>
In-Reply-To: <20181208170216.32555-7-georgi.djakov@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 9 Jan 2019 15:18:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xg5Sz029_UjuDg-ms05Ez+riv8qr0FLWkvg6axPYbZ_g@mail.gmail.com>
Message-ID: <CAD=FV=Xg5Sz029_UjuDg-ms05Ez+riv8qr0FLWkvg6axPYbZ_g@mail.gmail.com>
Subject: Re: [PATCH v12 6/7] arm64: dts: sdm845: Add interconnect provider DT
 nodes
To: Georgi Djakov <georgi.djakov@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_152624_402641_257F7B94 
X-CRM114-Status: GOOD (  17.74  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, sanjayc@nvidia.com,
 maxime.ripard@bootlin.com, Michael Turquette <mturquette@baylibre.com>,
 daidavid1@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 Kevin Hilman <khilman@baylibre.com>, Evan Green <evgreen@chromium.org>,
 ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 linux-tegra@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add RSC (Resource State Coordinator) provider
> dictating network-on-chip interconnect bus performance
> found on SDM845-based platforms.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..b3cd256a154e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1324,6 +1324,11 @@
>                                 compatible = "qcom,sdm845-rpmh-clk";
>                                 #clock-cells = <1>;
>                         };
> +
> +                       rsc_hlos: interconnect {
> +                               compatible = "qcom,sdm845-rsc-hlos";
> +                               #interconnect-cells = <1>;
> +                       };

It would have been convenient if this patch had also added an include above:

#include <dt-bindings/interconnect/qcom,sdm845.h>

...while the include isn't technically needed by this patch, all the
patches that want to actually _use_ the interconnect will need to add
the #include and then you get to some fun fights about who has to add
the include in which patch.  For instance these two patches won't
compile:

* https://lkml.kernel.org/r/1545373748-1416-1-git-send-email-jshekhar@codeaurora.org
* https://lkml.kernel.org/r/20181220173026.3857-4-jcrouse@codeaurora.org

...because neither of them happened to add the include.  Maybe they
were both assuming someone else would do it?


If nobody else wants to, I'm happy to post a patch to add that include
myself and it can be applied atop this one.  ...or if this patch needs
to spin for some other reason maybe you could add it into this patch
directly?

-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
