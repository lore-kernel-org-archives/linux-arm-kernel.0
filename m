Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4CDC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:47:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C2320878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tcqllKfk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvp9cApA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C2320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=+RGaLcBlDR6SZ1POThJxWQwZgntPI8zY97+WO5jSPsQ=; b=tcq
	llKfkjKLWQdDesScd8v7zbz6nFAB/FA7S+QiPQhgqijK4F8zt42Qhr2+4K0ecc2i8C3UsCjIfCM6w
	sGe192ex2/EwSsQXauwhSBbrQCsH4Ti0Ng3EXpEaX1rJ8ZSy5YqRmFqcDLt5EEf+CSAsieX7X/cWh
	E0jOtdvzkVM1XizNSrLvsNgURoAQ7avY4VTzcx1G0+EpK8yBm+3ShVEh92av/WyJzy9vjiZNY62a+
	5EXa70/FCNhd42a2InKaa/PJkHbzABBalyHS67fAG00Lzm6oJD54ccxnV0rZcD3XQLy1VEvbwhKG3
	3SC8KVryeMOgLAd1joytibHyzJjvhzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaKg-0003hh-Bo; Wed, 05 Dec 2018 16:47:30 +0000
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaKb-0003h7-3I
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:47:27 +0000
Received: by mail-yw1-xc41.google.com with SMTP id h32so8805009ywk.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=FU9DW50Ll/Lk+/UYUnmvIMm4Passm8+Y7GCkPCx5Cfs=;
 b=Dvp9cApAUfry4QomimiGSC379ppM5R2OKmpfXuBIcg7EhBYOOi0RwOTQ0kki1DDq/W
 ad8ro261+zf7PdpEmS6rNtXgehVGWQDP3E66oUNysjOAN4krki6DlKMP3eMkKmt2JAHA
 lEOcWYMMpcb/HVn2/nk2Zw9xgQqwbaNusoDMEhTZEIrR50sf3Y92WhZ1evKhq6fPZv9D
 r1Ukr7PdvOwyHeGbSa29NcKIh94Zqiyp1aIX0v2hA4sSj53A/4JLEd/Z+yYDO58YeXPq
 i5Au5HqlzGkasDLALArhLIwMUxzz80cWC8YwG7scqPXlLtRuE5Jeq+nHm4cDsZAI6h5K
 qw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FU9DW50Ll/Lk+/UYUnmvIMm4Passm8+Y7GCkPCx5Cfs=;
 b=aAvBJFFIkur0xva9viaiH7pqUrYD4EQcYxhnRQnhYNWbzgUpd+KgJQFJnD67oCK9MQ
 HTQX0C98/hywC+JBmCAnXTHQSgcLAL4HK/06wKREpcu3JZuzxAssnsvT5egAbszxA0Zx
 QW7yWga+CIwxVstk8BQaDQMwStYVNAvFWXn5aBBjVo5gMge4icGymYpFGAFMrElNa7yN
 0QTPruhjxij+t1UgXhyyTYHQGl4O1PrLprQF8hiElaqYMDG/aE8tB3rDMseNmQWt+w3b
 Yh//0hs7aR6AeLAzc2gT6Tm2EejolYtC81dRTHTgG/5eMMVSn825A6rzWDXSB9tOZCPP
 Jz0Q==
X-Gm-Message-State: AA+aEWa04cYjI+fYKOpzDZWuBF7Ni3Bz27B8pctVBonGa+PL3pHb9ROJ
 5itmeCAyRuk/D8O++SnIdts=
X-Google-Smtp-Source: AFSGD/WxZ4IcuNxWN4j+rh7Aq3mWxu6pJ8Lpoa/c0wFDH/IuGFWf31LuiZSuMr/tUd+OWS8nEaOohw==
X-Received: by 2002:a81:9903:: with SMTP id q3mr23610201ywg.96.1544028432958; 
 Wed, 05 Dec 2018 08:47:12 -0800 (PST)
Received: from b58965-E6430.nxp.com ([177.221.114.206])
 by smtp.gmail.com with ESMTPSA id r20sm13324445ywa.13.2018.12.05.08.47.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 08:47:11 -0800 (PST)
