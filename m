Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E95EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:53:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259CB2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZiZUifif";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tLlNBpBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259CB2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Tw0NImKATE6mXNDfUE44UyPVKaF8SkIBDQf1YD80aGM=; b=ZiZUififkvf+os
	T1Xzl8VdCEP2OhklqsDReQ77OlIgKijZBkjCoevlRNbYwvqtS6R3ZesROCB0Mld1gRSv7vwLtwVEh
	6TpbtmSMzKfQkBqMXo/5Z44Jhop7Q2Su/LRahzw4MOtjLHLBkEyiMC+Jh11jhy9F27W2U8F2Pffq2
	YAIHtOQ+T7r8kqhdmTs8m0hSC5u2jRmra6CM459bYA80CQbmID5it5NcCMNxVypOjyR08xupHmGTN
	4GqnGPxRMmQZF3QYpmftRXTrdsXcrm5bJf0nzS6BkSG8l+IKxXbOCMBwc07wqqcNwuWih08OCy1R5
	nswAEEArp8rM7pQCKpjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7WG-0000MH-1R; Fri, 22 Feb 2019 09:53:24 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7WE-0000Lv-8n
 for linux-arm-kernel@bombadil.infradead.org; Fri, 22 Feb 2019 09:53:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HLxIPactJv6OF936WWNNMtfpz6/NuTqORLy2Vnh+Pqk=; b=tLlNBpBVFIigBQxpFMXA76FRig
 8QLVO9pwvFss62xSuzuD39ClJ2va/XU4pvlLrRkvMhNdsC6aB35h42Zxkgy0vGbpSFczo0Y21UUfM
 XQbMJiAkeo5UyD3MObmKyIj8KXClftsa0SOMiQ8hVqRGv/Iy4d2fsALgdpEa+Ax/nwANfn4mqLIw0
 +2eMbu1xyfSstmqIz8otEPNextttBHiXiKpFA6tgoVgi+e15bkz8f451hNQHEitRe2BUcIGSsfqhk
 JmvIRDs2W65h1gXjoAwSli8alY7DovPTFL5s1uJJVcTH2wrcMWhGxRS/Dzpuwyvw/Yld8gF/felEA
 3kAIH14A==;
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7WB-0001Og-11
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:53:20 +0000
X-Originating-IP: 109.212.201.85
Received: from localhost (alyon-652-1-170-85.w109-212.abo.wanadoo.fr
 [109.212.201.85]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7B85920003;
 Fri, 22 Feb 2019 09:52:43 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 <arm@kernel.org>
Subject: [GIT PULL] ARM: mvebu: fixes for v5.0 (#2)
Date: Fri, 22 Feb 2019 10:52:43 +0100
Message-ID: <87a7io176c.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045319_183265_11CB2ECA 
X-CRM114-Status: UNSURE (   8.81  )
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

Here is the second pull request for fixes for mvebu for v5.0.

Gregory

The following changes since commit b5f034845e70916fd33e172fad5ad530a29c10ab:

  ARM: dts: kirkwood: Fix polarity of GPIO fan lines (2019-01-10 12:23:47 +0100)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-5.0-2

for you to fetch changes up to bdd22a41d55bb0068c8685e28839ed9492e96aba:

  arm64: dts: clearfog-gt-8k: fix SGMII PHY reset signal (2019-02-19 16:09:11 +0100)

----------------------------------------------------------------
mvebu fixes for 5.0 (part 2)

Fix PHY reset signal on clearfog gt 8K (Armada 8040 based)
Fix NAND description on Armada XP boards which was broken since a few
release

----------------------------------------------------------------
Baruch Siach (1):
      arm64: dts: clearfog-gt-8k: fix SGMII PHY reset signal

Thomas Petazzoni (1):
      ARM: dts: armada-xp: fix Armada XP boards NAND description

 arch/arm/boot/dts/armada-xp-db.dts                 | 46 ++++++------
 arch/arm/boot/dts/armada-xp-gp.dts                 | 13 ++--
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    | 85 +++++++++++-----------
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |  2 +-
 4 files changed, 77 insertions(+), 69 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
