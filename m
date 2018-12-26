Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A171C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:06:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA74720C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sZn/TUXM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DcChs5JS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA74720C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fiTq+AUz+M3vQMYJ9uFpzMZQx7mfBkx/po5WpVJzA2I=; b=sZn
	/TUXMl5QB5BpDKTu1Iy+8xZadPfYRelJJuecFm04g7fXT1cLaZW58f3zrcrJaRVROb5jMk9W7Gszj
	QMr3Ze4qFFH6EaY4j3kqnlLm/Z6cqthyP8vWDgw3Be2+oj1xIZ8iwwfZvQn6qssRVa0yCLtjZ7Ejz
	OAKjAMYs7WHiG9Wf5BTrhCV9goku1a2fjENqGqWz1s5U3oN9I2Cx96Wkm+qP4SaPUVith6U10phkl
	gBNFzhu9e1+lAAfh0K/RJC/d7I4ZyYRDMrXbqxLm/PfPRjGHi5iW5wPdBMHZzFoZvtYyzKwxDJQip
	OYHbnuXkCX/ntArgdb5jn2yT9fAvBng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbyaT-0005vE-Kj; Wed, 26 Dec 2018 02:06:21 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbyaO-0005to-4G
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 02:06:20 +0000
Received: by mail-qk1-x744.google.com with SMTP id q1so8713418qkf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 18:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ikr3Ra5EuhOrNtxrNCXKUlSEBXE4b8Xs1IWA6lspR/I=;
 b=DcChs5JSxuTLyStcDGQS4hxEQyUy0suQXId6oKYXSh9CZ+q40uAaJTCnAS2SwdU6+c
 6rVqD/VnspRoUEDUQRnkPgGbdz8HazinPgZHPIkpGBRKnnoXlFos3CjiATPHZn33eUsv
 XqYHBEgBzhavajRZzlVMp51DEAr0AUbZmaVxcodavg/7og/jym2TK+x94KDd5+TXR4kE
 qZ0IHUGICzIT3ftbU/AjmFSeuOA6nm0qBTMYQxZffwB8R5NAtxW3hIwm8w3jqtjrzm/y
 40VeZc9YtMdoO96L8wC8bwYAoxd+/BJ8ran2zuCmfH8O5Vek/pI1C4Hm49RE3rWz57Ws
 Qpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ikr3Ra5EuhOrNtxrNCXKUlSEBXE4b8Xs1IWA6lspR/I=;
 b=kbXilPRCd9UH7atT5AQmojSFrLdj0xUIrFfdW6LgitYqL4zza6BDnZAKRj1ckks50B
 RNWlBz7phicSH6PgmiXpGejrNWm4TQO94O3oq0esuTn2vmG1opjq/9bWlo6tFVO3IM0E
 yrA5peT/urticzshcB1uEYjqGqT/QN4FQgEMqFKlmTa06D/Hkzmaf9AFgkvcajCWmUdm
 ffZ/z7z8RQSGIXIEV2xu4bnaYP2Eev/W4GP1TeP28qVBXav4qddR+hNa9EzxlYpc6YBh
 kMiQkPLT6/SG8sHWXo+zYqaMA8Mep3+9F7Mi73l7hossy40rvSawseC+Rw150FEaq6H1
 ZIlA==
X-Gm-Message-State: AJcUukcGduduz1rKh1kQZfWuliwd4z3V5b/LAr4BLPsqF2bqyVwgs15v
 gRybzy/no1Yxj3xVXl1rHrTtVQ==
X-Google-Smtp-Source: ALg8bN4GquUtjdR5/5YXnS0aUfLrf7fPn9RuHDwgtdlxF3dHtmYPrLXed+Hi09h80vUtI8N5bkh8Aw==
X-Received: by 2002:a37:af42:: with SMTP id y63mr15876085qke.251.1545789964113; 
 Tue, 25 Dec 2018 18:06:04 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id e4sm12499934qka.31.2018.12.25.18.06.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Dec 2018 18:06:03 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: akpm@linux-foundation.org
Subject: [PATCH -mmotm] arm64: skip kmemleak for KASAN again
Date: Tue, 25 Dec 2018 21:05:50 -0500
Message-Id: <20181226020550.63712-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_180616_172911_DCE06CBE 
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Qian Cai <cai@lca.pw>, dvyukov@google.com,
 andreyknvl@google.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Due to 871ac3d540f (kasan: initialize shadow to 0xff for tag-based
mode), kmemleak is broken again with KASAN. It needs a similar fix
from e55058c2983 (mm/memblock.c: skip kmemleak for kasan_init()).

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/mm/kasan_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 48d8f2fa0d14..4b55b15707a3 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -47,8 +47,7 @@ static phys_addr_t __init kasan_alloc_raw_page(int node)
 {
 	void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
 						__pa(MAX_DMA_ADDRESS),
-						MEMBLOCK_ALLOC_ACCESSIBLE,
-						node);
+						MEMBLOCK_ALLOC_KASAN, node);
 	return __pa(p);
 }
 
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
