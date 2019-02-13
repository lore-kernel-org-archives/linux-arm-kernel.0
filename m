Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1884C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:59:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD99520836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WB8l/4K+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHXHCXDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD99520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DmBU1luKQ8/XBfbzyFqw5IyKhIg+RsGTRx3g/018AW8=; b=WB8l/4K+mAXfHe
	k5kGuxKlrqfNCr0Q2ZLVhvH1/V84A4MVuz1KZ3+Fg3NFqXRtEKb2U0W+1lPcKgjL9PFXOvPs479wm
	7Xhn/dm3AEUlE/P46kPCN+fG8RZMgy2SdmBVGjRiZGU3aZoBg5nzdHsmd9/Z9buiUhRO0JffPJWQO
	9NeFBgjxWZdde60BzARNELdMGSei6YZpU4OIBXFZhDP9YZ83rSyjAIEzkfrzJgFGe9Ltd1cMDIK3d
	bQFIYQ5kiqKWsAir+JdgTdkvTx9IwGVOQuBwLmO3OcDhb7QjVu1qhPo2FQMWtV9KEmTFfD5ncfCfE
	4c32FqcP+TSGU9qxUFvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtv4H-0006Ns-Jt; Wed, 13 Feb 2019 13:59:17 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtv4D-0006M5-OP
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:59:15 +0000
Received: by mail-pl1-x642.google.com with SMTP id b5so1214475plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
 b=HHXHCXDqjrbjv9vKNBt9+7oEqMLimW2KaqFOqXNr/HA7rhmmEUFkNlY/u1NnQgZNbH
 +CDaalSV78Qcw6kY5OQUhGjsfrH+by8CS5/gJGu3VNqes+WPN1dRNmLxWbGIfZdm7c8f
 15gEiqZIi9KcnTmJeiE0/uvejDFQlK3pGLnh1YPOu2dqmZ2OMrKZkGjN68Mg+yf3YDmN
 Ttkvg6nMsBdyaGH/uB7E4ipzK3thPAR0ZqymOfIw+XSoxI5PHoZerSNybOokoRu9/Y+c
 A3BYZAAsc1mpb1sa8omgtYbiZEsojeWq9nmMQjwKjC3dkqWy7hcLdNXjZUfWSeiI7qP3
 8jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
 b=DvtAjYapLbQRhUP+KUuZ4/Mc+1b4tVbcAkxmS2bRVLQqIIVn1+wjGO+WdYWhOQnx6z
 L2JpIK5iAgMS8XwjuN/jwT8wQ0g85ggJXcDV/ZmTxfcScXvWAyEzBiyOXnEnBXPHLfsT
 aagvuCcn4RlR4W3H1pklNzt9qsWD0LDO7AqsJuaT0PgUu/7c8aQOdVSZ42QE1otn6phF
 yHEkWwtBuizsBOwLR43/lUl+ckCNKxFsmitf6mNJk6I7jw258WMpHysyzDtYqxaDWqhj
 6dGVGFGM6zGW9fTvNy4++3DPezJYgUQ27EbaBupxBrYjryj+Bu2qZF7ZFeJTM8M4dY//
 aUmw==
X-Gm-Message-State: AHQUAuazwP320RnVGFIsaOMDUFH06/b5+pSrWMiQrZZ8ozVOPaH6FY1t
 oUr0/C4CEvEt7swAZviOzEk=
X-Google-Smtp-Source: AHgI3IYElBePFcn4s9J3Tqwya9pPVWfxESsTKj0N4GiKgmRE7PyggN/XPQLDEGJiVcCZzaxyw7jtWA==
X-Received: by 2002:a17:902:724c:: with SMTP id
 c12mr673309pll.144.1550066353286; 
 Wed, 13 Feb 2019 05:59:13 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
 by smtp.gmail.com with ESMTPSA id a15sm24035107pgd.4.2019.02.13.05.59.11
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 05:59:12 -0800 (PST)
Date: Wed, 13 Feb 2019 19:33:30 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk, robin.murphy@arm.com
Subject: [PATCH v3 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_map_pages_zero()
Message-ID: <20190213140330.GA21993@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_055913_792438_B71A3723 
X-CRM114-Status: GOOD (  13.64  )
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
