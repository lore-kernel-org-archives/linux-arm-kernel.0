Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E4CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE84218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UIAmGDnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE84218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bl2ql77ctZ13v6Ks7Za5H2Y1GrxiHKST2lQd8WEtyOo=; b=UIAmGDnl3OaMbS
	OJsyf1NS5Q/um/EzOiWbi1iX0BlB5bZTDsHiFMCfZFhg2IB2dtO9Ky8xEiKAjzeT9JNuvWbqIQZi/
	MyfVUFVTyJ9By7JGYFIrYmQz2RJtbzhc3MQ6OFjk5F+L2ajaLLnac53qrA1dB+iIFVhC81zQ3uZzl
	O36qSnabY+pao5GeUt0kQ0Bd6Q6G061wb+e7OvKXyjeFkzKYfGG+wO/3ZSpclThx7+4BhOGL++U0s
	O2WgbF9l0hSEiYwbDFtIEDA1DP9AG39tvgz2c+ilDxot7ywPpmw6+koXe2cq8cmm4jY1z1bWh7Ld5
	+RAFURRApVGRT+q6weqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfq4F-0006Qc-Ci; Sat, 05 Jan 2019 17:49:03 +0000
Received: from kozue.soulik.info ([108.61.200.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfq4C-0006PU-Ah; Sat, 05 Jan 2019 17:49:01 +0000
Received: from misaki.sumomo.pri (unknown
 [IPv6:2001:470:b30d:2:c604:15ff:0:a00])
 by kozue.soulik.info (Postfix) with ESMTPA id C92E5100F5C;
 Sun,  6 Jan 2019 02:49:27 +0900 (JST)
From: Randy Li <ayaka@soulik.info>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH 0/3] The basic patches for rockchip video codec
Date: Sun,  6 Jan 2019 01:48:34 +0800
Message-Id: <20190105174837.19378-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_094900_477276_C39A32BA 
X-CRM114-Status: UNSURE (   7.49  )
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
Cc: ulf.hansson@linaro.org, zhangqing@rock-chips.com, heiko@sntech.de,
 geert+renesas@glider.be, sboyd@kernel.org, mturquette@baylibre.com,
 Randy Li <ayaka@soulik.info>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I will post a driver for video codec using the vendor userspace
interface. It is not used for merging but checking the work status of
the other devices and pre-patches need to be merged.

Without the following modification, video codec can't work properly.
I check the status of the upstream kernel for rockchip, network, eMMC,
USB and VOP work much worse and slow than the vendor kernel. I think the
video codec driver would be a good example to verify the other drivers.

Randy Li (3):
  clk: rockchip: add video clk parents for rk3399
  arm64: dts: rockchip: add power domain to iommu rk3399
  soc: rockchip: power-domain: export idle request

 arch/arm64/boot/dts/rockchip/rk3399.dtsi |  2 ++
 drivers/clk/rockchip/clk-rk3399.c        |  5 +++--
 drivers/soc/rockchip/pm_domains.c        | 23 +++++++++++++++++++++++
 include/dt-bindings/clock/rk3399-cru.h   |  2 ++
 include/soc/rockchip/pm_domains.h        | 18 ++++++++++++++++++
 5 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 include/soc/rockchip/pm_domains.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
