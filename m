Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFD7C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0E721903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CjGVrY2g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfjIAf5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0E721903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aK+eDuln0VTFuL962edro5zV2U1MjBkrukJWgbxxDVI=; b=CjGVrY2g7daTXW
	o1SPKKiRGprYL+OjZzeLeNMxP7xTI6vOJ2/tbuI+14YHnHH1Xd7BplRmBCApc8fn9FRFZTUPCBmx+
	od7NOoO0fpyLjsxlQbZ233GY/R5g05pVn9L0GSwQFJI42NtXgls8m7/SFTjYvG5ZXqulG2yWZ0o8i
	cXOScJzXRKrVsLHNq3zp1Fd5hDpWd1JS817RX8LV6QfkwkyT+HVk7BdUQhpApkCbRX8z3FSQwjPnw
	esv2uwROISzZHwl+1GCjJqoHuAaCWs1U441CZLFOlimAoknYfW8a0riIXrM1svfaHo2+1v/UI3Ukx
	L+O/yvRBx6JG5Ne7SjCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFEi-0002W0-Sv; Fri, 21 Dec 2018 07:28:44 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFDw-0001ei-Ku
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:01 +0000
Received: by mail-pg1-x541.google.com with SMTP id j10so2120136pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O4mASvI0bC/QugbLYbpYLoCaECc3OWgx8IVqS8xMLbI=;
 b=PfjIAf5EaQ4lUe8mFdDhZEXTw9YDuTBnZNuNCgOaIqXKdeiCfnEHFnYYEwSd1z8YN7
 PrgsP3bh5563mr/+qA3bXaP0taH3DBzdn2kdZHMAJmwf9Ua5EafJzp76aWf8lyPrJWRB
 0WndyHY+qDCbfJYyjIqZgvBfGBYR1YA5jpyZAQO4KCGhRtow+wHb2+Rm9qTlx3yZ+9Q/
 /1W9Gsx1vhJ6J1dl0VR08NVrfAXGjo3e6SsKN9ePnzvx1N8Xkv+5XTD/Vgs9Bj31EOgd
 DCBINsu3cMbgeSTrQlZ76PzZoANdiwI/MFx4cow8RWKkijlz7jxXEZpfPhhANd3N+wyW
 MlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O4mASvI0bC/QugbLYbpYLoCaECc3OWgx8IVqS8xMLbI=;
 b=RUqFJg7QFICpFpKSnjZUfcPlVciQT2SImrOijTzZAuWEfspeAhhbT02GTkYTuhFdFg
 8HeP8W51S3XGU9I9KlcZ5BnvpAA2EU3tc8ZzPEsbqzIkqtkZrgaVChBAbYP5Kpiy/kzc
 ElOP6y9VSZouLn2aQNmw3UOeJ+Xm7G1hr7+LL3e0je81d013bVldY9YnX7cdj96Mtupt
 +q2jDW6WoEDcu84CmprVOWZTVA1iN11GNyURNmILWOXbJi1hJIFP8eVNEnKs0gLTDAGH
 sNBbGpmV0PhFBUOXmm7Q0d2vLajAcKIcIZEQ954tDf2LvGzQ0GOl59aWnGePXhqaJ0jW
 LmHA==
X-Gm-Message-State: AJcUukdXh0OcTlt76sZqTCLxslRczJJUdn9RSoK8D3Bk1nwKUkPkAcCo
 kTXS5PaIVP2/TrWYS6LghzI=
X-Google-Smtp-Source: ALg8bN4ONRm6Owxg+TWoErIgIUP722JgVl/i35d0LJyd36E21155w3ghEdpl/I6V0E928xCSKECv2Q==
X-Received: by 2002:a63:2e88:: with SMTP id u130mr1366861pgu.9.1545377264837; 
 Thu, 20 Dec 2018 23:27:44 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:44 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 03/21] PCI: imx6: Return -ETIMEOUT from
 imx6_pcie_wait_for_speed_change()
Date: Thu, 20 Dec 2018 23:26:58 -0800
Message-Id: <20181221072716.29017-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232757_042574_320B77D9 
X-CRM114-Status: GOOD (  13.26  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Change error code from EINVAL to ETIMEDOUT in
imx6_pcie_wait_for_speed_change() since that error code seems more
appropriate.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6ffadc29d21b..e990030564d8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -624,7 +624,7 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	}
 
 	dev_err(dev, "Speed change timeout\n");
-	return -EINVAL;
+	return -ETIMEDOUT;
 }
 
 static void imx6_pcie_ltssm_enable(struct device *dev)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
