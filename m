Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A551AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:56:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704B421873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yf5tnq2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704B421873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N358o2hox61fvKdu0Rkr0KQtW/9oLLgsp0N81Tz2V9k=; b=Yf5tnq2VS/Kq6+
	vcy3THB/DtFMMptOSow+LqbQeY737Yd9wbRLhqyH2VCeL6CKiDXYZ154/4kcwbzRteOd5z9TWy9zn
	abVSlDbDQhzZTgKAheTS77N5+RQVNNsqNS+vK/LAufs1kLjmAftj9yHMzeRNxqoUhSckKrxMdaEKQ
	oNh0EqxCeWdyq/zjldiXGp1hOafCSayNEjsXtys0e4tW0eJfUAA33ks2uMAnxOmnauj4ijt7C6dpT
	wOY7KTeyBTOJptmPN2/0y2PfRZ3uYVYdhCOF7H38xQh1jYRmNMQdayEkhVbFvtxGGKYcSQk1/pn6+
	t3h9iCyyejWqqdgchFqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYaE-0002Q7-QO; Wed, 19 Dec 2018 09:56:06 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYa9-0002Oq-PH
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 09:56:04 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 9CA9E5FB45; Wed, 19 Dec 2018 17:55:46 +0800 (CST)
Date: Wed, 19 Dec 2018 17:55:46 +0800
From: Chen-Yu Tsai <wens@csie.org>
To: arm@kernel.org
Subject: [GIT PULL] Allwinner DT changes for 4.21 - Round 2
Message-ID: <20181219095546.GA2302@wens.csie.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_015601_966981_BB967D93 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Olof,

This is a late pull request for 4.21. There are two patches, as shown
in the tag's body. The first is a fix for content sent in the first
pull request for 4.21. The second is a patch from a series that had
been posted over a month ago, and the driver bits were merged today.
We'd like to have both patches included for 4.21.


Regards
ChenYu


The following changes since commit 5719ac19fc32d892434939c1756c2f9a8322e6ef:

  ARM: dts: sunxi: Fix PMU compatible strings (2018-12-07 15:34:24 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.21-2

for you to fetch changes up to afdd273e269ca8dee3c70c150d96b4de4f83d39e:

  ARM: dts: sunxi: Enable Broadcom-based Bluetooth for multiple boards (2018-12-19 17:26:14 +0800)

----------------------------------------------------------------
Allwinner DT changes for 4.21 - round 2

This is a small pull request for some lingering things that didn't make
the first round of patches.

First, the new suniv device tree included device tree headers for the
clock and reset indices. These header filers are going in through the
clock tree. Thus with the dt and core branches in arm-soc alone, it
doesn't build. One fix is included to remove the #include statements.
The defined macros aren't used yet as they were properly removed during
the review phase.

Second, Bluetooth using Broadcom (now Cypress) chips connected to UARTs
on various boards is enabled using serdev and the updated bindings for
Broadcom Bluetooth. The patch series had been sitting on the mailing
lists for a month, and the driver bits were just merged on 2018/12/19.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sunxi: Enable Broadcom-based Bluetooth for multiple boards

Maxime Ripard (1):
      ARM: dts: suniv: Fix improper bindings include patch

 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       | 25 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts     | 18 +++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 18 +++++++++++++++++
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts     | 14 +++++++++++++
 arch/arm/boot/dts/suniv-f1c100s.dtsi             |  3 ---
 5 files changed, 75 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
