Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3BC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:03:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E2F2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OkeIUgbg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HS9y9EVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E2F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O7dHdkSSgzhshgEapBHoA08A4nkPXW0neVu8YppMKqA=; b=OkeIUgbgNcFcjj
	c52c/SawSISW/oBWO1/od63oFadMwyef/3QlZ8K44xuNERvtNFd2soUX0eL7QlSkFHo4TwXx4OaEA
	aJWQ9KQSmSRa6jER6jdHV9nQZlz9JerUjFOnELwY3kOLRp97Q45OBtqACIIR6cypRLwtzejYydwGd
	qUJNkXa9v5xKpKhwlllflPRiFzgnCFTCtG8ECS42cPRQBjjQMh7i1CFsBznMjqoCKxhrzHqn/kJUA
	NWMWEsepRS23Z4kAP9T0/5nG2NuMcyRHsdXWA0PM4onWmdr2llL5O/nvX+DURfRle61ETv6H3K0QQ
	GXTEQIzvI/tvMlo5G5oQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVg0P-0007Ky-F4; Sat, 08 Dec 2018 17:03:05 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfzu-0006j2-RH
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 17:02:36 +0000
Received: by mail-wr1-x444.google.com with SMTP id b14so6534764wru.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 09:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uYVwTFHfIdIF1mZV76OOxHqL8mAPwlcr24Pr/3Xy1IA=;
 b=HS9y9EVfzKeMOVbRIxLLfBnvq0rZL3W67pLPJ8NUfhzMZB3GBei6SgiXy3nuNR8Qdi
 9zpbM8Tg8A+Uh7RvBSv7GsomS42qtpcc9TGa1re2lSgz82OCPWf2EHIoqctxkDUqGZlM
 ytUJ7QrgJqbyCGDBfiSuYqZieQzCsXl4uxH3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uYVwTFHfIdIF1mZV76OOxHqL8mAPwlcr24Pr/3Xy1IA=;
 b=jGnQ/FLjWyPfwVdeV64sStALfaScx+5VNQUUGTwbV6WERHaElvtqskzMSNXR9CsaQn
 ESLi/I2Zkl7rjVzCWTuxw9XcoSQFE/Q1H5qTpn/+repB+TEeiy0X8hwTFERRQIrStkuB
 sO06nexsUB+ftWI8LSpkitE765RVVti2o5FHgzuJj58ZkPzJu2U9YazdZQ/LsjZ6/AJ1
 JNSecUnmm+mtFpWI9iMqsRks0Z7CLSBYrAokbrmbNMXjx5cm9U+JliS5mf+FR42ts3be
 FckXVha2HqbgCTHYNkNavu39TJ/jc5yiBp6Znr0THwwBNmC/iuQhjmTEfU/Z+twd4Nu0
 An/g==
X-Gm-Message-State: AA+aEWavcAaPJCn7tWVIcnowoJaLyRpNJB/1TbCkdPXlU0GZervgSEOG
 JrOp/zkpG5KTUPJoHBW4DyuZ1w==
X-Google-Smtp-Source: AFSGD/V4FMoCY4qPEk1+ugBTTCKc3TSjhL8vXLabfRIMUbTMklVDXHZz9AYWIkK/R+qo1ZBvgkEKmA==
X-Received: by 2002:adf:ef50:: with SMTP id c16mr5041589wrp.198.1544288543299; 
 Sat, 08 Dec 2018 09:02:23 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id l20sm17411344wrb.93.2018.12.08.09.02.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 08 Dec 2018 09:02:22 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org, andy.gross@linaro.org, olof@lixom.net,
 arnd@arndb.de, linux-pm@vger.kernel.org
Subject: [PATCH v12 2/7] dt-bindings: Introduce interconnect binding
Date: Sat,  8 Dec 2018 19:02:11 +0200
Message-Id: <20181208170216.32555-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_090234_880551_50633569 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 mturquette@baylibre.com, daidavid1@codeaurora.org, bjorn.andersson@linaro.org,
 skannan@codeaurora.org, abailon@baylibre.com, lorenzo.pieralisi@arm.com,
 vincent.guittot@linaro.org, seansw@qti.qualcomm.com, khilman@baylibre.com,
 evgreen@chromium.org, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, dianders@chromium.org,
 amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This binding is intended to represent the relations between interconnect
controllers (providers) and consumer device nodes. It will allow creating
links between consumers and interconnect paths (exposed by interconnect
providers).

Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
new file mode 100644
index 000000000000..5a3c575b387a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -0,0 +1,60 @@
+Interconnect Provider Device Tree Bindings
+=========================================
+
+The purpose of this document is to define a common set of generic interconnect
+providers/consumers properties.
+
+
+= interconnect providers =
+
+The interconnect provider binding is intended to represent the interconnect
+controllers in the system. Each provider registers a set of interconnect
+nodes, which expose the interconnect related capabilities of the interconnect
+to consumer drivers. These capabilities can be throughput, latency, priority
+etc. The consumer drivers set constraints on interconnect path (or endpoints)
+depending on the use case. Interconnect providers can also be interconnect
+consumers, such as in the case where two network-on-chip fabrics interface
+directly.
+
+Required properties:
+- compatible : contains the interconnect provider compatible string
+- #interconnect-cells : number of cells in a interconnect specifier needed to
+			encode the interconnect node id
+
+Example:
+
+		snoc: interconnect@580000 {
+			compatible = "qcom,msm8916-snoc";
+			#interconnect-cells = <1>;
+			reg = <0x580000 0x14000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
+
+= interconnect consumers =
+
+The interconnect consumers are device nodes which dynamically express their
+bandwidth requirements along interconnect paths they are connected to. There
+can be multiple interconnect providers on a SoC and the consumer may consume
+multiple paths from different providers depending on use case and the
+components it has to interact with.
+
+Required properties:
+interconnects : Pairs of phandles and interconnect provider specifier to denote
+	        the edge source and destination ports of the interconnect path.
+
+Optional properties:
+interconnect-names : List of interconnect path name strings sorted in the same
+		     order as the interconnects property. Consumers drivers will use
+		     interconnect-names to match interconnect paths with interconnect
+		     specifier pairs.
+
+Example:
+
+	sdhci@7864000 {
+		...
+		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
+		interconnect-names = "sdhc-mem";
+	};

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
