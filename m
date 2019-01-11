Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E708AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:59:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B652620874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B4XdkFa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B652620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lrACNyuzZ9QmEJYv0bleGfs/7hTm2vMDba5U9XtGH3I=; b=B4XdkFa2BGWyyy
	XtILmUps2UhoWUb85JQ9fDYqpyf2WODzUpiaE1iYLw/lM1drtnQQK9OrbyE9d8ghKpEHNKeFE4fLy
	L6qUagCYft3luG1vslCgvvUxmswDz+4gZCAdWMShHS44/FfJb68DkBr2Saf0K99kMWhHEosS90DkM
	gaFvtboYGHlKtr5qku/PSUplW1zB6aDHPS/OOYvyObvG/qxhjaJHwmpIVzW7iGIdl+rs8I7zh8gIa
	cYhzuanRcBWK2XPwceEe7USZw93hjBnx1DqkI3KmhuKwY8KfpaX+PcbqvXSKwt5pBXbR4zcgbjBeo
	jfwFJMJAS884eYl5IbLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi09B-0006oh-CP; Fri, 11 Jan 2019 16:59:05 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi097-0006o0-MS
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 16:59:03 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 28ED62078E; Fri, 11 Jan 2019 17:58:58 +0100 (CET)
Received: from localhost (alyon-652-1-22-18.w109-213.abo.wanadoo.fr
 [109.213.145.18])
 by mail.bootlin.com (Postfix) with ESMTPSA id E6AF9206A6;
 Fri, 11 Jan 2019 17:58:47 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 <arm@kernel.org>
Subject: [GIT PULL] ARM: mvebu: fixes for v5.0 (#1)
Date: Fri, 11 Jan 2019 17:58:48 +0100
Message-ID: <87zhs7qgfr.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_085901_872862_93435392 
X-CRM114-Status: GOOD (  10.88  )
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

Here is the first pull request for fixes for mvebu for v5.0.

Gregory

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-5.0-1

for you to fetch changes up to b5f034845e70916fd33e172fad5ad530a29c10ab:

  ARM: dts: kirkwood: Fix polarity of GPIO fan lines (2019-01-10 12:23:47 +0100)

----------------------------------------------------------------
mvebu fixes for 5.0

They are all device tree fixes which also worth being in stable:

 - Reserve PSCI area on Armada 7K/8K preventing the kernel accessing
   this area and crashing while doing it.

 - Use correct PCIe reset signal on MACCHIATOBin  (Armada 8040 based)

 - Fix polarity of GPIO fan line D-Link DNS NASes(kikwood based)

----------------------------------------------------------------
Baruch Siach (1):
      arm64: dts: marvell: mcbin: fix PCIe reset signal

Heinrich Schuchardt (1):
      arm64: dts: marvell: armada-ap806: reserve PSCI area

Linus Walleij (1):
      ARM: dts: kirkwood: Fix polarity of GPIO fan lines

 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |  4 ++--
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |  2 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
