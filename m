Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D50AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:47:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3002083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lWuIpTn/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu3tDq6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3002083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BYf+Cgoo6PmRGVNfhi4QOGISioHK8Rq9Jc7Ufw7w8fA=; b=lWuIpTn/BJDE01
	dKIyXxCO04BXgQJJTKfUAsfWxFJRsMTtwbw3v4nWUxNOP16mqd8FiztbwPn42dLCu4lzzlEj2A5g2
	Og/fwMAP+xKIp3dSAvnNX+l5jtdQLst55h2wSQFKHn/FQ6deJq+YU8qYMmgJFuY0ASOYVsy+ireZL
	bIm6bSMFYNJpz5jR1Qk4KfC3iZrUmPJadgZKt3gVIB50aeCNeiKZ+10L3gg4MopYMnNIqIxAUABtt
	mw8UIXHuGDcozeJaAhBfYM1JOdTRPv4G1KOguZJqLObX6CquJzOKcsqgCZ4jMKczRd4OlFA0xxbh3
	Gg+mzQDLHIROYxeB9i4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr7ct-0005mU-66; Tue, 05 Feb 2019 20:47:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr7cq-0005mA-En
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 20:47:25 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6BBDE2083B;
 Tue,  5 Feb 2019 20:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549399643;
 bh=VTpmfTKGtHgWiwqIWajrR7SPRxKH4ZGo6w3sS37zYAk=;
 h=Subject:From:To:Cc:Date:From;
 b=qu3tDq6+1EnQfvBIKgcxeOjs8949shMKJyWorrOVpDNIqT+z078CbjZ4X4XJeZf/4
 oqdwzget1KBG2FRk6P+JEwDmhxP8z7ytWgctPTF8kiI65RTuoxMpCLETTJEVxjcbVm
 9qm1x/wiCv2uHvzERX2C8pUlSBcVirPNIElsGK88=
Subject: [PATCH] net: Don't default Cavium PTP driver to 'y'
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Date: Tue, 05 Feb 2019 14:47:21 -0600
Message-ID: <154939964148.34496.18016063453530224332.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_124724_515685_CE3B0A36 
X-CRM114-Status: GOOD (  10.22  )
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
Cc: Aleksey Makarov <aleksey.makarov@cavium.com>, netdev@vger.kernel.org,
 Radoslaw Biernacki <rad@semihalf.com>, linux-kernel@vger.kernel.org,
 Philippe Ombredanne <pombredanne@nexb.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bjorn Helgaas <bhelgaas@google.com>

8c56df372bc1 ("net: add support for Cavium PTP coprocessor") added the
Cavium PTP coprocessor driver and enabled it by default.  Remove the
"default y" because the driver only applies to Cavium ThunderX processors.

Fixes: 8c56df372bc1 ("net: add support for Cavium PTP coprocessor")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/cavium/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
index 5f03199a3acf..05f4a3b21e29 100644
--- a/drivers/net/ethernet/cavium/Kconfig
+++ b/drivers/net/ethernet/cavium/Kconfig
@@ -54,7 +54,6 @@ config CAVIUM_PTP
 	tristate "Cavium PTP coprocessor as PTP clock"
 	depends on 64BIT && PCI
 	imply PTP_1588_CLOCK
-	default y
 	---help---
 	  This driver adds support for the Precision Time Protocol Clocks and
 	  Timestamping coprocessor (PTP) found on Cavium processors.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
