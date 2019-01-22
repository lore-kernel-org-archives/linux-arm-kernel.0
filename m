Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C0EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:23:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C52221019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ndSjhPZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C52221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dX/auAUR1KiSFo1z1re52J+Cco42XryY1v0ZkFqEglo=; b=ndSjhPZzlpnSYD
	5fp8bRt3QFDI/We/rTdPxliuZnvSdO1HtaEI+WiLxK4GRRucbiRvE8yzQ/UpbYSb2vg6IYjVrGaMh
	Fncb9TbRwxnvq+jyVAbzVO1uYhg9AutvgjSsnxa3gVKR5H6g7fUSxJKPUklEt+wcjnxTvUu/+7W3O
	SkqwAP4vq7yzo0OltOlTWpblBxokRF6fOJObHy+RjgQrW05XgRaD5/Nq+k26a17t6gqhdtz0tZFYd
	cpbKIht6Ti68EzakWtsT3qurS0H3joqdHsB3y6y/PYJTgwAG8Nls0MfAm3CAXBVywDnowbf8+bc/r
	P/xPNxaXaLkpFUg4Ii9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glw1E-0004af-L5; Tue, 22 Jan 2019 13:23:08 +0000
Received: from mxout017.mail.hostpoint.ch ([2a00:d70:0:e::317])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glw05-0003Uq-SE
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:22:00 +0000
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
 by mxout017.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1glvzx-000IW6-Hg; Tue, 22 Jan 2019 14:21:49 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
 by asmtp012.mail.hostpoint.ch with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1glvzx-0001Dy-DC; Tue, 22 Jan 2019 14:21:49 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From: Philippe Schenker <dev@pschenker.ch>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules
Date: Tue, 22 Jan 2019 14:21:34 +0100
Message-Id: <20190122132135.5012-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122132135.5012-1-dev@pschenker.ch>
References: <20190122132135.5012-1-dev@pschenker.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_052158_404282_FA8A34F9 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>, marcel.ziswiler@toradex.com,
 linux-kernel@vger.kernel.org, stefan@agner.ch,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 max.krummenacher@toradex.com, Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add the stmpe-adc DT node as found on Toradex iMX6 modules

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 ++++++++++++++--------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 22 ++++++++++++++--------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 8380f1b26826..e8c7ef7e078a 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -332,11 +332,17 @@
 		id = <0>;
 		blocks = <0x5>;
 		irq-trigger = <0x1>;
+		/* 3.25 MHz ADC clock speed */
+		st,adc-freq = <1>;
+		/* 12-bit ADC */
+		st,mod-12b = <1>;
+		/* internal ADC reference */
+		st,ref-sel = <0>;
+		/* ADC converstion time: 80 clocks */
+		st,sample-time = <4>;
 
 		stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
-			/* 3.25 MHz ADC clock speed */
-			st,adc-freq = <1>;
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
 			/* 7 length fractional part in z */
@@ -346,17 +352,17 @@
 			 * current limit value
 			 */
 			st,i-drive = <1>;
-			/* 12-bit ADC */
-			st,mod-12b = <1>;
-			/* internal ADC reference */
-			st,ref-sel = <0>;
-			/* ADC converstion time: 80 clocks */
-			st,sample-time = <4>;
 			/* 1 ms panel driver settling time */
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
 		};
+
+		stmpe_adc {
+			compatible = "st,stmpe-adc";
+			/* forbid to use ADC channels 3-0 (touch) */
+			st,norequest-mask = <0x0F>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 87e15e7cb32b..eb8603a2444e 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -262,11 +262,17 @@
 		id = <0>;
 		blocks = <0x5>;
 		irq-trigger = <0x1>;
+		/* 3.25 MHz ADC clock speed */
+		st,adc-freq = <1>;
+		/* 12-bit ADC */
+		st,mod-12b = <1>;
+		/* internal ADC reference */
+		st,ref-sel = <0>;
+		/* ADC converstion time: 80 clocks */
+		st,sample-time = <4>;
 
 		stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
-			/* 3.25 MHz ADC clock speed */
-			st,adc-freq = <1>;
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
 			/* 7 length fractional part in z */
@@ -276,17 +282,17 @@
 			 * current limit value
 			 */
 			st,i-drive = <1>;
-			/* 12-bit ADC */
-			st,mod-12b = <1>;
-			/* internal ADC reference */
-			st,ref-sel = <0>;
-			/* ADC converstion time: 80 clocks */
-			st,sample-time = <4>;
 			/* 1 ms panel driver settling time */
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
 		};
+
+		stmpe_adc {
+			compatible = "st,stmpe-adc";
+			/* forbid to use ADC channels 3-0 (touch) */
+			st,norequest-mask = <0x0F>;
+		};
 	};
 };
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
