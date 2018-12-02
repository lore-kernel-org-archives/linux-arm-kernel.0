Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:18:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E0B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RJXAc/35";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob52eAyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E0B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Loy8BRpAHtcpXHPkVZSW+j0QVNFil9xaFXoMXhsn+1M=; b=RJXAc/35c/MveB
	g6d6grTeu+tygcaDaLqD/mu7aFWeysZG9rHLjOXEVXe+z/XcPvM9FWfvx0oDlS19C8Igt6vxiosQo
	yj2IlKUjpAqowzCb52aKiepVG2Q4zVESwpPT5bCUl6suXpH85JdTPBuyBnPyVHwBWpW75jqQW5V2Y
	udFWyVaBOxTqbmQnFIn3akKHozHxNuclvYvUWKSBPVSvh0jbqlHBRbvhhC9nWPyqjvftvMKfcs8kb
	Bu8Y8bnb1CN9X7bkQjYPWv8T3/a9XaJFk0jLLTwl5mtLkR/jGrmHf91BFYxwUu8i/hfplklbSWpa1
	4QIFXvfndQzLNZQOaKzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTL5F-0002Uf-TC; Sun, 02 Dec 2018 06:18:25 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTL5D-0002RS-L0
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 06:18:24 +0000
Received: by mail-pg1-x542.google.com with SMTP id g189so4284963pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 22:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
 b=Ob52eAybZ+ukSyGdY8U/Z1jdhXxFQFle/dMi4Et2nQndtm7MZ2i4ONnKsVDEIcjDDz
 9W38WqOW1p9mt0J7xkQxfLmLL/jnq1/LcrLmoOqnc9m337jYRgsykPHqvssdhQ8pmZqy
 AcyrBFinNSivTuQmUI01wz1gKLQW9G1svEowGTi2+SAQF6CW3SbPSPNlOgF5HsoRXG/R
 9K9JQ52ZvaqN5BHcgkhczNdO8IQ5qGjOakvBGCY0Sm0g3u6hbovABd7E77bu2Yv2l4eb
 Ba8iBaRv7cN2h5YB8JO3+4IihJv60g16Rfz+y3KC66wo+3y0mJ60ov/ncoRJ0hAIFPOQ
 x9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
 b=Y2zCwt05u2hboKVbK9v74sGkDbgu4r5RyfzwTF+Aazs2/fcQWZLJrsELMaofZT67aY
 Arh/eVemejv7mzD8rdaa/xXZDiy6TrxEpKj5NaJZSIixm0YNPVEgWZ21W63X1duJsNEB
 FdUiUUPf43tTNrQa/uUoNZoaPytdYjz9rh3XxTL/KioS2GkbkLefMDaf31YMXYnXxzBX
 /Yyjd/xIhxkViCpyniSHgMiTX1YzwOZCjA5aWYEUCL+djEn76Lr3JGmKc/gwQPLCepuI
 AsqfsIcAHw2pLl546sMcare6X9I9EZUQcjyNLqVkiT295utmlYrp25S2kuo7nieXbq4D
 wxhw==
X-Gm-Message-State: AA+aEWb6n040qduni6Rw9xdcIqWYWuKxS/UGiXx7bn3qPttECc/3fTEu
 uR92FXjprhUZSJ0uxj/DLtc=
X-Google-Smtp-Source: AFSGD/UHCJICHgiE0m052Ybq6CARBcS+P92LNUcrBDatOdJIiC6ahi3tnqCNt66ImpC9ArLD+LG41w==
X-Received: by 2002:a62:546:: with SMTP id 67mr11166313pff.99.1543731493182;
 Sat, 01 Dec 2018 22:18:13 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
 by smtp.gmail.com with ESMTPSA id g15sm46055783pfj.131.2018.12.01.22.18.11
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 01 Dec 2018 22:18:12 -0800 (PST)
Date: Sun, 2 Dec 2018 11:51:56 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 stefanr@s5r6.in-berlin.de
Subject: [PATCH v2 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181202062156.GA3131@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_221823_693443_E198EB3E 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert to use vm_insert_range to map range of kernel memory
to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..7bf28bb 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
 int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
 			  struct vm_area_struct *vma)
 {
-	unsigned long uaddr;
-	int i, err;
-
-	uaddr = vma->vm_start;
-	for (i = 0; i < buffer->page_count; i++) {
-		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
-		if (err)
-			return err;
-
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_insert_range(vma, vma->vm_start, buffer->pages,
+				buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
