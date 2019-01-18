Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78F5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:17:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A764220652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IU6I72An";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HzAR1g2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A764220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wvJGz5BCOxwaz0Dvtq20NDcl6yuMMxqUE/8zBot/A5Q=; b=IU6I72AnXDIsTv
	2+CNQ8ALZEqJGaoqoFyQcP4lyjhgPhwAkSgdZEUnAqvtY16RuYy2uye6lgbRbHxSonEHuzXV0VrbH
	qZNzVSNJcqL/Ui1a17DaF2qFLcLmDsvDsrvUBIg25D6IfkVW1OWhJ/J5uxlV/QS2bcsYS2lbXhpFd
	N4sKRT+0hvU73Tcxa+YyIEclTsQtgoL092F8psCtdS4FGgQAuJDFEDbtvXni9eGI6jHm6Bmx8357h
	2Bk6BamyXtvi6p1KfVj9Z0orX6ngSkmdGDr/Hhmwc3zH2AD2oRUgbVTuQ+1W4HoejjiE4YbTsorPo
	VmLXjWly0RzcEYJAPXXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkU1V-0004MA-Lh; Fri, 18 Jan 2019 13:17:25 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkU1R-0004Kb-Aa
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 13:17:23 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190118131715euoutp024e3bca313547f975a2592948ac6f7f72~688GzkMHR0991809918euoutp02N
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 13:17:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190118131715euoutp024e3bca313547f975a2592948ac6f7f72~688GzkMHR0991809918euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1547817435;
 bh=0b95Ew6mlVQAmCd8W9+6vQaVfV0wIQUbFZyv/QEtiIY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HzAR1g2qzbD6VeYtja5B5iqREC/Qlyx5xOUPV5WRAf0d2drECThXVB6rqmh7w0muh
 YXn5chkk3jCx6zeTWGIjDQbZKu4UBxXQpxKHUxO+JUGYnaoucueJEpJqQjtIh0ru2j
 sexe3k6O7yy45hKidxVkl4PyTdi/dhQ7Ez4js0fc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190118131714eucas1p1b57b44d860b376c628bac5f1bb5a3f87~688GU7AIU1967419674eucas1p1H;
 Fri, 18 Jan 2019 13:17:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id DA.3F.04806.AD1D14C5; Fri, 18
 Jan 2019 13:17:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c~688FlSvLX1555915559eucas1p1s;
 Fri, 18 Jan 2019 13:17:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190118131713eusmtrp163be05bc6cafe69890d30148bb80ab0f~688FQ_p5g1588415884eusmtrp1P;
 Fri, 18 Jan 2019 13:17:13 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-66-5c41d1dab7b9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id AE.0F.04284.9D1D14C5; Fri, 18
 Jan 2019 13:17:13 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190118131712eusmtip154225cdd136edc77330e03f3e1decfa5~688EsiqaJ2065420654eusmtip1Q;
 Fri, 18 Jan 2019 13:17:12 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v4 5/5] clk: samsung: exynos5433: add imem clocks
Date: Fri, 18 Jan 2019 14:16:39 +0100
Message-Id: <20190118131639.17578-6-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118131639.17578-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djPc7q3LjrGGLw+L22xccZ6VovrX56z
 Wsw/co7Vom/ff0aL/sevmS3On9/AbrHp8TVWi8u75rBZzDi/j8li7ZG77BZLr19ksmjde4Td
 4vCbdlYHXo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStj
 ye7fbAU7+StmPt3J2sDYytvFyMkhIWAicXvHNlYQW0hgBaPE5stiXYwcQPYXRolXBV2MXEDm
 Z0aJJxcvsMPU9z+6zgRRv5xR4uacLIgioPqNH94zgiTYBMwlHm0/A1YkIuAm0Td5NhtIEbPA
 emaJjtNbwRLCAo4Sfw91gzWwCKhKHNrfzAJi8wq4SJzeOoMVYpu8xLTVXWD1nAKuEvPWrWCF
 qBGUODnzCVg9M1BN89bZzCALJAQOsUtsOHWdDaLZReLfrwNQg4QlXh3fAvWCjMTpyT0sEHa5
 xO6tz9ghmlsYJeZOXsQEkbCWOHz8IisoLJgFNCXW79KHCDtKPPmzkxkkLCHAJ3HjrSDEDXwS
 k7ZNhwrzSnS0CUFU60rM+38G6gJpia7/66BsD4k50xexT2BUnIXkm1lIvpmFsHcBI/MqRvHU
 0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwFR1+t/xrzsY9/1JOsQowMGoxMP7YptDjBBrYllx
 Ze4hRgkOZiURXq4VjjFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbB
 ZJk4OKUaGLdci0pddf7Hz5bC++X3Atz7HV01toWIppyYvq8p54H2SzNXKZ+/e69sj3/wk+G6
 WRG/zc1zReV2HVUbDmZtZjFh+aSgtiNixrrNc2vfPtUV3/Nv3ia3TK7L24vu+biJtk762hgc
 Lhg0/z//UwcOt+8K13XnzezbU92lUGTFmMldK/O/jWHrcSWW4oxEQy3mouJEAMLQTwJRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7o3LzrGGByaqmCxccZ6VovrX56z
 Wsw/co7Vom/ff0aL/sevmS3On9/AbrHp8TVWi8u75rBZzDi/j8li7ZG77BZLr19ksmjde4Td
 4vCbdlYHXo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtSs+mKL+0JFUhI7+4xFYp
 2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jye7fbAU7+StmPt3J2sDYytvF
 yMkhIWAi0f/oOlMXIxeHkMBSRolp3X+ZIBLSEo2nV0PZwhJ/rnWxgdhCAp8YJT5+LwCx2QTM
 JR5tPwNWIyLgITFj4mJWkEHMAjuZJZbfbmcBSQgLOEr8PdTNCGKzCKhKHNrfDBbnFXCROL11
 BivEAnmJaau7wAZxCrhKzFu3ghVimYvEhTkdzBD1ghInZz4B62UGqm/eOpt5AqPALCSpWUhS
 CxiZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG1rZjPzfvYLy0MfgQowAHoxIP74ttDjFC
 rIllxZW5hxglOJiVRHi5VjjGCPGmJFZWpRblxxeV5qQWH2I0BXpiIrOUaHI+MOrzSuINTQ3N
 LSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwFs3kN++233aZL4eppLFAY96e
 sL+XvjPcy5fi+StU1mEUyymtsNPn+lllqU7TwpfTT4Se9IzuDlCp3C48s+RIxWlzzr7PW4/6
 SbYc2XNid9/Waedy9JctNrl3SueOx8Sz5tXTOf0KztidO+Ayh2f6vdy5dpxVKtXJ+h4rg5s7
 LvQqRLgsZVBVYinOSDTUYi4qTgQAtiRlAMICAAA=
X-CMS-MailID: 20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c
X-Msg-Generator: CA
X-RootMTR: 20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c
References: <20190118131639.17578-1-k.konieczny@partner.samsung.com>
 <CGME20190118131713eucas1p11f52d9e6a11dbd2b66f289ca3c56d92c@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_051721_986367_630A1C77 
X-CRM114-Status: GOOD (  13.06  )
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
