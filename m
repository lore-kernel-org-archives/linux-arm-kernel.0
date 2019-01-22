Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA3C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:03:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E1720854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EYlHpbOL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hNg71bVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E1720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1pkjpY2IZK4FbRthmtQLi5NWOuT6j9zcVQs4l3O8l2w=; b=EYlHpbOLdWSc1M
	KDwwIoMtzpP+6T3aBp9AEx2TEQdjnPYSq1JoTpdh/1lq6Nu+sUbC+tAWkwkETsa+b1F1aRiIVI8gK
	TF5Eoq+wk1+uATrhhi+dflQkpMN0j6Mx27TvhSHAinmLq5RRAlcz8jL1syf+sRQafAI70w69bN+LU
	/LnBi9ECgbGb87EsDaInIcdgL3YOASi7+m8Kb6CSeHwz1ub5nnTh9U0SpSuVNZrBMvpPf8lgxPfUd
	NehJl9X2F+faQwfJ6J2pShgC/qFbxrdU9q0nJpN1xOhZbzeGG9afW2x3vBWw0kZWkrg3JfqNZsAb1
	aFAUbZ8pjOmb2Hyjl3Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glrxe-0008RI-KG; Tue, 22 Jan 2019 09:03:10 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glrxS-0008BP-4T
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 09:03:05 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190122090253euoutp02a360f75f5c8bdd3a503aacf1353490d7~8IDKfpLr80949709497euoutp023
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 09:02:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190122090253euoutp02a360f75f5c8bdd3a503aacf1353490d7~8IDKfpLr80949709497euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548147773;
 bh=Q/4f3YtlujODsfOS+QnEIqs7vj836/eeMsIngMZkX1U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hNg71bVWjusQDxcmBJwqUrGJU+h5fj+YaoYIys1UuwoIiuYYpVrC7Tiv5rrBlADog
 r5/9Ar4EbP6wbe2dZTdLMEc4RviuxynoGuOK5QZQbILGbeEo41dRv1EAKpUsJGqt4n
 qL5uM6A4t9lqwTfHX06ULsZK2C2GUgvWTWphm0Yc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190122090253eucas1p27c9be6de97a0a1ee4b8ed944678cbaad~8IDJ82nuR2904029040eucas1p2e;
 Tue, 22 Jan 2019 09:02:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 65.ED.04294.C3CD64C5; Tue, 22
 Jan 2019 09:02:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190122090252eucas1p2dee91ee12355eca7f79f29f945f0346d~8IDJOaAOw1350713507eucas1p2T;
 Tue, 22 Jan 2019 09:02:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190122090252eusmtrp1b52380bf1136b25cbb38e913215fedb1~8IDI-U-g92574925749eusmtrp1g;
 Tue, 22 Jan 2019 09:02:52 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-60-5c46dc3c16b2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.E2.04284.B3CD64C5; Tue, 22
 Jan 2019 09:02:52 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190122090251eusmtip19fe2a3964cc9720884d063daa9d556d5~8IDIYsknD2863128631eusmtip1v;
 Tue, 22 Jan 2019 09:02:51 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v5 5/5] clk: samsung: exynos5433: add imem clocks
