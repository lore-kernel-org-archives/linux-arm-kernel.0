Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF22C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:43:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E1220660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l1NWTuUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E1220660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CrzzIOpHlV8jrPzEbdGldXdUqwG6Hip9mysqFcrrPRo=; b=l1NWTuUWf7mfHw
	5Pd+cdfCmBa6UglzUi4g0KGD/PNBMjPVJDpPQ6VeibnDtPQzG7peP4fCovUYE3xIkqkONnks/5Bax
	LuBu7I4o1azIzyz68Sr+B+uSV2jzvMgWepbJ6LZO6SnHTOub2uCOnaFmQd3+SdyQf4F1m5Eq59lI4
	SHOFnHdO7T5xC+kknXaC/ViGsvqWgCvm1DEnC+BV4QXC49lY63q2I7XnofEbzlwsePKtOnr7WoB4f
	hi3zDTBHfaYLtqbWIyQdFynNV0IOPbXQjVrEdHiZppra5555ERI5mxzYRF0bbHtsSSepYYsDuBiu4
	75V2+ZrWfSLUroodCtvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghE8O-0006gB-W4; Wed, 09 Jan 2019 13:43:04 +0000
Received: from mxout012.mail.hostpoint.ch ([2a00:d70:0:e::312])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghE7u-0006CE-QX
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:42:38 +0000
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
 by mxout012.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1ghE7p-000DHv-5n; Wed, 09 Jan 2019 14:42:29 +0100
Received: from 252.222.41.212.static.wline.lns.sme.cust.swisscom.ch
 ([212.41.222.252] helo=philippe-pc.toradex.int)
 by asmtp012.mail.hostpoint.ch with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1ghE7o-0006KA-WC; Wed, 09 Jan 2019 14:42:29 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From: Philippe Schenker <dev@pschenker.ch>
To: jic23@kernel.org,
	marcel.ziswiler@toradex.com,
	stefan@agner.ch
Subject: [PATCH v6 7/8] ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules
Date: Wed,  9 Jan 2019 14:42:06 +0100
Message-Id: <20190109134208.5660-8-dev@pschenker.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109134208.5660-1-dev@pschenker.ch>
References: <20190109134208.5660-1-dev@pschenker.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_054234_853878_2105D12E 
X-CRM114-Status: GOOD (  10.54  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, robh@kernel.org,
 alexandre.torgue@st.com, devicetree@vger.kernel.org, lee.jones@linaro.org,
 Sascha Hauer <s.hauer@pengutronix.de>, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 NXP Linux Team <linux-imx@nxp.com>, mcoquelin.stm32@gmail.com,
 Fabio Estevam <fabio.estevam@nxp.com>, digetx@gmail.com, shawnguo@kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add the stmpe-adc DT node as found on Toradex iMX6 modules

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v6:
 - Just realized that the comment for st,norequest-mask was at the wrong
   place, fixed.

Changes in v5: None
Changes in v4:
 - Moved T30 devicetree settings to separate commit

Changes in v3:
 - None

Changes in v2:
 - Put common ADC settings in mfd

 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 ++++++++++++++--------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 23 +++++++++++++++--------
 2 files changed, 29 insertions(+), 16 deletions(-)

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
index 87e15e7cb32b..2e303d79c7f8 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -262,11 +262,18 @@
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
+		/* forbid to use ADC channels 3-0 (touch) */
 
 		stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
-			/* 3.25 MHz ADC clock speed */
-			st,adc-freq = <1>;
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
 			/* 7 length fractional part in z */
@@ -276,17 +283,17 @@
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
+			/* 3.25 MHz ADC clock speed */
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
