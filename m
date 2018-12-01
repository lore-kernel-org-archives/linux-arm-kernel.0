Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D47BC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC142147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mr1FYvE9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ruqiq1Dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC142147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tu3OMY7/4v4M21l7HTS5jONorncU5Ayf5ZkOeTPAoMY=; b=mr1FYvE9pV0JW8
	0Q+atpQkE4nTq/9XUHvjlFZ+bzEbIBhfqNTv5E3rawdJlSXHMTtz43h7qkeTHIP67gRnVJkMf/2C8
	Ci55Lgt9mXiOzVaO+tdmvrCeweS1Ofsr/LsSOAEHAHlj0URnY5vLd5fTacKNSThzcM4Det49dA1Ue
	OfS6Ysttyx5C0e5YKqaQpTzDW3qPcBtdfUlzM8HsFjA2RS6M/XTF+v970v51bIkUbOLw22WtpLIVl
	nHnQiTmkT7AGy/nj+X8imp7VyRWEMsEZVkx6b0IxNo/DLHovtJRMFhifaiq1tiacGQpIi8d1cCBdE
	f2K8rjTywSsDPVzJ5NTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gStRm-0001TO-K0; Sat, 01 Dec 2018 00:47:50 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gStRg-0001Qk-Oj
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:47:48 +0000
Received: by mail-lj1-x241.google.com with SMTP id c19-v6so6544297lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L9HJj8oQEV2tIq6wjZVCRS3Wb3cxGZvLkl9XqwuIovs=;
 b=Ruqiq1DyBvh9xaj9BiP5z75PTptbcHbQONvqi+pMje/q/DqwwsYLPi2Th6rcv/HcZ4
 UnKF5svkrTajzSW/r7RytDnCa5u2OTWKiuYcEFlrzjE+iAZpvj8gwYbX8gwsh7gkIKQv
 S4wiHnuF2P76oCPhdifJrPnIGnF+NqO8QolOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L9HJj8oQEV2tIq6wjZVCRS3Wb3cxGZvLkl9XqwuIovs=;
 b=Gsl+FIWHc7NTjlqXnU5uhAWLmx3RE/lHBohwgdf19aiUPKIblUff+mLG8r2wkpb0hW
 n6p3KnngP7sWLf9STYtM4gVB4M747wcKTYNdqciHbeNhN6aM2ObaE/tQFrG0vwKVpRG6
 +ZYPMS+9/CBsuoXZ1UNBmwp4RjmwASrKFIhNw06G83KgI+BgizI3smmFpIJEAND1dlfw
 92Z+Vno+06cy/KJfv3Pbrzf+ZO6xZbrhL2Rz+0lzmHtdTtst89bDeEd8JOoaRPOA9vk5
 MwUP8Hh1IsLmj7yOTJpdCDeCDNuoRUMh0sL3v62xw4e43s0n+DgRIMmHDCuiDWWIV6KC
 8Oyg==
X-Gm-Message-State: AA+aEWb5wM5/YGM0vceELRNlb05Cm+BVgrD+VQIf4d4yModO13O7Wjge
 rTgpp8BJSWnXPFdR81u3lz1D0FYh/8w=
X-Google-Smtp-Source: AFSGD/Xk8A9EmsUYme1X0zuZJkSy2yoBwkdKMcpv2PrswsU6wuFL6j5TsU1FQo9H37JTbZYcixw9Gw==
X-Received: by 2002:a2e:5356:: with SMTP id
 t22-v6mr4956841ljd.26.1543625252896; 
 Fri, 30 Nov 2018 16:47:32 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177])
 by smtp.gmail.com with ESMTPSA id 13-v6sm1023470ljj.49.2018.11.30.16.47.32
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 16:47:32 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id z80-v6so6532632ljb.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:47:32 -0800 (PST)
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr5132083lje.110.1543624788281; 
 Fri, 30 Nov 2018 16:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-7-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-7-georgi.djakov@linaro.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 30 Nov 2018 16:39:11 -0800
X-Gmail-Original-Message-ID: <CAE=gft4XEqkL4oON=Q1oji=AoYeEdL5DFjy3h6hN6uFR9oRA4A@mail.gmail.com>
Message-ID: <CAE=gft4XEqkL4oON=Q1oji=AoYeEdL5DFjy3h6hN6uFR9oRA4A@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] arm64: dts: sdm845: Add interconnect provider DT
 nodes
To: georgi.djakov@linaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_164744_930819_4393538E 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>, lorenzo.pieralisi@arm.com,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 khilman@baylibre.com, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 thierry.reding@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
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
> index b72bdb0a31a5..856d33604e9c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1324,6 +1324,11 @@
>                                 compatible = "qcom,sdm845-rpmh-clk";
>                                 #clock-cells = <1>;
>                         };
> +
> +                       qnoc: qnoc {
> +                               compatible = "qcom,sdm845-rsc-hlos";
> +                               #interconnect-cells = <1>;
> +                       };

Should we alphabetize this node above rpmhcc?

>                 };
>
>                 intc: interrupt-controller@17a00000 {

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
