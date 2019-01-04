Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:49:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF2D21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NU7EiQsX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXlHtoMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF2D21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=I/KkiE5s5GhcUh24x0s89cerMwTaR/9QAcoDrsouyd8=; b=NU7EiQsXtFt2E5
	oNbDcUueOIx21sq5AjY62UZJUT5tFMpDfv7Cl8ecyrxtQInGVkn16laBuf8no0RSRxBlUHTtRb/A3
	x2V8K4rbNihlM36mVHoIVHRPCDCDyKm1N3IRQj2wm8rfqpmgpYHaymaPHcjCuoHbq/oWfeQXBfa1o
	1x+TdA9DKthjP4R1PCSbkFPp89prLCWicREiKGQteN8vXDbbdKwJAbkYg51g5ARfO9W/3FnHl4VQ/
	OsQmwEaA1BxhJOmZazIdP5pxJG4rbo01MH4EyDztyCLkSUOyJcy7mzkU6B+575lpVfy1CMCxe5h1X
	PX4HFaNnmGuOnOpfANVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTbM-00043w-7k; Fri, 04 Jan 2019 17:49:44 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbI-00043D-GO
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:49:41 +0000
Received: by mail-pg1-x543.google.com with SMTP id t13so17764976pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3a4KVHdFpZohLc9Lz0HnZk5LDcrQaSTNBzc6TtIUt+E=;
 b=KXlHtoMTt9xiPy9mkkBCnREitHoOvmNi3nEYJnY1KF6Wtvu2QXFoMlw3o/jb1G+cBP
 81VHnVuQ4i1zpwy6zO3TQpnDEB+Jadp9ad89dUBhOk5oq0pfhpsnP7ks24u29pwoNjXg
 ks/Ucrp1Al/jdqjQy/zys1umYamaiHZ+uZwKWXVK6uk8cmzKL6ign7mOpLpI1Oo3Uzt6
 d55FgDfUoYru7h3YYmsWRyPemcxvkPLfTRk+u7znuGnvX9gdoZqC1Q4chX482Guu2wD7
 0i2U8Il3u8HFbzaFqe1oDumVsqbCJ4wHbRCtj1ssUDQJyMOo2WFa3ClZYDmjBryhWJIh
 H4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3a4KVHdFpZohLc9Lz0HnZk5LDcrQaSTNBzc6TtIUt+E=;
 b=tD1h2h5LZpt0tZZgRuhhIKgGIT7Juvl5IzvkAYDrlBaztxsrtWb3co+XbOoEJ/5I77
 2ARqu3crnz2iHPKQX9MOwcAO9nuS/cR21qUNpsf+gxJ5e5NFh5QQ2gJFN5gX58FcB8gQ
 1+xRTuw0b69+upwAkrBv8nbKU8QykwbP1skd+4trKQjTTefNHMqfTXF5B1nsCuvK3y7T
 oGKJr8tYlmv4BcJ+yNiQmw8L4ofeBdpTcZGMtdZRT6F7U4msc7TwumXt8+EquikodRxX
 ZzY34vdnUkVzvGjXszr5PthluEkVV1KX1HsUPXF7hHpnnJCGXNmBIyYpc+X+pCdxdUAv
 ndKw==
X-Gm-Message-State: AJcUukcWLaki7N7YvKUg5aG9/eyqGVvn9oi/DAL0xTaR+qc942KKr2gg
 nx8qp5legfjzWkTMVHO9oXc=
X-Google-Smtp-Source: ALg8bN6fYxRl67ezSLhygiOFXSew3F11dDLDHq2W1Wx8Hx85rr/zhQcpZAtYweuULUfI0dlqYCn7NQ==
X-Received: by 2002:a63:6782:: with SMTP id
 b124mr50197134pgc.151.1546624179336; 
 Fri, 04 Jan 2019 09:49:39 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:49:38 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 00/20] i.MX6, DesignWare PCI improvements
Date: Fri,  4 Jan 2019 09:49:05 -0800
Message-Id: <20190104174925.17153-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_094940_549164_B8EA4E8C 
X-CRM114-Status: UNSURE (   8.19  )
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

Changes since [v1]:

  - Dropped "PCI: imx6: Drop imx6_pcie_link_up()" due to the matter
    already having been addressed by "PCI: imx6: Fix link training
    status detection in link up check" from Trent Piepho

  - Changed "designware" -> "dwc" for all subject lines

  - Collected Acked-by's from Gustavo Pimentel

[v1] lkml.kernel.org/r/20181221072716.29017-1-andrew.smirnov@gmail.com

Andrey Smirnov (20):
  PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
  PCI: imx6: Remove redundant debug tracing
  PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
  PCI: imx6: Remove duplicate macro definitions
  PCI: imx6: Remove PCIE_PL_PFLR_* constants
  PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
  PCI: dwc: Make use of IS_ALIGNED()
  PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
  PCI: dwc: imx6: Share PHY debug register definitions
  PCI: dwc: Make use of BIT() in constant definitions
  PCI: imx6: Make use of BIT() in constant definitions
  PCI: imx6: Simplify bit operations in PHY functions
  PCI: imx6: Simplify pcie_phy_poll_ack()
  PCI: imx6: Restrict PHY register data to 16-bit
  PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
  PCI: imx6: Use common mask in imx6_pcie_reset_phy()
  PCI: imx6: Simplify bit operations in imx6_setup_phy_mpll()
  PCI: imx6: Remove magic numbers from imx6_pcie_establish_link()
  PCI: dwc: Make use of GENMASK/FIELD_PREP
  PCI: dwc: Remove superfluous shifting in definitions

 drivers/pci/controller/dwc/pci-imx6.c         | 139 +++++++-----------
 .../pci/controller/dwc/pcie-designware-host.c |  61 +++-----
 drivers/pci/controller/dwc/pcie-designware.c  |  18 +--
 drivers/pci/controller/dwc/pcie-designware.h  |  60 ++++----
 4 files changed, 115 insertions(+), 163 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
