Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01953C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:22:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F432084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ob2YtBCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F432084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=X4IZOhVX6Lqka9uANzfPV0LhqOw0tK9p9rnglvlJ1rM=; b=Ob2
	YtBCepu7idOsL363WsdTGUHI+9Cdoqlqwmh5oDtHMoywL8soPPbEcKLPWpPLBjH8BXmtmOmhHWd1Y
	x5l0d1hexrdgX4Mm1X7GdQL/IKNBjMUBVYa8xcIRRROhoTD6jPq2w392gAyt2CuEoR4NFDgt2025A
	FzQbrFaqDp9hw8vrMNjAgu7VG9oKFpqWgXkcd6K/7iKsyC7P2mrbZHHwXRMswbXS0pLnJig6YWNLK
	UcOCjCu9bhmXwHfKP7PTKM1CjpMUve7O2zHx3bG/1/G908VSH3km12wuhA6rLmalyF/EP1BN+pTIT
	kLFMOMgcVCENvzEiJujXA/Nun6yX2aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtW8N-0008RE-WA; Tue, 12 Feb 2019 11:21:52 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtW8K-0008Qq-AM
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:21:49 +0000
Received: by mail-pf1-f193.google.com with SMTP id n22so1157087pfa.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rB3aKpvt4PUbp7gFLpF8PRCHEu6/HC62xPzI+LXJxwY=;
 b=g4EvULGtH9ruRAUPI78iqtZ9rPj9IWQUHiR5n/Pakr3/gL4h5KF9Aim4zoWfxkOGJh
 Gicv2TaGYYpNLY11JWP3p1vYdku/3EwUSxtv4qrG/UbwSQOMZfzlEUQQRSI6pMrTD76e
 rwVNwmC22iA6lHMjAQLE2xUmfupbgKBateEOeIQqalaAYiencCu/sML7zoMBH3WhZZkM
 wXwGETWwz9FbwkIGXK3mUTcZZnNoRSZP8zF/gny9cIE0iChzYG9nKq4oBQf74Er7gtS3
 SiWN4RFfcjGOvtGbLeOCrcBujeewX8f7gO9e3MqGr5+5Ol1ZrkEZVZF9ib274APSWlRi
 diQA==
X-Gm-Message-State: AHQUAubYhKCwjxUyagUssCtGLQk/pkah1J3fvJmDogLuh1eKt21PKDwN
 HjgN5XbHGzsBQ6q+3AFD8wgt7A==
X-Google-Smtp-Source: AHgI3Iadmqn7oXnRtj8SAbdQp+6vtKCDebecEv/zGxDVawNHov/sxpj+nvUT4oincyfX8mAHOE8buw==
X-Received: by 2002:a63:1723:: with SMTP id x35mr3105710pgl.364.1549970507114; 
 Tue, 12 Feb 2019 03:21:47 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id s16sm22282264pfk.166.2019.02.12.03.21.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 03:21:45 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 1/7] i.MX drivers update for 5.1
Date: Tue, 12 Feb 2019 19:21:20 +0800
Message-Id: <20190212112126.572-1-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_032148_361261_0151A08E 
X-CRM114-Status: GOOD (  13.78  )
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
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, kernel@pengutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-5.1

for you to fetch changes up to d90bf296ae18f26a18e572965fc0047fa1bd37a8:

  firmware: imx: Add support to start/stop a CPU (2019-02-11 10:00:47 +0800)

----------------------------------------------------------------
i.MX drivers update for 5.1:
 - Do not get GPCv2 driver depend on SOC_IMX8MQ since the driver is
   going to be used on more SoCs than just i.MX8MQ.
 - Add power domain information into SCU bindings document.
 - Add support of start/stop a CPU into imx firmware driver.
 - Support multiple address ranges per child node for imx-weim bus
   driver.

----------------------------------------------------------------
Abel Vesa (1):
      soc: imx: Break dependency on SOC_IMX8MQ for GPCv2

Aisheng Dong (3):
      dt-bindings: fsl: scu: add fallback compatible string for power domain
      dt-bindings: fsl: scu: add imx8qm scu power domain support
      firmware: imx: scu-pd: add fallback compatible string support

Daniel Baluta (1):
      firmware: imx: Add support to start/stop a CPU

Lucas Stach (2):
      soc: imx: gpcv2: handle additional power-down bits in handshake register
      soc: imx: gpcv2: handle reset clocks

Sven Van Asbroeck (3):
      dt-bindings: bus: imx-weim: document multiple address ranges per child node
      bus: imx-weim: support multiple address ranges per child node
      bus: imx-weim: guard against timing configuration conflicts

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  8 ++-
 Documentation/devicetree/bindings/bus/imx-weim.txt | 32 ++++++++-
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |  3 +
 drivers/bus/imx-weim.c                             | 70 ++++++++++++++++----
 drivers/firmware/imx/misc.c                        | 38 +++++++++++
 drivers/firmware/imx/scu-pd.c                      |  1 +
 drivers/soc/imx/Kconfig                            |  2 +-
 drivers/soc/imx/gpcv2.c                            | 76 +++++++++++++++++++++-
 include/linux/firmware/imx/svc/misc.h              |  3 +
 9 files changed, 212 insertions(+), 21 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
