Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C81C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:50:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DC621907
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d1OOX2ND";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="D1xAybEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DC621907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=6i39EjhmYV+tre/6cc838sfesWY492U/s7MdeFqVXYs=; b=d1O
	OX2NDne2Vcm6QUjxob3xyc9PKPggDlY2P68TctlSeh5SmZSGxEawjd3wvEIKxj64SFQQsql2gfsLi
	lcVQSPY4NNX5uZXmGAM4ye2z+Fku05j/Uabtsv6EdM6QAsdHwCZd8C030lovck+wmbtWVSdytjDZ4
	T+jUwWm7pYrgYmFZ96A+CHXs69r11PO5AKsMS+z3xLKSCRRe+TYNbq9amiXPvPIXblnPE0KCpOLCr
	8iKhb5f0pY7pcXMbS64LlarLDsqm8l6Jx13Gq9SGrowcafqTxcGdwDMcbJ8mpZAvGwxyJc/3F8qKz
	2Du8RzQUeCF4NZWqlM3jAwtE883dIuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaAsx-0006Pf-BM; Fri, 21 Dec 2018 02:49:59 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaAss-0006MB-PU
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 02:49:56 +0000
Received: by mail-pl1-x642.google.com with SMTP id gn14so1784301plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 18:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ingics-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=B/9WIP1doMudHgKric46ysCRndOOFeg6o6f8nrVxxgI=;
 b=D1xAybEu8p7N8PuPqjF9RAdMDR0Bxs2b5PnjITwq0Hv8klYCPRk5HCb2r0gkkYw4tJ
 prectoMcBStEgk41uB9tXZ5BTgPPns0eYj8pjD5aiJukGdE7yuHmeHCRdJL1k9VXtg3/
 Cj42Mp24u4VDRjMn+qViuJCPKrIAXED98fT0kSA4fFcKqNLleOn1s+q6ycHGfDekgGu4
 0+cbsY/YsF81VeoKax9c7k3gg4+sSN5kF4vRxsnexw6EmL56Atvd0OTL+wvhsWD5t5JI
 LajEhaZsWYwj2Hymca+T7Igqq41/gshMmHpXzbwkHLYQ+rVhN+XyYsrxE+1EOicsE+Cn
 AGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=B/9WIP1doMudHgKric46ysCRndOOFeg6o6f8nrVxxgI=;
 b=XXWGnwbV829+JaHOkznCo9kbQAr8dBy5VrR3TAT/el2I8f9iBH2QdNBRLdmUl5B4CB
 zCtgWHLxJxKc+E3kwOaCSusGz7mH+qutKHcpmmOeC1Yoj3s4hkXUe3Ws2dSCewo6Isyd
 Ri+nOhgDtZ2knAV3QL3BjlanyrRa03lqVEx/C9J6fb56DYOOnqjlYcxXffZVq53CtIOC
 i2C3zQzJEFUQtK5YpWuereW7g8e0Mr3gZXUCH5B4UY+gCOhUlLO2d+p6vy1S8eZimido
 jMCL9Jl5ZRbCGx/Me5lxufeAHov0OW8hMnd6Yty0FpPgS+MjNy55WOuZZXCKqxPWj7uv
 i64w==
X-Gm-Message-State: AJcUukeIn2HztFcR2+Zeh8ciOJiaYC491QPK+px6K+QbB/5q4453HcGz
 jjWERtBzNYRcgE3Ey4E3SeIbdQ==
X-Google-Smtp-Source: ALg8bN75ERoYWk6L2eVHmcf4dP940Lm8nwWCEAhTb25M1nCXVq8AXmnZtdcPs3MiveECqZd64mjvhA==
X-Received: by 2002:a17:902:59c8:: with SMTP id
 d8mr751670plj.116.1545360583784; 
 Thu, 20 Dec 2018 18:49:43 -0800 (PST)
Received: from localhost.localdomain (36-239-205-170.dynamic-ip.hinet.net.
 [36.239.205.170])
 by smtp.gmail.com with ESMTPSA id c23sm27784184pfi.83.2018.12.20.18.49.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 18:49:42 -0800 (PST)
From: Axel Lin <axel.lin@ingics.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: mcp16502: Select REGMAP_I2C to fix build error
Date: Fri, 21 Dec 2018 10:49:29 +0800
Message-Id: <20181221024929.667-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_184954_826128_017C4BAA 
X-CRM114-Status: GOOD (  10.25  )
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
Cc: Axel Lin <axel.lin@ingics.com>,
 Andrei Stefanescu <andrei.stefanescu@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix build error when CONFIG_REGMAP_I2C=m && CONFIG_REGULATOR_MCP16502=y.

drivers/regulator/mcp16502.o: In function `mcp16502_probe':
mcp16502.c:(.text+0xca): undefined reference to `__devm_regmap_init_i2c'

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 719d9d660e56..ee60a222f5eb 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -570,6 +570,7 @@ config REGULATOR_MC13892
 config REGULATOR_MCP16502
 	tristate "Microchip MCP16502 PMIC"
 	depends on I2C && OF
+	select REGMAP_I2C
 	help
 	  Say y here to support the MCP16502 PMIC. This driver supports
 	  basic operations (get/set voltage, get/set operating mode)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
