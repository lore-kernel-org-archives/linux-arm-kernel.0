Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785F2C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:09:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5C82084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MlOUdF1J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBs4ssjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5C82084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5cojWAKxicIGx3/wKeZ01o3GcEg9IxojZEZAJSYOau0=; b=MlOUdF1JaNCoLb
	EWQJMAL9k4FrtUM5P0d8AAktdY0mn/mI4B42oN62NqO5Hw2YoHgoCrdwKAdBUOTohIa2vUfmwPGoS
	t0spZk8Tb/FKCEm0c+KS0qV9FnY3o33LU1qG+bjm4Qszl31LVx8j3WL18xjqIud6FaGRiRPjrrNEg
	sD9uL3YgTnEbWLrREYaWREC9RvCQPCnsUGjakw4ALEvJjBC3vfQmG4uDPCXd6KTWuz8NDztc8/kbj
	zfGj0Zrkc1wKN5UL9O1y8lLpbSkTcFt1mO8uBZYJdRJzM9mKf3OrivmYW/YWFF1SBS1yO4sls0t/r
	RdnYJAYgHihRCAJkd2RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYfXl-0000Cy-D8; Sun, 16 Dec 2018 23:09:53 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYfXi-0000AD-Cr
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 23:09:51 +0000
Received: by mail-pg1-x544.google.com with SMTP id z11so5190774pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 15:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OFUjPN/jOVveBQnYLdpNxVZQI1qdFi0ky0CAVcNgUaU=;
 b=cBs4ssjyrKZh/pfBcHc7tszNNTI5KPBtKvjTvBabda0HwZAW5CZ5BJ66dZ0UPhy9ax
 PcGshBPnEbxuz7l0wTbwyyXZcUFrFYn7VwB2maTAOwzPlpZvY2mT9c9/FZglFyUdNi/w
 Um4Y3l+4Df4m1XfjixauL/bI9onIN/gVbEj70HAG5GgUNdFa3ZLMt4yQW/UMYrYXlT7+
 h1M8qAqo6hUAzbhdYeWAgPuThH/0XQYFbrM/f6soBETkhqG03NElpwrA76tkWT5CF5/y
 nTCtYQZ2dkLDfClfNcfIeWj7EaQeGyPumu0j4Q5tZPbmJTmHlXtIyZn79/sc91GMTbeV
 LFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OFUjPN/jOVveBQnYLdpNxVZQI1qdFi0ky0CAVcNgUaU=;
 b=CGVlAMCvPxY4DN2NiOwDcg88k7A2Ct0eqQ/We1lJKFiJ69anv239TM7eMtxg4J1n3I
 SzvhlFjTgkph81bVOPSAtgFWxyM3oUjjngHm6jTdpn2MLDC3guSmtmqz1b9QC3vTJD3P
 SUBVte0QqzGcxFrqP/M0T/MDOfni16QXNQN1Wk4RqaNxlZnzfd0k5uSJsJh/I8yusl8o
 64NfSSi3cDFTcSGOlPZ9MmsuRhVqDUUmyJTk6oIOmWiAxynnNVFWDEjk/tZJhhwRGZFJ
 +Xk7Od/CMcdgoeQTz7+kdDXOTIj6EbRNz2bKY2MHctNkWKTNh0RAQ/olEzDh8aqDEd4N
 DRgA==
X-Gm-Message-State: AA+aEWbvmfjfsSbX2NNm2P/9lu4AluJ5+2K0uAwsYoeFrs/OaP4oVvqX
 L7EP6t/yjhRohfvls/DQTfPyBekO
X-Google-Smtp-Source: AFSGD/Xw/f1wvmdqOuwCVFqUk0yRoQPPRFGqUlAy+zXV3KDbMCKTOndo5zG2SVqP/+c4sv7+gnyplg==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr10345302pgg.429.1545001778050; 
 Sun, 16 Dec 2018 15:09:38 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id d18sm13837878pfj.47.2018.12.16.15.09.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 16 Dec 2018 15:09:37 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 0/3] Fixes for "PCIE support for i.MX8MQ"
Date: Sun, 16 Dec 2018 15:09:13 -0800
Message-Id: <20181216230916.22982-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_150950_434401_5B2996B9 
X-CRM114-Status: UNSURE (   8.55  )
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

Lorenzo:

These are patches fixing things pointed out by Bjorn in [1] and [2] as
well as something I noticed while giving pci/next branch a try (#endif
placement). Hopefully this is at least somewhat helpful.

Thanks,
Andrey Smirnov

[1] lkml.kernel.org/r/20181214203828.GD20725@google.com
[2] lkml.kernel.org/r/20181214203042.GC20725@google.com

Andrey Smirnov (3):
  PCI: imx6: Fixup Kconfig and #endif placement
  PCI: imx6: Invert checks in imx6_pcie_reset_phy() and
    imx6_setup_phy_mpll()
  PCI: imx6: Make fallthrough comments more consistent

 drivers/pci/controller/dwc/Kconfig    |  4 ++--
 drivers/pci/controller/dwc/pci-imx6.c | 29 ++++++++++++++++++---------
 2 files changed, 21 insertions(+), 12 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
