Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77144C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:59:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449CF21927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rkUrv01k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449CF21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1nbh+/VtBe14ixKkcrwOn9/DxJSApPm80vMpOIxOOI8=; b=rkUrv01kIRvNIg
	Z0Js2onGc2VQRHNqjqVFDTR0zDkEVdHWe0M3fGe8sDPk4x9WcXJz87HYSO7XTv1fTiKM7lqMtHEvM
	KYBHCaAZp7xfP9Jo96T7cWDixsY1NQBkhSTwumVWkg8al70SptyWnAPPrUoaW4b/kmTdbv1Dxyi5E
	MiC7PXkYAp7JdKsRuYS7AYULyyZ7oXHQuL+OxqvsxIkJjYxbZuxIm8t45FxErlyFjOc+vnXwXWITc
	dB5Gn8mtkGMHHeiYqZ+6Vga59aDNmwyN8t5h12F/eecf8uP4myX76hO5G0cvpAqys5Ui7VAsxmYT5
	v9FEk6hhPNgixl59Enqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guftq-0002JC-CS; Fri, 15 Feb 2019 15:59:38 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guftA-0001gc-Kg
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:59:00 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1FFuZlU000922; Fri, 15 Feb 2019 16:58:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qmy1njc1e-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 15 Feb 2019 16:58:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D454C34;
 Fri, 15 Feb 2019 15:58:50 +0000 (GMT)
Received: from Webmail-eu.st.com (gpxdag5node5.st.com [10.75.127.78])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E84F599E;
 Fri, 15 Feb 2019 15:58:50 +0000 (GMT)
Received: from localhost (10.75.127.49) by GPXDAG5NODE5.st.com (10.75.127.78)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Fri, 15 Feb 2019 16:58:49 +0100
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@st.com>
Subject: [PATCH v1 3/3] ARM: dts: stm32: enable Vivante GPU support on
 stm32mp157c-dk1 board
Date: Fri, 15 Feb 2019 16:58:36 +0100
Message-ID: <1550246316-9747-4-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To GPXDAG5NODE5.st.com
 (10.75.127.78)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-15_12:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075857_623706_358447E1 
X-CRM114-Status: UNSURE (   9.78  )
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
Cc: devicetree@vger.kernel.org, Philippe Cornu <philippe.cornu@st.com>,
 Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable Vivante GPU driver for stm32mp157c-dk1 and dk2 boards.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 873a80e..fb2ee06 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -27,6 +27,17 @@
 		reg = <0xc0000000 0x20000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gpu_reserved: gpu@dc000000 {
+			reg = <0xdc000000 0x4000000>;
+			no-map;
+		};
+	};
+
 	led {
 		compatible = "gpio-leds";
 		blue {
@@ -57,6 +68,11 @@
 	};
 };
 
+&gpu {
+	contiguous-area = <&gpu_reserved>;
+	status = "okay";
+};
+
 &iwdg2 {
 	timeout-sec = <32>;
 	status = "okay";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
