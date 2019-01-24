Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757B4C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44274217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WTH3npRn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpwsPUpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44274217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OugvU/a9Q8IZ93JdqTwR6fhZBGEpEcVXhhNKiQanSto=; b=WTH3npRnehWbfo
	h3C6MamKVs1HeefUyxHBmrqpnSNDL27M2Jw6HKUXlhayjN88SzN26SSp2LFdTxYu++NSveJlXV4rt
	PeFHQKAcMhsSrctXzS5kpMV6v0Tzwzc6BtyvEZQT/uWLyGZZQVr+bpV4opSwVE1W34/lXmLqbF9EL
	PJg5T3wo0vKaa7SotQV58ioXpL7PCOAoVxUrQEpW6xp8+nIK4qPEBJzb1H5eyUPcoOSrUbPuYCEa0
	8u2/8koi0SaRejf80npYrdq5h7uqnP3T7Ax+rhyWWajYwr1Dgiohp5ni0l3cO99TXKV3p4DZ2h+6I
	pYGBE/k5El6hqcI5U9BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlPd-0001ES-QU; Thu, 24 Jan 2019 20:15:45 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlPZ-00018J-Ua
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:15:43 +0000
Received: by mail-pf1-x442.google.com with SMTP id z9so3559199pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XOW0LX2PweR/cHPMdWN96QKcxoiR7cIq0Nnzo7uwIxQ=;
 b=OpwsPUpW8/I2DQ5qaiHRZ2tsIrURfyiUuNgI+6so7LJsu9yCoseuYvkzW9G5LpiF2o
 lSHIV8RTnSMjJ8YNXsIXiMKzYVe1rcm5+fypfvZ+h4PegBGyIuELJ7cPhM5Etq/wux0v
 uvjjDLlDO74EGwtAAViqAUodrWOisCLkmjle6tedXEaMXwKcuhOpDKGEKz75NOdfmt1w
 Ve1BJSMRmm0zNnu8ztpTFCaVmtJoNtH7YqJhYcUPaB7pMg25VLmu6kuaubU0+xWjRaBd
 9+ZHIFe+hGXuNl3Id0oZusMSHcqhOL6lHSvGO+SJReKxg/4GASInXvKsQg8YH15o3U6Q
 GVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XOW0LX2PweR/cHPMdWN96QKcxoiR7cIq0Nnzo7uwIxQ=;
 b=DsLU6zCi/A8wM7PvW3jnevAgRQS0dPpUOTFqjOOf4lP2SS8nPT9zjqceYnQ/o378TW
 RC9MiaPIKnvf/72sWvrZv1IgChmzwUVe/+uGO+OajBvLmK0j1JqXCELn00qZx5Za6/Pn
 6fEigWJIxAOnGleKhwekoHYJhfyUFy67eXy2ozHRGpvgYNW8aocsze5JD5hjtUcJWQCa
 Z/lEK+FWF4MeS9/9WpuCCn7YW5md9J/zkDo8Nlcwjor0ZVcBqAGsGMsG1aciU3b/f88l
 WcteBql5QGb+FgeuNWJTI9B1nxUOH1Qn2fprGjETHQs39nN6eyl2/XEZbYaU+Q4WWMGl
 eN+A==
X-Gm-Message-State: AJcUuke7H0BksLU16pPa0LHrxb60EFoupmCDZd+OqyzjRx9vnmn2v7Fl
 Am23e+PiMicsSvGwW1lV2fE=
X-Google-Smtp-Source: ALg8bN59RNULZU+WG6d1l7jJkppHQOKsMddfjKVuOCk2i9NONH2dLJtZnjD5Yp8qHwxIrI263ZVswg==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr7400377pgb.26.1548360940688; 
 Thu, 24 Jan 2019 12:15:40 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id m65sm53062646pfg.180.2019.01.24.12.15.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 24 Jan 2019 12:15:39 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v6 0/4] PCIE support for i.MX8MQ
Date: Thu, 24 Jan 2019 12:15:18 -0800
Message-Id: <20190124201522.8973-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_121541_992306_D823604B 
X-CRM114-Status: GOOD (  10.74  )
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

Changes since [v5]:

 - Reformatted commit messages to adhere to
   https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

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
  PCI: imx6: Introduce drvdata
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
