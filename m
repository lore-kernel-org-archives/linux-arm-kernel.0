Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4E0C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:39:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D53F21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qp9SK/3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D53F21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ymKhkV9YFm0yBftjLmUEzCF4pPIeFX7tOQTvb7Qbbrk=; b=qp9SK/3VqpzIP6
	UWL8H1mUlctD1aOuTDbATe2+aWa+35HO6R7oWrFnzhvjzwtq+awOV0zoRvOUlHZacwOWzt2/3SchN
	JUSz6tuthdjbPUxWor183+wCR0SGSLBKrp0r336NwAbjOHM5y9nCcjwntxjomBVV+n2ZazuQmr1Nw
	ef908kBjLbuAKKaQXjFKQ0nRLD9Vp0Oc8Go5ViznkixhY/1jSdL91Q0RZsGxil1KUTl48/YfBire3
	v4Gznv8kXZH4VNwrYxOBtqZvFWDjsjQ1GaPtBk2Y842tBio3tLGCF3MiEetl8aWgcPJhmGoirG0CV
	SVhVbwZyD8BpgK+06BVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gostO-0004Pd-EV; Wed, 30 Jan 2019 16:39:14 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gostJ-0004O0-Tf
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:39:11 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0UGQxRi005461; Wed, 30 Jan 2019 17:39:01 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2q8dw3aapn-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 30 Jan 2019 17:39:01 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D24338;
 Wed, 30 Jan 2019 16:39:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 06274A71D;
 Wed, 30 Jan 2019 16:39:01 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Wed, 30 Jan 2019 17:39:00 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
 <alexandre.torgue@st.com>
Subject: [PATCH 1/4] dt-bindings: nvmem: Add STM32 factory-programmed romem
Date: Wed, 30 Jan 2019 17:38:53 +0100
Message-ID: <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-30_12:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_083910_245844_24E08161 
X-CRM114-Status: GOOD (  10.76  )
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
Cc: mark.rutland@arm.com, lionel.debieve@st.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
 fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add documentation for STMicroelectronics STM32 Factory-programmed
read only memory area.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
new file mode 100644
index 0000000..fbff52e
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
@@ -0,0 +1,31 @@
+STMicroelectronics STM32 Factory-programmed data device tree bindings
+
+This represents STM32 Factory-programmed read only non-volatile area: locked
+flash, OTP, read-only HW regs... This contains various information such as:
+analog calibration data for temperature sensor (e.g. TS_CAL1, TS_CAL2),
+internal vref (VREFIN_CAL), unique device ID...
+
+Required properties:
+- compatible:		Should be one of:
+			"st,stm32-romem"
+			"st,stm32mp15-bsec"
+- reg:			Offset and length of factory-programmed area.
+- #address-cells:	Should be '<1>'.
+- #size-cells:		Should be '<1>'.
+
+Optional Data cells:
+- Must be child nodes as described in nvmem.txt.
+
+Example on stm32f4:
+	romem: nvmem@1fff7800 {
+		compatible = "st,stm32-romem";
+		reg = <0x1fff7800 0x400>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* Data cells: ts_cal1 at 0x1fff7a2c */
+		ts_cal1: calib@22c {
+			reg = <0x22c 0x2>;
+		};
+		...
+	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
