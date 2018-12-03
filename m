Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C78C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:21:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C27120666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NS3nHfPX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="KTJEG6/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C27120666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TXkioAjLSDzV/Y3Tk8lElajwegaBokNVa/0Kyh9bow8=; b=NS3nHfPX+QtlZYSqgB7SnjSZMl
	QJBII+oPzYTOdy1y6bKwDvbvufXmI0pAPu3bjfgDnj3mAKXCPcTK91lU/DKuXweyUFP9IbjND4nRf
	Lpj5wfi/zhXbmPZGCb/HFeHOnVqUJ/Cz/XPwnkBmQrIrZRvPgIZzN62hhued2S/jFkBGw00GO/wps
	yHAyO3iT2qhw3lpd0FnMdtyRUsiL3dJ7GEShD8ols00czsYAQNnhrj8k2aLCS+5tGbKYqSd5D4vO8
	N3aMZCrG2oJLQfrg2me8jUtv6pmrWCrxsv12R2XxnEnr18RUdmP26QoCCxhoc2+sriM+l3bGV6qvn
	EII/lbNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvej-0006Qt-EU; Mon, 03 Dec 2018 21:21:29 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvef-0006Pd-Ru
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:21:27 +0000
Received: by mail-qt1-x843.google.com with SMTP id t13so15625414qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nESaeaha8h52I+/daK2v+IFiza8HEsTIFWyRHl7bcl4=;
 b=KTJEG6/pmpCBQHZi/S0+c2+4iN1lmItwIGA3kvNgX4W3UaesMSiD85++dw5oEuFsZ6
 o7Wiwz2GhKoZgcxhfcgXxt+k1A0Or23UsLWRVCx+K/D00ngY5+XCVUJY1/h9adm1cU0Y
 T8L4zLDtiykvvRYkUmoVNbeMl33dJIUxWRqUVexXWlhaKgyJlYLobKk1GD8pvSYk9srj
 wlD8t+sIRxZ1+oDoBHPd69BrMI03tZHhstcDcyBZ5KWVwoofCgDjLnEaOMstaHiDyXpA
 i+TZ5EXRfQAe/TXrOUlcYcITBCXffHDhaaAKYkbyyyaj2InDfi6zIjA0RYse5+j9nbij
 OVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nESaeaha8h52I+/daK2v+IFiza8HEsTIFWyRHl7bcl4=;
 b=MhCIH949DaW7yS6ybRLLEYn+aXb6YqFjxbRYwYOXaJohBEyTRvAcbyPV+WNTcBK12l
 59s+6bh6gdHyjDw4ydbRnTEOvvmHYCOP09o5fKIw+0SSIeZsR00dA7XovmjMy0jqEqwN
 3jigHlpzlnFoyTdwihqf38AJmuo7/FAYnY5fJsa2mhFCWqfpm+05r5tlDMfwBRZRB8C0
 2yBtf4rgP0XOzvRnzCzlEpy107vUy4hxNkz/D+emOf8MD76ZpGFabjF4n5xo9xHluzsJ
 1Tr0Lz3k8FxknrMJeTseXffWsCpgHsaitEpbIWMXA6s6+Gl0vpKQlWn8RQexfORMy0wl
 OUCg==
X-Gm-Message-State: AA+aEWaKAkYodmrcQXAFF6HcT3nnYNTLahhNP8a2hHKwZ4gLMcTDlD9v
 ErJpGYDYPUAAlEFIIDq29rVbXw==
X-Google-Smtp-Source: AFSGD/W68sSsiIY627/Hp7yaghpXz85KuqKq+KhvmoO2nlO6YgIh7eYJ2AsfYS/yh+qNm3/+YdAEuw==
X-Received: by 2002:ac8:c7:: with SMTP id d7mr16495109qtg.326.1543872074162;
 Mon, 03 Dec 2018 13:21:14 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca.
 [74.57.247.14])
 by smtp.gmail.com with ESMTPSA id l33sm10567353qta.57.2018.12.03.13.21.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:21:13 -0800 (PST)
From: Jonathan Marek <jonathan@marek.ca>
To: freedreno@lists.freedesktop.org
Subject: [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
Date: Mon,  3 Dec 2018 16:18:16 -0500
Message-Id: <20181203211816.5129-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181203211816.5129-1-jonathan@marek.ca>
References: <20181203211816.5129-1-jonathan@marek.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_132126_037699_55E79B14 
X-CRM114-Status: GOOD (  11.84  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, festevam@gmail.com,
 Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Chris.Healy@zii.aero, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP Linux Team <linux-imx@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/imx53.dtsi | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 67d462715..e9a7bbce9 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -628,5 +628,22 @@
 				clock-names = "ipg", "ahb";
 			};
 		};
+
+		gpu: gpu@30000000 {
+			compatible = "amd,imageon-200.1", "amd,imageon";
+			reg = <0x30000000 0x20000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <12>;
+			interrupt-names = "kgsl_3d0_irq";
+			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
+			clock-names = "core_clk", "mem_iface_clk";
+
+			qcom,gpu-pwrlevels {
+				compatible = "qcom,gpu-pwrlevels";
+				qcom,gpu-pwrlevel@0 {
+					qcom,gpu-freq = <166250000>;
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 207eb557c..586d45586 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -838,5 +838,22 @@
 			reg = <0xf8000000 0x20000>;
 			clocks = <&clks IMX5_CLK_OCRAM>;
 		};
+
+		gpu: gpu@30000000 {
+			compatible = "amd,imageon-200.0", "amd,imageon";
+			reg = <0x30000000 0x20000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <12>;
+			interrupt-names = "kgsl_3d0_irq";
+			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
+			clock-names = "core_clk", "mem_iface_clk";
+
+			qcom,gpu-pwrlevels {
+				compatible = "qcom,gpu-pwrlevels";
+				qcom,gpu-pwrlevel@0 {
+					qcom,gpu-freq = <200000000>;
+				};
+			};
+		};
 	};
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
