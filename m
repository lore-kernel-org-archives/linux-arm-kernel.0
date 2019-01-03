Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD52C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376F520815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j/piDV66";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="A/YEFhdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376F520815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HQ+lyyQIOALg5ENtaXRINILNSjelmQWmpayd365dkKY=; b=j/piDV662JeZX2
	zVF2P38qNWqOf7kXiQaZFce7Z6RIs+4719JECq1kUJXxe9P2P68W7MX1Oaw2mQZu/+XtktOvxtxVi
	7HgW4dYGOc8wDPdwb1iFQQONckGoEmHVB5G36gfwWuBlJrN2/dh9hNwUP2vftm3rHlhBsEqBhJ83X
	d8/x2yfVDjsbhzOi1C7oCrP236ZPNrysgZnjG9pjH3fcOLFnUzl+92Y7u2TWs8BdqDOrhr+3RWH3e
	XMOtvgLoEcZvCnkGSgpgn/4bquA/rSOMQOpgBXrn8rO6zUV4StPv5CHwRaYkT1kfTXRYTqcfw2FRj
	+BZgpQbh18Qc4B6RVFWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfAqk-0001EJ-Ne; Thu, 03 Jan 2019 21:48:22 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfAqW-00014X-GQ
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 21:48:10 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 95C825C0C23;
 Thu,  3 Jan 2019 22:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1546552084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4b4Aplok1v5A3OAOr1AuVES09IdBt8fC2qqk06hsBWY=;
 b=A/YEFhdPPu1YKy28afnl4+dEVHpb1cR7skEuH/MFDaHVDtu91yrEUNJJCkiUC3vhMJ4Cx6
 ooWPIwuLH3WM18FRkOrv9qgPrg45zaxH/cAwC4+UPGM5pMTwBBEKcT2qU29OcHAx6i+vf7
 wB1wwIDtdKXjpFqqHMqrERCfa5UrUkM=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH v2 1/3] ARM: fix argument count to match macro definition
Date: Thu,  3 Jan 2019 22:48:13 +0100
Message-Id: <591c1d362838b8a83e1fdfea37f7b48fd85dbf44.1546551693.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1546551693.git.stefan@agner.ch>
References: <cover.1546551693.git.stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_134808_871293_F471E3BF 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: nicolas.pitre@linaro.org, mark.rutland@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, peterz@infradead.org, will.deacon@arm.com,
 julien.thierry@arm.com, ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, mingo@redhat.com, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The macro str8w takes 10 arguments, abort being the 10th. In this
particular instantiation the abort argument is passed as 11th
argument leading to an error when using LLVM's integrated
assembler:
  <instantiation>:46:47: error: too many positional arguments
    str8w r0, r3, r4, r5, r6, r7, r8, r9, ip, , abort=19f
                                                ^
  arch/arm/lib/copy_template.S:277:5: note: while in macro instantiation
  18: forward_copy_shift pull=24 push=8
      ^

The argument is not used in the macro hence this does not change
code generation.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/lib/copy_template.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
index 652e4d98cd47..2d54491b0e22 100644
--- a/arch/arm/lib/copy_template.S
+++ b/arch/arm/lib/copy_template.S
@@ -241,7 +241,7 @@
 		orr	r9, r9, ip, lspush #\push
 		mov	ip, ip, lspull #\pull
 		orr	ip, ip, lr, lspush #\push
-		str8w	r0, r3, r4, r5, r6, r7, r8, r9, ip, , abort=19f
+		str8w	r0, r3, r4, r5, r6, r7, r8, r9, ip, abort=19f
 		bge	12b
 	PLD(	cmn	r2, #96			)
 	PLD(	bge	13b			)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
