Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2306BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC99217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V3aBu8vX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC99217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y+s24wO19dvchBxsCkq2AZ281QP2WiU1Vu/21qMyXQE=; b=V3aBu8vX7SU+sX
	mbViHQXaLaBlZhCBqcvdfreOHnk+w/FoJWvWTbDHVipaAho8QjVaHTQcFtW26ZkbgWz85Cp9CFGrv
	WPXzj5ERtWOArGPgsalc4oDHFyOESTo+/vh7IIFJLmCH91IKIrLWUyHnt2Q1qTIMpbIKGgLZT7hC9
	jgvc5LKf5Rs1pYl9ZKNim2lTJhsb7C6FNe0I8pHGeCouia7qXe/2nVCWq4/jIR7iaE1Gyu/F07BdP
	tnJxHjMkwJXvFtbcZSaUg/YPAcmw6aca7PaNR3vUF2M0GAxqUzBRbATqx6iPfgePODm20bc5/OfZZ
	ftIriLtzhfvDws46dk2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYkAb-00013q-0s; Mon, 17 Dec 2018 04:06:17 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYk9g-0007ay-10
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 04:05:26 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 3F3825FADF; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 01/15] dt-bindings: net: broadcom-bluetooth: Fix external
 clock names
Date: Mon, 17 Dec 2018 12:04:35 +0800
Message-Id: <20181217040449.31437-2-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_200521_094276_C617F1D2 
X-CRM114-Status: GOOD (  12.36  )
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
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Loic Poulain <loic.poulain@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Broadcom Bluetooth controllers can take up to two external clocks:
an external frequency reference, substituting the main crystal, and a
LPO clock at 32.768 kHz substituting the internal LPO clock.

In particular, the external LPO clock must be used when the controller
does not have NVRAM connected, and the main reference frequency is not
the default 20 MHz. This is described in detail in the datasheet.

The original "extclk" clock name is ambiguous as to which of these it
refers to, and some designs might even require both.

This patch deprecates the existing name, and adds "txco" and "lpo".

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/net/broadcom-bluetooth.txt         | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 4194ff7e6ee6..711c75ac2bb5 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -18,8 +18,11 @@ Optional properties:
  - shutdown-gpios: GPIO specifier, used to enable the BT module
  - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
  - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor
- - clocks: clock specifier if external clock provided to the controller
- - clock-names: should be "extclk"
+ - clocks: 1 or 2 clocks as defined in clock-names below, in that order
+ - clock-names: names for clock inputs, matching the clocks given
+   - "extclk": deprecated, replaced by "txco"
+   - "txco": external reference clock (not a standalone crystal)
+   - "lpo": external low power 32.768 kHz clock
 
 
 Example:
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
