Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866A0C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:12:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA82218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tR5O9sZb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mODK4UqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA82218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WLoAhaP5HbqwSxTIi9ww2m9a0USz4aUJbcUxPk+9+p8=; b=tR5O9sZbDZI7WH
	Wr/C9nD146WVSw08r+ryrmJ9y6/pS5rFihpVhzIQFm2BcZb19C1alArvHljE6CM9fSBGV+wqZVCD/
	haT1j9Yj7n3xhrgsvzvEVO1gR3r/nh9QIACdNOfzqWjRXNsPG6wNz6cx98KAZIQzWci3+k9q8s0Yk
	025e5usvju59INHLt8IopcBG0laRFhVn2Qnfr9NKVe3T9tQU6qFFyIDucL70zq+sccBSk6c7s2ih6
	GpulMElm3He0yhT5Z54c6Jvujg2FnY87NntIAk5ioQ5dSV27/DF2gQc3bRXVfzhXQpQhZx1/NYken
	997ZjthPg7BT7OwI5EEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn7pz-0006h2-Il; Fri, 25 Jan 2019 20:12:27 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn7pv-0006Qe-Rs
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 20:12:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HvNkHBRSxSOO1LlnsjHPvwRr3HB1V4vK5JaDJXJqsao=; b=mODK4UqInvdkRWEDs51ftenYJL
 L6j4xAoDhIibJQug2f3wADc2TrcStUFYjk92k96TFWal0QS4c/zsbQorxMnIUYTnHDyDNXMe5KNZk
 Dd6Lt3yQiTf+KPxvG/efvAXdOjbwTgiZd03JB1O3thxaql/+GYrpsKsDHTMSBOpVl6Lo=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:46392 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gn7nr-0004of-OC; Fri, 25 Jan 2019 20:10:15 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gn7nr-0000Pm-39; Fri, 25 Jan 2019 20:10:15 +0000
From: Russell King <rmk+kernel@armlinux.org.uk>
To: <arm@kernel.org>
Subject: [PATCH] ARM: iop32x/n2100: fix PCI IRQ mapping
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gn7nr-0000Pm-39@rmk-PC.armlinux.org.uk>
Date: Fri, 25 Jan 2019 20:10:15 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_121224_047933_07312F51 
X-CRM114-Status: GOOD (  10.98  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Booting 4.20 on a TheCUS N2100 results in a kernel oops while probing
PCI, due to n2100_pci_map_irq() having been discarded during boot.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
I can't find a maintainer for iop32x anymore, so sending to arm-soc.

 arch/arm/mach-iop32x/n2100.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index 3b73813c6b04..23e8c93515d4 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -75,8 +75,7 @@ void __init n2100_map_io(void)
 /*
  * N2100 PCI.
  */
-static int __init
-n2100_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int n2100_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
