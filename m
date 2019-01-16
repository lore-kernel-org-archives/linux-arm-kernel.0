Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:13:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7604D20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EIBxEXJs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjTAT1Bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7604D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AHC6g1fxqoxcduRwVC75Ldl+JJ1oCJkOGqQE1MYBC+E=; b=EIBxEXJsHZmiHS
	XPkTHdK9ms05XLabcANzQ2sbZ47mJ2i4Z4ECwkwcdD3aLLeygSGJqZ5PYZ2AJvI8nQmw7p9JHKJHz
	8tZjvn6IBqXsC7d85SmbZl8DfX/WDOvc1hHXN94MG5KYkOWmOxFiWm8Zqe73AjH1/NX4q4lZk3nhW
	i+UUp4q0htBDCPq19t30gR47FYi6yD1C5+9CkQ3DHgEu/yoAPzjx1LleVPeUs4P0OAbXSXXX4/QPu
	3fVl1Ya8WScH4oYX9cCRZKpD2nONyRKpPruhHEjGrrOVF5pqdQycChjVmONFp8ptUz92pjvdby8iM
	dlZHq0PVZ82rQjRPPHjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjnoV-00083k-Mm; Wed, 16 Jan 2019 16:13:11 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjnmk-0006Kg-9w
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 16:11:29 +0000
Received: by mail-wm1-x343.google.com with SMTP id n190so2596243wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 08:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jinzyf9/O+SMx8INgN4EUNWLAGDQnyj+5fdQ+uj/Fb0=;
 b=AjTAT1BsYmaPC+ck8CpYqZVy5QMSxxLiU4/+Z3z4MhkagvUjAWUYVoiPq6eBH9qYA0
 nJkwADZpLT/dC7d07kuFthh50AqOSYg5bkOhNKGBQomqrjgDtIR6U4DPlBRryL5PQIT1
 BRsyQ1aD/Ows3h/6DAo2X7AraFlNcN6eq9N6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jinzyf9/O+SMx8INgN4EUNWLAGDQnyj+5fdQ+uj/Fb0=;
 b=bHZkJuSzS+LEEFHdbvSwwdCo5hhdEN/z+1NA0b3rwzAGRGmlWYUhAhmvtMwnzKTfRd
 cj8C/B0McQw0e4afJB25tnDecX7FK38SgL95MPsYrjGhlZkCMeiXmJmHoBFGW7GRmq7g
 aOrReQLPdWcmhxWy08RyFzZPZrgnojAkV9HrpKTQ/GarUXDhpg95DFkv8nOPcQTULcrG
 SbJAiAcJql7R/Z9/tJs2jLlIE+FccISjsnz7oCX8EgDvUY2FoxWtRsA/23RuU3JehET3
 NCYvRMGwD+3imhMEy7sV8+uV4kpiASvnU0UpjSecQPS8nXFmmL3Vhi9u4nOiMP8m0vQw
 GLvA==
X-Gm-Message-State: AJcUukfv0niEuNJKeqo8ZEn+KqIfbFJ9rd2kKz81qLa+3Ou4sfk4QiSa
 q/VpnOdoi2c0BJVqpoTopuZYRQ==
X-Google-Smtp-Source: ALg8bN6+OWLo23Zec1ggzBZW9SNn4OijgnXNuqhq1lo4rd9Kcqk7Gq947XzgiCxmwhPcOFg8yT3l/w==
X-Received: by 2002:a1c:20cb:: with SMTP id g194mr7947410wmg.77.1547655080868; 
 Wed, 16 Jan 2019 08:11:20 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id a17sm78193407wrs.58.2019.01.16.08.11.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 08:11:19 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH v13 6/8] arm64: dts: sdm845: Add interconnect provider DT nodes
Date: Wed, 16 Jan 2019 18:11:01 +0200
Message-Id: <20190116161103.6937-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_081123_130443_EF505B82 
X-CRM114-Status: GOOD (  10.53  )
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

From: David Dai <daidavid1@codeaurora.org>

Add RSC (Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..5179cb94c95b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
@@ -1602,6 +1603,11 @@
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
 			};
+
+			rsc_hlos: interconnect {
+				compatible = "qcom,sdm845-rsc-hlos";
+				#interconnect-cells = <1>;
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
