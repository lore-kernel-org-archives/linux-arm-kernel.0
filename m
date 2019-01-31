Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB88C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:55:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4542087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LtoiUhkD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IDBIwwJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4542087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=t+VPk3mzG3llS/FHB2KXpJJNSoGA0kinGRgm0wh0wu8=; b=LtoiUhkDaz7Hw6aoiYITzVvdxF
	62JCep7e0nMWJHRWjNBNnxdZeAQK7QOmumehhBVOxE4gEQ74SNJlSLPz5Fo8VHm0yiLu4v3mOu8k0
	zl5GKZkNCNdnz0LcMmlSMhnB0fxXFavJlUiBiPGPf9nm592qnW6s+nTOircG/SCzvMV/eHAagl+Nh
	sLh83cTiHTYK9GAolE43BuU5Q1/76081ThUXQNdT070yHMuB4smhq9hDhmq10BWOq81rFJry36Ujp
	DYfTt1m9qWnZZlqn0e4NUH+DJfTU4xu3cTOv0/0ZxydR+RZ8NTvaNWNu76z7juO32LrZzmBB38Ahm
	U+pX6U0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp88Q-0000B1-KZ; Thu, 31 Jan 2019 08:55:46 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp832-00051H-4H
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:50:16 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190131085010euoutp011621ec3364eee233dbe31f73980b26f4~_4roJrAzZ2230222302euoutp01v
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 08:50:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190131085010euoutp011621ec3364eee233dbe31f73980b26f4~_4roJrAzZ2230222302euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548924610;
 bh=4mLNlO8kn7enl8xaIirmpn61OEmGZImpqy0vkgZZ1Co=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IDBIwwJaU/10K3CxxdT85q4PsAOcL/wGXQEST1EZOu2TuvbliipTu3hedDCj86S5R
 armIOsa4xG1zu7ImN4yt8reTRNC28AGbtSZB3GisFAmN8lVMXryP6OdsXAHoVd3Rai
 Wn9jg1nA2U948nk9Z+elwkS6HkDQ2MD8yTxC3sVQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190131085010eucas1p1971da28de3106ed7e6d860da8798f9e7~_4rnre1xU2722227222eucas1p1l;
 Thu, 31 Jan 2019 08:50:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id B3.2C.04294.1C6B25C5; Thu, 31
 Jan 2019 08:50:09 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190131085009eucas1p14c96bc345bc4c414e6c4d7506f14e69c~_4rmxdRDb1812018120eucas1p1F;
 Thu, 31 Jan 2019 08:50:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190131085008eusmtrp24140cd3615e2e8ec95200ac70c00c9d9~_4rmiU__P2342023420eusmtrp2w;
 Thu, 31 Jan 2019 08:50:08 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-a0-5c52b6c1f32a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 48.7B.04128.0C6B25C5; Thu, 31
 Jan 2019 08:50:08 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190131085008eusmtip16904f54f397eb3d1111dec30c8863863~_4rl1r-db1381713817eusmtip1T;
 Thu, 31 Jan 2019 08:50:07 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 5/8] dt-bindings: devfreq: add Exynos5422 DMC device
 description
Date: Thu, 31 Jan 2019 09:49:51 +0100
Message-Id: <1548924594-19084-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djP87oHtwXFGMybrmmxccZ6VovrX56z
 Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
 ev0ik8XtxhVsFq17j7BbHH7Tzuog4LFm3hpGj02rOtk8Ni+p9zj4bg+TR9+WVYwenzfJBbBF
 cdmkpOZklqUW6dslcGXsuLCCraBLreL4/72sDYxN8l2MnBwSAiYS0/9/ZAKxhQRWMEocueII
 YX9hlJjTpNvFyAVkf2aU+LWigRGmYfGEV6wQieWMEg3LvrJDOEAdv9q2s3UxcnCwCehJ7FhV
 CNIgIlAtcef6fmaQGmaBO0wSe2cuZQFJCAuESlzu/MYKYrMIqErc/nYZ7AxeAS+JHUc+sUNs
 k5O4ea6TGcTmFPCWWNL1F2yQhMA2dol1jzZDneQicX13I5QtLPHq+BaoZhmJ/zvnM0HYxRJn
 O1axQdg1Eu0nd0DVWEscPn6RFeRoZgFNifW79CHCjhL/ly1kBglLCPBJ3HgrCBJmBjInbZsO
 FeaV6GgTgqjWkNjScwFqkZjE8jXToIZ7SLxesgsaVvMYJdZsPMM0gVF+FsKyBYyMqxjFU0uL
 c9NTi43yUsv1ihNzi0vz0vWS83M3MQIT0Ol/x7/sYNz1J+kQowAHoxIP74O1gTFCrIllxZW5
 hxglOJiVRHgNf/vHCPGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl
 4uCUamCcqCvd0vrsYxe72fzrP309W849ehX3y8w61fbMXelDIfMsmLfmHek+e0ba9uPqXd3P
 XCUa594t8JU7o3XoQFsp1xVJ+fOi7sG7RQ7JTuNeai4n+St7z+SjmhvNlPfFFGYaR1pPiPr5
 YcsdzVMGRqn/f7z8sfeDq89kL4+DDp99NTsupDlo7n+lxFKckWioxVxUnAgANFTaFzwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Xd0D24JiDDZO0bbYOGM9q8X1L89Z
 LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
 vX6RyeJ24wo2i9a9R9gtDr9pZ3UQ8Fgzbw2jx6ZVnWwem5fUexx8t4fJo2/LKkaPz5vkAtii
 9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ2XFjB
 VtClVnH8/17WBsYm+S5GTg4JAROJxRNesXYxcnEICSxllNjVOZMVIiEmMWnfdnYIW1jiz7Uu
 NoiiT4wSfxfeAnI4ONgE9CR2rCoEqRERqJfof3OJDcRmFnjFJNHwXgPEFhYIljj58QVYnEVA
 VeL2t8tMIDavgJfEjiOfoObLSdw818kMYnMKeEss6foLZgsB1fz495FxAiPfAkaGVYwiqaXF
 uem5xUZ6xYm5xaV56XrJ+bmbGIExse3Yzy07GLveBR9iFOBgVOLhfbA2MEaINbGsuDL3EKME
 B7OSCK/hb/8YId6UxMqq1KL8+KLSnNTiQ4ymQEdNZJYSTc4HxmteSbyhqaG5haWhubG5sZmF
 kjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQZGWYvb7F9Y36odmN9h+PSgY6Ze1R/nm19OSv4K
 U3wzeWPxXJNdtf9/SPNfn5dd5pE10Z87QTAuSPjm/oMn6+K6nL5Hp8zri83aGJPrbrnpnfXe
 D5FlKt0LVLxqF+6smMUf4Jzru3XhIR9GXjFrw7PLI/SzWxQqpmRWZNeIPW3/yvejPYbt6S4l
 luKMREMt5qLiRADEVGnKnwIAAA==
