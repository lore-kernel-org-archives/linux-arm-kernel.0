Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B27C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:01:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E909B2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RM5HxvmA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nT1MvMu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E909B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nLboJvu5fp7XW0X7Sfm5xyDA9Xa5tQ8uADi1DqNFyhE=; b=RM5HxvmA4EZF+Y
	AFf95unWm2+o5RmcOoHPiS/Z5Rm/+peUp0Pkk2tEu+UFgCkkp6wv/kbUu0Kq2d61pC7GQu0Va3g/1
	Dv5QT0n9x+Nw03PFO8oF0Pd+mpXyz0YZJZB/HDotlKSwZzVWeeC1cJk9nWwXeg1k+Gx8Jm4VVtooJ
	+s7F0gTYgJsj82sxr12w6HTL/C6PnP0BbYtniCVUObj8yYWYrzsj4WU5BQp1HBhCwbhF9dfIqX0Tx
	nUKdrBMk4jiR8CBQ4E0fm0P2jPW3J4BNAllOxShFyMuIIXoAclh7j9WFkJz4IEius78ZtNustEGpp
	Lkiuv2UKR7TGR+IKcjLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnyy-00089t-Hv; Thu, 21 Feb 2019 13:01:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnw7-0003Ge-UD; Thu, 21 Feb 2019 12:58:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+rjIAOxhdeD52kMA3q1zOLc9t1bwlWNyqYOBY1JvhAY=; b=nT1MvMu2Tb8X1/EuJFQaMwHk/l
 lJV9A2j1tIjaKrjoH+MAx45clc7F8PrxYOx8J7hGHoqR7qOaMHrPTW8lWDqEJSPYXQ8wqVHRoKW8Z
 N9tBF/0P2Cvas1CnXzEa6yDrS830j707fz8bIByyB8F2fc5EbMUAU/jmib9mxakcCUBdMep4QVSCZ
 mbnQpRPceU6rnQ+0A4c7v/aM2uMgMKqvlrKjZVaga2bxgX2hBOGrOMqfzV7MBvo36JxQ1mWTWkJZX
 JyKRho6rk8sokF03zRyHFJ9Rl7nBI6jMLeb0SyYWNNCjthmYAKwdF9Se7j+IRbI3prCJ4nmfMz8y1
 B6HUBuZw==;
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnw5-0000IR-0Z; Thu, 21 Feb 2019 12:58:46 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E12F7C0002;
 Thu, 21 Feb 2019 12:58:09 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 13/27] mtd: nand: ecc: Clarify the software Hamming
 introductory line
Date: Thu, 21 Feb 2019 13:57:52 +0100
Message-Id: <20190221125806.28875-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_125845_101185_E6FA222D 
X-CRM114-Status: GOOD (  13.82  )
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
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Julien Su <juliensu@mxic.com.tw>,
 Schrempf Frieder <frieder.schrempf@kontron.de>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The include file pretends being the header for "ECC algorithm", while
it is just the header for the Hamming implementation. Make this clear
by rewording the sentence.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mtd/nand-sw-hamming-engine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/nand-sw-hamming-engine.h b/include/linux/mtd/nand-sw-hamming-engine.h
index 1bd7493c682b..4ce99fa574e3 100644
--- a/include/linux/mtd/nand-sw-hamming-engine.h
+++ b/include/linux/mtd/nand-sw-hamming-engine.h
@@ -4,7 +4,7 @@
  *			    David Woodhouse <dwmw2@infradead.org>
  *			    Thomas Gleixner <tglx@linutronix.de>
  *
- * This file is the header for the ECC algorithm.
+ * This file is the header for the NAND Hamming ECC implementation.
  */
 
 #ifndef __MTD_NAND_ECC_SW_HAMMING_H__
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
