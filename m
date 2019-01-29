Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F879C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:21:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1382F20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oWbPm0D3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1382F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dj8JHtj6trG4fHjlQN9P0ujJCHzmbCFPs6GUbe+j/qw=; b=oWbPm0D3Wwu5kr
	XKmFvkgw530mznP3/vPMlLme9D2ZPu6JOJeKa4zvfyuhAwezLE1WtglB20uo+oo35o6jb9bIdMu16
	KRSxq4lbPME+Nvle4TLHLdEHbo8PfgbsuAvht25Ue4xPeUcM2lu/kcf2jfls3Zh8cA0wUsrOpHRMp
	a0TriuXuX7UC2pca4iuUOPWkDt48E3c8BWsMkVX7nAYypnVudsf1u6GjRA8Z5Dya2PalZUwuR48Tw
	FC19dvWshVzwMu483o+01yaW9s1sqTHG7LISK1iOdxhn25+LcVAyrL9IFHEOK8vQrx+f26X53rKaA
	cN4rJwSOwtgJOdOPMRcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYwh-00020X-7O; Tue, 29 Jan 2019 19:21:19 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYwP-0001o2-1K
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:21:05 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 3026B43EED3;
 Tue, 29 Jan 2019 19:20:56 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH 00/13] ARM: lpc32xx: various minor fixes and clean-ups
Date: Tue, 29 Jan 2019 21:20:36 +0200
Message-Id: <20190129192049.11223-1-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190129_192056_219096_D42FC6C7 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message. 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192056_219096_D42FC6C7 
X-CRM114-Status: UNSURE (   8.13  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The changeset consists of a number of minor clean-ups and fixes for
NXP LPC32xx SoC support, likely the most noticeable change is stripping
of platform data for PL180 SD/MMC controller and PL111 LCD controller,
originally both given configurations are Phytec phyCORE-LPC3250 board
specific, and now the right description is added to the correspondent
board dts file. The LCD controller is proven to work with PL111 DRM
driver, this justifies the correctness of switching the platform from
a legacy fbdev to the new DRM driver.

Fixed voltage regulator and DRM simple panel driver should be enabled
by default in NXP LPC32xx defconfig file to get better support of
Phytec phyCORE-LPC3250 board.

Vladimir Zapolskiy (13):
  ARM: defconfig: lpc32xx: enable fixed voltage regulator support
  ARM: defconfig: lpc32xx: enable DRM simple panel driver
  ARM: dts: lpc32xx: fix ARM PrimeCell LCD controller variant
  ARM: dts: lpc32xx: fix ARM PrimeCell LCD controller clocks property
  ARM: dts: lpc32xx: phy3250: fix SD card regulator voltage
  ARM: dts: lpc32xx: remove inclusion of deprecated skeleton.dtsi
  ARM: dts: lpc32xx: phy3250: remove regulators umbrella device node
  ARM: dts: lpc32xx: phy3250: setup LCD controller to panel interface
  ARM: dts: lpc32xx: phy3250: add unit address to memory device node
  ARM: dts: lpc32xx: ea3250: add unit address to memory device node
  ARM: dts: lpc32xx: ea3250: beautify gpio keys children nodes
  ARM: lpc32xx: remove platform data of ARM PL180 SD/MMC controller
  ARM: lpc32xx: remove platform data of ARM PL111 LCD controller

 arch/arm/boot/dts/lpc3250-ea3250.dts  | 20 +++---
 arch/arm/boot/dts/lpc3250-phy3250.dts | 87 ++++++++++++++++-----------
 arch/arm/boot/dts/lpc32xx.dtsi        | 12 ++--
 arch/arm/configs/lpc32xx_defconfig    |  3 +
 arch/arm/mach-lpc32xx/phy3250.c       | 84 --------------------------
 5 files changed, 75 insertions(+), 131 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
