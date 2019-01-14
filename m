Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564D2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:05:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2238E20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d/q6lzni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2238E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uLbcZKKafBQyE3G+/mqDhQSsWcxf2LpvuExq/C15ARQ=; b=d/q6lzniee29HI
	poZkASkluB4bCLcfHi+pW9FznDfKSSMKCjXaETAiAu3h0H28pjFP77iOfoPwb61BYTYmtNj9aEDqw
	cvTz2RUJ/zGHuwe9qLrjOH3cptosNOrdI7S4J8K//6B+u3Uz6iPcS6nm900RI9fMZghwrXmDDdcAH
	AUCKWvXCOUIJG1/vZgIrBrUdEVKag0VPpMhnKWvL/N2yZobc++Archcx+MgR1ThdQc8Fyv+Pmyo0R
	p+pX6rjQzHyxkCxWz1GeX8RltHyp6lK13W1geBsNDCOKlEm9OlDC3YlGiyc0qhzQbWP0oMeHr6lBt
	NLGvb6Az0scbtdUC2RwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0zz-0006ge-MZ; Mon, 14 Jan 2019 12:05:47 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0zw-0006g0-Sd; Mon, 14 Jan 2019 12:05:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC6A80D;
 Mon, 14 Jan 2019 04:05:42 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E84203F5BD;
 Mon, 14 Jan 2019 04:05:41 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: heiko@sntech.de
Subject: [PATCH v2 0/4] NanoPC-T4 (and a bit of NanoPi M4) support
Date: Mon, 14 Jan 2019 12:05:30 +0000
Message-Id: <cover.1547466003.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_040544_932167_9278A01F 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

With the initial patch now queued (thankfully solving the version-number
conundrum), here's an updated v2 of my further changes with the tweaks
Heiko pointed out. Comparing GRF dumps didn't give any insight into the
SD card thing, so I've kept the GPIO patch; ~100 interrupts per insertion
is still more useful than 0!

Robin.


Robin Murphy (4):
  arm64: dts: rockchip: Add DT for NanoPi M4
  arm64: dts: rockchip: Refine nanopi4 differences
  arm64: dts: rockchip: Add NanoPC-T4 IR receiver
  arm64: dts: rockchip: 'Fix' nanopi4 uSD card detect

 .../devicetree/bindings/arm/rockchip.yaml     |  6 +-
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3399-nanopc-t4.dts    | 74 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-nanopi-m4.dts    | 66 +++++++++++++++++
 .../boot/dts/rockchip/rk3399-nanopi4.dtsi     | 74 ++++---------------
 5 files changed, 158 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts

-- 
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
