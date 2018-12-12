Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7032BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:44:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B4620839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FY3nkWHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B4620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S+gIe8XTtq+mo8t97+U2JiodjC7GCtG3YJBZRj94qgo=; b=FY3nkWHTv/Ob90
	cwXR3LaxKO6UU8SJuYwGvmHn9M0ILILwvNTB9eHRAPF9d1oOLwQjZH+BAbentXkaPsARUvdK2uiCj
	KCfqywdC3Ei1DDE0SaY14vZegLPnAoY3gKXEcXJh3AVf9gYw785dbROnatmojv3rZruXV+cEH7stw
	cf276cgYurJQeHoKBV71vsvJ+OrEp/Yi/eV6xQch/UbDP+n9mkqE34rMXLB0cwRxCnWD3JBPfW3mn
	OzKFBO3mDaIhcQgxh0oskdQXB+NnnzbUT1YODF3KuZyZ6PS41e85g6y5r7V/jQe/CInhpZFPy2QpG
	rDFG6DJExqA1JHQNQNjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX08M-0005wV-1i; Wed, 12 Dec 2018 08:44:46 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX08I-0005vY-QY; Wed, 12 Dec 2018 08:44:44 +0000
Received: from p5b1274b7.dip0.t-ipconnect.de ([91.18.116.183]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gX087-0002RE-HG; Wed, 12 Dec 2018 09:44:31 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: arm@kernel.org
Subject: [GIT PULL 2/3] Rockchip dts64 updates for 4.21 round2
Date: Wed, 12 Dec 2018 09:44:31 +0100
Message-ID: <2442209.9nBR0uFduZ@phil>
In-Reply-To: <7153021.iXIDTOc0j0@phil>
References: <7153021.iXIDTOc0j0@phil>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_004443_006268_ED75D69B 
X-CRM114-Status: GOOD (  12.05  )
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

The following changes since commit cdd46460fe278e04d8ee665d975aa2962036838f:

  arm64: dts: rockchip: Add all CPUs in cooling maps (2018-11-19 14:45:35 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.21-rockchip-dts64-2

for you to fetch changes up to 953d9f3903659fb1e21f6453ef5221a7652ec908:

  arm64: dts: rockchip: Add on-board LED support on rk3399-rock960 (2018-12-11 20:09:38 +0100)

----------------------------------------------------------------
Support for the onboard LEDs of the 2 96boards (ficus, rock960),
hdmi output for rockpro64, vpu node on rk3399 and adding the
always on 32kHz clock on rk3399-Gru to get a more complete clock
tree.

----------------------------------------------------------------
Derek Basehore (1):
      arm64: dts: rockchip: Add 32k clk on rk3399-gru

Ezequiel Garcia (1):
      arm64: dts: rockchip: add VPU device node for RK3399

Manivannan Sadhasivam (2):
      arm64: dts: rockchip: Add on-board LED support on rk3399-ficus
      arm64: dts: rockchip: Add on-board LED support on rk3399-rock960

Oskari Lemmela (1):
      arm64: dts: rockchip: enable hdmi output on rk3399-rockpro64

 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts     | 78 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      |  7 ++
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts   | 79 +++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts |  7 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi          | 14 +++-
 5 files changed, 184 insertions(+), 1 deletion(-)




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
