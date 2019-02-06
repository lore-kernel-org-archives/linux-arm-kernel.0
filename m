Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688FCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:52:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359C0217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dx8YVuMH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3HFUKtZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359C0217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sg8T9R3D7EZrJnk1v5WG41T0pRhg9o6cWK2Hsq62BY0=; b=dx8YVuMHqFbwJa
	e3//VssrqGCDhCMfepcPrwTXQH+RRPcq2DXybYNxi25c/NBF3TfXVtg0gm9b3KSpB/Vl48L9MMZqb
	DutuBGjCH5XF5swTtMkDEyXZW+6vvobXr8W/qKzhTqCWCNbYUNwOlk1xunrTbN8KxTF81wP9X+HJx
	sFl929b5soKzqfI5dkzZTgbfv7FWXRjWOpo5WOzNZ6fdwKXKsYtLU8FuQRGmH2pZOzM9Xg7PiI/YQ
	t6E+GWXUnBg8m+onV0dxwlmiNkuRJjbd/KK26rYy3/SDcLM8kA8up3CCDU8lgiY8RmNUkqNrC2oww
	nB7uYdwSbca3E3jk7+jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grTEx-00007n-N2; Wed, 06 Feb 2019 19:52:11 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grT5l-00044w-Sz
 for linux-arm-kernel@bombadil.infradead.org; Wed, 06 Feb 2019 19:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JCH/HT6W8URuCGiWHpQAhWzbyZz6PL7PoFvICD4xxUE=; b=3HFUKtZi39s+0hJplN7ox1MNGA
 aYvEqW3YycufZ+BPhA0PYcWLqLtCL1+RJBxQaPDy/hsdA4PmJx66w7MImoy2r0/39tZkVa7Aq+qYz
 2+boZ6xi3JUmmKM+2d2xvRSLV8BKhLhcIKxyZtEvljjD0b7/eHYazlmrxNyMxhywA4SyvGL0OWX8h
 qdW9yCkUgjO65ObuXHAjAduMIOxm/rOKFR2Efd7RNBFpcs9Bzs4BlvsmH+zlflR8EOo0qxI0XGLKz
 lDYwbo7GjJ95nkEbX1riEbTXqSeoqwHuR0iHrO9RQcf/hZMoJfDNtgyK4AMaNpj9TuISQzASYx3CN
 Vmy/tETQ==;
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grT5i-0005cP-PY
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 19:42:39 +0000
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 6D6C940002;
 Wed,  6 Feb 2019 19:41:48 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 0/7] sunxi: Add DT representation for the MBUS controller
Date: Wed,  6 Feb 2019 20:41:17 +0100
Message-Id: <cover.ddd928eab0069d426b711e69940918eaf85625ce.1549482066.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_144238_946834_01C5FE3D 
X-CRM114-Status: GOOD (  12.71  )
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
Cc: devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Yong Deng <yong.deng@magewell.com>, Robin Murphy <robin.murphy@arm.com>,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

We've had for quite some time to hack around in our drivers to take into
account the fact that our DMA accesses are not done through the parent
node, but through another bus with a different mapping than the CPU for the
RAM (0 instead of 0x40000000 for most SoCs).

After some discussion after the submission of a camera device suffering of
the same hacks, I've decided to put together a serie that introduce a
special interconnect name called "dma" that that allows to express the DMA
relationship between a master and its bus, even if they are not direct
parents in the DT.

Let me know what you think,
Maxime

Changes from v1:
  - Change to use the now merged interconnect bindings
  - Move the DMA parent retrieval logic to its own function
  - Rebase on top of 5.0

Maxime Ripard (7):
  dt-bindings: interconnect: Add a dma interconnect name
  dt-bindings: bus: Add binding for the Allwinner MBUS controller
  of: address: Add parent pointer to the __of_translate_address args
  of: address: Add support for the dma-parent property
  drm/sun4i: Rely on dma-parent for our RAM offset
  clk: sunxi-ng: sun5i: Export the MBUS clock
  ARM: dts: sun5i: Add the MBUS controller

 Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt      | 36 +++++-
 Documentation/devicetree/bindings/interconnect/interconnect.txt |  3 +-
 arch/arm/boot/dts/sun5i.dtsi                                    | 13 ++-
 drivers/clk/sunxi-ng/ccu-sun5i.h                                |  4 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c                           | 28 +++-
 drivers/of/address.c                                            | 49 +++++--
 include/dt-bindings/clock/sun5i-ccu.h                           |  2 +-
 7 files changed, 114 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt

base-commit: 87e87c7b0eeb3c9e08cdfe28fd540247bdf31ef5
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
