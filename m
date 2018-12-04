Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7B4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:41:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE7720834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D44MTZwt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb7W6dwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE7720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9hpUDYNssEaIxXeCKjW9dtfFUEcb9Cw5XEUNaqWrFBc=; b=D44MTZwtJAqQJD
	AYSVYf7ND64cNzBsWImtddX6WmT3pNmf3VcftoxUknZzZR5gf3vc3lIAE3uAPnqyWZxA4u/VPuBDO
	HkybLzSrmR3qh/kbbBUWa2nzvhniDVBfElQEueNOml/clx2WqNvHMLYaA9dSPluovgvN/GkiLaD2q
	IgmJHLv2kzsJEq3r7c2EFtADe+NGLQQI/45xazg/sVsXi+S9m84ouYYwNdO5Gje8zZutBH6VEL9sY
	TJonudVrPECVCWpHn8SFOwJipaU+HloL4jD2nwjUJdMXGQGqWk5MOsrAlybrm7xA1HQIJegWqPQKT
	2XdN+gUC/EVVevkwel9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFcx-0000dS-NC; Tue, 04 Dec 2018 18:40:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFcu-0000aa-IO
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:40:58 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E509520672;
 Tue,  4 Dec 2018 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543948846;
 bh=70FCe/g3xQN8TQUOhW/j45IzCZfy8wgmX9zghLqJmvg=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=fb7W6dwaC+lurnNVkMlTjzHA4T3Ew09bB45HwH+1pFtHIHCR13rEpDZPgJnZfaai7
 VBwYlyfUa+LTHFSyQk5EiZ8PUqoSUeFI/MD09ssjtGAj8row1pQv5qXKRZ6qvGR+Ov
 YcboxsQYdJBrG5VyCDrqXvM+LPNZi+7eKa8p1x40=
MIME-Version: 1.0
To: k.konieczny@partner.samsung.com, linux-samsung-soc@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204165248.17572-6-k.konieczny@partner.samsung.com>
References: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
 <CGME20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee@eucas1p2.samsung.com>
 <20181204165248.17572-6-k.konieczny@partner.samsung.com>
Message-ID: <154394884525.88331.3007383362383800806@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 5/5] clk: samsung: exynos5433: add imem clocks
Date: Tue, 04 Dec 2018 10:40:45 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_104056_618422_D2EB0ED7 
X-CRM114-Status: UNSURE (   8.74  )
X-CRM114-Notice: Please train this message.
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
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Kamil Konieczny (2018-12-04 08:52:48)
> +
> +static const unsigned long imem_clk_regs[] __initconst = {
> +       ENABLE_ACLK_IMEM,
> +       ENABLE_ACLK_IMEM_INT_MEM,
> +       ENABLE_ACLK_IMEM_SSS,
> +       ENABLE_ACLK_IMEM_SLIMSSS,
> +       ENABLE_ACLK_IMEM_RTIC,
> +       ENABLE_ACLK_IMEM_SMMU_SSS,
> +       ENABLE_ACLK_IMEM_SMMU_SLIMSSS,
> +       ENABLE_ACLK_IMEM_SMMU_RTIC,
> +       ENABLE_ACLK_IMEM_ARBG_TX,
> +       ENABLE_ACLK_IMEM_SMMU_ARBG_TX,
> +       ENABLE_PCLK_IMEM,
> +       ENABLE_PCLK_IMEM_SSS,
> +       ENABLE_PCLK_IMEM_SLIMSSS,
> +       ENABLE_PCLK_IMEM_RTIC,
> +       ENABLE_PCLK_IMEM_SMMU_SSS,
> +       ENABLE_PCLK_IMEM_SMMU_SLIMSSS,
> +       ENABLE_PCLK_IMEM_SMMU_RTIC,
> +       ENABLE_PCLK_IMEM_SMMU_ARGB_TX,
> +};
> +
> +static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
> +       /* ENABLE_ACLK_IMEM */
> +       GATE(CLK_ACLK_AXI2AHB_IMEMH, "aclk_axi2ahb_imemh", "aclk_imem_200",
> +                       ENABLE_ACLK_IMEM, 24, 0, 0),
> +       GATE(CLK_ACLK_AXIDS_SROMC, "aclk_axids_sromc", "aclk_imem_200",
> +                       ENABLE_ACLK_IMEM, 23, CLK_IGNORE_UNUSED, 0),

Why is there so much use of CLK_IGNORE_UNUSED in this file?

> +       GATE(CLK_ACLK_SROMC, "aclk_sromc", "aclk_imem_200",

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