Date: Tue, 22 Jan 2019 10:02:32 +0100
Message-Id: <20190122090232.29194-6-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190122090232.29194-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87o2d9xiDFY9NbHYOGM9q8X1L89Z
 LeYfOcdq0bfvP6NF/+PXzBbnz29gt9j0+BqrxeVdc9gsZpzfx2Sx9shddoul1y8yWbTuPcJu
 cfhNO6sDr8eaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXx
 5/Zq5oKX/BVL3z1hbmDcwNvFyMkhIWAi8bX5MHsXIxeHkMAKRonVz5qhnC+MEk9O3GWFcD4z
 SnzefZQJpqXxWxcjiC0ksJxRYs3LaAgbqGP22gQQm03AXOLR9jNg9SICbhJ9k2ezgQxiFljP
 LNFxeitYQljAUWLl3nfMIDaLgKrEo/33wWxeAReJebM3s0Msk5eYtroLrJ5TwFVi1qsdbBA1
 ghInZz5hAbGZgWqat85mBlkgIbCPXeLbqm9sEM0uEmfXbIWyhSVeHd8CNVRG4vTkHhYIu1xi
 99Zn7BDNLYwScycvgnrTWuLw8YtA/3MAbdCUWL9LHyLsKPHh3EMWkLCEAJ/EjbeCEDfwSUza
 Np0ZIswr0dEmBFGtKzHv/xlWCFtaouv/OijbQ2L2wd/MExgVZyH5ZhaSb2Yh7F3AyLyKUTy1
 tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMF2d/nf8yw7GXX+SDjEKcDAq8fAmXHCNEWJNLCuu
 zD3EKMHBrCTC63rRLUaINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKY
 LBMHp1QD42QTbY27p36tbOY9lcEuKdbEEXgm1TVw7+ScJS7VZcEXi7wOq/4p9PIKYF7b/2nv
 1MirU07c7zv65KOE5O5Lt43NV4u9m//LUzeuLvDHjrUSy28u6jRZtYzl9rGCY7HZMY//Pa21
 Fg75U2J/PFGi2dZhubejvq6vwb6EiOy02fNjPmZWfKs4oMRSnJFoqMVcVJwIABgGTidTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7o2d9xiDBo9LDbOWM9qcf3Lc1aL
 +UfOsVr07fvPaNH/+DWzxfnzG9gtNj2+xmpxedccNosZ5/cxWaw9cpfdYun1i0wWrXuPsFsc
 ftPO6sDrsWbeGkaPTas62Tw2L6n3OPhuD5NH35ZVjB6fN8kFsEXp2RTll5akKmTkF5fYKkUb
 WhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfy5vZq54CV/xdJ3T5gbGDfwdjFy
 ckgImEg0futi7GLk4hASWMoosfTADjaIhLRE4+nVTBC2sMSfa11sEEWfGCWmfNrMApJgEzCX
 eLT9DFiRiICHxIyJi1lBipgFdjJLLL/dDlYkLOAosXLvO2YQm0VAVeLR/vtgNq+Ai8S82ZvZ
 ITbIS0xb3QU2iFPAVWLWK4grhIBqrnZeZoWoF5Q4OfMJ2ExmoPrmrbOZJzAKzEKSmoUktYCR
 aRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgZG079nPzDsZLG4MPMQpwMCrx8HKcc40RYk0s
 K67MPcQowcGsJMLretEtRog3JbGyKrUoP76oNCe1+BCjKdATE5mlRJPzgVGfVxJvaGpobmFp
 aG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mDU6qB0fbDnckszjMaWk3iz0QGtUvkZPtJ
 dPq06ZZ+PJZpaMxWYLftoXLcst0ee14f2e2sl5v1UHaPbap2aAzDf7/D7fe2GkwQffyXbyb3
 9h9nPS5L6LWaFa/86+F8JLKwuKzIb3bQBxsVw5VlnQlz106bvWv5fo+NE+WC50Wz+grWXpiR
 I7bpsm6PEktxRqKhFnNRcSIA6M0mUsICAAA=
X-CMS-MailID: 20190122090252eucas1p2dee91ee12355eca7f79f29f945f0346d
X-Msg-Generator: CA
X-RootMTR: 20190122090252eucas1p2dee91ee12355eca7f79f29f945f0346d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190122090252eucas1p2dee91ee12355eca7f79f29f945f0346d
References: <20190122090232.29194-1-k.konieczny@partner.samsung.com>
 <CGME20190122090252eucas1p2dee91ee12355eca7f79f29f945f0346d@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_010259_279742_9EC70B22 
X-CRM114-Status: GOOD (  13.39  )
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
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add imem clocks for exynos5433. This will enable to use crypto Slim
Security SubSystem (in short SlimSSS) IP block.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 24c3360db65b..dae1c96de933 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -5467,6 +5467,35 @@ static const struct samsung_cmu_info cam1_cmu_info __initconst = {
 	.clk_name		= "aclk_cam1_400",
 };
 
+/*
+ * Register offset definitions for CMU_IMEM
+ */
+#define ENABLE_ACLK_IMEM_SLIMSSS		0x080c
+#define ENABLE_PCLK_IMEM_SLIMSSS		0x0908
+
+static const unsigned long imem_clk_regs[] __initconst = {
+	ENABLE_ACLK_IMEM_SLIMSSS,
+	ENABLE_PCLK_IMEM_SLIMSSS,
+};
+
+static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
+	/* ENABLE_ACLK_IMEM_SLIMSSS */
+	GATE(CLK_ACLK_SLIMSSS, "aclk_slimsss", "aclk_imem_sssx_266",
+			ENABLE_ACLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+
+	/* ENABLE_PCLK_IMEM_SLIMSSS */
+	GATE(CLK_PCLK_SLIMSSS, "pclk_slimsss", "aclk_imem_200",
+			ENABLE_PCLK_IMEM_SLIMSSS, 0, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info imem_cmu_info __initconst = {
+	.gate_clks		= imem_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(imem_gate_clks),
+	.nr_clk_ids		= IMEM_NR_CLK,
+	.clk_regs		= imem_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(imem_clk_regs),
+	.clk_name		= "aclk_imem_200",
+};
 
 struct exynos5433_cmu_data {
 	struct samsung_clk_reg_dump *clk_save;
@@ -5654,6 +5683,9 @@ static const struct of_device_id exynos5433_cmu_of_match[] = {
 	}, {
 		.compatible = "samsung,exynos5433-cmu-mscl",
 		.data = &mscl_cmu_info,
+	}, {
+		.compatible = "samsung,exynos5433-cmu-imem",
+		.data = &imem_cmu_info,
 	}, {
 	},
 };
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
