Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1ECC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:08:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC072084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R/AXmtA7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XksMBmHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC072084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MI9aODlhXQ8H5G+bqtfhcrC6ozKbWmzrEAYF887x97U=; b=R/AXmtA7C8cYqd
	4LMRdeDHRfF2o3l6l9oOP0HUfcyIozj29P4rUPIhud1a9hRw7+E18Of0zcxxzbDd0N9pNQQMBMWRj
	u2MRDupchPy0ywchkIwKTd3ORT8DdjfC1QdUjagPfWMEr39jkO5PGCZ/S6D1VSxISgVvkTqmJgcWl
	1W6uYgcxHtfYQxpsxKb58oDB/2StsbogD25j1h2+d2ff3CMJgzLGYGfVyzCXAf2If20knyC9hd020
	g24KYgSNnlEY+3LW/+lK74ef6tdrj4yUlo9QLisEPZQhbjnFiPbwxllrfd8esQznwHaPJHbPoMKzG
	M9cIy3PJc24uzyB36kQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZih-0000t7-B7; Wed, 05 Dec 2018 16:08:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZid-0008HC-Un
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:08:13 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8B6BE2084C;
 Wed,  5 Dec 2018 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544026081;
 bh=/UF/MxvG92TnyDRm5hcG3+fOPtnFWrk4VZx+jrKEyM0=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=XksMBmHlS6sPDomWwXj6+pM+Y681CsdvtgXywZx1Baas4NmgDQH1QtpWiUycPYv00
 q6+Jsvnu/m/P7tBV4HgdH4bXSgkYA+4GcWMmgCRHDx9RZBdkGtq5IQ/B0ucera57OC
 /OzR4YywFNHaCSg/L9OhClrxAvIdeVT9RqUuk1fk=
MIME-Version: 1.0
To: , Sylwester Nawrocki <s.nawrocki@samsung.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <3bb9f4b5-e069-79fe-6ab3-2750c6191e57@samsung.com>
References: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
 <CGME20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee@eucas1p2.samsung.com>
 <20181204165248.17572-6-k.konieczny@partner.samsung.com>
 <154394884525.88331.3007383362383800806@swboyd.mtv.corp.google.com>
 <3bb9f4b5-e069-79fe-6ab3-2750c6191e57@samsung.com>
Message-ID: <154402608077.88331.684195407604647728@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 5/5] clk: samsung: exynos5433: add imem clocks
Date: Wed, 05 Dec 2018 08:08:00 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_080812_044655_CD3718BC 
X-CRM114-Status: GOOD (  16.50  )
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
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 k.konieczny@partner.samsung.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Sylwester Nawrocki (2018-12-05 02:57:32)
> On 12/4/18 19:40, Stephen Boyd wrote:
> > Quoting Kamil Konieczny (2018-12-04 08:52:48)
> >> +
> >> +static const unsigned long imem_clk_regs[] __initconst = {
> >> +       ENABLE_ACLK_IMEM,
> >> +       ENABLE_ACLK_IMEM_INT_MEM,
> >> +       ENABLE_ACLK_IMEM_SSS,
> >> +       ENABLE_ACLK_IMEM_SLIMSSS,
> >> +       ENABLE_ACLK_IMEM_RTIC,
> >> +       ENABLE_ACLK_IMEM_SMMU_SSS,
> >> +       ENABLE_ACLK_IMEM_SMMU_SLIMSSS,
> >> +       ENABLE_ACLK_IMEM_SMMU_RTIC,
> >> +       ENABLE_ACLK_IMEM_ARBG_TX,
> >> +       ENABLE_ACLK_IMEM_SMMU_ARBG_TX,
> >> +       ENABLE_PCLK_IMEM,
> >> +       ENABLE_PCLK_IMEM_SSS,
> >> +       ENABLE_PCLK_IMEM_SLIMSSS,
> >> +       ENABLE_PCLK_IMEM_RTIC,
> >> +       ENABLE_PCLK_IMEM_SMMU_SSS,
> >> +       ENABLE_PCLK_IMEM_SMMU_SLIMSSS,
> >> +       ENABLE_PCLK_IMEM_SMMU_RTIC,
> >> +       ENABLE_PCLK_IMEM_SMMU_ARGB_TX,
> >> +};
> >> +
> >> +static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
> >> +       /* ENABLE_ACLK_IMEM */
> >> +       GATE(CLK_ACLK_AXI2AHB_IMEMH, "aclk_axi2ahb_imemh", "aclk_imem_200",
> >> +                       ENABLE_ACLK_IMEM, 24, 0, 0),
> 
> I don't think that clock will ever need to be disabled/enabled, so I would
> drop this definition. The clock will remain in its default state after reset
> (enabled).
> 
> >> +       GATE(CLK_ACLK_AXIDS_SROMC, "aclk_axids_sromc", "aclk_imem_200",
> >> +                       ENABLE_ACLK_IMEM, 23, CLK_IGNORE_UNUSED, 0),
> > 
> > Why is there so much use of CLK_IGNORE_UNUSED in this file?
> 
> I suppose CLK_IGNORE_UNUSED is needed because there is no drivers that
> would enable required clocks. For some clocks the flag could probably
> indeed just be omitted, e.g. SLIMSSS clocks. 
> 
> I'm inclined to just define clocks that we are confident about and which
> are needed now. i.e. the SSS IP block clocks. So in include/dt-bindings/
> clock/exynos5433.h we would have something like:

Agreed, it doesn't make much sense to add clk support for clks that
you'll never need to modify one way or the other.

>  
> +/* CMU_IMEM */
> +#define CLK_ACLK_SSS                   1
> +#define CLK_PCLK_SSS                   40
> 
> +#define IMEM_NR_CLK                    41
> 
> The other clocks could be added later as needed by someone who has 
> detailed knowledge about respective peripheral blocks.
> 

The slow addition of new clks to the binding header file makes for an
integration problem, so can we try to expose any clks that we know about
now as defines and make them not work if the driver isn't implementing
support for those clks? That way the binding is not changing but the
implementation can decide to support or not support certain clks.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
