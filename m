Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8941C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:23:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D9A2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I6cO9+zG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9neKnfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D9A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gZxAOHF5C4v2WRsRii5MHlgzUxdLrtDMSjg66LMauHM=; b=I6cO9+zGIgeX4c
	7MKQheLP1+eza0YwC/uU0HwL0JEE4pgKbaXczweT/BbwuEuDIQt8j7TzunRje0NacGA1WiGdOLZOE
	IPFwgsjEM0DfXS0joWnOlFOiDT8N3fJwGitsXWs9FqYXZQoFR1+j1CkGP5R4FHyZ4IpqHG74pmUoz
	qNrMb4U3if8AIfC4eUDaJRbzckTuuUl8NZAEPRq+LgARRJKPupUYQy6pHg71wh8trkp4yTcmjQPHS
	O1WMgOHlGGW4J+fK5YzSYUoa/ae0LKNAxlIlFPCN9FvZ4wpOB1fbBn8kpi8saC8LUDDL2/z3bZgZr
	6O7Gmevy91CjAFTu5ahg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqypR-0005c2-Sp; Tue, 05 Feb 2019 11:23:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqypN-0005bK-RZ
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 11:23:47 +0000
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D8D72175B
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  5 Feb 2019 11:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549365823;
 bh=NSlis3uww8wozoZ8nV/g/cBjtqy1PK2yWJaHvYlsPcE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=D9neKnfcHahRljZ62EkKFRL0LaPX6Fi/U6lvg0z9Ml4TiCXis2q4tRyEmXWwS5Jdv
 axd17ev4cnW1yzHFdYR7IbUJT0f9xacT1mT2rFTzEKwLR4NFsaU0M/xQoOnHr10MY8
 y1Ozcd7UEp1q2P85dnPAs+4g8VBdgLz8nGk0xing=
Received: by mail-lf1-f45.google.com with SMTP id z13so2315579lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 03:23:43 -0800 (PST)
X-Gm-Message-State: AHQUAuZVtWmQArwYWMzbEekjrfJs7OYijmDkU4OVldj4/bVQkGzTmusV
 YOS4ku/qu1q1OCR7A3Ed7/h9t+6mtbuAxouSSGY=
X-Google-Smtp-Source: AHgI3IbkzSzvEgI8/lhW9Ro7hmoO9zcfRbZldJ5mKbvoFrSxFN+shDynqBaQaNYneLlmhlKiMDt0mTaA0jz3gOVsxz4=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr2679972lfh.159.1549365821571; 
 Tue, 05 Feb 2019 03:23:41 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7@eucas1p2.samsung.com>
 <20190124154521.13589-1-k.konieczny@partner.samsung.com>
 <20190124154521.13589-2-k.konieczny@partner.samsung.com>
In-Reply-To: <20190124154521.13589-2-k.konieczny@partner.samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 5 Feb 2019 12:23:30 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfm1L2FvcyhbfYEgv-04RQpVnARc0zXt6j_41nCzfE53Q@mail.gmail.com>
Message-ID: <CAJKOXPfm1L2FvcyhbfYEgv-04RQpVnARc0zXt6j_41nCzfE53Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: exynos: add SlimSSS for Exynos5433
To: Kamil Konieczny <k.konieczny@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_032345_912932_9D97B399 
X-CRM114-Status: GOOD (  17.47  )
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
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 16:45, Kamil Konieczny
<k.konieczny@partner.samsung.com> wrote:
>
> Add DT node for SlimSSS (aka Slim SecuritySubSystem) in Exynos5433 SoC.
> The users can use compatibility "samsung,exynos5433-slim-sss".
>
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Before picking this up, bindings have to be accepted and I see
discussion is still ongoing (no Ack from Rob yet). Anyway this depends
on header file with clock ID, so it will have to wait for next cycle.

I will pick it up for v5.2, after v5.1 merge window.

Best regards,
Krzysztof
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index e7cd3b67d818..9e5fcb6c7776 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -559,6 +559,15 @@
>                                 <&cmu_top CLK_DIV_ACLK_IMEM_200>;
>                 };
>
> +               slim_sss: slim-sss@11140000 {
> +                       compatible = "samsung,exynos5433-slim-sss";
> +                       reg = <0x11140000 0x1000>;
> +                       interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "aclk", "pclk";
> +                       clocks = <&cmu_imem CLK_ACLK_SLIMSSS>,
> +                                <&cmu_imem CLK_PCLK_SLIMSSS>;
> +               };
> +
>                 pd_gscl: power-domain@105c4000 {
>                         compatible = "samsung,exynos5433-pd";
>                         reg = <0x105c4000 0x20>;
> --
> 2.20.0
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
