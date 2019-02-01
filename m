Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9945AC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:24:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6700921908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6Y0MAjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6700921908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vfP2sPf0y9FnJiGKFrcT8CF+wqbNubcXJlSlKrddJSs=; b=O6Y0MAjV1VbOUx
	5jNzT5BrBjS5qk+HPfh84quXkAJGFlbeQxYio5ZjmMZ3tpJ9WJW8pGsXy7YZXIyG85YOiTjCVpd/j
	wf/cShJaFKtXjl3jF2MCDil21x51tnCA88hNPRy5ZD7fqI3gwlKuErf+gxr/EHzcEUHMH3jX1Y9zz
	i0p/zI6097nAuOeLDuBdvEPWCP4HNgLs7w4/sAQpWxf5pSBR19o8JuJPPmBz74Bk6nrxRhu56t8xy
	iO5JkrekHYq+ZPHUjvUEzNedU2/MFwk29dgChCafl1Bf0t2VTZ5Nf42IIMtEsB9G78WNn+yxu55cL
	l5mf6zNl9K+mZKP91c6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpWwA-0007HL-4s; Fri, 01 Feb 2019 11:24:46 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpWvr-00071M-9U; Fri, 01 Feb 2019 11:24:33 +0000
Received: from [88.128.81.210] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gpWvp-00019Q-QY; Fri, 01 Feb 2019 12:24:25 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: arm@kernel.org
Subject: [GIT PULL 2/2] Rockchip dts64 updates for 5.1
Date: Fri, 01 Feb 2019 12:24:29 +0100
Message-ID: <1744093.FyxTZ0jN5f@phil>
In-Reply-To: <2570520.8EeqtpO5V7@phil>
References: <2570520.8EeqtpO5V7@phil>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_032427_760234_3D96677D 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v5.1-rockchip-dts64-1

for you to fetch changes up to 79164c99db284d07aa4e84e57b469d225609799c:

  arm64: dts: rockchip: clean up the abuse of disable-wp (2019-01-28 10:51:22 +0100)

----------------------------------------------------------------
New boards are the Rock Pi 4, NanoPC-T4 and NanoPi-M4, with the last
two being part of a family and sharing bigger parts of the devicetree.
rk3328 got sound-related upgrades and a wider patch drops mmc display-wp
fields from nodes which shouldn't use it.

----------------------------------------------------------------
Akash Gajjar (1):
      arm64: dts: rockchip: add ROCK Pi 4 DTS support

Heiko Stuebner (1):
      arm64: dts: rockchip: move rk3328 #sound-dai-cells to the soc dtsi

Katsuhiro Suzuki (2):
      arm64: dts: rockchip: add rk3328 ACODEC node
      arm64: dts: rockchip: enable analog audio node for rock64

Robin Murphy (4):
      arm64: dts: rockchip: Add DT for NanoPi M4
      arm64: dts: rockchip: Refine nanopi4 differences
      arm64: dts: rockchip: Add NanoPC-T4 IR receiver
      arm64: dts: rockchip: 'Fix' nanopi4 uSD card detect

Shawn Lin (1):
      arm64: dts: rockchip: clean up the abuse of disable-wp

Tomeu Vizoso (1):
      arm64: dts: rockchip: Add devicetree for NanoPC-T4

 .../devicetree/bindings/arm/rockchip.yaml          |  12 +
 arch/arm64/boot/dts/rockchip/Makefile              |   3 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  26 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  14 +
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       |   1 -
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    |   1 -
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi      |   1 -
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |   1 -
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    |   1 -
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   1 -
 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts  |  91 +++
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts  |  66 ++
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   | 676 +++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts  | 606 ++++++++++++++++++
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |   1 -
 15 files changed, 1492 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
