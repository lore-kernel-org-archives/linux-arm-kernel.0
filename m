Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9594EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:40:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3182082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jFKw9rwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3182082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free-electrons.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=S3eQGIXCOISG/sAXsAHRqfwhMQAZHVf/p3F798ppviw=; b=jFKw9rwXIKISEi
	emlnzVHlpV85E1eITeGrQRpPi2ggqUwVZNJdbszShIpSjrOfyw19xhmcHkmg7d9hCT8PpPvBRzGhB
	uC+25B7L4WRR+ansYlsSViXzhV+g1RAIQXV6KH1d7VBd2IY80nip6rmXm9Kc7kkYjrNWdoiGfBxpH
	yXD3qjmXuAsxwpT+ig86W3hkuEW7ZKTUQPXa9oHrK2uTcLmnoNwnkJmsgHZe72X/lZDImVpDx44em
	SVTPy0Y7jRfRz+DraKhw4lpijQ+SO5u9O0yb0fcuy4UnBWJTHzF2QQxtsCz/7rv6EO/dubPCENEYg
	OjrFUr2ch/tGbe0V9FCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVY9i-0001VH-En; Sat, 08 Dec 2018 08:40:10 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVY9e-0000dA-B7
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 08:40:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3F27120741; Sat,  8 Dec 2018 09:39:51 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
 by mail.bootlin.com (Postfix) with ESMTPSA id 10D1A20618;
 Sat,  8 Dec 2018 09:39:51 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 <arm@kernel.org>
Subject: [GIT PULL] ARM: mvebu: fixes for v4.20 (#1)
Date: Sat, 08 Dec 2018 09:39:52 +0100
Message-ID: <87efasv2cn.fsf@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_004006_533412_805C86DC 
X-CRM114-Status: UNSURE (   9.06  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.20.

Gregory

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.20-1

for you to fetch changes up to dae522045094ebfa9a10cf7951a8f79b02da8e15:

  Revert "arm64: dts: marvell: add CPU Idle power state support on Armada 7K/8K" (2018-12-05 09:28:17 +0100)

----------------------------------------------------------------
mvebu fixes for 4.20

Adding CPU Idle state in the device tree for Armada 8040 seems to
breaks boot on some board, so let's revert it waiting for a better
solution.

----------------------------------------------------------------
Baruch Siach (1):
      Revert "arm64: dts: marvell: add CPU Idle power state support on Armada 7K/8K"

 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  4 ----
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 27 ----------------------
 2 files changed, 31 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
