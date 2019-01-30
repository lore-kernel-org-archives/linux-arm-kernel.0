Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDA9C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:20:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DFF21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GsGehSnz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="EU5LrvU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DFF21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rcrW61naZP+ay7ydi25m76hbSc3TpggeA+xrI8a7em8=; b=GsGehSnzDD9UTU
	s3Bjaxzny80+ATmcbGnFv1ruvUWD16yxl9Uae797WWeJ+J/Kb+Crcq9mHCCFhKwD00A5QdSilViuK
	aWJsCQwD1Sq88HTCmtQxKb3ne0na6RdAlRVNFjQVd1DoLk/8pYpgcGucx/rJX03wlte4BxOAFkEM8
	TyChmxZYqTZLBEu2li+58Re6lYObOO/noo2B+z19Hu01YBzbJlJx4hn+LEM7SnSupYfZbJ6mp3Qtl
	IRr6nYY49rZFIcfQtesmV/VDJnFiIw/T33+Q+EKtdOGOWgW0LJBDzEHW1aPbTKwsgJb7Z97dYiv4r
	CNhPPAIch4OikGtY0PNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gohMA-0004yn-6k; Wed, 30 Jan 2019 04:20:10 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gohM7-0004TO-NL
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 04:20:09 +0000
Received: by mail-qk1-x743.google.com with SMTP id y78so12939692qka.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 20:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=Fzcc/R4/54r9R11SG+ZIXMS8b7DnX/1jbnuwWDazTNQ=;
 b=EU5LrvU1K8DUn1+EdPN8g1DMPZzC9da4Lg12nihs5prQ3wxKNUxQS9Y2U/jsrAClS7
 k34NeVHI9Lx6w//cwCLb15PKRoyzL0x80MbDbbu6+EDTYr26u2EpKXOyOBQI2RDvuS93
 dBeQ3NV0VN8zeUElbFBiQzZVb8gHFahxVFHhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Fzcc/R4/54r9R11SG+ZIXMS8b7DnX/1jbnuwWDazTNQ=;
 b=KVbBOfz0T0U4RIr4eJckDZtRI6eQqZ6njx3Xc/fqiqDGN0FkEyjwdFHyx5PCwDfipw
 Qg8hIzxCqfQeeU8sVevBGQ/OsPW+YppAo8HjHkMDaAQ4nd84Bfg6/O8WLtbnMp+wKk+7
 PHERaXDMShj9tsIiXT/4wTpsP1YfeNIZSsiRmhWNX/LLKaPBo+kw4/B0IbDOhitge6uO
 gOQFzeopZv7Cr3u2O4CgVHaIIDVq6TEf2VSD594W8lweBaZKizJ3FsO8Ar7H9K17Uc/T
 AC+X8wjFwtcSqSx/RVLsIxeXzoz9qz/vBrqwKLSBFDXuz9HuaZB+15hexY92nYJCqHr/
 co3g==
X-Gm-Message-State: AJcUukcX2SXxT7c68AdyMSyFzl/0rp+sbyNnEJv7WT1E3vBTKxxH7hdl
 VNIdBG3L8uAgbg1yYa6fOm3TnjMYtqZIC8Pa/wk=
X-Google-Smtp-Source: ALg8bN5JIwpdireTRqxv1WMrIF8SnjhSWUCQrF8+J3V2WFazRrTXwSmLAKRkQtFKqnLcu8gb1mBzlr4x1fQtn4DxSNQ=
X-Received: by 2002:a37:bc06:: with SMTP id m6mr27121969qkf.336.1548822006032; 
 Tue, 29 Jan 2019 20:20:06 -0800 (PST)
MIME-Version: 1.0
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Jan 2019 15:19:54 +1100
Message-ID: <CACPK8Xczpf-wwGYJYHOgQ3TOpcLOz5wkPJbR8RfxjS0i2i52eg@mail.gmail.com>
Subject: [GIT PULL] ARM: aspeed: dts changes for 5.1
To: arm <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_202007_766406_F31DBCDD 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>,
 Mark Walton <mark.walton@serialtek.com>, Patrick Venture <venture@google.com>,
 John Wang <wangzqbj@inspur.com>, Vijay Khemka <vijaykhemka@fb.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello ARM Maintainers!

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
    tags/aspeed-5.1-devicetree

for you to fetch changes up to e1542521499070f88b18846f676b4cd2a166aee5:

  ARM: dts: aspeed: quanta-q71l: enable uart1 (2019-01-30 14:28:57 +1100)

----------------------------------------------------------------
ASPEED device tree updates for 5.1

 - New machine: Inspur ON5263M5, an Intel Xeon OCP compute node

 - Misc device tree updates from the OpenBMC project

 - #iterrupt-cells fix for GPIO controller

----------------------------------------------------------------
Joel Stanley (1):
      ARM: dts: aspeed-palmetto: Add i2c OCC hwmon node

John Wang (1):
      ARM: dts: aspeed: Add Inspur on5263m5 BMC

Mark Walton (1):
      ARM: dts: aspeed: Add #interrupt-cells property to gpio controllers

Patrick Venture (2):
      ARM: dts: aspeed: quanta-q71l: enable lpc_ctrl node
      ARM: dts: aspeed: quanta-q71l: enable uart1

Vijay Khemka (5):
      ARM: dts: aspeed: Add KCS support for LPC BMC
      ARM: dts: aspeed: tiogapass: Enable KCS
      ARM: dts: aspeed: tiogapass: Add sensors
      ARM: dts: aspeed: tiogapass: Add LPC devices
      ARM: dts: aspeed: tiogapass: Add uarts for SoL

Xiaoting Liu (1):
      ARM: dts: aspeed: stardragon4800: Add power supply

 .../dts/aspeed-bmc-arm-stardragon4800-rep2.dts     |  10 ++
 .../arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts |  55 +++++++-
 arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts   | 145 +++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |   5 +
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts       |   8 ++
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   1 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  34 ++++-
 7 files changed, 255 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
