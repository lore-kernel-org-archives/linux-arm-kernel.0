Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094AFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:19:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB88220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hmi0Luaq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="mVS3WXeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB88220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bVaxsdjrWZ1BxQ3tRQekw7cZiGCciJaTkmfWdBsEejg=; b=hmi0Luaqd7mrgJmQHfIfK689bz
	DkUYyivWnmX2BXvrSUTZvZtN9C+hrBfEKZSMmLZdyF/HH2jxStnnw/g0uQKgnc6SLnLFCpspKJEi9
	kbkhqeCjL2yNnLDfQ8RSauqhXKTA+OvoPuQvHGCWZ0kPI1KKmeFol0tEiMjUyVE47/PmCKt+ryQHp
	VhUJjdoHv+yCyEH8iWzAv0JfKGevDk+NnDJEsAVLJS3Bsd5FPLEdSnMKp/S6TEsjcRqALourYKOCI
	oLhTNjxpwiVM/mnJON/z8UGcfTK0QbqTf9P9Er8uOc9TJzatEXDNInz3MCmKhuPb2WF1VLX8Qrh1F
	Bq5ZzWnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4Bd-0005a2-CE; Fri, 08 Feb 2019 11:19:13 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4BG-0005IB-FE
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:19:10 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 0538425BF02;
 Fri,  8 Feb 2019 22:13:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624430; bh=0Die1B+H43MQV2AMhJ1TxoqSuF1qu2d/btMlvKBDTi8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mVS3WXeMa7rSk4EFyjwAHXwU8wklzM9yE3o0jrUwGN/uwMgKZO0huBMRxtFEfglzN
 g/WhRZymWF8x6sJ+ypX+siOqY4Pcu+RVlWJ+nv8M6zmVyWsUgMh24J9kYE5Jjqp5b4
 wUVNR/NdHncDp50PUIx+6OR96wAYngqqsJ+TPZ+c=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 49A72940171; Fri,  8 Feb 2019 12:13:48 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/5] ARM: multi_v7_defconfig: Enable NXP pcf85363 rtc
Date: Fri,  8 Feb 2019 12:13:44 +0100
Message-Id: <e5168ec09d993d2b64cd9ee8d4cff269e53538be.1549621233.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549621233.git.horms+renesas@verge.net.au>
References: <cover.1549621233.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031850_757151_505CE5E8 
X-CRM114-Status: UNSURE (   9.14  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase
hardware support enable the driver in the multi_v7_defconfig
multiplatform configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5bee34a7ff2e..ffaf5c00f367 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -826,6 +826,7 @@ CONFIG_RTC_DRV_MAX8997=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
 CONFIG_RTC_DRV_RS5C372=m
+CONFIG_RTC_DRV_PCF85363=m
 CONFIG_RTC_DRV_BQ32K=m
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_PALMAS=y
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
