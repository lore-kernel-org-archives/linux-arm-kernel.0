Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E97C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:17:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4D320850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UU1xB8OW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LetujdSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4D320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UrBed7OF5UKZGdKkt4eRcKEtUm1o5hadJLmwkToDT7g=; b=UU1xB8OWaue5Kc
	YVBmxtMPY3h3WHEbMvS5P1Ln+gILj623dtjB0qAwitmTfZ10KgeT5N4ES/kCH/rVvMdf7+wWUpxut
	hPXlsUXX54EnC8pqNJ16bYYzFyp04yxbXrIeO+U7ghHjWLUYxp5s8FYEEYXMSwPw8FUBRz6L37c/W
	Kae6QbqQ3Khzo/fSc8qkCYml6Feyw5Qn0JeYKI9cv4GW9Pz0vcIWkWcb1YYn1+9fZGZsFJnwDbkdt
	Qz01c+Pzf4eBGaYlUubUzk7A7tnOGno8nOYhj04jWafl8iltQQ3N5s7zDsbKSPbUVZEvfh3LMFdEM
	VQT6SitZ4uCPLH+DGlEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giroY-0004ea-AF; Mon, 14 Jan 2019 02:17:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giroU-0004eF-E1
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 02:17:19 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6238420660;
 Mon, 14 Jan 2019 02:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547432237;
 bh=e5ojOEBLXdevoFTDWP+WypVXL261SNAmUjmeL3hTmz8=;
 h=Date:From:To:Cc:Subject:From;
 b=LetujdSYurRevu3yTiFdhQ+kgE0FElO7HH/4Hz/TFTtdaPOWVne5kgljlFAhST7GQ
 Zj5TRG5a1igh9+e2KI9K+3rUYcmvzfJnI8f1Xl+quD5LKz98M3EMq4blR7a/HoI04K
 kGIS260EZsA0cLi3R8+E5GXsPWLTksLP9AMgsEho=
Date: Mon, 14 Jan 2019 10:16:59 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL] i.MX fixes for 5.0
Message-ID: <20190114021658.GI15371@dragon>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_181718_493668_71BB43D1 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-5.0

for you to fetch changes up to ba0f4560526ba19300c07ed5a3c1df7592815dc6:

  ARM: dts: imx6sx: correct backward compatible of gpt (2019-01-13 10:40:22 +0800)

----------------------------------------------------------------
i.MX fixes for 5.0:
 - Fix spi_bus_bridge DTC warning by correcting '#address-cells' of
   dspi3 node on vf610-bk4 board, as it's being used a SPI slave
   controller there.
 - Replace deprecated gpio-key,wakeup property with wakeup-source for
   board imx6q-pistachio and imx6sll-evk, into which the deprecated
   property sneaked during the merge window.
 - Correct the backward compatible for i.MX6SX GPT device, as it's
   actually compatible with i.MX6DL GPT rather than i.MX31 one.

----------------------------------------------------------------
Anson Huang (1):
      ARM: dts: imx6sx: correct backward compatible of gpt

Shawn Guo (1):
      ARM: dts: vf610-bk4: fix incorrect #address-cells for dspi3

Sudeep Holla (1):
      ARM: dts: imx: replace gpio-key,wakeup with wakeup-source property

 arch/arm/boot/dts/imx6q-pistachio.dts | 2 +-
 arch/arm/boot/dts/imx6sll-evk.dts     | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi         | 2 +-
 arch/arm/boot/dts/vf610-bk4.dts       | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