From: marcofrk@gmail.com
To: shawnguo@kernel.org
Subject: [PATCH] ARM: dts: imx6qdl: Fix memory node duplication
Date: Wed,  5 Dec 2018 14:47:04 -0200
Message-Id: <20181205164704.21649-1-marcofrk@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_084725_173859_2D21A336 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: robh@kernel.org, marcofrk@gmail.com, kernel@pengutronix.de,
 Marco Franchi <marco.franchi@nxp.com>, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marco Franchi <marco.franchi@nxp.com>

Boards based on imx6qdl have duplicate memory nodes:
- One coming from the board device tree file: memory@
- One coming from the imx6qdl.dtsi file.

Fix the duplication by removing the memory node from
the imx6qdl.dtsi file and by adding 'device_type = "memory";'
in the board Device Tree.

Converted using the following command:
perl -p0777i -e 's/memory\@10000000 \{\n/memory\@10000000 \{\n\t\tdevice_type = \"memory\";\n/m' `find ./arch/arm/boot/dts -name "imx6*"``

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/boot/dts/imx6dl-apf6dev.dts          | 1 +
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts  | 1 +
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts  | 1 +
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts   | 1 +
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts   | 1 +
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 1 +
 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts    | 1 +
 arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi   | 1 +
 arch/arm/boot/dts/imx6dl-rex-basic.dts        | 1 +
 arch/arm/boot/dts/imx6dl-riotboard.dts        | 1 +
 arch/arm/boot/dts/imx6dl-ts4900.dts           | 1 +
 arch/arm/boot/dts/imx6dl-ts7970.dts           | 1 +
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts  | 1 +
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts  | 1 +
 arch/arm/boot/dts/imx6dl-wandboard.dts        | 1 +
 arch/arm/boot/dts/imx6q-apf6dev.dts           | 1 +
 arch/arm/boot/dts/imx6q-arm2.dts              | 1 +
 arch/arm/boot/dts/imx6q-ba16.dtsi             | 1 +
 arch/arm/boot/dts/imx6q-cm-fx6.dts            | 1 +
 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts     | 1 +
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi        | 1 +
 arch/arm/boot/dts/imx6q-display5.dtsi         | 1 +
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts       | 1 +
 arch/arm/boot/dts/imx6q-evi.dts               | 1 +
 arch/arm/boot/dts/imx6q-gk802.dts             | 1 +
 arch/arm/boot/dts/imx6q-gw5400-a.dts          | 1 +
 arch/arm/boot/dts/imx6q-h100.dts              | 1 +
 arch/arm/boot/dts/imx6q-kp-tpc.dts            | 1 +
 arch/arm/boot/dts/imx6q-marsboard.dts         | 1 +
 arch/arm/boot/dts/imx6q-mccmon6.dts           | 1 +
 arch/arm/boot/dts/imx6q-novena.dts            | 1 +
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi    | 1 +
 arch/arm/boot/dts/imx6q-pistachio.dts         | 1 +
 arch/arm/boot/dts/imx6q-rex-pro.dts           | 1 +
 arch/arm/boot/dts/imx6q-sbc6x.dts             | 1 +
 arch/arm/boot/dts/imx6q-tbs2910.dts           | 1 +
 arch/arm/boot/dts/imx6q-ts4900.dts            | 1 +
 arch/arm/boot/dts/imx6q-ts7970.dts            | 1 +
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts   | 1 +
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts   | 1 +
 arch/arm/boot/dts/imx6q-wandboard.dts         | 1 +
 arch/arm/boot/dts/imx6q-zii-rdu2.dts          | 1 +
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi        | 1 +
 arch/arm/boot/dts/imx6qdl-emcon.dtsi          | 1 +
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi         | 1 +
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi   | 1 +
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi  | 1 +
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi      | 1 +
 arch/arm/boot/dts/imx6qdl-icore.dtsi          | 1 +
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi      | 1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi  | 1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi     | 1 +
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi  | 1 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi      | 1 +
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi      | 1 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi        | 1 +
 arch/arm/boot/dts/imx6qdl-tx6.dtsi            | 1 +
 arch/arm/boot/dts/imx6qdl-udoo.dtsi           | 1 +
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi       | 1 +
 arch/arm/boot/dts/imx6qdl.dtsi                | 1 -
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts  | 1 +
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts         | 1 +
 73 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-apf6dev.dts b/arch/arm/boot/dts/imx6dl-apf6dev.dts
index 4a7f86de6c39..6632e99fbb68 100644
--- a/arch/arm/boot/dts/imx6dl-apf6dev.dts
+++ b/arch/arm/boot/dts/imx6dl-apf6dev.dts
@@ -55,6 +55,7 @@
 	compatible = "armadeus,imx6dl-apf6dev", "armadeus,imx6dl-apf6", "fsl,imx6dl";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
index 29940ba215a8..b16603f27dce 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
@@ -49,6 +49,7 @@
 	compatible = "fsl,imx6dl";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
index 240f3661469f..abb2a1b9ce08 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
@@ -49,6 +49,7 @@
 	compatible = "fsl,imx6dl";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
index ad7733662fe5..b87a85cd44ac 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
@@ -28,6 +28,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
index 64ed84e3c512..e71ad9062fd1 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
@@ -17,6 +17,7 @@
 	compatible = "fsl,imx6dl";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index d08e0402793b..d5f7a1703aae 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -55,6 +55,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts b/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
index 89384cb618f6..588286adee67 100644
--- a/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
+++ b/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
@@ -23,6 +23,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi
index 7d9888937f12..d7e72993eaf8 100644
--- a/arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi
@@ -17,6 +17,7 @@
 	compatible = "phytec,imx6dl-pfla02", "fsl,imx6dl";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-rex-basic.dts b/arch/arm/boot/dts/imx6dl-rex-basic.dts
index 3fb7f4ee2496..853e58defa9c 100644
--- a/arch/arm/boot/dts/imx6dl-rex-basic.dts
+++ b/arch/arm/boot/dts/imx6dl-rex-basic.dts
@@ -17,6 +17,7 @@
 	compatible = "rex,imx6dl-rex-basic", "fsl,imx6dl";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 8e51491e68cf..65c184bb8fb0 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -16,6 +16,7 @@
 	compatible = "riot,imx6s-riotboard", "fsl,imx6dl";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6dl-ts4900.dts b/arch/arm/boot/dts/imx6dl-ts4900.dts
index cc01a7a22e30..3d60cc725d9e 100644
--- a/arch/arm/boot/dts/imx6dl-ts4900.dts
+++ b/arch/arm/boot/dts/imx6dl-ts4900.dts
@@ -49,6 +49,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-ts7970.dts b/arch/arm/boot/dts/imx6dl-ts7970.dts
index 82435d5bf33f..5da6feba2e66 100644
--- a/arch/arm/boot/dts/imx6dl-ts7970.dts
+++ b/arch/arm/boot/dts/imx6dl-ts7970.dts
@@ -50,6 +50,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts b/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
index 738db4fc7702..c2946fbaa0dd 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
@@ -13,6 +13,7 @@
 	compatible = "wand,imx6dl-wandboard", "fsl,imx6dl";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts b/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
index 51de6b4bd7d8..6d1d863c2e3a 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
@@ -13,6 +13,7 @@
 	compatible = "wand,imx6dl-wandboard", "fsl,imx6dl";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
index b43454deaa1a..4a08d5a99452 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
@@ -13,6 +13,7 @@
 	compatible = "wand,imx6dl-wandboard", "fsl,imx6dl";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-apf6dev.dts b/arch/arm/boot/dts/imx6q-apf6dev.dts
index 5e72f81cdf8b..07a36bb8075b 100644
--- a/arch/arm/boot/dts/imx6q-apf6dev.dts
+++ b/arch/arm/boot/dts/imx6q-apf6dev.dts
@@ -55,6 +55,7 @@
 	compatible = "armadeus,imx6q-apf6dev", "armadeus,imx6q-apf6", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index 953a5b5a8ea4..baadcb7fe011 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -19,6 +19,7 @@
 	compatible = "fsl,imx6q-arm2", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index e903c488287b..adc9455e42c7 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -47,6 +47,7 @@
 
 / {
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 18ae4f3be6e3..cab9e92531c7 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -51,6 +51,7 @@
 	compatible = "compulab,cm-fx6", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts b/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
index ad12d76bbb89..e13acbbcdff4 100644
--- a/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
+++ b/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
@@ -23,6 +23,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-dhcom-som.dtsi b/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
index bbba0671f0f4..387801dde02e 100644
--- a/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
@@ -19,6 +19,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/imx6q-display5.dtsi
index 85232c7c36a0..83524bb99eb3 100644
--- a/arch/arm/boot/dts/imx6q-display5.dtsi
+++ b/arch/arm/boot/dts/imx6q-display5.dtsi
@@ -48,6 +48,7 @@
 	compatible = "lwn,display5", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index b3c6a4a7897d..ee8c38eee03b 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -30,6 +30,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index fcd257bc5ac3..c63f371ede8b 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -51,6 +51,7 @@
 	compatible = "uniwest,imx6q-evi", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/imx6q-gk802.dts
index 84d3540b3a97..ccc2487d47ca 100644
--- a/arch/arm/boot/dts/imx6q-gk802.dts
+++ b/arch/arm/boot/dts/imx6q-gk802.dts
@@ -20,6 +20,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index a8f70b4266ef..4038170369fc 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -61,6 +61,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index 714e09e04dcb..b8feadbff967 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -51,6 +51,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts b/arch/arm/boot/dts/imx6q-kp-tpc.dts
index 302d8d06e4cc..50fbf46d17c2 100644
--- a/arch/arm/boot/dts/imx6q-kp-tpc.dts
+++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
@@ -13,6 +13,7 @@
 	compatible = "kiebackpeter,imx6q-tpc", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-marsboard.dts b/arch/arm/boot/dts/imx6q-marsboard.dts
index dd763f205819..d8ccb533b6b7 100644
--- a/arch/arm/boot/dts/imx6q-marsboard.dts
+++ b/arch/arm/boot/dts/imx6q-marsboard.dts
@@ -48,6 +48,7 @@
 	compatible = "embest,imx6q-marsboard", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-mccmon6.dts b/arch/arm/boot/dts/imx6q-mccmon6.dts
index b7e9f38cec72..74d9824e920b 100644
--- a/arch/arm/boot/dts/imx6q-mccmon6.dts
+++ b/arch/arm/boot/dts/imx6q-mccmon6.dts
@@ -20,6 +20,7 @@
 	compatible = "lwn,mccmon6", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index fcd824dc485b..61347a545d6c 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -57,6 +57,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index fad858c30fe9..097f2c56c20b 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -17,6 +17,7 @@
 	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts b/arch/arm/boot/dts/imx6q-pistachio.dts
index a31e83cd07a3..5edf858c8b86 100644
--- a/arch/arm/boot/dts/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/imx6q-pistachio.dts
@@ -57,6 +57,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-rex-pro.dts b/arch/arm/boot/dts/imx6q-rex-pro.dts
index d6cae73b1927..aa3004eab06c 100644
--- a/arch/arm/boot/dts/imx6q-rex-pro.dts
+++ b/arch/arm/boot/dts/imx6q-rex-pro.dts
@@ -17,6 +17,7 @@
 	compatible = "rex,imx6q-rex-pro", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-sbc6x.dts b/arch/arm/boot/dts/imx6q-sbc6x.dts
index b7aa2f0b9f53..3129f727750f 100644
--- a/arch/arm/boot/dts/imx6q-sbc6x.dts
+++ b/arch/arm/boot/dts/imx6q-sbc6x.dts
@@ -13,6 +13,7 @@
 	compatible = "microsys,sbc6x", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index 505cba776a2d..279b15e9ae2e 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -60,6 +60,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-ts4900.dts b/arch/arm/boot/dts/imx6q-ts4900.dts
index e655107edc56..dce1e8671ebe 100644
--- a/arch/arm/boot/dts/imx6q-ts4900.dts
+++ b/arch/arm/boot/dts/imx6q-ts4900.dts
@@ -49,6 +49,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-ts7970.dts b/arch/arm/boot/dts/imx6q-ts7970.dts
index c615ac4feede..570bd3c309a6 100644
--- a/arch/arm/boot/dts/imx6q-ts7970.dts
+++ b/arch/arm/boot/dts/imx6q-ts7970.dts
@@ -50,6 +50,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-wandboard-revb1.dts b/arch/arm/boot/dts/imx6q-wandboard-revb1.dts
index be85b980bdfe..f6ccbecff92c 100644
--- a/arch/arm/boot/dts/imx6q-wandboard-revb1.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard-revb1.dts
@@ -13,6 +13,7 @@
 	compatible = "wand,imx6q-wandboard", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-wandboard-revd1.dts b/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
index fcfba28764d4..55331021d80c 100644
--- a/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
@@ -13,6 +13,7 @@
 	compatible = "wand,imx6q-wandboard", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-wandboard.dts b/arch/arm/boot/dts/imx6q-wandboard.dts
index fa36fe183fc0..0be548beef86 100644
--- a/arch/arm/boot/dts/imx6q-wandboard.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard.dts
@@ -13,6 +13,7 @@
 	compatible = "wand,imx6q-wandboard", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-zii-rdu2.dts b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
index 7da6dde9c857..0f0743db2779 100644
--- a/arch/arm/boot/dts/imx6q-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
@@ -50,6 +50,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 3dc99dd8dde1..8380f1b26826 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -49,6 +49,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 9332a31e6c8b..e3be453d8a4a 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -44,6 +44,7 @@
 / {
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
index bfd5f373921e..397e205551c4 100644
--- a/arch/arm/boot/dts/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
@@ -24,6 +24,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 17a7b9c083d0..d3609966b846 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -45,6 +45,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index b8044681006c..2ff377d0df7e 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -60,6 +60,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 629908fbaa32..68ab54351109 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -60,6 +60,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index a1a6fb5541e1..81b2fcf6eedf 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -60,6 +60,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 4e21b3849394..8e46a80f57a4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -75,6 +75,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index 81dae5b5bc87..dacc2a14d0e7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -52,6 +52,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index c5d95e8d2e09..a1066897be18 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -81,6 +81,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
index b5986efe1090..e8e36dfd0a6b 100644
--- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
@@ -114,6 +114,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index 368132274a91..9cb9a7439121 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -84,6 +84,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 3c52bdb453f3..6d21cc6a9d4b 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -94,6 +94,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 0e64016e765f..2ffb21dd89f2 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -43,6 +43,7 @@
 / {
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index c413f9c3540f..e4231331f04e 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -43,6 +43,7 @@
 / {
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index ba93026ecee8..1d1b4bd0670f 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -10,6 +10,7 @@
 
 / {
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index aaed37c73c29..7814f1ef0804 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -10,6 +10,7 @@
 
 / {
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index 29baf25ae5d0..7a85116ef1d2 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -11,6 +11,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 39200e5dc896..c3415aa348a2 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -11,6 +11,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0xF0000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index 572abd7499b1..ed53f07c6b7b 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -11,6 +11,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 98384a6c5d12..8b0e432099b5 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -13,6 +13,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index ed1aafd56973..1b50b01e9bac 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -16,6 +16,7 @@
 	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 38f94a1dddac..4402c0af62b1 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -12,6 +12,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 654cf2c9b073..8468216dae9b 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -50,6 +50,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 6e46a195b399..9ac9e1bdc812 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -13,6 +13,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index a98fb2564c63..c68cb90fd801 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -62,6 +62,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>; /* will be filled by U-Boot */
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 40d1b0d9faff..776bfc77f89d 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -32,6 +32,7 @@
 	};
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
index 38080c1dfaec..8752a4961c47 100644
--- a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
@@ -11,6 +11,7 @@
 
 / {
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 6d827b69ead0..84afc555606f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -16,7 +16,6 @@
 	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
diff --git a/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts b/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
index bcca5ac5fa51..08d8b78a2096 100644
--- a/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
+++ b/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
@@ -13,6 +13,7 @@
 	compatible = "wand,imx6qp-wandboard", "fsl,imx6qp";
 
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0x80000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
index 8c293e9f36a7..98bf7a6b2850 100644
--- a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
@@ -50,6 +50,7 @@
 
 	/* Will be filled by the bootloader */
 	memory@10000000 {
+		device_type = "memory";
 		reg = <0x10000000 0>;
 	};
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
