Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:57:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794AD2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hDBl7O0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794AD2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Pf6NX1sNT/EsHWgCJvK6FBdPLutMj+50kTtNZ1jMOVE=; b=hDB
	l7O0zTVkamMfOjiP77Q6nUG5mn8rSwkedQBpJrk7zDHXN2QZKF8k5NPF6NN72iBDzPFGJtJ58iHrD
	JycrDF7y6i9j8yVlkv5teU7kXigJrSw9YuPkUgKkKdwgesihJhkAmUqPco1ytUzDH49cCJLvBNXdC
	t9jEyU3lS43XBEvJLFE/nYT0/tQvlT4OQLFdC1/j7N7sCM+DhchLd4KXNaglhj5kETli4wHufjMjZ
	isY1PXVASqPJvrQ+GOg474P4oHnJQXL5wq7Y8vrjQgvadpoXPoxIWRDL3Y4drZpfkNXWUKq9jKWyu
	BlnstY1gKG0nFO41EUni6H0ppeqr33w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzNW-0003nF-TG; Tue, 08 Jan 2019 21:57:42 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzNU-0003mQ-3Y; Tue, 08 Jan 2019 21:57:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9125F80D;
 Tue,  8 Jan 2019 13:57:37 -0800 (PST)
Received: from DESKTOP-VLO843J.lan (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A2A43F5AF;
 Tue,  8 Jan 2019 13:57:35 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: heiko@sntech.de
Subject: [PATCH 0/5] NanoPC-T4 (and a bit of NanoPi M4) support
Date: Tue,  8 Jan 2019 21:57:22 +0000
Message-Id: <cover.1546981251.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_135740_153390_BBFBB889 
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

Since I finally got to spend some quality time with my NanoPC-T4 over
the holidays, I set to testing Tomeu's v4 patch, and ended up poring
over the schematics of all 3 boards and doing a fair bit more hacking.
I've taken the liberty of addressing the remaining review comments and
posting it as v5 here so as to also start adding stuff on top. My
current step is trying to get Wifi and Bluetooth working reliably...

Robin.


Robin Murphy (4):
  arm64: dts: rockchip: Add DT for NanoPi M4
  arm64: dts: rockchip: Refine nanopi4 differences
  arm64: dts: rockchip: Add NanoPC-T4 IR receiver
  arm64: dts: rockchip: Fix nanopi4 uSD card detect

Tomeu Vizoso (1):
  arm64: dts: rockchip: Add DT for NanoPC-T4

 .../devicetree/bindings/arm/rockchip.yaml     |  10 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../boot/dts/rockchip/rk3399-nanopc-t4.dts    |  91 +++
 .../boot/dts/rockchip/rk3399-nanopi-m4.dts    |  66 ++
 .../boot/dts/rockchip/rk3399-nanopi4.dtsi     | 677 ++++++++++++++++++
 5 files changed, 846 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
