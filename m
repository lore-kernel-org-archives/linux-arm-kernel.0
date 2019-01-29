Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95253C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:44:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649D42087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jHXUdRHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649D42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1rXoAoPLBwfRL2joVjSP73WiXjr4iKrEXQzloZcuvLg=; b=jHXUdRHqFG7zGX
	+t/SspvjB+3AJlROcB0wLsf9ECTUFXq/5SJA2D9VbYKkqj39f9xnWYMFvpDVuFyqKWNH/C6B3a2O1
	GMPV+auJZ4frMnO+W6Rnie6fkKSJMOjoNa5dJNRUjqxf5JcNYLtGLuOYMLOlnwY2qrDxQsigq9ycC
	vGV246EiJNGXm5Ndshk7SYHfW8T4dHB9GBBqFZVu91i+GY2yUHTBBI9TI0AGNIwWDRsMAMwrICH5h
	D7gwsdAA38vAwNEylm+QHCTusX78RghRHCLn3TK7tUNcsSwrxJwc1BNOfCEvzL4LICWVrxT+9lQqa
	OUcBXWD4hBQ8ZgzMyD+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSl0-0005PQ-76; Tue, 29 Jan 2019 12:44:50 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSkm-0005Fc-Qg; Tue, 29 Jan 2019 12:44:38 +0000
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.76) (envelope-from <colin.king@canonical.com>)
 id 1goSkf-0003g1-Vd; Tue, 29 Jan 2019 12:44:30 +0000
From: Colin King <colin.king@canonical.com>
To: Liang Yang <liang.yang@amlogic.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Subject: [PATCH][next] mtd: rawnand: meson:: make several functions static
Date: Tue, 29 Jan 2019 12:44:29 +0000
Message-Id: <20190129124429.19829-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_044436_996149_1E6686C3 
X-CRM114-Status: GOOD (  10.66  )
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

There are several functions that are local to the source and do
not need to be in global scope, so make them static.

Cleans up sparse warnings.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index b9c543d1054c..9557bd94dcd2 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -829,14 +829,14 @@ static int meson_nfc_read_oob(struct nand_chip *nand, int page)
 	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
 }
 
-bool meson_nfc_is_buffer_dma_safe(const void *buffer)
+static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
 {
 	if (virt_addr_valid(buffer) && (!object_is_on_stack(buffer)))
 		return true;
 	return false;
 }
 
-void *
+static void *
 meson_nand_op_get_dma_safe_input_buf(const struct nand_op_instr *instr)
 {
 	if (WARN_ON(instr->type != NAND_OP_DATA_IN_INSTR))
@@ -848,7 +848,7 @@ meson_nand_op_get_dma_safe_input_buf(const struct nand_op_instr *instr)
 	return kzalloc(instr->ctx.data.len, GFP_KERNEL);
 }
 
-void
+static void
 meson_nand_op_put_dma_safe_input_buf(const struct nand_op_instr *instr,
 				     void *buf)
 {
@@ -863,7 +863,7 @@ meson_nand_op_put_dma_safe_input_buf(const struct nand_op_instr *instr,
 	kfree(buf);
 }
 
-void *
+static void *
 meson_nand_op_get_dma_safe_output_buf(const struct nand_op_instr *instr)
 {
 	if (WARN_ON(instr->type != NAND_OP_DATA_OUT_INSTR))
@@ -876,7 +876,7 @@ meson_nand_op_get_dma_safe_output_buf(const struct nand_op_instr *instr)
 		       instr->ctx.data.len, GFP_KERNEL);
 }
 
-void
+static void
 meson_nand_op_put_dma_safe_output_buf(const struct nand_op_instr *instr,
 				      const void *buf)
 {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
