Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F4AC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:48:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D897E218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="akaxP4xA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ELw9a9uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D897E218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SqkE3ywLLJS0mCbRTqXw+8Sf35CExsTlfbTVe4t+ZeE=; b=akaxP4xAd54fEZ5ylRboQHIXbG
	QMwkLfeTOKR4rASPr5t2UZo8fKFGXJqEfNO1BmWgFW1DKb0VmO65bvdgdkTv6tu/hRMjrqzUFy1dV
	jQUcMFZfOIB7kMVTGCvtEK3ykQ4i9NVHu2fu+UAvyfOP31PUwlQB1qkOGEQfu0kiudSDOvPbSh/g/
	ELr2fg7Sv55yZcsJADXT1O4HEvfzXpwtOnrIWpkBpYwLH2bZxr4VwxyLUQXLrI3tD/mv1TVELsgbo
	sZGyyIgQSAfRvBGW0xP5rhJIlSdtixKT2RtyHbeg/kO3zC+GWYd7Nuur6T+TE28/nkitIZkyT5a4i
	QCJW3slw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbz8-0004u6-M4; Fri, 01 Feb 2019 16:48:10 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbyO-00046b-Ri
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:47:27 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190201164723euoutp0274687812aa127b62207795375e30dee9~-S1kqykpZ1427814278euoutp02X
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  1 Feb 2019 16:47:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190201164723euoutp0274687812aa127b62207795375e30dee9~-S1kqykpZ1427814278euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549039643;
 bh=eQxUQ6zh1i/xD8vQM8B9I97Hq1f7nTOJyrCVlZmwLd8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ELw9a9uKx1JuWTJA8CDHVIO3lodjlqsZ5F/oqCcbi8ZeDaMD3XiGKAjOD9GsCdqAm
 k+Dac5Vj1WGbJzFjM4d1qaox7lB7cXH/prr+zeBn1+XA2iHUWgPDaAHYmg5qn/I2Ok
 WRz3Jvfq4sea+ujWUuQg7/1fWvw9GCHmBCivOtlk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190201164722eucas1p2418d3a2dd8e78be2b85205b46e873f14~-S1kAlLZz1349813498eucas1p2V;
 Fri,  1 Feb 2019 16:47:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 7E.EE.04806.A18745C5; Fri,  1
 Feb 2019 16:47:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190201164721eucas1p286976bab0cc9e06c2cf74a0eaa20144e~-S1jRkgpT1211412114eucas1p2C;
 Fri,  1 Feb 2019 16:47:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190201164721eusmtrp1dc21472702c487bada8e1727dd46397f~-S1jCndNf3167231672eusmtrp1Y;
 Fri,  1 Feb 2019 16:47:21 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-1e-5c54781ac127
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.30.04128.918745C5; Fri,  1
 Feb 2019 16:47:21 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190201164720eusmtip27babc33c83122a5192ce35d0ebd14abb~-S1iW-b2S0078200782eusmtip2h;
 Fri,  1 Feb 2019 16:47:20 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v4 6/8] DT: arm: exynos: add DMC device for exynos5422
Date: Fri,  1 Feb 2019 17:46:50 +0100
Message-Id: <1549039612-28905-7-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTcRTH++3uPnxMrtP0ZGawHmSQVkbdSKIsahipiFGYUVMv03I+dn1m
 kAXmA18olJpohDK9OFxr+FhpNSURcyaGmg8SJDOb/ZEzSrNy3ln/fc73nO/5nj8OhUmbcC8q
 PjGVVScqEmSEo7j19c/BfV6ZEVH7eSvJPKlswZlR6yecqesx40zpzBeMGRzUkczAXQvJjOd4
 M/qZEZwZNtYQzGJxD2IqB7tEjLZnimQaRodEzMSdRoLJ7ewhmW5LHn6CljfXNiO5ni8g5E/r
 b8tffX0ukpcYeCRf1PuEEZGOgbFsQnw6q/Y/fs0xbrpJiyf/2JY5sVRG5KAVj0LkQAF9CPKM
 WrIQOVJSuhGBRlcgEgorgpbeAlwoFhHMzprRhmW5eJUQGhoEHavvsH8W6zPrWkFRBO0H7XyK
 zeBOZ8Pk6Iv1GYyeFEFnVYPY1nCjz8B4rQW3sZjeBS3Dn9cTJHQwrJR9EAtpPvDeXIDZ2IE+
 B/kzbfYrjCSslIYKfBqWzTwpsBvM9xrs7A39FUX2PRwM5POEwLcgr6/dPnMMunuHcNvNGO0L
 LUZ/QT4Jc1Uz6zLQLjC24GqTsTUsb32ACbIE8u9Jhek9YCh6KxLYAzTN9+3L5fCt2ryuS+la
 BG26wDK0vfp/1iOEeOTJpnEqJcsFJLIZfpxCxaUlKv1iklR6tPZA/b97l9pR169oE6IpJHOW
 6JbDo6S4Ip3LUpkQUJjMXRJ0PSJKKolVZN1k1UlX1WkJLGdCWymxzFOSvWn6spRWKlLZGyyb
 zKo3uiLKwSsHdedOhLiFLNU3jO28uBhOZhp0mYXpFqiIPKg96qzMCODSCssjiZQE3vXs49Wa
 S1rt4VN6gyLdpFwo6dTsVl8YHzli+bgFy5A+fFla/yfU1xgNGJp3cqnIrsrP0pjeeHpq52O6
 5r7Hbg7i63aEOlmCXc9H9l3p8K3pnpBNhTnJxFyc4sBeTM0p/gJLc3pbPAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4PV3JipAYg3+nxCw2zljPanH9y3NW
 i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhsenyN1eLyrjlsFp97jzBazDi/j8li7ZG77BZL
 r19ksrjduILNonXvEXaLw2/aWR0EPNbMW8PosWlVJ5vH5iX1Hgff7WHy6NuyitHj8ya5ALYo
 PZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwHK9ey
 FvyQrbj9dQJbA+NvsS5GTg4JAROJX71/2boYuTiEBJYySvx5fJ4ZIiEmMWnfdnYIW1jiz7Uu
 NhBbSOATo8Tkv35djBwcbAJ6EjtWFYKERQTqJfrfXAIrYRZ4xSTR8F4DxBYWcJO4Ne8NK4jN
 IqAqsf7yS0YQm1fAS+L3hPssEOPlJG6e6wRbyyngLdHxeDsjxCoviVX/DjBPYORbwMiwilEk
 tbQ4Nz232EivODG3uDQvXS85P3cTIzAith37uWUHY9e74EOMAhyMSjy8G34FxQixJpYVV+Ye
 YpTgYFYS4XXKCokR4k1JrKxKLcqPLyrNSS0+xGgKdNREZinR5HxgtOaVxBuaGppbWBqaG5sb
 m1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamCsOnxXQuKrZxLjgvtCjzO/nE+99TaawbL9
 zeFzm4t++JyvlHFPuiBgGi0vr/dsY9aU2BP+KcEVE2a/m7djn++Uvdy3fq/+XFXqvVO78OW3
 u8FfbmWdXGa8+FFH2Sn7HSLut8+ncj89ePEVe/fjZ7Hehvqnru2T8VDRCzopvnydMtfEuyfi
 1nY9U2Ipzkg01GIuKk4EAApodMSeAgAA
