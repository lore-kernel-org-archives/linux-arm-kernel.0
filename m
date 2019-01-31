Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D089C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:05:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6322184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eawZ1EMI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGxAv8qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6322184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5uMXCpYFCISForuYdy84gqxtPJTB4n8ozwt31Hy8Zwo=; b=eawZ1EMIQ7Amp8
	+G5NeyHEZtM8SmOebyvEX+dfOa+CphbKOeka+r+v0tuDis9pkJ/Bw8Wg+dEkUEWRrW7RbEW5K4tq0
	zVI3MX65Qeyv5yBlUgtn/9VPb/gECWDRxUPXfC7NNVFfND9YOMqlkgiOV/p5sf7v/cS0d6xz4OnN7
	31u8F5yFN7rn03tVjff+eognS3Yh4aB5AU08rwixAyVln6Lk4L3fM0UYpOy6lNVmkquVSbFnc61Kx
	ZeghVPeazHErGZlp0fceY5R3pwD2h/0Q11muxVp0d9j/YwW+CmR0jiudglg0dmvAltmngS2ItxwEl
	RXBW3m4ed+j2HNDP3h1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2fT-0003JZ-6f; Thu, 31 Jan 2019 03:05:31 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2fP-0003J6-Sh
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 03:05:29 +0000
Received: by mail-pl1-x644.google.com with SMTP id t13so783505ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 19:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=3XbEqy88Jb4MHLdqNBAQMVZdhzSqLBYAliAQZ38QAz0=;
 b=bGxAv8qAAnGE4/0/1ZNjA6WdKrdCJaWxsds6XkiT0j20gD9HiazNhxVH3jQ2NfE954
 f6lyd0VtxLMs3+6FRXMX72RP0MLcU8kSYzRvCqc36bVeBoEUUt4cCcRzjKrr0DUHj74D
 j9qcNWRhCCVd5JaqHz54fuG71h5sJjppg+vqkXnF8LAbrY3kiad+ZfgzV4/6MNqMsgT2
 ZdjbvtewujSzC1z2S0F736u8ktEFvbNL5pp3ja1qicUK+TfG8FpcL2gTM5p9xmuJpln+
 kGpZMAgm4fZkYZ+MMSQgvJ3NwtoLooCY/h1XB4GQShk+odi8bnChiBHfA0/ewbRogLEq
 bdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=3XbEqy88Jb4MHLdqNBAQMVZdhzSqLBYAliAQZ38QAz0=;
 b=HDfd7+yc71VnO3YzMfDeplDXo/FnHlwsscVpjrJij+YbtTgjFhUfq8DZ3EGJm8UCHE
 fP50bJhiUpM45OzmCmf2Q3EOvkuAvgpA8/9CYtH8ucg/L0FiMVfCKVmPPty4peyBWtHC
 WJl54vhQ8qEq2dFTuQmaeivRc72AMvbWOF/cl7+OvPyneLWxPE1ctXiMnRfqkU36RIFb
 +ZQghmdqKMU/wLTe4qGi/O5n67rB0eU+Uq/BGjmq92U8p9xm9ETOHhfOj/1ppufgtsOn
 BkZmfrDbfIXmK3QAxdcBUQ4vlr0CubD6IYXH6CfVpyFrIDW7HaWN6TNOY95Gd3OhRMI+
 0ypA==
X-Gm-Message-State: AJcUukcjU09w7B97ohJwXP2w+Vae7eOnhC5v+m2JOZys6bw8PzgGKbQ+
 Z1shdzSjK3QBt5kzllHkDvs=
X-Google-Smtp-Source: ALg8bN7ndYdcd0KZwye/sDZozNTEEaoNSd0U+GQ1UnkHVLNJBfYQ4gj/bRKSiWuZTWLYRspxbFj3zA==
X-Received: by 2002:a17:902:8306:: with SMTP id
 bd6mr33281522plb.217.1548903927316; 
 Wed, 30 Jan 2019 19:05:27 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
 by smtp.gmail.com with ESMTPSA id a15sm3835392pgb.1.2019.01.30.19.05.25
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 19:05:26 -0800 (PST)
Date: Thu, 31 Jan 2019 08:39:40 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk, robin.murphy@arm.com
Subject: [PATCHv2 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range_buggy
Message-ID: <20190131030940.GA2305@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_190527_955338_CE7BB44E 
X-CRM114-Status: GOOD (  12.70  )
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

Convert to use vm_insert_range_buggy to map range of kernel memory
to user vma.

This driver has ignored vm_pgoff and mapped the entire pages. We
could later "fix" these drivers to behave according to the normal
vm_pgoff offsetting simply by removing the _buggy suffix on the
function name and if that causes regressions, it gives us an easy
way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..99a6582 100644
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
+	return vm_insert_range_buggy(vma, buffer->pages,
+					buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
