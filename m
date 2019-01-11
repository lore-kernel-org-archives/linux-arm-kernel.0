Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EB7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EC12084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I3Qn6qCd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMaXhdA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EC12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5uMXCpYFCISForuYdy84gqxtPJTB4n8ozwt31Hy8Zwo=; b=I3Qn6qCdpm4eSj
	FR23LGI/3beB+JH36dKUEcV6f9g+n40PXoam2oBp/GNK8Ak2VF/hWf1U2gdkz56/JxH3pg2pmvCPB
	wzwA6ppDHm+p97/759InXCUdi2VDvMJT8JYm4E3SOfipy8q+elD17VfgsBWLo0bl0HTjcdbAlqYak
	bmcSgUvyRy8YSmE+u0auKqhnSLbczA64oYq+4QgLdSIufISjhcxvQNJl9PjBXlI2yI88JzlzMES81
	BuVDiiVR85tTB/4MdMMBH5rGV/nUYR9C7Vfi/0Q58DWrjqwrYrIjJ74nvg/BODQe58zoAtn0m2jSN
	5f92W0Lju3uVGXrObP4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyMP-0006q2-HU; Fri, 11 Jan 2019 15:04:37 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyMM-0006pg-CZ
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 15:04:36 +0000
Received: by mail-pf1-x443.google.com with SMTP id y126so7082628pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 07:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=3XbEqy88Jb4MHLdqNBAQMVZdhzSqLBYAliAQZ38QAz0=;
 b=SMaXhdA8Q7nrM9qGUNh1kXzTtWH3gVpEoGrrBwY0qxY14/6qIrIZLV5RIbHD4KieFg
 uMMs3JSQnImublU4VhMlU8lpOUNf2T+DQ1ruR+6UTCQVwyJEqccZa5+mnpsFhDKrFHy5
 02c65ESvjA43b3Q3wXtts81HrN/V4kc0SPTdigGT9Sgqw4BqeszJJTCwc+gBM1vxQzTN
 DHTmwg24rP7PK2YUNwW+2JaRT5FNu8YihWMNxmwMPbZTqtN5VeHCCTywejrfNHHFyh5z
 OaZ/UtkiIR/jd52gMYtkRUHgi4X2dctsgtWFTEfHBzP1UaGCggVU6qAB+PrqACCOkVwX
 Bv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=3XbEqy88Jb4MHLdqNBAQMVZdhzSqLBYAliAQZ38QAz0=;
 b=HdPv5ET+T+4arFITyJQvpXrP0LcnNCy/yjRovTCWyuGumtMzrdz7yRQ9Zs5PIH93oI
 bCEyS/yusYrtehDsK0q4hxaRNt9UpU6MFIsnwHwp7033UQ1Lwwfn/Im02DT3fT9rT6yV
 aLhwhl0aNT0yCIoLa59Kj0xJ34NBcECdAB+0aOhkn9kTuZQBTLUc9tG99TuCD92A3r1C
 zVWaI/Z9NrDC+vGrUk/UlI89Ss9Y2CzRpzLIv3FcfFyqdPKGHZ9vldLesglSYIT8ukmy
 vlhV7vsrxxlRfCauSiAVe2aBHW+HhvWFFarM/tpAvPJsJ2ItniCq+LNDPx9hxKbVDnX5
 I/zg==
X-Gm-Message-State: AJcUukc/6IR0QV6q/SGILT/KRK8yS8vXtCK2GQ87dCH7FgNww23okVJs
 wtftaqvLqPiPoC3RqO0e9L4=
X-Google-Smtp-Source: ALg8bN5euVDCQBAFkwT8uFKwwThbROCLZs0KfIkBUValIFAmJazBRAFlZV0vDYopnVamFPnq3w74KQ==
X-Received: by 2002:a62:b24a:: with SMTP id x71mr15274522pfe.148.1547219073889; 
 Fri, 11 Jan 2019 07:04:33 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
 by smtp.gmail.com with ESMTPSA id 125sm131459879pfd.124.2019.01.11.07.04.32
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Jan 2019 07:04:33 -0800 (PST)
Date: Fri, 11 Jan 2019 20:38:34 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk, robin.murphy@arm.com
Subject: [PATCH 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range_buggy
Message-ID: <20190111150834.GA2744@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_070434_429885_54528CA7 
X-CRM114-Status: GOOD (  13.07  )
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