X-CMS-MailID: 20190131085009eucas1p14c96bc345bc4c414e6c4d7506f14e69c
X-Msg-Generator: CA
X-RootMTR: 20190131085009eucas1p14c96bc345bc4c414e6c4d7506f14e69c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085009eucas1p14c96bc345bc4c414e6c4d7506f14e69c
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085009eucas1p14c96bc345bc4c414e6c4d7506f14e69c@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_005012_303364_DDE1D18D 
X-CRM114-Status: GOOD (  19.00  )
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

The patch adds description for DT binding for a new Exynos5422 Dynamic
Memory Controller device.
It also contains needed MAINTAINERS file update.

CC: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>
CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-pm@vger.kernel.org
CC: linux-samsung-soc@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/devfreq/exynos5422-dmc.txt | 106 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt

diff --git a/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
new file mode 100644
index 0000000..229efba
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
@@ -0,0 +1,106 @@
+* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
+
+The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
+memory chips are connected. The driver is to monitor the controller in runtime
+and switch frequency and voltage. To monitor the usage of the controller in
+runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
+is able to measure the current load of the memory.
+When 'userspace' governor is used for the driver, an application is able to
+switch the DMC frequency.
+
+Required properties for DMC device for Exynos5422:
+- compatible: Should be "samsung,exynos5422-bus".
+- clock-names : the name of clock used by the bus, "bus".
+- clocks : phandles for clock specified in "clock-names" property.
+- devfreq-events : phandles for PPMU devices connected to this DMC.
+
+The example definition of a DMC and PPMU devices declared in DT is shown below:
+
+	ppmu_dmc0_0: ppmu@10d00000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d00000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
+				event-name = "ppmu-event3-dmc0_0";
+			};
+		};
+	};
+
+
+	ppmu_dmc0_1: ppmu@10d10000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d10000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
+				event-name = "ppmu-event3-dmc0_1";
+			};
+		};
+	};
+
+	ppmu_dmc1_0: ppmu@10d10000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d60000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
+				event-name = "ppmu-event3-dmc1_0";
+			};
+		};
+	};
+
+	ppmu_dmc1_1: ppmu@10d70000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d70000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
+				event-name = "ppmu-event3-dmc1_1";
+			};
+		};
+	};
+
+	dmc: memory-controller@10c20000 {
+		compatible = "samsung,exynos5422-dmc";
+		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+			<0x10030000 0x1000>, <0x10000000 0x1000>;
+		clocks = 	<&clock CLK_FOUT_SPLL>,
+				<&clock CLK_MOUT_SCLK_SPLL>,
+				<&clock CLK_FF_DOUT_SPLL2>,
+				<&clock CLK_FOUT_BPLL>,
+				<&clock CLK_MOUT_BPLL>,
+				<&clock CLK_SCLK_BPLL>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+				<&clock CLK_MOUT_MCLK_CDREX>,
+				<&clock CLK_DOUT_CLK2X_PHY0>,
+				<&clock CLK_CLKM_PHY0>,
+				<&clock CLK_CLKM_PHY1>;
+		clock-names =	"fout_spll",
+				"mout_sclk_spll",
+				"ff_dout_spll2",
+				"fout_bpll",
+				"mout_bpll",
+				"sclk_bpll",
+				"mout_mx_mspll_ccore",
+				"mout_mx_mspll_ccore_phy",
+				"mout_mclk_cdrex",
+				"dout_clk2x_phy0",
+				"clkm_phy0",
+				"clkm_phy1";
+
+		status = "okay";
+		devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
+				<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
+	};
+
+
diff --git a/MAINTAINERS b/MAINTAINERS
index e81dfbf..ab0d8a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3316,6 +3316,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/devfreq/exynos5422-dmc.c
+F:	Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
 
 BUSLOGIC SCSI DRIVER
 M:	Khalid Aziz <khalid@gonehiking.org>
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
