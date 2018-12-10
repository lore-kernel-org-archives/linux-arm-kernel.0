Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D96C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:47:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136692081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U3m8H5r5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136692081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=q4nzhPDFPinAAFRqmE55l069Ikn6QMWmaQkA1yLRTiA=; b=U3m
	8H5r5y0zoMxqsg4CaOnOcMDC9tb5aGu63Gb0RbMCYctsrVxdD4wiBmc+h/8yYY2nHFJXhY3vi1Aqu
	DCoPj1DlMYLu4pPiyt9xlMcksE1eEEoHLPav/SJ+sleFoX1pXb9nHsEX2JuKwnKqAIdGBaQMjBnKi
	INrcEjb6Ny7kGVvQhHJMd0I3+CHnDCSvMtFTDflHb8Dr4MLvE6YWBK/E21gIHOB8IXoizhFm7F50a
	TaThG57Gf+m6iM7F5JXxxxQL5+SzHUWcM7HMhAfqiZ5W2gxSIRn1sMDhZi0QLn12MC/AqC7/Axz3k
	UjhaOJVV9All5xvJSLqNnNC26OoLV1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGIC-0003jh-OS; Mon, 10 Dec 2018 07:47:52 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGI9-0003io-CQ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 07:47:50 +0000
Received: by mail-pl1-f196.google.com with SMTP id z23so4860307plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 23:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=PVxJYCb7Cqtnjgs+FRiMxlSYbBhTqYd+iockG/lq+fM=;
 b=fzYs3kV1uy3Xb+2kSxcUml+b4pqiGeLJHfQtswv3QFS5rwwvl11H/aAwKFHjuZWSbt
 RLABReonMSWb/uale5zmQknYyDC5FFjtmOP8wyIvbOTfXpB/NBf5lSfwJ/rSZYtxD5dn
 GiJVUrzKON7iFSm4HmNP84Pnzre71IyEeLysxuDC+LHRwpbt0YJ7uQP7frFC9qAXlG1w
 9+xuT4aye7smh8kA4R07BlUypmy4+DhcEWiS6SrKjxGG8tZbVXHrlRn/ELSK46HsSEyG
 tsVvoQRN7jmIAcdwLj6HtJGg3TglL2P1z77W01tqhO6MZsNZotdgqLKhQVSHHh4fMmiN
 r32w==
X-Gm-Message-State: AA+aEWZOUX32j4HAJzhlIz94SYf9o+hsBDs7Q6mCgchF28mJ0b8z8svb
 ammnDcDkWZMr1EDom0y9dXib9A==
X-Google-Smtp-Source: AFSGD/UnBoQtpsR4qkrmv9hx48hczLTuIJHbdtxxFi/6JmkOS4GvhQ1/4xPBo9bZidIUVC5OuQyyCw==
X-Received: by 2002:a17:902:f44:: with SMTP id
 62mr11359055ply.38.1544428056440; 
 Sun, 09 Dec 2018 23:47:36 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id c13sm14363809pfo.121.2018.12.09.23.47.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 09 Dec 2018 23:47:34 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 1/7] i.MX drivers changes for 4.21
Date: Mon, 10 Dec 2018 15:46:32 +0800
Message-Id: <20181210074638.27873-1-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_234749_421694_4F803658 
X-CRM114-Status: GOOD (  13.69  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.21

for you to fetch changes up to b6444cf5fa607469d9a14edef2edad32773f4514:

  soc: imx: gpc: Increase GPC_CLK_MAX to 7 (2018-12-10 08:51:12 +0800)

----------------------------------------------------------------
i.MX drivers change for 4.21:
 - A series from Aisheng that improves SCU power domain bindings by
   defining '#power-domain-cells' as 1, and adds i.MX8 SCU power domain
   driver support on top of it.
 - A series from Lucas that updates gpcv2 driver for scalability and
   adds i.MX8MQ support into the driver.
 - Increase gpc driver GPC_CLK_MAX definition to 7, as DISPLAY power
   domain on imx6sx has 7 clocks.

----------------------------------------------------------------
A.s. Dong (5):
      dt-bindings: imx: add scu resource id headfile
      firmware: imx: remove resource id enums
      dt-bindings: fsl: scu: update power domain binding
      firmware: imx: add pm svc headfile
      firmware: imx: add SCU power domain driver

Leonard Crestez (1):
      soc: imx: gpc: Increase GPC_CLK_MAX to 7

Lucas Stach (3):
      soc: imx: gpcv2: prefix i.MX7 specific defines
      soc: imx: gpcv2: move register access table to domain data
      soc: imx: gpcv2: add support for i.MX8MQ SoC

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  37 +-
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |   7 +-
 drivers/firmware/imx/Kconfig                       |   6 +
 drivers/firmware/imx/Makefile                      |   3 +-
 drivers/firmware/imx/scu-pd.c                      | 339 +++++++++++++
 drivers/soc/imx/Kconfig                            |   6 +-
 drivers/soc/imx/Makefile                           |   2 +-
 drivers/soc/imx/gpc.c                              |   2 +-
 drivers/soc/imx/gpcv2.c                            | 296 +++++++++--
 include/dt-bindings/firmware/imx/rsrc.h            | 559 +++++++++++++++++++++
 include/dt-bindings/power/imx8mq-power.h           |  21 +
 include/linux/firmware/imx/sci.h                   |   1 +
 include/linux/firmware/imx/svc/pm.h                |  85 ++++
 include/linux/firmware/imx/types.h                 | 552 --------------------
 14 files changed, 1284 insertions(+), 632 deletions(-)
 create mode 100644 drivers/firmware/imx/scu-pd.c
 create mode 100644 include/dt-bindings/firmware/imx/rsrc.h
 create mode 100644 include/dt-bindings/power/imx8mq-power.h
 create mode 100644 include/linux/firmware/imx/svc/pm.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
