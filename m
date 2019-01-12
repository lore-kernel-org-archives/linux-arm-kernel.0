Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8A6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CF52086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l+GesViC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB8bX8Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CF52086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5HHgM8ZvUbKloRZhhko4mEdHaoLPJQWXexoxXGoxDbw=; b=l+GesViCrTjhfk
	cApqsrbFctrUOiWuy4hC55DhGuUVGgU3s5AdpVb2VDzX8/GE7k5aLia/S33Y13QLGIUxVzoQkV83O
	MG2kvtxfiv4JrYsc9EGkk7GK+wnoSAQK8TxGcBpUMQWJir6v4lb/AF2yELIO/uB20aaqFAQ1AD+NN
	jFMYcZhczvKmWp9OL2mMKpmGNs46L0+2m+iPfoW9UIG4uart6RacEz6Nylswyk1aMSvwVxwqX8iuw
	ombUTXI7rMLdeYgbMlGDx5kM5K41Qx9+WRP7hdCJ7ThkDPZ6Dj91wsWog9KzEtNF3jRHTxCNgE7vi
	QlYlP0tAJSt4gCmc0yrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giRGM-00080y-56; Sat, 12 Jan 2019 21:56:18 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giRGI-0007zz-70
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 21:56:15 +0000
Received: by mail-pf1-x442.google.com with SMTP id w73so8567875pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g3vJfMdgiVEA4VDR/kEGDKihZfUkd5cH3sJDDh5BGKs=;
 b=DB8bX8Jf14k4jVPG0SnjWlW31F5N6xU1qCEGMXdOUcKLovBS1jQil4NADkMxFvBFou
 MyD7A/7oHOrJ1wyvD36ypodEWXs37fdPUQykyJXyHljNbA9PlbuwBC64HrimxalNCt2k
 5WiaCs/1bXMHg3HbBWmUpC//2go8u1dmAfTIUqCodyY3OPr34YypYzqQ86ZxoOSxf+TX
 bPRz3mdLaCk+W0RAV6BUyz0xPeniLssGq7swDLqgzeWfTt+CywfP1IWwvobLoUkcfy25
 DQoy7NOPTaYp8h7DzY3tddoFAgfmCb08nEIlowPe4Ww3KGY0Z3IgnbMctfGsnx/nQ2aX
 qv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g3vJfMdgiVEA4VDR/kEGDKihZfUkd5cH3sJDDh5BGKs=;
 b=mPkqUASHW4Mas9GbSkCPkpH+ToiuwSqAnJkfCqGVJqN8b0IAxt+4muzVrZfX5hSYck
 mMrBupF8l8E/Yk/xsF2xGKcaVOhV9IZhonp5aSifJuMgDWPRTbDY4yvMZ+V9Jbvwwmil
 jtgXZ5IB/VGjgmMO8iwaYW5Hisn311TvKRNLRwp+/nnAsTQ8FdEMu+bMju4BwdDn+KJb
 sqEfo0ifnOpRaxCKUfFfWgq+yFistZUxnuuczxMtXEaIsbVFw6MOuQOnmEFCrlej1Jgk
 cDy317lTFotFPW2JA4WiouoR7c5EOZ1ogxGOWZHrR+hfJqXyh9j6N04HuJ/L8bV+3Cj2
 AXXg==
X-Gm-Message-State: AJcUukdOkBDmDPWms7Bx9aFJa1VO36Ro0P4WNRwKRj+/mkpXaYuvnYDg
 U0u8yvn/itf7uu4W4/LE6XQ=
X-Google-Smtp-Source: ALg8bN4IWoCJaYJiTdNEcbMksNHQH5T8M1EUVpoJ3aiTcRfRp9p9oqi05CJGPFRo7sUxRXgDvW36IA==
X-Received: by 2002:a62:870e:: with SMTP id i14mr20284592pfe.41.1547330172464; 
 Sat, 12 Jan 2019 13:56:12 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i72sm122284327pfe.181.2019.01.12.13.56.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 13:56:11 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v5 0/4] PCIE support for i.MX8MQ
Date: Sat, 12 Jan 2019 13:55:57 -0800
Message-Id: <20190112215601.9535-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_135614_288319_EB0BBB53 
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

Changes since [v4]:

 - Collected Reviewed-by from Lucas

 - Replaced ((ARM || ARM64) && COMPILE_TEST) with COMPILE_TEST as per
   suggestion from Rob

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

[v4] https://lore.kernel.org/linux-arm-kernel/20190104165335.13205-1-andrew.smirnov@gmail.com
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
