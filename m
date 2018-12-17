Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51059C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:40:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F377620672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BcbqzGu5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L70vPrdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F377620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=J4PbaXhhtdnON+KMWn/DtO76AmV9oGkjOneMcrXONqc=; b=BcbqzGu51m4iHZ
	gcOzArrZdpD7VgH8EsrTMgkowq8r7CynKCnCB/xCqmyg6RoGLavTtZ/rKKMa2sgiXYmT6je+GMJg2
	5KhLu3OQ9h00FIYIc+16yHKTyRUsHgAsgXmxdLGEySmA+pUV/52xnXoLY8aRU18auGyjBFajSxXzS
	MbTQu05Su6Yhf89Wo2q7L0s0M11GYYgi1570YvWa3eVxdwySVjOxOLt648uCIhiLmYzuV8xK0rB5C
	dok57zbM0vcCZWLn45YpLXy/rzlITTyaa2Zvad2w32MuT+unyPbdk1KtTYDV8QOiC8+NRldA/xGx2
	Cc5DtFF0BNyEM+ukZscA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYsC7-0006W3-2u; Mon, 17 Dec 2018 12:40:23 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYs9S-0002rf-37; Mon, 17 Dec 2018 12:37:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sdnrlv5TjOsJE3G5P46rY44iJpWV3cBFRu/h9LPxPXc=; b=L70vPrdKXsqYYyu7scTJL2Pi2w
 F6wGZ63jT2fj5r3Hxkz0XKRLYVMUzhVMUwtG5Vzhb+/mHm1R5TkbbiaPADsvAxnRURwQossdksh2g
 ID8yL2sGWKLaHuDQhdrK6gje+m1UKtbg3n0U9rEJQBB/VCSbIq9WZGv//tqzIuvgqTblm12jEiGfe
 T7rjBWeDuNQ6b7mqWeDaWh+TVxzkkiFmT9gkJTt3n6sJniwgj3HYPWFYkUWfHF6nSbPRqHYZlnkjd
 e2bPZIIUQRlaEerqVKFHJL+L7j4eCiAy+2M17eG0EM1xS7mh5Id0e8c4SGeEjKcH8shM+t0UiAa8X
 zvzsh7Mg==;
Received: from gloria.sntech.de ([185.11.138.130])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYs9O-0000Z7-TV; Mon, 17 Dec 2018 12:37:36 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80]
 helo=phil.dip.tu-dresden.de)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gYs8q-0003o4-Sv; Mon, 17 Dec 2018 13:37:00 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	hjc@rock-chips.com
Subject: [PATCH 00/15] drm/rockchip: add display support for rk3368
Date: Mon, 17 Dec 2018 13:36:35 +0100
Message-Id: <20181217123650.6773-1-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_073735_067697_D7A9BDCA 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, architt@codeaurora.org,
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, a.hajda@samsung.com, robh+dt@kernel.org,
 Laurent.pinchart@ideasonboard.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This ties together the last lose ends to make display support
work on rk3368 and includes some missing clock exports,
compatible values+settings for the specific encoder drivers
and quite a number of dt-changes enabling power-domains first
and then adding the display stuff.

The core rk3368 support for powerdomains and the vop is in the
kernel for quite a while already but hasn't been used so far.


Heiko Stuebner (15):
  clk: rockchip: add clock ids for dphy rx and tx channels on rk3368
  clk: rockchip: add clock id 24m dsi clock on rk3368
  clk: rockchip: use clock ids for dphy rx and tx on rk3368
  clk: rockchip: use clock id for 24m dsi on rk3368
  drm/rockchip: dw_hdmi: add support for rk3368
  drm/rockchip: analogix_dp: add support for the rk3368 variant
  drm/rockchip: dw-mipi-dsi: add support for rk3368-variant
  arm64: dts: rockchip: default values for core clocks on rk3368
  arm64: dts: rockchip: add power-domain nodes on rk3368
  arm64: dts: rockchip: add dw-hdmi controller on rk3368
  arm64: dts: rockchip: add analogix-dp controller on rk3368
  arm64: dts: rockchip: add dw-mipi-dsi controller on rk3368
  arm64: dts: rockchip: add core display support for rk3368
  arm64: dts: rockchip: enable display on rk3368-r88
  arm64: defconfig: enable hym8563 rtc driver

 .../display/rockchip/analogix_dp-rockchip.txt |   1 +
 .../display/rockchip/dw_hdmi-rockchip.txt     |   1 +
 .../display/rockchip/dw_mipi_dsi_rockchip.txt |   1 +
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts   |  17 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      | 309 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/rockchip/clk-rk3368.c             |   6 +-
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  17 +-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |  25 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  15 +
 include/dt-bindings/clock/rk3368-cru.h        |   3 +
 11 files changed, 387 insertions(+), 9 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
