Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF5C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:14:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA66221904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qXh1QVma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA66221904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XMXz/sSI+DspkRK8I+wJhGQxGX5bAWB7RdwV//lQs7I=; b=qXh1QVmaBxvA02
	euRUen8iS4zBu0yecoSOvDfe9Hv2NXpMd0b/373QvNqXKTBjsnl17TT5ksM0LPwtDKgIxfWEFsu2z
	4hS/PJ5CKatRclP5PsYScJrWWwbrrnRazqBgg2m62vCWu1ZMfVoAvx6BJhg2Fy4oeFBotYMuNcHTk
	fN7Dx26nmJoURoHy3iu2d7lJ9J7bwQTRVmkWH2kY5rChBXnb7d5FjbDfgT9tRUMuCEpwpR8D3YXEM
	ceGlGEa/jG6UmQe6Bha8kDtPFKgRSrPR7/XIWAX4MI8iKWwYByjFcTzvu2BT0x9PzS4R9qY/mPMeW
	kqLdTTZC3AGJl9b62Xww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpWmP-0001Hs-0y; Fri, 01 Feb 2019 11:14:41 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpWmL-0001HP-Py; Fri, 01 Feb 2019 11:14:39 +0000
Received: from [88.128.81.210] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gpWmK-00015l-EZ; Fri, 01 Feb 2019 12:14:36 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: arm@kernel.org
Subject: [GIT PULL 2/2] Rockchip arm64 devicetree fixes for 5.0
Date: Fri, 01 Feb 2019 12:14:40 +0100
Message-ID: <23121360.LiWTZRSn6P@phil>
In-Reply-To: <7484850.KS8GUYnfXV@phil>
References: <7484850.KS8GUYnfXV@phil>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_031437_984674_0B30DEC3 
X-CRM114-Status: GOOD (  11.13  )
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v5.0-rockchip-dts64fixes-1

for you to fetch changes up to 26e2d7b03ea7ff254bf78305aa44dda62e70b78e:

  arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-rock64 (2019-01-27 23:14:04 +0100)

----------------------------------------------------------------
Fix for new dtc graph warnings and a regulator fix for rock64.

----------------------------------------------------------------
Dmitry Voytik (1):
      arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-rock64

Enric Balletbo i Serra (1):
      arm64: dts: rockchip: fix graph_port warning on rk3399 bob kevin and excavator

 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts             | 2 ++
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts          | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
