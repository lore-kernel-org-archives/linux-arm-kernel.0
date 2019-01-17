Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:38:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE48205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n+JMa9WA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blz9J7A2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE48205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qL5Zbh7Rju5ca9ux/YUjVnztMY7iwVEMXhuUZtIibcA=; b=n+JMa9WAcD/buB
	ODAA2sQjR+dthGn+ItQX/9d+HAFkkaFTDmXk5CHhYyZTjC97A0hkEkhnVMyVVdp81D3cZAm1f+mwQ
	OBmjp+0AG9WXcXWcB5qjsPrsnR4tStHdBc1i8uWuEXnMGuCludxqw5ia3Etqo+EXeWG37cLUx2K5a
	DWzSRKncbWjtP4jR7T1tzI41t8+msNaje5Ub3+t12QhOCDm/EKHwAJgm6F0ezuLLa/zkOchRM2ZCU
	F5DZFTROG0a1FmTOBP1UXjdO8JEef30gb+E9kNiuR8jkKKtTs01KC9uPveiw6g8dWJCLN5/n0ZqLA
	Jk+4pBO4d8tgJ2k0pSUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk8nw-0005Au-Fy; Thu, 17 Jan 2019 14:38:00 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk8nt-0005Ab-Dq
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 14:37:58 +0000
Received: by mail-pg1-x542.google.com with SMTP id w7so4513109pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 06:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=67KdRtf3gBQZSqEzeYBLHnkzf1Hr8Lnj8xOAI6w6D2U=;
 b=blz9J7A2wMXAFuN8wZeupd4BI7lp7TmufkG2SIPXFC+X5UGvYFuoBdkxZmwuXM6AVo
 NgHwe37xxMWMtQ0SUBwUQCFNd4s7qN5ZxUVTN7dHe+yknCVQphokPq+mPcVPGflkD2D6
 OOwJ6s0LglAHQYXTmUszTiSbSZPTVzb1yy/qyUroewFPo6f8YVvAKxJF7WLpzPJbwJsD
 6tNg8FzAamxyQ7xheKQEzOBtJgzjXl5kWmaV1P41P7JPhswhgNwKaXPglpANQibPGtrC
 4S6qiEaA0qMNnW/HF46zxV7HkVwKRwICUlHLOSvf4+f27SWRr+zTKE19rHTHFuprc0Il
 5m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=67KdRtf3gBQZSqEzeYBLHnkzf1Hr8Lnj8xOAI6w6D2U=;
 b=ZNQ96mMRd/JaG/BfXINccux+nxHvKqk+kGo071+3x8DILR5vcmJ/q1QyvwCknQvj+w
 A/3GhSY4R13uBXuU1nUhk5xH5Y8ninJH1850MXrmw9nPeB69xyb08fDowiqi4bXIgGkh
 S3/icmWAClHqY0M08inP4uHYUC5eTQngdsLcmXyTmuYgyZ76OP0rVZV7Q/0rJ4Jy8RoB
 Nvx5USWbnYb4owCmJuAi+ISD043ZFKYkZI+YHO2bRt7Cu3eldrZ6usn98LFS4fIDXzkl
 u4eA6zPdA1bUNF3vuhklkJwHd/kpDEWKF9JL8yAbK3KLELwhVl31nOSimS4DatmLQfde
 FaoA==
X-Gm-Message-State: AJcUukeHEOnAFfILi2yhsMXswaVgT0OFxBELfS8xVtS4qL17ybJcRw+T
 h0MlZQZ5IoKBfE9Sc8VCx+aMihVb
X-Google-Smtp-Source: ALg8bN4F/kloviAoLjxyMQS8wAfpCWY/ItspHghPgGNpB30ZOdcUnUTjO5FGom9C4PKbc7VCHlrRng==
X-Received: by 2002:a63:91c1:: with SMTP id l184mr13797903pge.29.1547735876478; 
 Thu, 17 Jan 2019 06:37:56 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar
 ([2405:204:4402:39a3:451f:6d25:2f65:74d6])
 by smtp.gmail.com with ESMTPSA id g26sm3394598pfh.61.2019.01.17.06.37.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 06:37:55 -0800 (PST)
Date: Thu, 17 Jan 2019 20:07:51 +0530
From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
To: lukma@denx.de, hsweeten@visionengravers.com,
 alexander.sverdlin@gmail.com, linux@armlinux.org.uk
Subject: [PATCH] arch/arm/mach-ep93xx: Remove duplicate header
Message-ID: <20190117143751.GA3462@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_063757_494970_6B1FB61F 
X-CRM114-Status: UNSURE (   9.91  )
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
Cc: sabyasachi.linux@gmail.com, jrdr.linux@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove mach/gpio-ep93xx.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/arm/mach-ep93xx/ts72xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index c6a533699b00..85b74ac943f0 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -26,7 +26,6 @@
 #include <mach/gpio-ep93xx.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/gpio-ep93xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
