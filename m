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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB32EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:24:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FEC2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="txC9Qoz2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfb0Huoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FEC2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ogiju7cOvsVDTO3cb3Kh8y6FGprXyaaQQKJM3WTC+SM=; b=txC9Qoz2Ufcbbr
	4Ew158F69+25OUYo8aq1l7ndJJuApvQG+4eJH2qDq0VE7NBPSCr3ygZ1hq8bApFN05xlSkdZnysEQ
	Wjh2Ic61Z2YK7svFw2cDo1qwrtuX0RfuDQGL+DEcFueJD1EgjXdDKz6X0VEoHFuKKyclSQUtYD6z+
	GLf1JCDHHAs0fzg+DNCGwoAy0UWiR7hHKNlW2x6IQg0499Fb6LQbWpHLI4ETGIV6xFxh5IKnGin8X
	NilosXlh6v6jj5YBspTxoHnWe9UGdboUnXk95jVAeHSA0qOM9Ydhe989G7Smlnkx0RWS5tRKvEaFr
	/t2hsrvdYOpNVg3YaJdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggYdL-0003Qq-V4; Mon, 07 Jan 2019 17:24:15 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggYdI-0003QC-Jh
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 17:24:13 +0000
Received: by mail-pl1-x642.google.com with SMTP id gn14so440216plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 09:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=h5MALT2X5pDliyqWk6KlkEi5unDMEOp/ldBTKlH3kTk=;
 b=Hfb0HuohMJIyDMfHKGDS+Z0nlRBUfEo2wywrLh20vzNDHR+3MyOWMVfIZtei2Wk5jN
 sZCefk7LxhtCltmgRxk7AgLeVDSg896kX8+JESOQgOPc4ohkEglHWPSwMK6Lx9h1YI4t
 eyVMa6XQvrRJE0wZ9/+IE8HWirRsziX1M7M8n1s3EwIl5wOAXUe5VPlhN2GRFkTTDw2M
 GVQuQedtag/IOtufRaE6Bizs7iDpCtOE90mfuBV5+hbroG6RFdDFKDKA+udHnm/w6jn9
 vpFdQGBHy+866v29YO8QSe+Yl1TTiy4EgTjwOePFIB1r6NkWgkTBDp6IKmyRsKX0NeLj
 AjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=h5MALT2X5pDliyqWk6KlkEi5unDMEOp/ldBTKlH3kTk=;
 b=bQ7VNlmKwJGRCtOPBRtbO2dFmvOURM4mWLUBCH3h0GwoDpLR3Eg8cWFAAs+DLLhxuy
 6QnSsM1dGNxKVrTq5i5Y+qs+99h6LiGAJXnas1SPt4CHDkdG9VJRYPYGY4mxIb0ulgzx
 hosdQCyKQXM4+HjoGRAJFgX9AX/dMaN1sCqA8CoWmtW8SVoF73p1TepS3BIL9gMtI7Gd
 97TLtD17A+ZULeSyDAsnTlw/15wHtjVEX2wqaoRiniTS8CEgVbyzU/36AL/mjHjyFMk3
 8Q6F2qQg7wlmrTLbaCllydO4i09l45doRlPQQlIcLcLAnO8pPkiIHHz2aPIC+arrYJJA
 0NtQ==
X-Gm-Message-State: AJcUukdYUo6K+1b4R3yybkmfDDkHkW2nHCNjSUjFlutW3A5+fuKpsMA3
 2UM0nzH7p2cN+jafgPCYqXc=
X-Google-Smtp-Source: ALg8bN6yPML3KHWfETYEKy6ZAhyax4PM9FZ88O6RVrdPTTSxfeug/qLYU8NI9NsZTLumjeNLFT0Kjg==
X-Received: by 2002:a17:902:654a:: with SMTP id
 d10mr60845311pln.324.1546881851351; 
 Mon, 07 Jan 2019 09:24:11 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.19.175])
 by smtp.gmail.com with ESMTPSA id v15sm96759729pfn.94.2019.01.07.09.24.09
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 07 Jan 2019 09:24:10 -0800 (PST)
Date: Mon, 7 Jan 2019 22:58:06 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: linux@armlinux.org.uk, mhocko@suse.com, rppt@linux.vnet.ibm.com,
 akpm@linux-foundation.org
Subject: [PATCH] arch/arm/mm: Remove duplicate header
Message-ID: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_092412_650655_C6230BFA 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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
Cc: sabyasachi.linux@gmail.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, brajeswar.linux@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove duplicate headers which are included twice.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f5cc1cc..dde3032 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -23,7 +23,6 @@
 #include <asm/sections.h>
 #include <asm/cachetype.h>
 #include <asm/fixmap.h>
-#include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
 #include <asm/tlb.h>
@@ -36,7 +35,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/pci.h>
-#include <asm/fixmap.h>
 
 #include "fault.h"
 #include "mm.h"
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
