Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EDFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:28:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07472190B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R23vLKEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07472190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=l7NsEYSEAV93/TpMav+ZkKxxFyStsJDmxZOxWw0GV+I=; b=R23vLKEeAFiRm6
	iKhhsqawRNcJGW0af2PzfHF3G4ZRpZdFPuksN+oyKyMDo4N1DnJu/hRHeMc3kO7Ny+n8Z1T2APOXB
	TGUWxRxo39tFmZ+QcJX8E4FYjXrBC6cDGOBE6xrdBgg3AF6dO4vaWmBZEQrayg1Btam1h7iYtDppH
	8ultfKQV6eQXsjacFZ8y4Lm1yS8U1GynLntpEp35PV3weE43BTGIN+lRum6pR3rlOXdMz4WiHGfcM
	n4UvH+pEzKX1ilUr9xptgfdDvS12a4R1Obie56rdDhlkDhFkNNyEzzL10djwTKkuWDmli9s0VtuLa
	X0YBimKcifVIUEZchW6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtdje-0006l4-AG; Tue, 12 Feb 2019 19:28:50 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtdja-0006kO-WC
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 19:28:49 +0000
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr
 [86.202.231.219])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id EDE311C0007;
 Tue, 12 Feb 2019 19:28:38 +0000 (UTC)
Date: Tue, 12 Feb 2019 20:28:38 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 arm@kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.1
Message-ID: <20190212192838.GA12677@piout.net>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_112847_189634_266AF225 
X-CRM114-Status: GOOD (  11.10  )
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

Here is the only AT91 pull request for this cycle.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.1-dt

for you to fetch changes up to 31f031f73a01fb83fd6f4abfff04a79b360219e1:

  ARM: dts: at91: replace gpio-key,wakeup with wakeup-source property (2019-01-08 19:12:40 +0100)

----------------------------------------------------------------
AT91 DT for 5.1

 - Enable QSPI NOR on sama5d2 SoM1
 - replace deprecated gpio-key,wakeup property

----------------------------------------------------------------
Claudiu Beznea (2):
      ARM: dts: at91: at91-sama5d27_som1: add QSPI1 + SPI NOR memory nodes
      ARM: dts: at91: at91-sama5d27_som1_ek: enable qspi1 memory

Sudeep Holla (1):
      ARM: dts: at91: replace gpio-key,wakeup with wakeup-source property

 arch/arm/boot/dts/at91-nattis-2-natte-2.dts |  2 +-
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 30 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts |  4 ++++
 arch/arm/boot/dts/at91-wb45n.dts            |  2 +-
 arch/arm/boot/dts/at91-wb50n.dts            |  4 ++--
 5 files changed, 38 insertions(+), 4 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
