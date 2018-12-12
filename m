Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CFEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:29:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6538B20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fQ5vrVb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6538B20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e/Iuu6E7SYx/NOf9pBj+1PHt9DhFfS/1PnWP82+dTyI=; b=fQ5vrVb4obQcl0
	xR6u2LJdgQkLhm7gTBeixcZCqF1T0CeANxeJAhN9GcCnAXi0SGlSuCrmB3IJqM4UcJIp9zyS9Yxg7
	ozgR55V3QoZOVxW1gw4pzwG34xYf4ZXUfFf93QoPTl7vBQ9uxou/gubNnH/lw2UGX1NMnuhQ4at+8
	aHsXTKVHlfXA/prNGH9vQXTHFeA0p5eNfpjfQWCs2yVUtVimjO/rBJ97NCIuPXOWw0qd7+xkzkWfK
	pzvdkxTd14blfKT774RVFw8Hqp1u4UjFwJOEGcce/aWXUb8rwG2HSGxllFJvEwkeMIb4ms3ZZ5nuF
	wv+6Fp7bje+4iSKBGclw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWzsy-0007mF-Tw; Wed, 12 Dec 2018 08:28:52 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWzsu-0007kk-2h; Wed, 12 Dec 2018 08:28:51 +0000
Received: from p5b1274b7.dip0.t-ipconnect.de ([91.18.116.183]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gWzsg-0002M0-M8; Wed, 12 Dec 2018 09:28:34 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: arm@kernel.org
Subject: [GIT PULL] Rockchip arm64 devicetree fix for 4.20
Date: Wed, 12 Dec 2018 09:28:34 +0100
Message-ID: <5618815.AsiCPEelux@phil>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_002848_270725_706FBDE3 
X-CRM114-Status: GOOD (  11.47  )
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

Hi Arnd, Kevin, Olof,

one more fix for some regulators on the rk3399 rockpro64
turned up that may be nice to have in 4.20 still.

Please pull
Heiko

The following changes since commit c1d91f86a1b4c9c05854d59c6a0abd5d0f75b849:

  arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou. (2018-11-13 15:02:07 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.20-rockchip-dts64fixes-2

for you to fetch changes up to 690e16bada6029694740d5501025faf483d14339:

  arm64: dts: rockchip: fix rk3399-rockpro64 regulator gpios (2018-12-06 13:46:16 +0100)

----------------------------------------------------------------
rockpro64 regulator fixes that cause stability issues

----------------------------------------------------------------
Oskari Lemmela (1):
      arm64: dts: rockchip: fix rk3399-rockpro64 regulator gpios

 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
