Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987A0C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:36:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB0A20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E/EbJCtQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SqulDG1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB0A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9wz7TEgr9V/JWfJwa0gwZxrhtAOifDGRoI9+kh3Du2g=; b=E/EbJCtQubNDcqSTdXJfawpbHE
	ZNylFqSTMLW8LWnUI3GuWEf3WzrZVrz22X0wm9bVUe/eFPampx4zZtOBNar0wK6HJoP99r1vSyn1y
	vAV8NELQsmtJogkE7sL+7Mi4d4jaX7TVgR7OvHYMhVSU2Plch8RYhr4z8TSrF9SN5Yz71HmERxXlK
	i61ANWyFFCY/yEZ5jSqY7pTkC2YUUQ/rhWC9faUmV62uqOQLpswsY//P8buKPKZrAk5zSdoTC2WqL
	y+/HVaAPzTs2ooJ7ofv2vZy2weL0BL3n3NJu8DcM3t1CZ20gdn1Fc1O2iNkszxfgBLHhrl/NmSYQZ
	/Hgb7pQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBlY-0000ta-2u; Mon, 28 Jan 2019 18:36:16 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBix-0005nb-Fa
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:40 +0000
Received: by mail-wr1-x443.google.com with SMTP id p7so19288792wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xY2V4sBj5Ds3+SQmdTspSIBla6JHASTE6hEmXoXtqtk=;
 b=SqulDG1htlstay/n1BHzyLU2JQGWF4RcVpu7TJm73i+S5Fwr+HCfyNcMj/gpDjDYK4
 gFskLeTNSduRkgrAzr+oYZGbPzCkSuEcRZ0babBtOqcd4KKxZkGbns0m7Wx7mB4L/1Kk
 r/8EwQt55R5byIizULDYs4GIaxcrrL7l7/Lh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xY2V4sBj5Ds3+SQmdTspSIBla6JHASTE6hEmXoXtqtk=;
 b=FQJYaMotIFnPfbd0R8hHgDeDsWiO9E73dM8y+mX6ELR5+LflukfJMop4ljggK1JNdI
 KzHlgBc4D+nRekV9YcpLRdtxwB+nVQQnZZWvY47HBDMcz61JNcXQo+7fPMBoC8fJdTew
 XGnGQfEn9veNUvSSJsffPQE4qXyBLEiXqLY08ng/q4507K70eN7KkZhGSrHo6D1BOaZo
 nwANfn1sX7WbFv5lL0SmF4xMxIrABoJcip12xlkQd8o/Sdwq1uUnZZUoBU5QrQLykidm
 y/OxsMFbpJPbSWz7uCiZrddjwO2wu3AgsJFb1zrNkJH69CevAstXa0VnhNMWg6+XXUZb
 mU1w==
X-Gm-Message-State: AJcUukfR2gYIXcCFnuv2Jgipkw3bMAiCZRREzNPmhvfBWhOfqoTUM87K
 tq3ld3KlLR1F9nURa4PUvEm9WA==
X-Google-Smtp-Source: ALg8bN5DOJIKZG0xMjU6d3Nh9DE1ZaDcgoyjVebiHC2cVRDceHePkKjSLdouz4HUMHLiqUO88F69nA==
X-Received: by 2002:adf:e846:: with SMTP id d6mr23424491wrn.72.1548700414206; 
 Mon, 28 Jan 2019 10:33:34 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:33 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 10/14] arm64: dts: qcom: qcs404: Add OPP table
Date: Mon, 28 Jan 2019 19:32:57 +0100
Message-Id: <1548700381-22376-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103335_731041_94DD076E 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a CPU OPP table to qcs404

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9b5c165..4594fea7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -62,6 +62,21 @@
 		};
 	};
 
+	cpu_opp_table: cpu_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+		};
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+		};
+	};
+
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-qcs404", "qcom,scm";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
