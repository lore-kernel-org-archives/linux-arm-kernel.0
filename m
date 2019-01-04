Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC8DC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:54:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F077218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T/ua+mkA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF2/qmwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F077218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ngoalq8T9jmQtH04SRhadgUNhw/BhbdBvPzjLS8Wa3E=; b=T/ua+mkAR10s+3
	vanVoETjEhBlyg3cP0uylMC3VswGC9LGelcWr7WbMYvlOwuPGHW80mm1vyxrVflYBSdWcmqGEe2F4
	6Di5uaveDtldHX7yKnHMNKecZEcMlQcNp0npxSmrAo1jYxWp61U79L/PIoEf5uzTRWn7ThZredNl7
	uik179kXgnmK4Cv92gJSPHSen7M5cN+657LEGYIbMNA8Bv8XcN6EwZ+czfX4yQkpqxn0FljFUIBEx
	c++ANnVXwnCeg4JsofXq+yMv9ZT5XEMq+/R5w3LLI9EE6jBnzt7M/But3p0yNvtlUnnHcmD6aXnoG
	dEMDAqjEmNwUn0cXxItA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfSjQ-00074I-86; Fri, 04 Jan 2019 16:54:00 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfSjN-00073N-6E
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 16:53:58 +0000
Received: by mail-pl1-x641.google.com with SMTP id p8so17675283plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 08:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KHC/zMtIBsgOaORZM1PGs7BI8KoWKlR6MHjCuPkH680=;
 b=uF2/qmwUquF5L+bNLOVzyUlm3r6wjN9Uv+W37NpsWru0ExE/Lk7SNsuucBVo2wAf4+
 C5w7D8dkBZcoDOD2VZpxjKxBrV4aA+KqFHr97HrJXc2mVXpRWxUC3gnJ4ALm8oOC4QCN
 +GPGO+GeskloIq3NtNnedtrJCviBH6uWwasjBuVaUpYsHY2v1a321o6cJtoLD0NMihkP
 Teh3P0sVuGG9tZZpJ6g0zMya3C3fu4xxYB9TPVLC5P8FtlQujNyXFgpbCALZyLEUVwbY
 gZ7EoVHkJQbyZ3hTO2sMdSgarMUqKam6i9ns5n+qM5P8Cv55usZjR3HjZSPo/ZpQocP/
 IDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KHC/zMtIBsgOaORZM1PGs7BI8KoWKlR6MHjCuPkH680=;
 b=FbVfXWMEoanDzgbHaFpovqPw9exi4q1p8etAyUHYyx4o9JFlj6JtL7ydJJwkp7bfXr
 VrOg1+Q/uRSEcUXVaJa7h9X9O81o0AnMk8DB2LmtJIRRMepRxSvRwhM9lPv3mHGuXe0i
 NuQchXnZ5p8MKe2hO7yKgQn5IGi7al6yOhCbzV17RZg/jdKHmaqV/oxYFLVxVrI8rMQb
 r/e0F3VXOShiqzYyIR6syeGsOR/TP1wPs1EbSVDhBYkoNLL30xw4jTx8lQHoRdkPlQk/
 yFYlXKyZir5vAvjIXHSzlotN2YZfeXe1/7usKlmiaMZfLhTXoInRFE4086O4thoS5rBS
 7aGg==
X-Gm-Message-State: AJcUukel8uBSbFGD0Tcg734xBEN1dmBVLBBVZ84Nk4RVL5D0UPO3+vcI
 HkTMjjIn0GXKDgw9gssogYU=
X-Google-Smtp-Source: ALg8bN5VITyWQzPo2idOKEn1GD9kVo+ZZ+YuJPiFgVMh5C6p12jU3RIH5eJtV0LS4Yzh1O6kw+kqlg==
X-Received: by 2002:a17:902:4d46:: with SMTP id
 o6mr49524570plh.302.1546620836177; 
 Fri, 04 Jan 2019 08:53:56 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id p67sm101900564pfg.44.2019.01.04.08.53.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 08:53:55 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 0/4] PCIE support for i.MX8MQ
Date: Fri,  4 Jan 2019 08:53:31 -0800
Message-Id: <20190104165335.13205-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_085357_232758_9E9B8477 
X-CRM114-Status: GOOD (  11.01  )
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Everyone:

This series contains changes I made in order to enable support of PCIE
IP block on i.MX8MQ SoCs.

Changes since [v3]:

 - Based on feedback from NXP, DIRECT_SPEED_CHANGE quirk was expanded
   to cover both i.MX7 and i.MX8MQ

 - Code setting device type in GPR12 moved to a standalone function

 - Explicit "fsl,controller-id" binding was dropped, replaced by using
   controller physical address to determine logical ID

 - Dropped Reviewed-by from Lucas for patch 4/4 due to the change
   above (haven't heard explicit "yea" for it from him)

Changes since [v2], [fixes]:

 - Incorporated [patch] introducing drvdata

 - i.MX6 PHY operation gating converted to a single patch and to use a
   dedicated flag instead of doing explicit variant check

 - Kconfig entry changed to use ARM64 && ARCH_MXC

 - Dropped FALLTHROUGH annotations

Changes since [v1]:

 - Driver changed to use single "fsl,controller-id" property to
   distinguish between two intances of PCIE IP block

 - All code pertaining to L1SS was dropped to simplify the patch

 - Documented additions to DT bindings

Feedback is welcome!

Thanks,
Andrey Smirnov

[v3] https://lore.kernel.org/linux-arm-kernel/20181218040702.29231-1-andrew.smirnov@gmail.com
[patch] https://patchwork.kernel.org/patch/10712261/
[fixes] https://lore.kernel.org/linux-arm-kernel/20181216230916.22982-1-andrew.smirnov@gmail.com
[v2] https://lore.kernel.org/linux-arm-kernel/20181206073545.10967-1-andrew.smirnov@gmail.com
[v1] https://lore.kernel.org/linux-arm-kernel/20181117181225.10737-1-andrew.smirnov@gmail.com/

Andrey Smirnov (4):
  PCI: imx6: introduce drvdata
  PCI: imx6: Mark PHY functions as i.MX6 specific
  PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to use a flag
  PCI: imx6: Add support for i.MX8MQ

 .../bindings/pci/fsl,imx6q-pcie.txt           |   3 +-
 drivers/pci/controller/dwc/Kconfig            |   4 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 150 +++++++++++++++---
 3 files changed, 133 insertions(+), 24 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
