Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAE3C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:18:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52A321850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LbcYZGGm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD45kp+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52A321850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Loy8BRpAHtcpXHPkVZSW+j0QVNFil9xaFXoMXhsn+1M=; b=LbcYZGGmUbi7st
	D73dvz+PBi/xaQqpRUnJAIESJPPAmklmlFsX1xia+J0Gx6DrjQykeaec41Iykdfn/Iwybc0SV2GiE
	4p4TQXp1dui2OawCA1oRbL+Llwh3I6rBGy5Ipq/GbhU3Rl7NH9FKIk4hqlFcPbT+0/rO+e+SJh53V
	29dok2Mf7jK4MmYaN+xbfg6ODQRWd26t9oCleXKoTNfK/dAQofvOGqRCw0WRx9qkQ3w+FZcV8mzlu
	+15Lv6NJWWXUBMuWUHH1xfFjZ+imcqqKEw0TDwyYNd3dAuIJD2cbsoFwOAiGiPUezbWiKovR22ccA
	Ad0C1JS9vidBlD8Jh88w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbQ84-0003MP-RF; Mon, 24 Dec 2018 13:18:44 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbQ82-0003Kg-0J
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 13:18:43 +0000
Received: by mail-pl1-x641.google.com with SMTP id w4so5603097plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
 b=TD45kp+Toiz0zyzHxRUMulEByoStvt6ALI4SRmA3r7+UR6vf1Fv9a5JZlAX5TD1VXN
 uySrs+KKlKj6AILhcxkzINzdziuX5bcL2X/eIZv1ApoknaBxtC0iQ+dScI6QyWwvgG9A
 KWU48g1Gzfc82fpG+paZm07hduVR+l1LiSnXUyIrBafxPSynW7LPdl8bhdzMYq/4AeCK
 OdyaoSSvevrLr/uRnMFcP5ABeJIURBQ3dcRXX9+4yECKcyCXvhymfBQVwrUDrubsv/sn
 T+AXjPEGV5m+ZsjztLaTPuh8na33XnafrsLskOheO2KRZnyIBRfgSSuM6Pn95LfGvPeR
 06SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
 b=Y8njGoAnO4LIrU4KcOVeR1nXeHwCu2Tnb/ZkDm4IICvyrQfIip/KmO2MN3H5uoENB0
 GU5plS1Fazhv3kjC6U6SBU47q7+mstqNj+zwIjQEsk/0KJgDYx5fbzstUn7gFXOiUyvq
 tVK9Sbjf5YejIjs5PijlKXkAKsaHmwN/sNRWwQmbY2PsE9mrF3CASM85MQovCSJPiLtY
 E4xEBuedIUt1MYy57MSDvLEHKwzXovpbEz3NdrSFhaIPOsgVNSwxPDQJ+hG7xKqx/qzJ
 LwEp3hO6X8QWGlPcFBFZOL/Hglhr9GoJx1n1F/+0kaKjefuRhbetmaLBg7iD557ekLzu
 Fkww==
X-Gm-Message-State: AJcUukeU6ZuCuKTXoGqvViV71gh5NMSs1vfAmADoT3hCB/B04rNHy/YC
 e+MH4nwh8jnLVsqv9scEw9U=
X-Google-Smtp-Source: ALg8bN4XK5L89IhWFZWeXxyCo+XDDhmG6v7dUoEX5qNfkascP5MGDznUdyua+AHQOE+3TD6j5/G3fA==
X-Received: by 2002:a17:902:8ec8:: with SMTP id
 x8mr13070446plo.210.1545657511512; 
 Mon, 24 Dec 2018 05:18:31 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.181])
 by smtp.gmail.com with ESMTPSA id k14sm58126547pgs.52.2018.12.24.05.18.30
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 05:18:30 -0800 (PST)
Date: Mon, 24 Dec 2018 18:52:27 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
 stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk, robin.murphy@arm.com
Subject: [PATCH v5 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181224132227.GA22096@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_051842_046286_221444DB 
X-CRM114-Status: GOOD (  12.60  )
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
