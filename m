Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C2CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:12:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD1C2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IRZZ0uZg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKOQFcMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD1C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jfdje91Zt0yOX/8xCN2c+X45wRb38BU99EgD9dcuSvA=; b=IRZZ0uZgpQpt26
	8dMmaPEYAvQHompODALRAYtWhmeERRO1BrEX3PNOEWMqIeHokqX0yEC8z3w3UAN1FVNyXdFF5VGF4
	3UEmzJYVXtYTg8FzAB5eTAP9o26tmpuQQq5FvPndZhgdldTjh9S/j+N6f8/CW175OHXx1P9SSJvPj
	d/TL7JXESag/PShtmaUmhAi+KUgvK3Ji7XxnAFQj2OAQQVXapGD4CA+IaRLHJkMJPh1qoEWpqMBuC
	30FmWCvGYe7dL6lQq5hqc/dZ2RVfDhfGxxDaSwIcnGHUzy9AvZJF1B0SxTv+h+5K0GEGjwE7FCnxf
	4lqN4QmK5nw2oXvTah2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1groA2-0000Gg-V4; Thu, 07 Feb 2019 18:12:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1groA0-0000FS-2G
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 18:12:29 +0000
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com
 [70.114.128.244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E8E082086C;
 Thu,  7 Feb 2019 18:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549563145;
 bh=nuywoxFAYOyuxnSl2xu8hX3CcvgH2LN3BQymPCN5LV4=;
 h=From:To:Cc:Subject:Date:From;
 b=qKOQFcMUjAo4FF+DnSs3c5EhkqHFf7Zu2Ovbp5lqDy54CXvtbnlKlPpePH4BytXph
 To7R3c9LrMa13FTQusbQfvr9TjovdpoHVndnrk4Eg+mgOjpIYyaI23giHhXjxXS8Of
 GPFUB4flwQgp6NZw982Rhp6SeaBF6PaTqOdjDVns=
From: Dinh Nguyen <dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] ARM: dts: socfpga: enable MMC highspeed support
Date: Thu,  7 Feb 2019 12:12:12 -0600
Message-Id: <20190207181213.26153-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_101228_171117_1B19F525 
X-CRM114-Status: UNSURE (   9.87  )
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
Cc: dinguyen@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add 'cap-mmc-highspeed' property to enable high-speed support for MMC cards.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
index df2bab1624d4..64dc0799f3d7 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
@@ -9,6 +9,7 @@
 &mmc {
 	status = "okay";
 	cap-sd-highspeed;
+	cap-mmc-highspeed;
 	broken-cd;
 	bus-width = <4>;
 };
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
