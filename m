Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0994C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:13:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D914421906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yaq6lX+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D914421906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hctMv8VG4HsVXGpAcPSWf4hUCAS1hJfcwyolibxqM3E=; b=Yaq6lX+E4fb0V9
	Pb/hf4FI9xpp6eddv8GFL0+tEzpaYZl2byu7bcm6BB54R51UfMqlntayTVLO5Q5u7mDVJXJBbW22j
	oOMH8gkZ/nqaWkhmfPTcxWpWSu6bE1oErNbCtjDotyJbzrv1ITNOxzsrdNSAlq5bz9JpMB55ZbMkS
	l8Grl8HCWlwCfRd1mf6H9jWewxbJNjm2ygvvBqDfRs7g2E3DIrYFQKIXUKD/EWJ7XhW1oq1Tbjos2
	Ntm+Hl1CazRKIc3QHwytlqZgw/AYAbyn/OCDhTZ4w4aCSN6F8yUkV7WnKVhc6Q88BPKV/46FDOA6I
	25cbKlZumD6+GySNyUlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpWlc-0000zR-M7; Fri, 01 Feb 2019 11:13:52 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpWlZ-0000z4-SP; Fri, 01 Feb 2019 11:13:51 +0000
Received: from [88.128.81.210] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gpWlX-00015N-F9; Fri, 01 Feb 2019 12:13:47 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: arm@kernel.org
Subject: [GIT PULL 1/2] Rockchip arm32 devicetree fixes for 5.0
Date: Fri, 01 Feb 2019 12:13:51 +0100
Message-ID: <7484850.KS8GUYnfXV@phil>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_031350_065935_E6A8B7F8 
X-CRM114-Status: UNSURE (   9.97  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below and in the following mail some fixes for Rockchip SoCs
on 5.0-rc. Nothing overly major thankfully.

So please pull

Thanks
Heiko

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v5.0-rockchip-dts32fixes-1

for you to fetch changes up to c9a8a92a9961dcd822015ee406e1a011b772112e:

  ARM: dts: rockchip: remove qos_cif1 from rk3188 power-domain (2019-01-07 09:14:42 +0100)

----------------------------------------------------------------
Drop one non-existent component from powerdomain list.

----------------------------------------------------------------
Johan Jonker (1):
      ARM: dts: rockchip: remove qos_cif1 from rk3188 power-domain

 arch/arm/boot/dts/rk3188.dtsi | 1 -
 1 file changed, 1 deletion(-)




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
