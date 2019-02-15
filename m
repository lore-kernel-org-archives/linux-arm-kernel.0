Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAF4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799B3222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CUjybRiO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLj6pOyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799B3222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DmBU1luKQ8/XBfbzyFqw5IyKhIg+RsGTRx3g/018AW8=; b=CUjybRiOiZ6Jjc
	tvRVWOAibrOjeXTiBaxxKGA96DYlntfD6HkCAc3/Uhs43JEHphgmqAvF0k9qoEs40KVJZaeQtGmVr
	YGukK/GXfmzBCmlz1phMTdpY7h/MSZpTwlNd2b0IqNzRjiwLLCyYndLrGSCqBPAI+B39ao83gyJZq
	yAWcWwMmq4rM9tYrecjDeh/ZGrfhDWWqZyCHd79n4F5SZNsWy18BQ/wXn2t9akXHwcoSfnC6GT2Zo
	rBlT3S8xWTla2bvWoUL7mmPefVuHq7etA2KH8+oHnRC+YMjy5JG9Pwu4iVSG1kNxNt8UQPRURDmbE
	Vjib5F1gTo6PIvqEbzCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guTPr-0005fw-3r; Fri, 15 Feb 2019 02:39:51 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guTPn-0005fI-Po
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 02:39:49 +0000
Received: by mail-pl1-x643.google.com with SMTP id bj4so4173424plb.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 18:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
 b=kLj6pOykfXcUG+qvmp8kJ2UtHrXBRj6IN3Rg/liMZsHGVPGT1Cp7dMXvFmX5uZCSeY
 B3KIkeIYAm0k1MB8GKNJ87FZ4Vy695j5l38NPs1xFMYDCLZUvhkvGy1mlKkfvT+k8GQ2
 sxhz7j+Ff8zJlO1XPDqtwuLtZpw+ZlgXtuuxCDdo1lQuxcTTQZL7hLUUEsrmJDB7raae
 ML3zxRkAZIlYzUwLc95t1N0v/NAKk5JyljdPIuHYJC9t4svAJVwEY6qRlPpJWfd+8Y21
 tfowupbrIJH1YLp3e5fxV5An+XpPk5PkF0zIASwVxYHrVgB2K7TOXw9wK0KqNnd5f49U
 yn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
 b=Tif8ygui9kG0w8cvZFS7xTltewfKWbpmO46FjLvsTfhNCxlOunmlcTFIVhYqGfVJ9G
 Cv4NOr94YM0YPHl/sW2qbt4wNhDxndK0TEZaTdCi1ML1sr3ELW2XAs8jsjZHEMXQfVQS
 whncIsBjR99wXiMdVoJIK1pi/Sjx6oYSBlu+MznwyLaAD/53BJRe9b+vm5JR7ArJFNRB
 7+Yn26JP1+VxPzUhnQjBILDptBdiztESwSwy+aguAxF2uwo7L6/Fr7hL6XIHqgKyq8q+
 F69d4BC3lbb0DnaxVpXByYs//uzD6/KwCkjsLLfBtrP6EVP1nVixzMbTj/rJSeIl7ej2
 5IKA==
X-Gm-Message-State: AHQUAuYgtvHk57IHd9VsGtX7+deNGw2qifH322LaBhrVJgRJL/srKGjf
 YnsMo7UypRU0qofQJBEVXBY=
X-Google-Smtp-Source: AHgI3IY7ZJP/9c0JvwcJkUpHOWFlwfJrQShpMUSfzKDJXptrzyrCoFV9i84p4XJmD8juyeubZ7QRMQ==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr7294631pla.276.1550198387177; 
 Thu, 14 Feb 2019 18:39:47 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
 by smtp.gmail.com with ESMTPSA id k1sm4194873pgq.45.2019.02.14.18.39.45
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 14 Feb 2019 18:39:46 -0800 (PST)
Date: Fri, 15 Feb 2019 08:14:07 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk, robin.murphy@arm.com
Subject: [PATCH v4 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_map_pages_zero()
Message-ID: <20190215024407.GA26389@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_183947_858679_814670B1 
X-CRM114-Status: GOOD (  13.52  )
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

Convert to use vm_map_pages_zero() to map range of kernel memory
to user vma.

This driver has ignored vm_pgoff and mapped the entire pages. We
could later "fix" these drivers to behave according to the normal
vm_pgoff offsetting simply by removing the _zero suffix on the
function name and if that causes regressions, it gives us an easy
way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..5414eb1 100644
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
+	return vm_map_pages_zero(vma, buffer->pages,
+					buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
