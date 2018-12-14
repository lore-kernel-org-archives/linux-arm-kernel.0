Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5245C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2070206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tD2Q2PZR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNHHszyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2070206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZuSzFZ0lqq9k0psQ+oQrtGclFPRwkjtF+3nYBBhW6D0=; b=tD2Q2PZRgyNmKvA3HWLikrcRwZ
	aI9HBGBStpii1mBEuUN8gyrKAoFfqY8jJRPxtsh3NL8vCVHHbPiv4JjYY1EtdmTDDcHN4ott2gptU
	R3a/KG+E9IMCbAkjAVprdQmlEapx8yINuj8UxwOFJjNmhUE8vo5YCd5gM7A7Kj5q+5zvfSHu7A6VG
	yTAzTMlQLESghCM5sV4uiaVd6SlWt0xq5qRu0VX7ksq2rbjpHsstUCO9V4eFNt3dZFa34nZsRH4vJ
	QDWYgNr1YADI1Xpq1a34bI6/8AnGf9OJJnn9nCak9dq4Nl8wiCNlyCvgmn9ryRJhdFBx7BhOOIaJh
	qYjAZ4FA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp8k-00014G-Gf; Fri, 14 Dec 2018 15:12:34 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp82-0000LV-Vg
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:11:54 +0000
Received: by mail-wr1-x444.google.com with SMTP id r10so5749646wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=auUSZFGFdGybS+YYFDRiniv29seLWmCuXr51Wi5g/uk=;
 b=NNHHszyhil0vep2OuKhPJ4YXwMqVoivDPKelCo7LbHUvfswVhqEFu6nXtYYXaBUUPy
 ZaOWMVO33M9VfvtSZVaATUZfOgQ3XfoeDXDUPZ8TK1syCAQ8zkjMwE1AamAF4OzXjJE1
 dpZfPJxEb3vtx+Vlv0DABxGUC1SPJEFe5jQnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=auUSZFGFdGybS+YYFDRiniv29seLWmCuXr51Wi5g/uk=;
 b=C4Y0FdMbXM75wmeVUyuAyaNj8ZPelRaAPodMjye4egSYLfnwMFpITQOJMf+RuKI20i
 0ZZPpZn7a/rlbbI5ZuU+eQGftRJdSC5HhqUAh3VrvWbYTi8cnpVnoem4SjolNeOHvL7E
 iBwMCqcECqfIh7WUXuLRl6qeVa8AMnsVbCkv+NsTDRMg9psS6sEGzPfXXgAs+JoRr3Es
 B41Nzgz/5NSrEJmhjoFZDj8/awGgJ4/xoRkqfxKlKfE8lTdHMF+WvafVCXxLCFb5b9gk
 G316kFWhh4cC6XAyXj5NYVm894LUm1YV8tXDQWAreI+iW5tJ1FUEdH2jhGHU4P4rWooN
 svig==
X-Gm-Message-State: AA+aEWbnS9u8IOGHQ4/lzlyrmimGt4gBXS5K1Gw/C607i3MIZpIVTQMf
 s8QAkXEN7ryJcyMFGKzWoOB47Q==
X-Google-Smtp-Source: AFSGD/W3NGU0hC84t8J7pRTbdkLoTlCyVJb3MJzJnZC9MCb7KNuHslAz3T1WVNHyYfwjqDBo2UmTrA==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr3041021wrs.117.1544800298961; 
 Fri, 14 Dec 2018 07:11:38 -0800 (PST)
Received: from lmecxl0911.lme.st.com
 ([2a04:cec0:113f:f362:2090:a70c:c5c6:347e])
 by smtp.gmail.com with ESMTPSA id i13sm3381567wrw.32.2018.12.14.07.11.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 14 Dec 2018 07:11:38 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
 robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com
Subject: [PATCH v2 2/2] ARM: dts: stm32: Add hwlock for irqchip on stm32mp157
Date: Fri, 14 Dec 2018 16:11:28 +0100
Message-Id: <20181214151128.10005-3-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181214151128.10005-1-benjamin.gaignard@linaro.org>
References: <20181214151128.10005-1-benjamin.gaignard@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_071151_622044_CE8E9B79 
X-CRM114-Status: GOOD (  12.20  )
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
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Define a hwspinlock to be used by irq controller

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 8bf1c17f8cef..cac0af371082 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -815,6 +815,7 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x5000d000 0x400>;
+			hwlocks = <&hsem 1>;
 		};
 
 		syscfg: syscon@50020000 {
-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
