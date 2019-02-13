Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4829FC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:51:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1713921925
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tEtaV5xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1713921925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eru+dSbJLOP9UTjGkpoxgKvKh6KbJVaWjJ1Zggecnns=; b=tEtaV5xVoGpDtE
	2T+nm2b44o0a+eILzjWJL3PSZR+GmynXF3na+5M+1jF2CFKjSYHfHEa7RwkCX9UV/nzC+HLqgEQc+
	+A5ToBBbRGOfip4u8kg1ljdMj6E8TK+3q/0/ZV4csXz6G4N09RSRtq5m8RlMX2tzKnikA9LFiKHAY
	gU28TcJEhIiRMU8tUtGYRRJR8VFJd+JTOd9X9asdZ8pLmma90B35FpjAuCem2ZXFSfN4ZCL/naeVK
	ilr5qgVQgUyQDyiO6CnzSQbWP59zqPtgUT4euP/Vrfu9UbJxuIQ3ZMbvE4zzaRPzDFrkoifEZj0Xp
	/eZAPYo6k/6yl6v3mktw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gts83-0001vr-T2; Wed, 13 Feb 2019 10:50:59 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gts7o-0001fG-Gh
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 10:50:47 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1DAkvNf020737; Wed, 13 Feb 2019 11:50:39 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qjfy6akcj-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 13 Feb 2019 11:50:39 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 71B6A38;
 Wed, 13 Feb 2019 10:50:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E8E9F4EE5;
 Wed, 13 Feb 2019 10:50:36 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Wed, 13 Feb 2019 11:50:36 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: pwm-stm32-lp: document pinctrl sleep state
Date: Wed, 13 Feb 2019 11:50:10 +0100
Message-ID: <1550055012-23348-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-13_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_025044_836215_37CB453A 
X-CRM114-Status: GOOD (  10.75  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 tduszyns@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de,
 fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add documentation for pinctrl sleep state on STM32 LPTimer PWM.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
index bd23302..6521bc4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
@@ -11,8 +11,10 @@ Required parameters:
 			bindings defined in pwm.txt.
 
 Optional properties:
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		Phandle pointing to pin configuration node for PWM.
+- pinctrl-names: 	Set to "default". An additional "sleep" state can be
+			defined to set pins in sleep state when in low power.
+- pinctrl-n: 		Phandle(s) pointing to pin configuration node for PWM,
+			respectively for "default" and "sleep" states.
 
 Example:
 	timer@40002400 {
@@ -21,7 +23,8 @@ Example:
 		pwm {
 			compatible = "st,stm32-pwm-lp";
 			#pwm-cells = <3>;
-			pinctrl-names = "default";
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&lppwm1_pins>;
+			pinctrl-1 = <&lppwm1_sleep_pins>;
 		};
 	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
