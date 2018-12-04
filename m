Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E791C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:50:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DF6208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pvnrOSgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DF6208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gwCQBEf2g7FJdhQW2X/XC4BWPD6cdf2UIFP9ro79gtg=; b=pvnrOSgMgqCxw+
	l9ZGoVA7gxzVaJyd+fhZ9uD/ui61j51cnwYrPuK6ozr0goZ7xJyZYpIw/JWi0aC7jlIDKOoE5HD/W
	/Of2i0h6QmMv9GyH+4fs+ZTb6/ZuY/IZeZJ2Yo7FZZdipI8Y0QJAcOdOPnPSJB27qJH0StBD3ZXDr
	1BQkNYLVsSgAAW3Umz/TXcuw4DX4a0CZkZ21ErYoNvcWrp5zT9l1PYQ26odz0LP2PHVq4OZ0wOs1v
	DbTcErwW+O1YU8m5cN9kbH5Eo7GEGxw6537ohqgKiBQQ5Q2csOJRcBnFLiuIHjd7JkfxUn/0JhLPl
	GxaDfmP/XG72u2uHuVXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU5Tb-0000HB-70; Tue, 04 Dec 2018 07:50:39 +0000
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU5TW-0000EQ-Op
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 07:50:36 +0000
Received: from belgarion ([90.89.234.36]) by mwinf5d67 with ME
 id 7jqH1z00H0nnJME03jqH2V; Tue, 04 Dec 2018 08:50:21 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Tue, 04 Dec 2018 08:50:21 +0100
X-ME-IP: 90.89.234.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: arm@kernel.org
Subject: [GIT PULL] pxa-dt for v4.21
X-URL: http://belgarath.falguerolles.org/
Date: Tue, 04 Dec 2018 08:50:17 +0100
Message-ID: <87r2exu3wm.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_235035_087406_BC247E9A 
X-CRM114-Status: GOOD (  18.45  )
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
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is a pxa pull request for 4.21 device-tree. Please consider pulling.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-dt-4.21

for you to fetch changes up to ad8044f87c0b53ee45f5d367584eefb222a06883:

  ARM: dts: pxa3xx: Add Raumfeld DTS files (2018-12-03 22:51:01 +0100)

----------------------------------------------------------------
This device-tree pxa update brings :
 - various fixes from Daniel (W=12 issues mainly)
 - support for the first pxa3xx devicetree pxa board

----------------------------------------------------------------
Daniel Mack (8):
      ARM: dts: pxa3xx: add gcu node
      ARM: dts: pxa2xx: drop #address-cells and #size-cells from /cpus
      ARM: dts: pxa3xx: drop #address-cells and #size-cells from pinctrl node
      ARM: dts: pxa2xx: fix hwuart memory range
      ARM: dts: pxa3xx: order timer and gcu nodes under /pxabus
      ARM: dts: pxa3xx: clean up pxa3xx clock controller node name
      ARM: dts: pxa: clean up USB controller nodes
      ARM: dts: pxa3xx: Add Raumfeld DTS files

 arch/arm/boot/dts/Makefile                         |   7 +
 arch/arm/boot/dts/pxa27x.dtsi                      |   2 +-
 arch/arm/boot/dts/pxa2xx.dtsi                      |  13 +-
 arch/arm/boot/dts/pxa300-raumfeld-common.dtsi      | 405 +++++++++++++++++++++
 arch/arm/boot/dts/pxa300-raumfeld-connector.dts    |  73 ++++
 arch/arm/boot/dts/pxa300-raumfeld-controller.dts   | 266 ++++++++++++++
 arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts    |  11 +
 arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts    |  11 +
 arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dts  | 137 +++++++
 arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts    |  11 +
 .../boot/dts/pxa300-raumfeld-tuneable-clock.dtsi   |  85 +++++
 arch/arm/boot/dts/pxa3xx.dtsi                      |  30 +-
 12 files changed, 1027 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-common.dtsi
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-connector.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-controller.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-tuneable-clock.dtsi

-- 
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
