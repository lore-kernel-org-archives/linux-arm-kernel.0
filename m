Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DA2C3E8A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:15:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD40221872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TGIybg21";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkCpzawB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD40221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fwWZKLjkXtwM9wwnOvd8bZOlfFiVknI7blK+GztHIEA=; b=TGIybg21xeId68
	qYgKhfiNHLt4z6O9lINgoOhNHyD2gSzD4RTiIDeVnRr9/w7tnfepA7Z9FmYi+kzxt/+slNPsyGE/h
	TkhlgjOUByJH2OmsJjO7X3OOv69aucHVO6s7qgbnBDvMwi3zRcczoeswMypvwVlbzk+ndqos3dHek
	zoQG0RbMQyWKmHGcuAnByA9keykP5pfmxsjF33FQQxcyonweQ3C+qtuliV3+MN4RELgZsL0EOhtZI
	WtOpRYoAe6N1VIL6HThVFIV4IC3tfK10thDr7nl4ETMRZxAN+LCp2T5vgAqx5b8KePeNm3/Mf2ddq
	zxq5DAGUghH3UtWV10ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpiyC-0001UH-Di; Sat, 02 Feb 2019 00:15:40 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpiy9-0001TC-4K
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 00:15:38 +0000
Received: by mail-pf1-x443.google.com with SMTP id c123so4034759pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 16:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jEfHVg5adgM29Wvz/BKP6/4kELk5ivTcvMeeOgWs9Bo=;
 b=RkCpzawBmG/DUG20vkHE8nM+/HZVsIgcbpJyA134UvLrxUKAeotdXxP/iHwhWMRqf4
 AYkRiZkuGV/+zU2tcznCbc59WslEiNG6EiZmbGibznA8UipVmyJ3xpQFQ6E/wtfTh2wQ
 ywyxQ9t2CNl2X7nQMG+Hf+Msb70CD0mgzN3QnC7eCxktCYk0S8yRvYLAdAiv/yPfgj7T
 IlLKgFQZx5Typ45zO+71rCWwLA89wNy1MsycW/+dWac3Bf1iq3nqoZAz/72MdCC0Ycia
 k9pAXJ1cUgfjQWaVUlMlzi9nQX/3mpJ3mvnRYWGOnKGL9rx4WkDl6pTDXFflgefs1l0W
 LAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jEfHVg5adgM29Wvz/BKP6/4kELk5ivTcvMeeOgWs9Bo=;
 b=S0q/R1AkyKKpgj3XNZ/JJctZJ5TktakdZlkrhWxKgOOOOoDcyqTtyKZz1cyracBXJT
 GPLcV4jc8KA0E22MBdo/L4ByMyRXnZcj2yEtnjr10+cujgKvnIqbinZZTEC+A9iVTXRJ
 jmLXqAYrifYvLdLHHJFApexVGkMNdSDTY2/fBjxIRXNiQeJ8sBY8Ru5UVmsePrddq+CA
 2UXOy4MHh+hljdYz74J+ab4UoRoscB6fFGVQqYe81MpbhuRu16YrJqe9rAGKYseZmlgW
 eBIzHt+g/PdC4PcugPN+eD7b9Rp2FMy6Or8/vrpQIC5pplE81jfcDMEfgSH8T562mogs
 pdbQ==
X-Gm-Message-State: AJcUukeIYv9GYx2LRfoUydVeUgfOEK6IzjaiO55ULJ1KN6GmZpUkmdHK
 EBqcTGW+PL4czz2eOHVo0tq72zC/
X-Google-Smtp-Source: ALg8bN7CwYfzPenhtI9KfgSMrD9gYvxUtOH9Knxhz3A5up69TRXJk2mfCuNzwvmmXgNtOi20Cj16jQ==
X-Received: by 2002:a62:32c4:: with SMTP id
 y187mr43076304pfy.195.1549066534634; 
 Fri, 01 Feb 2019 16:15:34 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id w6sm28374545pga.72.2019.02.01.16.15.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 16:15:33 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v7 0/4] PCIE support for i.MX8MQ
Date: Fri,  1 Feb 2019 16:15:19 -0800
Message-Id: <20190202001523.12517-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_161537_204757_A1E2B738 
X-CRM114-Status: GOOD (  11.63  )
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

Changes since [v6]:

 - Patches rebased on Lorenzo's pci/dwc branch

 - Reworded commit message of "PCI: imx6: Mark PHY functions as i.MX6
   specific"

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

[v6] https://lore.kernel.org/linux-arm-kernel/https://lore.kernel.org/linux-arm-kernel/20190124201522.8973-1-andrew.smirnov@gmail.com
[v5] https://lore.kernel.org/linux-arm-kernel/20190112215601.9535-1-andrew.smirnov@gmail.com
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
