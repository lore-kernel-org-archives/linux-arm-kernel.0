Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA95C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:47:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE2620866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TYdteU/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE2620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zj6QEyEZKE7F+i5XRPDWV5nxHdCH50yAJEo0/bG/suI=; b=TYdteU/JDh6wDA
	9YRkBLnbRTQO6iDoB4DiWD3nVHu7rvgCc9smazODhI8OSSpxlGrbjmNnzSvjyZ276XqgJRWVLIdtG
	DjFyjHfHkp0B6Xfb/6kZtbVZWM2ab4FzMditd9gK2Haqzf7NFeKgEn1xl4AtgDorRTnSs1bwU/mwE
	0T/Dn/FL6mzIPvA852KcFHP+keHh8nJh6bgKi7hEe9oCbEl0L9NHsdbcSQFZiH7vXdd2a9GnVOzxe
	ucq5KG1mmKJeSccEv0hKbnvp4tUX5XxE9V4WfZXChWpqmNHLMuRpKzFb+AMvedYxeW1cW7YlFk6Yw
	k/JM6KXLBhV65JmxZqBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaL97-00048a-Di; Fri, 21 Dec 2018 13:47:21 +0000
Received: from mxout017.mail.hostpoint.ch ([2a00:d70:0:e::317])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaL8w-0003yD-F1
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 13:47:12 +0000
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
 by mxout017.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1gaL8g-0005bs-KB; Fri, 21 Dec 2018 14:46:54 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
 by asmtp013.mail.hostpoint.ch with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1gaL8g-000BCi-E0; Fri, 21 Dec 2018 14:46:54 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From: Philippe Schenker <dev@pschenker.ch>
To: jic23@kernel.org,
	marcel.ziswiler@toradex.com,
	stefan@agner.ch
Subject: [PATCH v5 7/8] ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules
Date: Fri, 21 Dec 2018 14:46:36 +0100
Message-Id: <20181221134638.20600-8-dev@pschenker.ch>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221134638.20600-1-dev@pschenker.ch>
References: <20181221134638.20600-1-dev@pschenker.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_054710_501452_0E3E645E 
X-CRM114-Status: GOOD (  10.68  )
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
 linux-arm-kernel@lists.infradead.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, digetx@gmail.com, shawnguo@kernel.org,
 coquelin.stm32@gmail.com, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add the stmpe-adc DT node as found on Toradex iMX6 modules

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

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
index 3dc99dd8dde1..8db476d8978d 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -331,11 +331,18 @@
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
@@ -345,17 +352,16 @@
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
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
