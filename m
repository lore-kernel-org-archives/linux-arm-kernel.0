Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42056C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:43:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB3720823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bvPOu9An"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB3720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YJ7u2g3W4qW9S7YvFFonT34+6s6Y+8vVSlLWmJE3X3g=; b=bvPOu9AnCfmdvm
	/CcenX4ct0V1ILNHgYRiZp/UBGfYVgdVjgwXcslnZtvqETc3+MUBY1HiyK0tta7OrDLS0qyhBMHgc
	hAXIaCwQrfm8YV2nskmEnhJek/zbIjd/q8k+bUt7lBBSTMFiEd7FnZhaeJSrAUYElAAM1O/f1nLkT
	bEdA9b/u8hpCrhpTDYCECNL5il2lG8n4Q1UXs6lSZAFF+QmaspMh9p/CHQY88W8XcjmaUqAn24keL
	uRNVO02XRxfhc2wZEx1CPb7pOdDsfv3O9SqBe1nG5Wmk7sqhTB6q/6kL0oImx2bHltNjKJOGFywWx
	DC8IOorUS4gvnOSCd4DA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxC36-0005uK-DO; Fri, 22 Feb 2019 14:43:36 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxC2q-0005cy-EW
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 14:43:22 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLA6k-1ggD7c2B8s-00IEXc; Fri, 22 Feb 2019 15:43:10 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH] arm64: avoid clang warning about self-assignment
Date: Fri, 22 Feb 2019 15:42:23 +0100
Message-Id: <20190222144301.3516708-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:3vMyVhA/NmVqE8rVfJt7N/FIr5UNMdS5rMFHSOEzM3LfFmczuSG
 EzAhqToaSsNSdgXGQsijk7viVCnMc7EEKtj1uIaDoFTYr8f16BtiaZ/FdzEenc+spaitemW
 +E61FF0sTXICXZQaJwFD3iiKxXLaNf9E+YwRfuVvxArXKSh09EJfik25dgqHLqzC9Pkhema
 GiviClDZF+/BliRAHNftg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pUS0q+W4c4E=:E90vViuwwtsZ9RWcqz+rmP
 X+CtVWP0w8KbG6uCQiAEFb8tJdRb9yg9x72I8fXOyzTKUzO0ngS6EduS+17FyD3sh7Yqzs8ei
 9cNqtjRpaaUtOpoTGSVmTzcqHWBaoyU7XF6vmy2DoCl8hXoB9MHThBVXDnynh+nZPWF4hLCIL
 KoMQUOCARFPR7ewCyAKlOXD/jB49Miz1HVe1Ktq3s9A8Td04/i+BdfXm71sBLyhLFEVx+vJ+C
 rfEbz9/9idvSn/gdmiCIo1LQrqawsdT5CLyWmM1KTXBtififY1juoNujhgx/1JWxfdbBoxZcY
 CVZSttvrLRel0O1BbtRiBRVAzFPxC5Iaq3TKWBGGMKnPosflrx5dHY4hq4jxH+4yQizpiVvYe
 +1Uxw89GKpIcsbNqJtC+XgytymnUB0GROoXamayNUI2gCCaQFFt5ogiyeHv7HQ59oecG0yzcz
 unHt4ecf1ynVcQWwDjV5MPYR6zHO20i+pntYYiGnJast5JoimOhxXbuEWL0W4IDO8fuNFVoFa
 EYQTxYZQ8T+WHlgCghuJW3O4DED8M8WmgljPt6bcs4r07acH26kupzy2k7tJZ1XaMjkSpbbL/
 i4jiDys7460v7AGGaAO6zu/Fw4htWneuDzcg4N2nemNL6NdEDXIxPe+X2gCrdUVsLs3tokhq6
 LKVC5QcRE5ZhTTb0ke2LIRTPPdd7zR6mPkNfw26E6PSJGN3g8FvCONrgrEpLvd0E3wqux4Eks
 LrMqSATVcEFs48lJ7QOZGL7TJFyy3oC7jKwZRA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_064320_783167_03656521 
X-CRM114-Status: GOOD (  10.29  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Andrey Konovalov <andreyknvl@google.com>,
 ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, natechancellor@gmail.com,
 Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Building a preprocessed source file for arm64 now always produces
a warning with clang because of the page_to_virt() macro assigning
a variable to itself.

Adding a new temporary variable avoids this issue.

Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via pagealloc")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/memory.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b01ef0180a03..290195168bb3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -312,8 +312,9 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define page_to_virt(page)	({					\
 	unsigned long __addr =						\
 		((__page_to_voff(page)) | PAGE_OFFSET);			\
-	__addr = __tag_set(__addr, page_kasan_tag(page));		\
-	((void *)__addr);						\
+	unsigned long __addr_tag =					\
+		 __tag_set(__addr, page_kasan_tag(page));		\
+	((void *)__addr_tag);						\
 })
 
 #define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
