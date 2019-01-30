Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B198C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:47:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A03120882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CsLUDvV7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewpcWeJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A03120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Co/aMdHLON92IAY0TNdafzsYXVfMc2146EPIzVVrHzM=; b=CsLUDvV7kZXh+G
	d3yxTJidpEoylymKxb7e0jfrq1QYqrC9kgGdNBj0vPKBrZ2lAV7VL8F5qZWcGlfLaVrrDLDO9gyk+
	LdAv3j4cp2N2eRu5lxCo22DSrHGdQ33OL0CWy+9evpCjBsN5mBKHmSDjXYbBn0dZ8luR8QBvb3HA/
	FGxF4kqS1WwReL2USddrArqATQsUyVV+FTkjJZ4d7zhhx27BmRJ5HrQ+XIi8sH1jXLFW9/hhDm6w4
	dzCnnnZzDnbZC4dorRvZbUcqrtIsazB8woDVqmy7bstQ8i7BWhq9tULaJLLtEBBit4/+8Zd9v99w5
	Xlpeh3eAVT7Eo9tFQiGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomSQ-00013w-AQ; Wed, 30 Jan 2019 09:46:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomSM-00013Y-KZ
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:46:56 +0000
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9BD0C218AE
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 09:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548841614;
 bh=eq6mkz7tmSz4JqlH9cPSbzOyve7f/T0O6pQ9peiyEIc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ewpcWeJntLaw60JgMv5ifNswo9PvyC6Vs6v36gysimDKyC6EnBeAfnDSh0tOasBlZ
 2R8Kq1YHXLjjSTMzQl/17QkgIHdeZB+06QNWxcT2UkD7a95FOX0qG/y7puVJ459pkq
 PXjhhuli+NzgGJjfesVxn2XACdcHG5CkDWrxd3jM=
Received: by mail-lf1-f48.google.com with SMTP id c16so16882065lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:46:53 -0800 (PST)
X-Gm-Message-State: AJcUukfavnNgIpZYsNeyX+Ovg2fjZMYHue8e85HaUwrVsZHz8ZynAo8Z
 r0xWhZGU2n9wQESvUIDUsWKjb2EqsQ+QRw2fh1U=
X-Google-Smtp-Source: ALg8bN61aj/FiXXDgFycATgLJ2gdYQ6qz8VxuYXguWjaGkfgynYNnDZoXdCzq6sv17QfVxUYvVWlpioJGlSzoUuYSew=
X-Received: by 2002:ac2:4194:: with SMTP id z20mr22462742lfh.74.1548841611662; 
 Wed, 30 Jan 2019 01:46:51 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0@eucas1p2.samsung.com>
 <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
 <1548784514-26649-7-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1548784514-26649-7-git-send-email-l.luba@partner.samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 30 Jan 2019 10:46:40 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcfZsZPYStrV-QOd2YJsoaJdbtdz2RX-AJrC6A6B8vJqA@mail.gmail.com>
Message-ID: <CAJKOXPcfZsZPYStrV-QOd2YJsoaJdbtdz2RX-AJrC6A6B8vJqA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] DT: arm: exynos: add DMC device for exynos5422
To: Lukasz Luba <l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_014654_705238_6A1A3E93 
X-CRM114-Status: GOOD (  16.44  )
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
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
 <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com,
 kgene@kernel.org, myungjoo.ham@samsung.com, s.nawrocki@samsung.com,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 29 Jan 2019 at 18:55, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5422-dmc driver.
>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: devicetree@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-samsung-soc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 69 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 +++++++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff158..4d76335 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -235,6 +235,27 @@
>                         status = "disabled";
>                 };
>
> +               dmc: memory-controller@10c20000 {
> +                       compatible = "samsung,exynos5422-dmc";
> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                               <0x10030000 0x1000>, <0x10000000 0x1000>;
> +                       clocks = <&clock CLK_FOUT_SPLL>,
> +                               <&clock CLK_MOUT_SCLK_SPLL>,
> +                               <&clock CLK_FF_DOUT_SPLL2>,
> +                               <&clock CLK_FOUT_BPLL>, <&clock CLK_MOUT_BPLL>,
> +                               <&clock CLK_SCLK_BPLL>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                               <&clock CLK_MOUT_MCLK_CDREX>,
> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
> +                               <&clock CLK_CLKM_PHY0>, <&clock CLK_CLKM_PHY1>;
> +                       clock-names = "fout_spll", "mout_sclk_spll",
> +                               "ff_dout_spll2", "fout_bpll", "mout_bpll",
> +                               "sclk_bpll", "mout_mx_mspll_ccore",
> +                               "mout_mx_mspll_ccore_phy", "mout_mclk_cdrex",
> +                               "dout_clk2x_phy0", "clkm_phy0", "clkm_phy1";

We misunderstood each other. I did not ask for compaction into one
continued line but for proper indentation. Having one entry per one
line was fine because you have really a lot of entries and it was
making things easier to check.
It should look like:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos54xx.dtsi?h=v4.20#n78

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
