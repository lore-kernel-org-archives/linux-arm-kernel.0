Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB81C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:48:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9719C20865
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XeClmDRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9719C20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gRBmRHI23cmSqzleIOTrtJn/x8jSXR99MreAoBC0Dcw=; b=XeClmDRuG0kafnooTrtoMtZeaD
	xymQ8z05r+qfa+PohrABJ7FEFgaecCUSZ0b/XnWpjcqCdEP8KVZmYsZXJHZ8LMOGImo+2iXDbwi1q
	RgDpxUmr1Cbl8JBXJJ+y+eM23bY9pSGYkU8e8QOkaBv1m30HZ9+L87GjSrBkmax6D9znLZp6HEram
	e2OHaC1uJ4rNGBG8a7Um96XueVrf7yqEzI0W6zdA1O/qDWZbc4j7CH8J1j6ZESmyq0546pxsYKyXU
	JHeCL2M4Ue7vXeKbHYXuoyI7m/Dx8E9zD0OmLUumSbd8R14wmghhq9JLDD8axPIlwK9QhAk1cn+d8
	9di2x3NQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGIh-0004E6-V0; Mon, 10 Dec 2018 07:48:23 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGIM-0003je-9C
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 07:48:05 +0000
Received: by mail-pl1-f194.google.com with SMTP id y1so4842235plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 23:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mS/2TOyy4LY7Or33HHWvLDgpaakgok9mlJH/bUzPeC4=;
 b=CDQfUBSn1RJKOdZ062k8f9EzZT/qyz3tVgSBiTv4fCVANCoNLnJM/YczWjhNkBEgvH
 Eu71KFn+3V8Xj1Vb1GbxWjwqx8+INXTr7KtxTe66AsePNEK9UzhfomR3juEQnyka0Q5r
 E4eL/AcZuEOBJtOKzLmsSm/sWShaAvvs/K+R+6WdO41Wbp2WuPiK/ntXIfIm1JSS0WBx
 qwBHGmQFBpBS8iNr68XVQ5GGtWWolDTPxro6FdrDBtcq1NQqSyFr14PJegyNcE6xy6Dm
 Vi2O7yvdkYjQVnoEpCqrcIOtg84G55RisaBs4VBwnsA5zODBmHkQ1raP6CO/TNz9Vf+9
 81Xw==
X-Gm-Message-State: AA+aEWYhMJASNmW2p7mjFOwZwm2pnGD1uyotAa8Desj5w+SW//wZoX37
 jD0zysG6TWRKWPtJZ+zxsYSWtA==
X-Google-Smtp-Source: AFSGD/XWVOUAsPwf7QasrVI+DPJJibgeC0D80R1eyjp48a6R/lghAKxJQfF/bEV6ZTinAAmH3Oy+iw==
X-Received: by 2002:a17:902:7201:: with SMTP id
 ba1mr11106641plb.105.1544428071538; 
 Sun, 09 Dec 2018 23:47:51 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id c13sm14363809pfo.121.2018.12.09.23.47.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 09 Dec 2018 23:47:50 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 4/7] i.MX7D PICO boards device tree update for 4.21
Date: Mon, 10 Dec 2018 15:46:35 +0800
Message-Id: <20181210074638.27873-4-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210074638.27873-1-shawnguo@kernel.org>
References: <20181210074638.27873-1-shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_234802_706609_2AFF15A1 
X-CRM114-Status: GOOD (  13.31  )
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

Hi,

I need to send this patch series as a separate branch/pull-request
instead of just as part of imx-dt-4.21, because it's based on a patch
on imx-fixes-4.20-3 (ARM: dts: imx7d-pico: Describe the Wifi clock),
which has been pulled by Olof.

In short, this pull-request is based on a merge of imx-dt-4.21 and
imx-fixes-4.20-3.  Please consider to pull, thanks.

Shawn


The following changes since commit 2e8566106d284badf6ec94509f77fdf7725d04b4:

  Merge tag 'imx-fixes-4.20-3' into imx7d/pico (2018-12-10 10:32:51 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx7d-pico-4.21

for you to fetch changes up to 7f68ffe0617b44fe189271701f6443beb23907ad:

  ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant (2018-12-10 10:33:36 +0800)

----------------------------------------------------------------
i.MX7D PICO boards update for 4.21:
 - It contains a series from Otavio Salvador that improves i.MX7D PICO
  SoM, and then adds Hobbit baseboard support on top of the improvement.

----------------------------------------------------------------
Fabio Estevam (8):
      ARM: dts: imx7d-pico: Do not harcode the memory size
      ARM: dts: imx7d-pico: Switch to SPDX identifier
      ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi
      ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
      ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
      ARM: dts: imx7d-pico: Extend peripherals support
      ARM: dts: imx7d-pico-pi: Extend peripherals support
      ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant

Otavio Salvador (1):
      ARM: dts: imx7d-pico: Improve WiFi regulator name

 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx7d-pico-hobbit.dts | 105 ++++++++++
 arch/arm/boot/dts/imx7d-pico-pi.dts     | 180 +++++-----------
 arch/arm/boot/dts/imx7d-pico.dtsi       | 355 +++++++++++++++++++++++++++-----
 4 files changed, 457 insertions(+), 184 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7d-pico-hobbit.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
