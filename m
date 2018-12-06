Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9E5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:58:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347BB20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u/1IVLCl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3BlfhLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347BB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=/mVgaJ8xiRenf7JxHwEM7aFsuqzDba/8gkruuStZCPI=; b=u/1
	IVLCluF4A1JA7RuNd/lm3uRbaljxVkbPm5VZp+ZaGB2f4CWrUxmbRoh50ygKxWKXnmy9/f1xigU+L
	GcBKkEhkHaRIxWQmP1oSFT9jhIp6fAiz4W9txctSVxaRSOVr3xqEdhk0Uqbi2RzPyhv3qufRJzeBc
	oyr9wz88XJd/PxBl7As8Bz+SX+Xlo39i5R+PjrMW+mZnAFxaq3RQpEHar0DedB9G4+j9mHtq4UB2S
	DwksqAiQjuSMrfMduMvekAbXD56waZUW/5VQcHkSa7NEkn6rriAIMpsH/WBmVn404+ARVyJgOhvHF
	KBlQDJSDvAZp1/kP6R8dfiYU+Y0rRxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqQP-00058O-SX; Thu, 06 Dec 2018 09:58:29 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqQD-0004xr-Nb
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:58:19 +0000
Received: by mail-wm1-x341.google.com with SMTP id a18so361282wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 01:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=kmeN4J5R9xs3mYXoP7Fp+Ey5CgaHJ7uOHwX9towS34Y=;
 b=Y3BlfhLgbisVYA/HIV/+Rab9fIIJD5TdZ8zHzsHH59V5T3VzZyqsiX8HjT3kG0TH8m
 T5U3jkD2uTSuFHxXKdFUFXitFt+8YK2r4HITacvlb4v16fW1JfXkvbRo1pJbFgYez0mV
 ip+dn+duTRTb/Ww/sm41Nwkvv5DDe4LLl1D8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kmeN4J5R9xs3mYXoP7Fp+Ey5CgaHJ7uOHwX9towS34Y=;
 b=OPuAcjl8lNbsU10/FJUjxYr9rAurGzFqrKEKf1+6CroCFDwV5pMUpi2FegI28dSqs9
 vqHBbuvkk8pk+A6nsl1wCkzqgPl7DvGEwVyNtjnkV9PZQSlzY5BezlbkJ2H/lSNlQZ1P
 gDtkdTN4gcDnbZh3wnKhwJ8Fhge9HTxfzHyuOXAC/bWeliPNdqWil793IemW8+WPZoBO
 MrKqFGTRlzOPe/i4Q5mMXjl01cV/6fBIKpE/IGXHuD/Y6e3xhaEtkcs/VDNIr0og2Zc/
 QnDnuJ6NiJwarn76Etn3Jh7lnMW2iRLvGc7K+9DA8JeGWvW0jbuoK/aSkRWFHnFBVbWx
 5J0g==
X-Gm-Message-State: AA+aEWYbS/nae7nA4iWBF0A9EvXinRpaOJNOiNdaGn3T5KwDij4Z1Z4s
 tLqs6OBzXr0KZIi1WCmrdViGkFm97xo=
X-Google-Smtp-Source: AFSGD/UAS+ctTUuZ5fzn8SLLW5HTTPbxllBO1zOY8iCFJsTGXrsmCvCs6V+4YBhd5SkwX5aNhS3Unw==
X-Received: by 2002:a1c:8fc2:: with SMTP id r185mr18702221wmd.54.1544090285865; 
 Thu, 06 Dec 2018 01:58:05 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:100a:b939:11c3:94f9:a500:590])
 by smtp.gmail.com with ESMTPSA id i13sm16527677wrw.32.2018.12.06.01.58.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 06 Dec 2018 01:58:05 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: alexandre.torgue@st.com,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Subject: [PATCH] ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
Date: Thu,  6 Dec 2018 10:57:57 +0100
Message-Id: <20181206095757.16363-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_015817_792521_DBCDECAF 
X-CRM114-Status: GOOD (  11.04  )
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
Cc: devicetree@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>,
 linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Declare hwspinlock device for stm32mp157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index f8bbfff5950b..2bd4394fd791 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -886,6 +886,14 @@
 			status = "disabled";
 		};
 
+		hsem: hwspinlock@4c000000 {
+			compatible = "st,stm32-hwspinlock";
+			#hwlock-cells = <1>;
+			reg = <0x4c000000 0x400>;
+			clocks = <&rcc HSEM>;
+			clock-names = "hwsem";
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
