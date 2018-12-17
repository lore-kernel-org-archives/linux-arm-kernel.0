Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BA1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:19:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6295F206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U9RJAFzV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN3LRotB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6295F206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Loy8BRpAHtcpXHPkVZSW+j0QVNFil9xaFXoMXhsn+1M=; b=U9RJAFzVxKvuno
	23DXSZ/mNkbJkBoPjONkGRRLY83OC6bfZmQcZhuCxMu6d4bur2P6e95POevh3bga9MQuf1jqc6Mq0
	ApL8nGaooCVby5QuEFwag3HUIkEO8Zxz2n8ZaXxdOney7Z7hDuyIj2KfywZcIclG2BVI1A19VSMg7
	7KE2iwIB7RdLyYHwGNteDjkjx0+LIVcZEa3jln/p8CcThobgSjVCBVWAN7lBqXnDl4tRWcCjp+Aim
	0XLdtGMGnjVxFmaUAhbYh4US475ngqBwCmslpcstc9EhrQexZlZxeFe+OyHgOmyOww+jgbz3TYO78
	3QjlIrJVjfHKATFlzBAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYzM3-00074D-J7; Mon, 17 Dec 2018 20:19:07 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYzM0-00073A-Ld
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 20:19:05 +0000
Received: by mail-pf1-x442.google.com with SMTP id g62so6891972pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 12:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
 b=UN3LRotBmLU7g4NYrRKgWGuyzje0zXTtKnRBRlwk5Lu8DyWMsl6VlJf+28+6Wu8jUv
 3dt9zpCCKdA9JZTazgv5TcRWxgSUlsSdzevpGdqJpv8WVOO3IRZnrSkvKb6ubnohoV8m
 WBQRSZHxdT7S6ZEvQ/j1SuVSrVP7sby5mirPqSgW8uKaLKcjTIMx1gE8n8BCn7uBbM6E
 qNvm3sByxZ+GjVVz9M+zYJANQIHyzWVDgrbqWLHcnolk6INBvFGBnZnm5I3oFH71QBCO
 ra+TEojmKZjUaj3uSfaUG0YtsVnRJmnJwN0YlCBULNR12n8Uynxq3FKnsXpN7gHm1RBp
 29tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
 b=akScHA5iLAJea1TlOi09O1AzJFx4G8dU7uCOMfCiZAxW/ugovdjJDnvLmUjdAYXcCG
 Twnw3fkzknM0LfIxe9cJKg51PbA9nGjEKwjtBU01X/srj/OpLdBn/7v4pSKYnJ21JVZ2
 p83V6c6HxJcOqib4/W9vJOh2NmoSlE4DnTLpFndebgxmaPtJXemFPP9k/dh5YgVCneAj
 cohD2jXqRdvYVvZY1sHHFOsMf5QNgsajefc+GP9mKIzt6OJwvtyeZ12A+8smhM97bETH
 KeTinF22xCT0mOh2xWlas0D8P7n+9iLdNZe5iNQn158wX+yidayFA1MkD5xqhgd1jcE1
 zPrw==
X-Gm-Message-State: AA+aEWbYS6hG+4Xzyw6XtVT/wrASkuv+ZbkGSmsgVS2/7vCbLaYusZZo
 dpWKJX/YP4oG7AUV6y39L26oCpf/
X-Google-Smtp-Source: AFSGD/VZpPr1vEyhblYwvkUoYGzeXCeGHGsoaWXD+5TdUu/r2E6BL4B7uDKXBU7K9UAg8FWdanGGog==
X-Received: by 2002:a62:8949:: with SMTP id v70mr13708541pfd.85.1545077934004; 
 Mon, 17 Dec 2018 12:18:54 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
 by smtp.gmail.com with ESMTPSA id f67sm18955733pfc.141.2018.12.17.12.18.52
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 12:18:53 -0800 (PST)
Date: Tue, 18 Dec 2018 01:52:46 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 stefanr@s5r6.in-berlin.de
Subject: [PATCH v4 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181217202246.GA10500@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_121904_705784_342FC26A 
X-CRM114-Status: GOOD (  12.63  )
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
