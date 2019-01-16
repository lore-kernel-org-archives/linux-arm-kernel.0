Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C556C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3373B20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YzyccV0a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bz6AnpAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3373B20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sr9s+le6tmR6jlgrVQdUJJxDxKqTRsTyHPvbMU8kSU4=; b=YzyccV0ac2eTGC
	0GYFjIm/3J9mhiierIooqQAtPjYzGxa19I4l+++/m1KYNEqlhkBTUR2lnEa2LMawLcV/3wLCG243m
	lhm1ud36KKjh7MmL+G0tMUwiP8d/SnMPsuoJE5YG9y0Y7VDdex6m2BovM4TfKEdoL/VJVANYmDGoy
	IvKyJoK25Qd2W0VHN0GsUIdkOWMlIwLoj4Po9obsVpGOcx1pURE9VE0o7IVIsk8gJ4opwAJq8JLTg
	FL9Zx1DIhisBe6+KZAAS9fRxM2+ODNcExj8xStOO7ua5N5+63i+etiWIqFrKAjfeV4i1FsGF5pba0
	JEI8gnipNC0KsgmggQnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjnmy-0006XR-3m; Wed, 16 Jan 2019 16:11:36 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjnmb-0006E8-0j
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 16:11:15 +0000
Received: by mail-wm1-x343.google.com with SMTP id f188so2568326wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 08:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zq2oMbbyivDSUeOMLU6UgVaZMPHzfeEtdH+iJhaQzFI=;
 b=Bz6AnpAOC1LWp7HIBwDPW+c8rI8rUIahEAzNe0cf4f9UbL5QjWiz+9EPB6M8Nomzlh
 oaHmJRLfPCL9PHQSBM4L1e4f9TLFbjrjJ5tOTWBpDhIWOBhONvm1Y4f1pdYJZBm1cCCg
 KNQiq/we5MfhtJ2paVJvkrEDQx1ztjjFkjxHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zq2oMbbyivDSUeOMLU6UgVaZMPHzfeEtdH+iJhaQzFI=;
 b=MQXKnDxBGqJF9JWIdon8jfPEedll20lZPmmGxZ3w17/ZE+Y0QOMlUSj6Tswu9jdbi5
 Y4p8W1fhLXUKl7rnSid18uaprKMOk1/EKKitr8aYVjH3PayhcXCbOjCX1voZhhuB2BPF
 nThyDSQRJ5d7d+vF00YeACq2ZKI+7l3tldoMdMvfuarqVzFPOTIdBwe3H9aP7CsA9KH9
 PH6d+QqT2j1D3yhZjtxmnTBwz0BACgzhl902ZYWW+Jglj7eFwztfuOL20BsdmC/SCfNu
 +nwbTX/XMSJfkzTa5C8mI/FKB/KfC6yG/0KnA18L2u4Wt+awSE5FlepnHjZAEKrxSUIa
 ctkQ==
X-Gm-Message-State: AJcUukcY09dSf5gGbcKcNqdTjDm7f0Lc7ImnBSO+OplkFo/UD2uetsuj
 jVhDALemoBP1Mpsx2RJWJvaBkA==
X-Google-Smtp-Source: ALg8bN4Cf46ZL1gy7/zlADr5kz6Lry7MyVxWtkfDt83Hljxxs3bH3mOcohe+U1Tkugq4psB8bi4ACw==
X-Received: by 2002:a1c:d1cd:: with SMTP id i196mr7978630wmg.107.1547655071506; 
 Wed, 16 Jan 2019 08:11:11 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id a17sm78193407wrs.58.2019.01.16.08.11.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 08:11:10 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH v13 2/8] dt-bindings: Introduce interconnect binding
Date: Wed, 16 Jan 2019 18:10:57 +0200
Message-Id: <20190116161103.6937-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_081113_068455_C878DECC 
X-CRM114-Status: GOOD (  13.83  )
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
Cc: sanjayc@nvidia.com, maxime.ripard@bootlin.com, mturquette@baylibre.com,
 daidavid1@codeaurora.org, bjorn.andersson@linaro.org, skannan@codeaurora.org,
 abailon@baylibre.com, vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
 khilman@baylibre.com, evgreen@chromium.org, ksitaraman@nvidia.com,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, henryc.chen@mediatek.com, andy.gross@linaro.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com, olof@lixom.net,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This binding is intended to represent the relations between interconnect
controllers (providers) and consumer device nodes. It will allow creating
links between consumers and interconnect paths (exposed by interconnect
providers).

Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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
