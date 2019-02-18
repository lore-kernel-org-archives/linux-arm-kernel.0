Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29284C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:18:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04EA218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b8adIOkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04EA218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9tUbEOc8lOPfs5vJArUOGsfzxbntGKQ8JRStNP6z1jQ=; b=b8adIOkJpX2mKj
	m/HWXa8cYUaCPOyCzX1MgmrcC+LtlTJb/nFYlglBz/93oqzGh0hOST+O/JbKeoFNIaN0+urc+30DO
	EdotvaXwC5SzmQ+cuqPbLw3vhRnE6AG+jvOB4FI/pMJlFw/eF+kcNZlukJZHFhLdIEqSRLiQBkzEG
	J6W/UDRGXG2bswQneVMBceOsi0dWs7M4wh4mbJiA3dHnS/JDL13wNsYVdOgQiVfs5kVkCfC7eBA6k
	tp1TFa2Wux/1gKMrf+kgHgAg55mYdGtVtqO6DeYT0qkOF9uT73ROAt2nUhlrkx6+07zMyAlsGUFyh
	+kj7BZbdjkH+R+lfpEgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWdl-0000lp-QG; Mon, 18 Feb 2019 00:18:33 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWdg-0000lK-Cg; Mon, 18 Feb 2019 00:18:30 +0000
Received: from p5b127a91.dip0.t-ipconnect.de ([91.18.122.145]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gvWdb-00042y-Sg; Mon, 18 Feb 2019 01:18:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: arm@kernel.org
Subject: [GIT PULL 1/2] Rockchip dts32 updates for 5.1 - round 2
Date: Mon, 18 Feb 2019 01:18:23 +0100
Message-ID: <1972197.JU0Au1QvNm@phil>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_161828_580979_C9174B27 
X-CRM114-Status: GOOD (  11.59  )
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

Hi Arnd, Kevin Olof,

please find below and in the reply a second round of Rockchip devicetree
updates targetted at 5.1. Again nothing major just some more collected
improvements. So if there is still time, please pull.

Thanks
Heiko

The following changes since commit e6b97a47b5b9512828859778acafd3fe107b395e:

  ARM: dts: rockchip: clean up the abuse of disable-wp (2019-01-28 10:51:55 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v5.1-rockchip-dts32-2

for you to fetch changes up to 5aed37a5cdef6453eb3bf307574e19e547ca0432:

  ARM: dts: rockchip: add chosen node on veyron devices (2019-02-16 21:18:26 +0100)

----------------------------------------------------------------
A number of improvements for rv1108 boards, removal of an obsolete property
from the Edison tablet and a chosen node for veyron devices.

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      ARM: dts: rockchip: add chosen node on veyron devices

Johan Jonker (1):
      ARM: dts: rockchip: remove cap-mmc-highspeed from rk3188-bqedison2qc mmc1 node

Otavio Salvador (3):
      ARM: dts: rockchip: Fix vcc5/6-supply representation on rv1108-elgin
      ARM: dts: rockchip: Use the correct regulator properties on rv1108-elgin
      ARM: dts: rockchip: Use the correct regulator properties on rv1108-evb

 arch/arm/boot/dts/rk3188-bqedison2qc.dts |  1 -
 arch/arm/boot/dts/rk3288-veyron.dtsi     |  4 ++++
 arch/arm/boot/dts/rv1108-elgin-r1.dts    | 34 +++++++++++++++++---------------
 arch/arm/boot/dts/rv1108-evb.dts         | 20 +++++++++----------
 4 files changed, 32 insertions(+), 27 deletions(-)




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
