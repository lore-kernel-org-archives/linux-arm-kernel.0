Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69DCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:33:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742D92183E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r9wH7Sz/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2TA0EkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742D92183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bX4ZJoRMucp1GxjhRhJyv4+EAevx4//UUw/ukF1OyGk=; b=r9wH7Sz/28mXul
	ZyMaf6n7xYf8Q9V8+zDSstdUwqCCTw3TC3QRf50IyDtRSbDpqIBF+M0+HjuMZshxHlu0dAGDTl5ft
	fWPV5y+HQNz1KarUEMFC2T45IBLB9eTOgXP9zve+vzumoo6ddpw+G3j91y/lAH4BcM1GSIZURE3MP
	scHMNnJuqUedbcXqMNjhnewe7c4GS92cJN+axCJpPdUF0FVnAaNyaz9Z4qeM13J+BURKg43PGbiyD
	6aYsxihC9/Woa0HZeYx0SBKaTHBqDHXQo/XNmWCDKREAUKajKTvU9hcoP3YUJV2ue3c4SL0GUUPIj
	zq30ChhpkaCRM9SBuNhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggYmC-0006Xv-HS; Mon, 07 Jan 2019 17:33:24 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggYm9-0006XR-JX
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 17:33:22 +0000
Received: by mail-pg1-x544.google.com with SMTP id t13so418291pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=TzVTvpAb35f1kBJYpNhxLKE+jFS6+lVH81Gm2pSVJtA=;
 b=U2TA0EkXWafeqV/8dfLqyaRgnqSywKjYnqmKweV9JCahl3CmndgmX9GYhDBOXVvfAH
 1+reOQexuH0r+hR52y6v3NFynnAhXDKz1yBvJVupq73GfHJaekpUEjZZ5VERnswkkztC
 u1kw31yXXta8dPiYKRQzXf9kkWAGlHvuM2y+xARUfNZwBu/pNrcdqfwJ5IAzxaNbQSnj
 wZ+BNwAeUkxGvhgqzN2y4PnZ8nyVHwHdKL5fiHu9odP7SjkeOBKiOVTDm/VrYD6ngYmR
 CvqhST1ELZSx7jqRTucSaWSqKvHoZcJgHdXNkuZykezKqeaRIapcmUfattd4H0HkJPaN
 459A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=TzVTvpAb35f1kBJYpNhxLKE+jFS6+lVH81Gm2pSVJtA=;
 b=L8NXUJLX942Ea4sA3hWmFE26zSIM3n2/oDvjZSMtjsnbGAWuIsCO6ppH1SBPp10rhy
 RCV6AMlICiqXdtBoHQcNKWZNvhSBO9sOOd/p8AGKjHHKjNkhQgZz2kHDb3QTJxyfcSqm
 fa3eJJZBI9KSKUKlmQzd2pCLAALHqaIWx833S1yTYdm1umVClydrlqgkDdj0L3wB3U1s
 tOzWd6Hn1Tx4VJzVqW2C3baPHj4o83uXmY6YlXWPf6n0mvibSrxmTSEu1oli+GUe/zVh
 GNe0VqFlfSCEZyXM0S639Sp87cj5Q4mRARCZf8nF8OWC0PxI4GkeKt5d7qs785524dj8
 Ma2w==
X-Gm-Message-State: AJcUukfR1cTWQJbtohLMuKyRn7f25RXH7MtT//s8gW1eJqUOKCM0g1np
 xZumsJAO/77CeZVUIeRFqkY=
X-Google-Smtp-Source: ALg8bN6TbNX0GSsEHpfdKPKqRQG1e1izikJ//pKVOnmmq2WtZeqa16bHPW+0/ZMzrx+AOnX27tZbsg==
X-Received: by 2002:a63:4101:: with SMTP id o1mr11609715pga.447.1546882400351; 
 Mon, 07 Jan 2019 09:33:20 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.19.175])
 by smtp.gmail.com with ESMTPSA id t13sm117651332pgr.42.2019.01.07.09.33.18
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 07 Jan 2019 09:33:19 -0800 (PST)
Date: Mon, 7 Jan 2019 23:07:19 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: sstabellini@kernel.org, linux@armlinux.org.uk
Subject: [PATCH] arch/arm/xen: Remove duplicate header
Message-ID: <20190107173719.GA30197@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_093321_650702_0DF2FB59 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: xen-devel@lists.xenproject.org, sabyasachi.linux@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 brajeswar.linux@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove duplicate header which is included twice.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/xen/mm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index cb44aa2..e1d44b9 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -7,7 +7,6 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
