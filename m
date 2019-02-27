Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7683FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:37:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4060D213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I6ZXW+0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4060D213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C56kAeYynaq/FlXAxZuFPoQrdnZ5drLVZUEIGhgs1TM=; b=I6ZXW+0lHLeeht
	xet66xq60OoKvG+90TRka+fwqJQzvpiC+mkAuiXSQdLFgRqJwWO1oe+yq6MOVzvolYEPN5fFOZ5I1
	cUD50bzai+5AF69k7Hv2xnaza/aFocxh+sf4v+ArEqTE5SvwHv16QH7vuZRYDL/g1HaY7liHQphxt
	75XBc6VmcX1jbLGvTq9FsuQSfl+w3+jv394uh5bDc8Gaetc8Z+6FX7rlQ6smSH6z4R2fIcR4qv3uE
	O9HnjGg+10jy9W9jI2iOOyByP0CWqBa4w8/E5vWsefgvd9kC67Zh/gdFWs19V88DKOg7WrNHSG5bQ
	Lc2SxbYp8IhDZGpQhBFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyveB-0005bv-DP; Wed, 27 Feb 2019 09:37:03 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyvcZ-0003bQ-3R
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 09:35:29 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1R9XlY5000487; Wed, 27 Feb 2019 10:35:18 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qtv6cx2xx-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 27 Feb 2019 10:35:18 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74F2134;
 Wed, 27 Feb 2019 09:35:17 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 577F12BF7;
 Wed, 27 Feb 2019 09:35:17 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb
 2019 10:35:17 +0100
Received: from localhost (10.201.20.5) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1;
 Wed, 27 Feb 2019 10:35:16 +0100
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>
Subject: [PATCH v4 8/9] ARM: dts: stm32: add STMFX support on stm32mp157c-ev1
Date: Wed, 27 Feb 2019 10:34:53 +0100
Message-ID: <1551260094-32570-9-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_013523_845953_12FC6381 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: devicetree@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds support for STMicroelectronics Multi-Function eXpander
(STMFX) on stm32mp157c-ev1. It is connected on i2c2.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 063ee8a..3a6f033 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -99,6 +99,22 @@
 	i2c-scl-rising-time-ns = <185>;
 	i2c-scl-falling-time-ns = <20>;
 	status = "okay";
+
+	stmfx: stmfx@42 {
+		compatible = "st,stmfx-0300";
+		reg = <0x42>;
+		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&gpioi>;
+
+		stmfx_pinctrl: stmfx-pin-controller {
+			compatible = "st,stmfx-0300-pinctrl";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&stmfx_pinctrl 0 0 24>;
+		};
+	};
 };
 
 &i2c5 {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
