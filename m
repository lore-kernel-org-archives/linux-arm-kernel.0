Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF94C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:02:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34DA20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O4CRz/JN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34DA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LrE5GhcfOENMFwOs1AYbOrhVMGjU7Cgc9AkOB1kBXAo=; b=O4CRz/JNcvu0FU
	BN6scrFKvdeB8d2+OWHcOqECrLN28/76ZkHjqze9nxszujZCxDQfva7Wg33QbhU341oZWTBWO9dvV
	LKMJg69QNpckYXLqY4BzDyfQtaS6KYxfmu5Nw2ldu9Eexpusm7wPTTfHtM2byxBW9wOej1RUL0kPU
	KgHyTZKalmH3lH95POGR4MYi97LxYN/xdcQdxoOgSx9J4ms3TlTMpQUBfS1KwNZSXqi2cw3R7nfy2
	3YO0J2eNDxFB7zuYZ9n3tZ3ayyLTnkTQSrnKYjuMTxzJkF1ovKMaen15owpjzeKz7XBQVLMV6CmQe
	mIj9+kG8nbHQXhFthHww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuEP-0004a6-Tj; Thu, 06 Dec 2018 14:02:21 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuEM-0004ZC-18
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:02:19 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 36A1920750; Thu,  6 Dec 2018 15:02:05 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 11FE720745;
 Thu,  6 Dec 2018 15:02:05 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] pinctrl: sunxi: Account for per-bank GPIO regulators
Date: Thu,  6 Dec 2018 15:02:02 +0100
Message-Id: <cover.50931fbda5c95345087740e4c1ef5a57fdd53480.1544104801.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_060218_207568_96281F6F 
X-CRM114-Status: UNSURE (   9.86  )
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
Cc: linux-gpio@vger.kernel.org, Mylene Josserand <mylene.josserand@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Here is a first attempt at getting the regulators properly accounted for
the GPIO banks on the Allwinner SoCs.

The main interogation I have currently is whether we should always try to
get the regulator for the current branch, or if we should restrict it to
the one available on the SoCs.

Let me know what you think,
Maxime

Maxime Ripard (2):
  pinctrl: sunxi: Deal with per-bank regulators
  ARM: dts: sun7i: bananapi: Add GPIO banks regulators

 arch/arm/boot/dts/sun7i-a20-bananapi.dts |  5 ++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c    | 63 +++++++++++++++++++++++++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h    |  6 ++-
 3 files changed, 74 insertions(+)

base-commit: 651022382c7f8da46cb4872a545ee1da6d097d2a
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
