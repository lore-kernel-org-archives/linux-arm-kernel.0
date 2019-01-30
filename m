Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF7FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:05:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581CB20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nmwFiRzJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Fie6jY3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581CB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zKNJu7FZU0PQFgjd0Jmld5BOiXczssNAwXbU43ihWz4=; b=nmwFiRzJQsRq/+
	FGJvICxsgmOWTvAEpwwGchDt47JHxCMVTtv3AjKVwBdg1CQkFgqWc4F04VTcyeUMsXXwu7ZtSq6uy
	ojBGXiRDtgGxw7C+WUjn2NDNaOInO/THSsSOBTOTCe5Ny9xgUh7BzCQGctGzofLKi4qYly437NHh8
	jpxNWQA5HFR6ILt+Jl3r33hgKj2jWi0e8E1LcDOj5zFAN/ZsZUH9fT53jMPXmF3kDtoLI1OMDesrR
	5YRIZr2rYk4p1cRiWW46GBm7QHXsyYeN+b9z/aqI/9EFnx/m0zMS8uIWS5ZwqZLNqIK/kT6ShMVSs
	n2/2SXSLt7jaU+7TKgMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gooch-0003kI-HI; Wed, 30 Jan 2019 12:05:43 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goocN-0003Tb-LL
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 12:05:25 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so21363803wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 04:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wqYT4k+TQ+M+pfm87o38f7PaCTS9uBZHsXpt5KCiYd4=;
 b=Fie6jY3eWbgGocsWjh+fKz9xKmPKXiVcOt/es8g2FFJuo59MlB7k6p8tCL0KgkNitD
 ixgQQpY4Ft62I25mtytFZNcyrhKHIooBHoGAOkZ5ZJx1uPszWfdcSFCluYt2IBJcYwr2
 6rIiiFiKXzr4Hfgu+Bqjf2sGQdHzZIezERFciPYxKNV8FqSctL/xRPtrR6l0pqB2gQkl
 HX10VxWWl652xJEJGERzaNv1R5JUIiZuU5szJOv9Nsv2Jqt2rfR20dABHkcrFhpWhRne
 hne4GbEzvDTGoTxlg8r4PwztQqBMSJh4k/7SjVXvGQJmsxUBuyXcPXEUONwsy6nuPrni
 1pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wqYT4k+TQ+M+pfm87o38f7PaCTS9uBZHsXpt5KCiYd4=;
 b=GlOLw7Bj4VBTLQAlc0LAGVhr6Z0i23hxb3p19k4SZkX6DrAoF5aeimp5GF5SgMc42V
 CKZSF8UmVOpVC9sETcYXWBV7RLu3aJq60tjiFcyw3RChKaumDsyqLb2I9ITKNRdn/96X
 sa2BrvsK/DPG+aRRhFehHF2tIETF2VfvrRNcfmxISP7vdAqUx04BVXLuth2vzb7CotWn
 /NILs8m2HqxvhofsvYKlg71dOUGWyXkA0MeVzdrxT6mN8gEICvLIpReoYYFddnJVNY8E
 jMP6zwV3VXdzfgpyIZgPtORtDRP7ZSNEOkASI75P974yz3KDh823Gw0Q1rtfPvwwSjhH
 c59A==
X-Gm-Message-State: AJcUukeIWOo9bDVzptQnhX8qbBVCoYlBTClBwPMIt3qgXsyLFr9b4g71
 eLszndWacH3a7OarfuYOLP1JMQ==
X-Google-Smtp-Source: ALg8bN7iabYejaasVAwO2Aui7uaHUFO/u9or32gSchK5Gs2ZTvTR7ob0iYkmmLwNM/fBjzkAZMH/rQ==
X-Received: by 2002:a1c:9dc4:: with SMTP id
 g187mr25641923wme.152.1548849918689; 
 Wed, 30 Jan 2019 04:05:18 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id f15sm642954wrt.10.2019.01.30.04.05.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 04:05:17 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/3] arm64: dts: imx8mq: Add QuadSPI controller
Date: Wed, 30 Jan 2019 12:05:09 +0000
Message-Id: <20190130120511.11555-2-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190130120511.11555-1-ccaione@baylibre.com>
References: <20190130120511.11555-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_040523_697507_62BA6405 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a node for the Freescale/NXP QuadSPI controller and extend the AIPS3
memory range to accommodate the QuadSPI-memory region.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index dbedc4a5e7fb..2be302cb2f1f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -379,7 +379,8 @@
 			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x30800000 0x30800000 0x400000>;
+			ranges = <0x30800000 0x30800000 0x400000>,
+				 <0x08000000 0x08000000 0x10000000>;
 
 			uart1: serial@30860000 {
 				compatible = "fsl,imx8mq-uart",
@@ -497,6 +498,20 @@
 				status = "disabled";
 			};
 
+			qspi0: spi@30bb0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx8mq-qspi", "fsl,imx7d-qspi";
+				reg = <0x30bb0000 0x10000>,
+				      <0x08000000 0x10000000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_QSPI_ROOT>,
+					 <&clk IMX8MQ_CLK_QSPI_ROOT>;
+				clock-names = "qspi_en", "qspi";
+				status = "disabled";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg = <0x30be0000 0x10000>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
