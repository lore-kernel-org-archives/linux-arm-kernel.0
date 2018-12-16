Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC30CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:18:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D97F206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UqaCJyTg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="dmPED/qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D97F206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=70rie2+tf0p49+KsIUNFelrmKSNU+kxZDn7S2quUrcI=; b=Uqa
	CJyTgUFmCOXLi/6FQX5/T8LtguA3soLtoW3CH77Nsgyxv/6bkfONX8PO4SYSU8w4yuHnnG9Rj+8Kw
	KxnXGnZqR0NopAhvajvZyXzI09xtyyFRWVSsyXwrOnOpVIupN+te4QjcOOJ7V244hmL1MDlF6CDIw
	IiPRpcrKg3AAQs/GOSBoBtsv8fbuDvkcxObnxBoMKRaCyy2PodNTG3khNHmeQU2Qj/BlT5I29vAxE
	6voyd7DeGUt55o7tG4O5XfSEKj1IBrsj9bkGHbXejApe77fBaaMWWBr0uA+v/X17lEVnWHQnHWwyh
	9bvOkFtUYwa6sZKtVRAklVXEX3L5RGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYQh1-00022e-Rb; Sun, 16 Dec 2018 07:18:27 +0000
Received: from smtp14.mail.ru ([94.100.181.95])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYQgy-0001zi-6W
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 07:18:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; h=Message-Id:Date:Subject:Cc:To:From;
 bh=IOJnANEdt7V10WdxlzWPxnIl3hL4Hj3Q2uXYAZj+5rg=; 
 b=dmPED/qppZynFwiz4g4wt/7l0QmgzPCoPvf2F1mrKxQLR+pTw1yWyIo+m7CBrh7xrm2OTKUUOBVzQczUzzM+xtYuD4Yl5dP+1YS3vbPeSoQQY8ikCkyC4TI1WGM2fQH6zDmdtQLd6qEvmf+ZM8oFLqx4v/rN0SG+T5Pie9Fz++g=;
Received: by smtp14.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gYQgg-00046Y-K6; Sun, 16 Dec 2018 10:18:06 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: nspire: Fix Kconfig dependency
Date: Sun, 16 Dec 2018 10:17:41 +0300
Message-Id: <20181216071741.4981-1-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
Authentication-Results: smtp14.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 3FFC80838138E3AB5A78504BD2AC294197136A761B28238545F674C8F173E90D3E760A1ACED123EC27FCB8928402A81B
X-7FA49CB5: 0D63561A33F958A5763A1CB0B76E7AE2B513D02B3E5982C5C6755A9933ACCFBC8941B15DA834481FA18204E546F3947C744B801E316CB65FF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B3733B5EC72352B9FA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249E20791DD86E535D73AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE74AAC223A686B1DECB3661434B16C20ACE7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7C20B067EC1DBC83C190E4C5A2D7E61F29EFF80C71ABB335746BA297DBC24807EA27F269C8F02392CD20465B3A5AADEC6827F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445E4C8221FEB4EEC05EC53BAB2E17FCA527B46B90E34C11C6D6B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_231824_610072_5D9F1FE2 
X-CRM114-Status: GOOD (  11.07  )
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
Cc: Russell King <linux@armlinux.org.uk>, Alexander Shiyan <shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ARM926T-based machine should depend on the ARCH_MULTI_V5 option.
The ARCH_MULTI_V4_V5 is selected automatically by basic ARM configuration.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-nspire/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
index d498530..9cf2d68 100644
--- a/arch/arm/mach-nspire/Kconfig
+++ b/arch/arm/mach-nspire/Kconfig
@@ -1,6 +1,6 @@
 config ARCH_NSPIRE
 	bool "TI-NSPIRE based"
-	depends on ARCH_MULTI_V4_V5
+	depends on ARCH_MULTI_V5
 	depends on MMU
 	select CPU_ARM926T
 	select GENERIC_IRQ_CHIP
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