X-CMS-MailID: 20190201164721eucas1p286976bab0cc9e06c2cf74a0eaa20144e
X-Msg-Generator: CA
X-RootMTR: 20190201164721eucas1p286976bab0cc9e06c2cf74a0eaa20144e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201164721eucas1p286976bab0cc9e06c2cf74a0eaa20144e
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190201164721eucas1p286976bab0cc9e06c2cf74a0eaa20144e@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_084725_111553_7B4E5630 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 b.zolnierkie@samsung.com, krzk@kernel.org,
 Lukasz Luba <l.luba@partner.samsung.com>, cw00.choi@samsung.com,
 kyungmin.park@samsung.com, kgene@kernel.org, myungjoo.ham@samsung.com,
 s.nawrocki@samsung.com, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add description of Dynamic Memory Controller and PPMU counters.
They are used by exynos5422-dmc driver.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi             | 78 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 ++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff158..574d398 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -235,6 +235,36 @@
 			status = "disabled";
 		};
 
+		dmc: memory-controller@10c20000 {
+			compatible = "samsung,exynos5422-dmc";
+			reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+				<0x10030000 0x1000>, <0x10000000 0x1000>;
+			clocks = <&clock CLK_FOUT_SPLL>,
+				 <&clock CLK_MOUT_SCLK_SPLL>,
+				 <&clock CLK_FF_DOUT_SPLL2>,
+				 <&clock CLK_FOUT_BPLL>,
+				 <&clock CLK_MOUT_BPLL>,
+				 <&clock CLK_SCLK_BPLL>,
+				 <&clock CLK_MOUT_MX_MSPLL_CCORE>,
+				 <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+				 <&clock CLK_MOUT_MCLK_CDREX>,
+				 <&clock CLK_DOUT_CLK2X_PHY0>,
+				 <&clock CLK_CLKM_PHY0>,
+				 <&clock CLK_CLKM_PHY1>;
+			clock-names = "fout_spll",
+				      "mout_sclk_spll",
+				      "ff_dout_spll2",
+				      "fout_bpll",
+				      "mout_bpll",
+				      "sclk_bpll",
+				      "mout_mx_mspll_ccore",
+				      "mout_mx_mspll_ccore_phy",
+				      "mout_mclk_cdrex",
+				      "dout_clk2x_phy0",
+				      "clkm_phy0",
+				      "clkm_phy1";
+		};
+
 		nocp_mem0_0: nocp@10ca1000 {
 			compatible = "samsung,exynos5420-nocp";
 			reg = <0x10CA1000 0x200>;
@@ -271,6 +301,54 @@
 			status = "disabled";
 		};
 
+		ppmu_dmc0_0: ppmu@10d00000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d00000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
+					event-name = "ppmu-event3-dmc0_0";
+				};
+			};
+		};
+
+		ppmu_dmc0_1: ppmu@10d10000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d10000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
+					event-name = "ppmu-event3-dmc0_1";
+				};
+			};
+		};
+
+		ppmu_dmc1_0: ppmu@10d10000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d60000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
+					event-name = "ppmu-event3-dmc1_0";
+				};
+			};
+		};
+
+		ppmu_dmc1_1: ppmu@10d70000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d70000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
+					event-name = "ppmu-event3-dmc1_1";
+				};
+			};
+		};
+
 		gsc_pd: power-domain@10044000 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044000 0x20>;
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index bf09eab..e2b59e9 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -127,6 +127,12 @@
 	cpu-supply = <&buck2_reg>;
 };
 
+&dmc {
+	devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
+			<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
+	status = "okay";
+};
+
 &hsi2c_4 {
 	status = "okay";
 
@@ -535,6 +541,22 @@
 	};
 };
 
+&ppmu_dmc0_0 {
+	status = "okay";
+};
+
+&ppmu_dmc0_1 {
+	status = "okay";
+};
+
+&ppmu_dmc1_0 {
+	status = "okay";
+};
+
+&ppmu_dmc1_1 {
+	status = "okay";
+};
+
 &tmu_cpu0 {
 	vtmu-supply = <&ldo7_reg>;
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
