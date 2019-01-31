Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:10:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C3820823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b4HtDDX9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dTLgm58J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VACCNkOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C3820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mQnozD8v3/hzxdhSJmU7cqkSvCYbfeSxEqUTdDTfeSQ=; b=b4HtDDX9IYrELx
	/76G+nNw0YcJzHVehky2zXxz9Y3/zA+QE4GFFiR8U82Sqi7m7l29bA+TzBlDhjKqwxoGlY6Xe5Pep
	JlnysGjWX0gOEcoFa4wdamXZnDH9qsPuV1tJuYIam0JCdMAXNiCSWTqI1KLqkWRwHGOc8HqKZUbSA
	8hEmFsOf/3K2/TEPACSakyKhHx5qeXqRx0sKO4ly5QC7gcCKvW4AjovLOHhCafKzjkMY+tftG+SH/
	yAHAZ6ciYsc8B97OI2353lfZ15xNvZ7h4wn5AhzU3KGCmTunt2tCuYYkeGjPwoHEL7jTBpMl4nWj9
	2nZCEz3TUIsAmQiQUEpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpJbj-0005KE-Ky; Thu, 31 Jan 2019 21:10:47 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpJbh-0005K3-PI
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 21:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k/d0qYjvUjOnhK3byzjqxMrsrkZAK3+9jUq6QNPQ6V0=; b=dTLgm58JWR+Q4MNFugViH+Nv93
 QtKngehVdJ42+KUzBpPG2bl9j6wD09nUKsWW0lHH+rgdy8grej40Fp1rL5TFGsZ6mdDSVzJufjCC1
 vMpLqs3LeCQupFRS9QmJXrDsTPBAQhbXNBhSB1Q0oKM5zPoze1nH5ugNw7gQNd3UOat9Ps7FXNSVL
 eNmtWX5CcuXqXxc04vcQo2zRkPfTW+4ewoRj7/nSiAspkl4voedh8rLI8zeHqCESxlYkKN86vCR77
 vtTExDHt3iolFlE1VRW9+zJCh5jc+i72Jjv71Zs9jh7IoNzxppVWJ/OBqcrgLJ50jpV8rSe2LR/xV
 Yq6Tt9QQ==;
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpJDN-0006uJ-5c
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 20:45:41 +0000
Received: by mail-pf1-x442.google.com with SMTP id c123so2037753pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 12:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k/d0qYjvUjOnhK3byzjqxMrsrkZAK3+9jUq6QNPQ6V0=;
 b=VACCNkOWHNp0gHVNgItfZ7UJZZHmj+kQXl8MMDgurV6S5VvSoewKO2Gq6vDw9wIh50
 BDrIkbmIwNNwHPyeWBu+TeIEOzPZbhkpa4OY7GSCWwlwICeHALDKN6hbX5dn9lY32wBR
 nxWosgis1tn4oH2s2aU3T584pqKZ5njcI6cVrPWQGjrlMPUMB9WuU/IZ3N3tPDzh5TGn
 rPGsIA9TK+BnNUUknLUsmDs5PcLYiXQuuORmilTg4dJa6zApg71aJSBrbtuBfLWdNjoG
 4xY3MxBVExY9KYmkaHnEPKhOmk0jsrk/ETEt33T3A4QOm/vHXnqPHG0sNagtOspGDxNh
 LHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k/d0qYjvUjOnhK3byzjqxMrsrkZAK3+9jUq6QNPQ6V0=;
 b=e/rj7rzloBKUujBNfOa+DpHrusHk+KTPVVDkKw+q6z2teQNyT5eWV/iC7Y1UKZGte5
 d0MT241MCEPKNLd3QTAv4DgX6qXq4kUl2J8kCSHEqd3F1omnC9G4TY6w0dOnWLGBgODg
 jRgyTPxb+KJ7rjRw2H60W9UNTFldT4KOrp7vRGi6RBKYUNT4wUrBBy3lpJTZe3V9+dEb
 OU3P2Hq9scgn3o8pnus9QbPCl3uKDcxalqX8eXZZJu5dvSsH6pemTXnetlpX+xl+IS14
 MNikA7PdZS1oZBaFmCmAzicT5i8hu7dlC43Z7r713NaPRI/DkUd1m3/RqvLTylS+TBF5
 aFrQ==
X-Gm-Message-State: AJcUukfupwxZPoKfZoRW2sOWcuxCEbzvev1+R1bb3o/0136fyDMeGp1W
 PJ6NYFWKrVFBYLMZ3xYOboc=
X-Google-Smtp-Source: ALg8bN5lyN17RFOlkB5Dcg5EzsR5JtMfeU1YZzRbWG/L2OB/7Ndye9FSc2SnO4T2ztSP1WKarvKCwQ==
X-Received: by 2002:a62:4549:: with SMTP id s70mr35947940pfa.233.1548967531819; 
 Thu, 31 Jan 2019 12:45:31 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i1sm7228759pgb.46.2019.01.31.12.45.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 12:45:30 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] arm64: dts: imx8mq: Make GPC default interrupt parent
Date: Thu, 31 Jan 2019 12:45:24 -0800
Message-Id: <20190131204524.1218-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_154537_227511_38F53496 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that the GPCv2 driver supports i.MX8MQ, make GPC default interrupt
parent.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d20e5c7e21a3..e9aa64156577 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -12,8 +12,7 @@
 #include "imx8mq-pinfunc.h"
 
 / {
-	/* This should really be the GPC, but we need a driver for this first */
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&gpc>;
 
 	#address-cells = <2>;
 	#size-cells = <2>;
@@ -265,6 +264,11 @@
 				compatible = "fsl,imx8mq-gpc";
 				reg = <0x303a0000 0x10000>;
 
+				interrupt-controller;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				#interrupt-cells = <3>;
+				interrupt-parent = <&gic>;
+
 				pgc {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
