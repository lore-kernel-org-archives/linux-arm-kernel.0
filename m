Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCF8C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25D220672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rc1nhpwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25D220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uNMOKOiVQb6ypI7vhVIqQEad4v6sVc/icIhQfQPuhBk=; b=Rc1nhpwUr0q/GC
	MvaAo3c9+XItd+/4q7HK/HyZorGZCzVLulq/Rj7Pmi0c4uKZhT2OrE/mqu7DfUH/0hSQ/3AovavP0
	siMkN6+TLyP6gKyOaYAfYp/UzL9qla+UROz0PbgNr3uSxxY42aXXtl8I5kV/PF30XpkJjMFYf/Jd3
	wpQrMAzaY9ijG6AQVD9OxKMTSnZSv21BjHx8NTNrwxFZy1aVyRZcFFzjccaNjGlrD4TB4oN2ET4b4
	SL171madvHSu1XFOuiPGfAkVUO/ml8rmcdLK3Ka85VPGqcX5MTcJRNuUQnntiJ8p9ENhr3S7iJFKi
	5/AoiLYi3rg9Nrbho+Wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqbF-0000yn-Dq; Thu, 06 Dec 2018 10:09:41 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqb8-0000mm-Hv
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:09:38 +0000
Received: by mail-qk1-f196.google.com with SMTP id o89so13710729qko.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=ydbINwojpYRSXY/r/4xdFQC3b7eWc6o2T8B/MVbGzqg=;
 b=JpP9r5WlU4wzmFpmhU8SQkNa4akwrq0mpH8YT9IX7Ewudv9xqDwqxgdmX2jl3a5hbD
 2/whM5pltQCB/hqOinGGL8qdiujAh1g4rWB84CKjLJ2sBjfmbWAM72zFpZTuro6G7Qux
 VyUIFz/+Pd+hA3h4L7GPvZvKmsfheid8ntfaM74PdZTUV1vNUb06NTq0ORua2cWk0B5Q
 pXJBZLRjoEK6TA6Vrlri9S/95CUXghNYwegFlTHZqSAdO2uKKNYMmnWTBoyJi/SP4cZc
 g2jl3R4dx8RsXqbmayrw/6ZfKP+WT9+fm45XstjisXNT6+jF9ktOM1G8vHci1JD4z4CB
 +uFw==
X-Gm-Message-State: AA+aEWZ4UnFA4Xxhs2g5vUBXuvMxKiMXgBVn/7Awz5jfCosLW7S0Rc4/
 B/1ACFhIzC3WzlAycdld82Wzwyse
X-Google-Smtp-Source: AFSGD/WetsjPRoF/iNM53Ts96TKT9tS1KQKgLlwX3lBOVgnV3f3DHpM1cr3sqK6DgjgL726q+pzJ9A==
X-Received: by 2002:a37:4f8a:: with SMTP id d132mr25033506qkb.17.1544090963145; 
 Thu, 06 Dec 2018 02:09:23 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id k6sm16111395qtk.41.2018.12.06.02.09.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 02:09:22 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 06 Dec 2018 08:09:15 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/9] ARM: dts: imx7d-pico: Do not harcode the memory size
Date: Thu,  6 Dec 2018 08:08:57 -0200
Message-Id: <20181206100905.15053-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_020934_943239_735642D3 
X-CRM114-Status: GOOD (  15.06  )
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
 Otavio Salvador <otavio@ossystems.com.br>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

Currently the memory size described in dts is 2GB, which is incorrect.

There are 512MB and 1GB versions of imx7d-pico boards, so remove
the hardcoded memory size and let the bootloader pass the correct
value to the kernel.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/imx7d-pico.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 934a019f341e..0df68e53e9fa 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -48,9 +48,10 @@
 	model = "Technexion Pico i.MX7D Board";
 	compatible = "technexion,imx7d-pico", "fsl,imx7d";
 
+	/* Will be filled by the bootloader */
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0x80000000 0x80000000>;
+		reg = <0x80000000 0>;
 	};
 
 	reg_ap6212: regulator-ap6212 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
