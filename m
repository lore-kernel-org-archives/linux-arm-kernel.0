Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06645C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:38:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E6A20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D1mOKZ9J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbLh52nP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E6A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Loy8BRpAHtcpXHPkVZSW+j0QVNFil9xaFXoMXhsn+1M=; b=D1mOKZ9J4DskLn
	duGzSIsdPTlZzi3KcCb6Yw+kHPH8mlQhHXOoKx94TEV3RD6ArByxWtgEAaYDQe491JBMzjFfZxRI7
	Qa4+JM6jjCMYV2i8z0nY0KgwSYKWpPxRz544s4ru8KgJCd4biK5ud4K1kuwfpRBrq+atssnb80KPT
	L4PvWDHIIXzc69xE6D0HmtYPa+ZXCRLLjaO1AbM2t9OpDBc1VhKkuGiftE5ABuU9ElM9wex7pU1mX
	fgNZh+yNQ9UInohOBe6rOSUS9fwokMOpZZIZRif3bImzasQeNlbGBFXjk31nU2lpFWboQ6PyLw7ow
	KxZhoC9R0IqlnxXNS39Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyXH-0004Gl-8d; Thu, 06 Dec 2018 18:38:07 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyXD-0004Fn-KL
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:38:04 +0000
Received: by mail-pl1-x642.google.com with SMTP id u6so554557plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 10:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
 b=fbLh52nPpkqcT1Z9V3ynz6uiPBZF5qfoJ7/hPEZvBCMX9CeGjmuiaMJt+rxLafnLa7
 f/xYhIOsoC0o/ferMj/eZvUp5HVv4NMCx/xUGLT4rts1Z7F6Ekp43794GO6SxyUjq41C
 62Wr6dgG7VRi3tjWvD2US+JF0DTPRcxDbkHYRfJ0H+SUa5FM6wr3LYGbjxxPgweg7mGO
 sZE9GdYGcKvIWQseAlW5idOnudxqMDkBFLSpmuI7zJ1qNdogSjACVAFOtRLMxidohXSa
 ScDcjF5aHzGL/JZZHC+dhbQx4sQctZ2rE77G+oqhq1rYOkSTTueCdoOBKkz4sBuPsw0/
 wcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
 b=Aig1DYWSuI2Cecpm8cM55lXuGrY0Sr2yOjAy1xYrDHVcXuXOtcWwYgFOUeXL1e9+u9
 5rVHMi0LFfRW0UUHa2npqhSr8Q0PGorrWNCLh6nrBvLmuc2uks3968h6t/kURl/5jHYm
 vEPJ+/VRQl+eRqAEinTWRuqfA5qcRS8Wgoo9y7BknitYUQlzxUAhAtYRrGKffuVZqiwT
 b8ITDEoOqEVdNr7P1X3M7/TaMwFQC8Q+lFnjr8hRkYsb7AbBuLKkEyzEKD2/1tKWD2Pf
 H49Xs/78w0DM6T9IDu0mXLgv7ScxMq0J6mrCgWhsAIaVLaata6z57abKu2/T+NPjo9CH
 3CWQ==
X-Gm-Message-State: AA+aEWYcR42jAgOaRRmFrVcKAryaBNZwqU8qjYXigNnqWudTjHrb8BOC
 x/koE8zBylSH3BSZp4TvEjg=
X-Google-Smtp-Source: AFSGD/UDqrBQcxC59f83l1Xagr3hCTLl/ORxA4W+x1FMEYcVxWh5JAcv00gbvM11R+DxMrDXnFwY2A==
X-Received: by 2002:a17:902:9a41:: with SMTP id
 x1mr2169801plv.126.1544121473041; 
 Thu, 06 Dec 2018 10:37:53 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.39])
 by smtp.gmail.com with ESMTPSA id o1sm1621229pgn.63.2018.12.06.10.37.51
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 06 Dec 2018 10:37:51 -0800 (PST)
Date: Fri, 7 Dec 2018 00:11:39 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 stefanr@s5r6.in-berlin.de
Subject: [PATCH v3 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181206184139.GA27514@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_103803_662509_43E914D2 
X-CRM114-Status: GOOD (  12.67  )
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
