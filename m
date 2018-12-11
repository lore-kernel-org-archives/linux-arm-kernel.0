Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E81C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:11:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547CB2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z15c2Iea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547CB2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3DonoPIy77De2j9oV0N8fZ0cgeiLwtfVTIBlypGoJTo=; b=Z15c2Iea19mhbY
	+GI0dtigJrxGu2jFB26OEydKvxYs9ZS7N7fNC1TKmIwImATbwJZUm0J3ZckZMtzQmvSwhJCH7HPT0
	pzWELdCGbHWE0mtB4PA561SNZ3CiYM8noUbxybiVZH0fu0JDLczsfStVh95poAZOHMLCIBK6zwEBB
	YyOyEHqScwYDtEU9XlhRA7eQ4sqUWY5F4QrYQq3U6iv9wmW84hMuy4eJnD7HglzjShQwqQmhAvDrN
	7xLvmrJz29s8VXHmK/1kmU0FizX3IpHtEx22TYo3RVAsns1GqPNDQjd74MkQiLDPpB11/AUUophFk
	kxkfaALKD7wzXG50oi0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlZK-0002i8-27; Tue, 11 Dec 2018 17:11:38 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlZG-0002WH-Kn
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:11:36 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6C2A420510; Tue, 11 Dec 2018 18:11:23 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 422D6207AD;
 Tue, 11 Dec 2018 18:11:13 +0100 (CET)
Date: Tue, 11 Dec 2018 18:11:12 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 arm@kernel.org
Subject: [GIT PULL] ARM: at91: DT for 4.21
Message-ID: <20181211171112.GA30925@piout.net>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_091134_951524_E2B47C35 
X-CRM114-Status: GOOD (  11.55  )
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
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arnd, Olof,

Here is the DT pull request for 4.21. The clock DT binding switch has
been in -next for a while and doesn't seem to have any issue.

This is based on the 4.20 fixes branch that you alredy pulled.

The following changes since commit 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14:

  ARM: dts: at91: sama5d2: use the divided clock for SMC (2018-11-21 11:50:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.21-dt

for you to fetch changes up to d8007306f6ad18f2ba0dcad68ffe9b2fd1d56bfb:

  ARM: dts: at91: nattis: initialize the BLON pin as output-low early (2018-11-21 12:24:50 +0100)

----------------------------------------------------------------
AT91 DT for 4.21

 - Switch most platforms to the new clock binding
 - Small improvement for Axentia nattis

----------------------------------------------------------------
Alexandre Belloni (7):
      ARM: dts: at91: sama5d4: switch to new clock bindings
      ARM: dts: at91: sama5d2: switch to new clock binding
      ARM: dts: at91: at91sam9260: switch to new clock bindings
      ARM: dts: at91: at91sam9261: switch to new clock bindings
      ARM: dts: at91: at91sam9263: switch to new clock bindings
      ARM: dts: at91: at91sam9x5: switch to new clock bindings
      ARM: dts: at91: at91sam9rl: switch to new clock bindings

Peter Rosin (1):
      ARM: dts: at91: nattis: initialize the BLON pin as output-low early

 arch/arm/boot/dts/at91-nattis-2-natte-2.dts |   8 +
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts |  12 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |   4 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts        |   2 +-
 arch/arm/boot/dts/at91sam9260.dtsi          | 308 ++-----------
 arch/arm/boot/dts/at91sam9261.dtsi          | 287 +-----------
 arch/arm/boot/dts/at91sam9263.dtsi          | 315 ++-----------
 arch/arm/boot/dts/at91sam9g15.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9g20.dtsi          |  23 +-
 arch/arm/boot/dts/at91sam9g25.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9g25ek.dts         |   4 +-
 arch/arm/boot/dts/at91sam9g35.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9rl.dtsi           | 239 +---------
 arch/arm/boot/dts/at91sam9x25.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9x35.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9x5.dtsi           | 326 ++------------
 arch/arm/boot/dts/at91sam9x5_can.dtsi       |  18 +-
 arch/arm/boot/dts/at91sam9x5_isi.dtsi       |  11 +-
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi       |  19 +-
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi     |  11 +-
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi     |  11 +-
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi    |  11 +-
 arch/arm/boot/dts/sama5d2.dtsi              | 670 +++-------------------------
 arch/arm/boot/dts/sama5d4.dtsi              | 535 ++--------------------
 25 files changed, 295 insertions(+), 2541 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
