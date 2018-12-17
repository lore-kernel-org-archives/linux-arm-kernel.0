Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6639DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159DC2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eq4Ju1dJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdHo/8Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159DC2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1ZGF/NllSyT/CYI2IQnnNMoJdnrjjL+JhJHKUyt1AxM=; b=eq4Ju1dJKvKk+33YLs9q5Twe4m
	Elc/tZnBwKyT67sQ2m/U++A4j1xhA/xxtqiZNf2eo7NWR/YORi62e8VIj4k9TA/HWlgOoHYxIjsRf
	ChdlaelTsr+6E3kpjAnl4ScJcja1wW7j4kGZp6uWRNf0fvi3wvwA9SJXMEnsdScqSo9S53RSYyV+e
	NAPPc0jtE2HuPkChIvEtge0HeBygyrbf9zo65Kb6JRXms67j8r9tvjduba+P7s+cQXsX00me2jXtn
	hjhpGiRxLONbhmX2a/k/84ZucXDKOHE7WhQuKqh868hdVjvakhlzSKt2uHuw8bKvhVLQEL2xylRYD
	NyV89QFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpVh-0007Ni-S5; Mon, 17 Dec 2018 09:48:25 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpUF-0005qv-UX
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:47:01 +0000
Received: by mail-wr1-x443.google.com with SMTP id s12so11100015wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RXGJUDtV43vtkJcjcMqswspwSUTkhQ4p8WwX+rLLTcY=;
 b=YdHo/8VlDHD/XH++DFycOyIheMQnzZsvbLugbbHc7UQZcNUmGcurmALjHh0qfwqFAO
 1+iCxmpXAHraLrtCGrNtgw+bXyRr78aSb9mf48IqnDu5imbXEZUUX1TX6gKmuvSg36qY
 kgiE0JP7rrL6FXcVFIc/RRM5iiPPqO1AIgK5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RXGJUDtV43vtkJcjcMqswspwSUTkhQ4p8WwX+rLLTcY=;
 b=D8Pu6hGpd9Gf62ZofkCR+y+iqLWlVfrAXVhnbBGObKstQkt2Axgc/J2s/qfyLRU5bH
 PxTHnrxlCnmG++pZ4mGVu1DdeLhD8C2jQSLxrjWXwRSXD0hDa4fjHUibloXCIEPZTHjo
 +hCo6X6S+z8BzHL4b01dJLDIipGiCuv9rY0/bCjsp2gACzNSqjrb32+80C455rLxzt2P
 z0nqiYiPIpLWJVFhBSHnyQUE3+PbL0LfALOQ2nvZuYQ5kcCnvp41GQHoidL5ZSa+uFnn
 LZcWrzy88Rpk9249Jorw9mz3GI2bnVfkvF5enkOxEVi5QcY055EZY0PSN3/HcChJJf5a
 8uJg==
X-Gm-Message-State: AA+aEWZm68J500oPXWwmTqeKtHc5mP3/oSPVC8eKgZ3XeZZJgnW6oi82
 H2hvr6a8ScEH0gKb02V5YAoylQ==
X-Google-Smtp-Source: AFSGD/W8DpmQ1e838SqPlmsvrSAYTNxnzP5FGpj5vmGIgcpooxl9YQ4KtNc5pi02rANEG/HKd3RoRA==
X-Received: by 2002:adf:c042:: with SMTP id c2mr10420188wrf.158.1545040003249; 
 Mon, 17 Dec 2018 01:46:43 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:46:42 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 04/13] dt-bindings: mailbox: qcom: Add clock-name optional
 property
Date: Mon, 17 Dec 2018 10:46:21 +0100
Message-Id: <1545039990-19984-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014656_382412_81318957 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When the APCS clock is registered (platform dependent), it retrieves
its parent names from hardcoded values in the driver.

The following commit allows the DT node to provide such clock names to
the platform data based clock driver therefore avoiding having to
explicitly embed those names in the clock driver source code.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../bindings/mailbox/qcom,apcs-kpss-global.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
index 1232fc9..f252439 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
@@ -23,6 +23,10 @@ platforms.
 	Value type: <phandle>
 	Definition: phandle to the input PLL, which feeds the APCS mux/divider
 
+       Usage: required if #clock-names property is present
+       Value type: <phandle array>
+	Definition: phandles to the two parent clocks of the clock driver.
+
 - #mbox-cells:
 	Usage: required
 	Value type: <u32>
@@ -33,6 +37,12 @@ platforms.
 	Value type: <u32>
 	Definition: as described in clock.txt, must be 0
 
+- clock-names:
+	Usage: required if the platform data based clock driver needs to
+	retrieve the parent clock names from device tree.
+	This will requires two mandatory clocks to be defined.
+	Value type: <string-array>
+	Definition: must be "aux" and "pll"
 
 = EXAMPLE
 The following example describes the APCS HMSS found in MSM8996 and part of the
@@ -65,3 +75,14 @@ Below is another example of the APCS binding on MSM8916 platforms:
 		clocks = <&a53pll>;
 		#clock-cells = <0>;
 	};
+
+Below is another example of the APCS binding on QCS404 platforms:
+
+	apcs_glb: mailbox@b011000 {
+		compatible = "qcom,qcs404-apcs-apps-global", "syscon";
+		reg = <0x0b011000 0x1000>;
+		#mbox-cells = <1>;
+		clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
+		clock-names = "aux", "pll";
+		#clock-cells = <0>;
+	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
