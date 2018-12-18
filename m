Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2968C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:07:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF718217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ae8Dkcf5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb357ngO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF718217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZQNmBn0Ibtl2rDYUC7V/SQJk2mdJ22Js8Lnf4Xi9eDs=; b=Ae8Dkcf5mVXBuq
	Evl9DkYBOfrm7C8orvn0yW7yfEoMf5bzE4pBUrUyBy4iZhnLNnkGtfeD98TPFuhRSl9brSCRj4gVw
	8hYXorBmMV43D9FzgbbiFIH7NxgQbOHH253YzuamAE7vRg0n136Yybu5d5NhkAYIrmfQF/QGz+Ic8
	2HxkypyI2Fk09A4z7xm+Ydog1bfOk6HdrgifDSRMGv/YMZ3OBVB6zDUIopIk2im+/LrnUSAViRkWG
	nrfOW9EH6/0e6wYVZoTAdhGj4PoAHj4rqCbmb0PTarVyHJ2D4FzGvFQyEcNkkjS3hD8u6zDtO9Ybt
	n8Pmu0RLDUXlD8r4AwDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6fO-0000EV-AU; Tue, 18 Dec 2018 04:07:34 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6fL-0000Cx-EH
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 04:07:32 +0000
Received: by mail-pf1-x444.google.com with SMTP id q1so7458644pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 20:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l3+OCgKPBIWFfLC4rx2+DZloTP4JnnVc5aNIGz681To=;
 b=gb357ngOzxNoFri/o7AF4EJpdSAeaYcCfa9DurKZvA1OumCMThDqf5Z5LeYiUkAGP/
 Onui3I2USzFMiGzvbMHjCTY4ziceWzKOcSzOWYaHUgSLxHI+HA2N/RL0ppDpyy7kPhLT
 UzOY5G/DwcFkjFH1enqhlBLQDJCYNZS5hFpBWaqNYmy3keh53AIwOLvecu+8cWLKHBCe
 qujZYhpknUD8PF2ZSTA5rvAuWAeylV6DAgeAZoOuie8PLIg3x5qPS6pzdCIh0UAQMc2r
 UivI6V/TZvVjbjSAd3XFGjL+mxJLsHW59muttveYtOEtna5uDAaIHEParqq6hLm1lxW0
 7ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l3+OCgKPBIWFfLC4rx2+DZloTP4JnnVc5aNIGz681To=;
 b=VmxOImjdl/+10/E+ojMWU3lxR1azc1Mfy1EcIMLOEyermu+btSJkKQ1Xhd7exp26/W
 o2xVB+NGL1DLJFEtrRfg13C+WEciKS9Vzrzec1HoyCWbq9XIRF9sfrCf0mA8oVDJeBjC
 wK0//qb8+tD5EH3CxhJ1GVly6WvbnREZ+xS25bIz9anodeLzHYL/pLL1gvhZzqkB6SHs
 3bc6Gf93bov5ltEB7DuRP+4/KGXA6/AB7aBZNKHhbmJ5gTPefH66huVJHpdshpjwIX+4
 UPMX+4jjq1Jz7b3gWZqe8xvl07B8jopQhn4gbgUMWX9zh5Z4u5X1wsnNHErPVLUrVXOT
 JWRw==
X-Gm-Message-State: AA+aEWY4LfU0FjdjAd8mkuW4Dfi+mgs60eLMnd/cYncXFSQeerYNHAz1
 4P4+RpYtBGWTW5koGEt6b8c=
X-Google-Smtp-Source: AFSGD/VwUDV/b7a2YyxHMr5g+cDFK6C3R+R4LhOP6fp+RV2donKCg6OSjbhgJIdr30CaIbFy0BFuPg==
X-Received: by 2002:a63:cd11:: with SMTP id i17mr14570991pgg.345.1545106040001; 
 Mon, 17 Dec 2018 20:07:20 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id m67sm18538837pfm.73.2018.12.17.20.07.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 20:07:18 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 0/3] PCIE support for i.MX8MQ
Date: Mon, 17 Dec 2018 20:06:59 -0800
Message-Id: <20181218040702.29231-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_200731_483755_A81FBA14 
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

[patch] https://patchwork.kernel.org/patch/10712261/
[fixes] https://lore.kernel.org/linux-arm-kernel/20181216230916.22982-1-andrew.smirnov@gmail.com
[v2] https://lore.kernel.org/linux-arm-kernel/20181206073545.10967-1-andrew.smirnov@gmail.com
[v1] https://lore.kernel.org/linux-arm-kernel/20181117181225.10737-1-andrew.smirnov@gmail.com/

Andrey Smirnov (3):
  PCI: imx6: introduce drvdata
  PCI: imx6: Mark PHY functions as i.MX6 specific
  PCI: imx6: Add support for i.MX8MQ

 .../bindings/pci/fsl,imx6q-pcie.txt           |   6 +-
 drivers/pci/controller/dwc/Kconfig            |   4 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 150 +++++++++++++++---
 3 files changed, 136 insertions(+), 24 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
