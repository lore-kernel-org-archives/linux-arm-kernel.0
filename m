Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1302FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:27:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7F221903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kFa4FAno";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPCt8xVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7F221903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=P8Aewg/1CdavvDncT/IJ200ahi199Rfmuk14juv8f98=; b=kFa4FAnoTn2KBv
	SgnHzfoiKVZLvG5gHCdOllB77+X7BYYiD4Ce6YjJGjpD3o0JUvisihWr38lQGbazaD7FazxbQbIdm
	NKh/OztcB87RIuDw2/DbGVvAFsN3fpjbyHo55a3RY5hVqfa6lPu0w5cdAUaWxoKuiZhp+2QnMyndU
	gtN0L7gohRzQy5YnJuUvkLkoR7hpDBT7cLrXk3p1PFBOH3hWQ2TZXEmD/t5nvptbOuvjHYDQvdv8T
	dJKrjVNkRXbhNadsqjJWO06PtokdCuSSaP6JKlIA3+NQE5QQbS8KWzS8tefE7x8+piGzXDj3qOs63
	1WRnljtkN5Mlbld6K98g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFDt-0001gD-Nt; Fri, 21 Dec 2018 07:27:53 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFDq-0001e2-Hw
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:27:51 +0000
Received: by mail-pl1-x644.google.com with SMTP id y1so2097418plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kOc0ZMWuA+wm6aVDJRuGECq2GcrB/9tzKOsAAmB0XOw=;
 b=TPCt8xVCVDNxQebkP1nin8NzBDcA1ymLh+qmgaDZK2/R84wnC0MGL83O2AbRWUOMIl
 aBz+6aVlXOFXp87rfma2dUDM7+FQhc/0kNuzxmMs0aojYjVMlulbqZH972LaSDHUaR3t
 QWdxj4ms/Hqvayzoyuy4YlyJ4OLZP5BixfI6GlXQtL+7RegjwPqIVOJPYTouv1H0T5b+
 5jiJBS+SI1eP2mSf4dbyd3Bv7MpN3YIP51YYOP5PuxYWALLGPM8fNEg0CdVWAw/SrKGw
 LUSgAkc78RNyeNHrAExKXm8zzBtGaxLPB8ZQ/NmI+saNZAif8Rm5Zxfqbys0PDMuhohf
 c4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kOc0ZMWuA+wm6aVDJRuGECq2GcrB/9tzKOsAAmB0XOw=;
 b=XmaKRcDEFYr9bpba3IftYNST6mbh7B883wXVwc0ZL7uae6t53BvhW/sVcUkX5CYuVS
 b2MXq43erPayW2ZiRXzYFwBHEYNU0AW/m+fnqzWysuTCXsGjE+fyFcx7lmnsIV85gFwH
 9XoKBzIyW2qW2WIwg4Kk2PcSvoNwF4qlX8iSN6nb3JPDi1DQ9WYNrU0lxjo2dfjo82eI
 2BUxFCh+MLzmai5wVJv8pLZvneFNr0O9o4uTwoMQ8phUptwEhnRQjPzfntp5MXwC9qDC
 sDYArjXHqRg2TeGFpKAb2+I9usU0B4aqEeE7yHqZQMaGtUnHhR6VDOlNS/QcGudaBhrv
 vbkA==
X-Gm-Message-State: AJcUukcolZxcKzmT0Dt1/CGTUXHcfpDSy09OAPUq21zXLxXh2LOveZ0D
 OvShpkhG+qdhPU3j2C5cBs8=
X-Google-Smtp-Source: ALg8bN7yfpjuiwJOykG2+SWyVOxDLnQslYnPFMp5CGu0sCI/4m5T4u96cgAQER5ge0VU9qEafNlb7w==
X-Received: by 2002:a17:902:28e9:: with SMTP id
 f96mr1405913plb.169.1545377259137; 
 Thu, 20 Dec 2018 23:27:39 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:38 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 00/21] i.MX6, DesignWare PCI improvements
Date: Thu, 20 Dec 2018 23:26:55 -0800
Message-Id: <20181221072716.29017-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232750_600352_E37B5983 
X-CRM114-Status: UNSURE (   8.03  )
X-CRM114-Notice: Please train this message.
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

Everyone:

This is the series containing various small improvements that I made
while reading the code and researching commit history of pci-imx6.c
and pcie-designware*.c files. All changes are optional, so commits
that don't seem like an improvement can be easily dropped. Hopefully
each patch is self-explanatory.

I tested this series on i.MX6Q, i.MX7D and i.MX8MQ.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (21):
  PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
  PCI: imx6: Remove redundant debug tracing
  PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
  PCI: imx6: Remove duplicate macro definitions
  PCI: imx6: Remove PCIE_PL_PFLR_* constants
  PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
  PCI: designware: Make use of IS_ALIGNED()
  PCI: designware: Share code for dw_pcie_rd/wr_other_conf()
  PCI: imx6: Drop imx6_pcie_link_up()
  PCI: designware: imx6: Share PHY debug register definitions
  PCI: designware: Make use of BIT() in constant definitions
  PCI: imx6: Make use of BIT() in constant definitions
  PCI: imx6: Simplify bit operations in PHY functions
  PCI: imx6: Simplify pcie_phy_poll_ack()
  PCI: imx6: Restrict PHY register data to 16-bit
  PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
  PCI: imx6: Use common mask in imx6_pcie_reset_phy()
  PCI: imx6: Simplify bit operations in imx6_setup_phy_mpll()
  PCI: imx6: Remove magic numbers from imx6_pcie_establish_link()
  PCI: designware: Make use of GENMASK/FIELD_PREP
  PCI: designware: Remove superfluous shifting in definitions

 drivers/pci/controller/dwc/pci-imx6.c         | 151 +++++++-----------
 .../pci/controller/dwc/pcie-designware-host.c |  61 +++----
 drivers/pci/controller/dwc/pcie-designware.c  |  18 +--
 drivers/pci/controller/dwc/pcie-designware.h  |  60 +++----
 4 files changed, 116 insertions(+), 174 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
