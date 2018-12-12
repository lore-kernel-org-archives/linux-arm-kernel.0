Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE8FC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:48:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF13E20839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c4/1lSKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF13E20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mhhFjA88P8j/pGM0z2NkGhCqOViTusv7PrYtDu9cKi4=; b=c4/1lSKjiaAvJP
	mK6yK2/h1w+1UXWtIbfs5BN5XRTKQSq3XGMQSx8EKa3mZht+VYb+fHUimp41j1Hmhfg5qQmqabLu4
	yUqYTBnDexmJKcFxGkvgmGdxVplvW1Bok8o0VSDP8s68lNeLcrJKgB/RCc2NH0fAv1XzWodjsBUE7
	AjkqoQcpS8jYYGaTJ4MCeGa6v6mxBLc4WCOv3u6crYT1mS2sKMBaxdHg3Mw7zuuvIH43Qi8dRaRTI
	leYVnGbxS22xaoyL7lJUzMM1kn9RbJ8Vc+5XeiDoNkuqfTsQ51HP0BlMS9pD0cOSqlgwRxTEyEoNG
	XZAn0N/rA1tf/I0FQpcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX0CG-0007iH-Qm; Wed, 12 Dec 2018 08:48:48 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX0CD-0007gU-1a
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 08:48:47 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBC8kD7l031600; Wed, 12 Dec 2018 09:48:29 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p85qk5pt1-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 12 Dec 2018 09:48:29 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49C9731;
 Wed, 12 Dec 2018 08:48:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2501C275D;
 Wed, 12 Dec 2018 08:48:28 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Wed, 12 Dec 2018 09:48:27 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
Subject: [PATCH v2 1/3] dt-bindings: stm32: syscon: add clock support
Date: Wed, 12 Dec 2018 09:48:13 +0100
Message-ID: <1544604495-4082-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-12_02:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_004845_427621_E8FFA058 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, gabriel.fernandez@st.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

STM32 system configuration controller registers needs to be clocked.
Document clock support on stm32-syscon.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- move clocks to specific bindings using syscon as per Rob's comment
---
 Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt b/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
index 99980ae..c92d411 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
@@ -5,10 +5,12 @@ Properties:
                  - " st,stm32mp157-syscfg " - for stm32mp157 based SoCs,
                  second value must be always "syscon".
    - reg : offset and length of the register set.
+   - clocks: phandle to the syscfg clock
 
  Example:
          syscfg: syscon@50020000 {
                  compatible = "st,stm32mp157-syscfg", "syscon";
                  reg = <0x50020000 0x400>;
+                 clocks = <&rcc SYSCFG>;
          };
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
