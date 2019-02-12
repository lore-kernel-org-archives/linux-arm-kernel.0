Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FD9C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA8020449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k1V/NM/n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ab0ASbTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA8020449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZG9n2b+UG5mLSQHJ13UCgB3EJnQzonYNZf+1tYTS78c=; b=k1V/NM/nBsgQc9
	FgcrheJgQUeM1/gbkIBeswIQUz/tTvlBfFVZwlAErM2FCQl07lv8FyV13Xu2184Yb779+hhd7ql1t
	0aSRFkm4lclR9L/xG9nYsownWicTYyA7WtxVHW5dA5lR7vXwmXdcA/BCn3gw0rNsFMd/k1k5ani9j
	H7n57Q4YK+putDIJMimuNPtMkQ8cZyemj5D1X+6rnHrVg15krCs5v6TIwDJjH0R/3oSBaqRb09dIG
	wtih+3i1mepkeaTA4dk8QoCRIXViNA4mFLb8W9AahLfeRytyhQtnE6Ig6gW0tmWJm3ZqXZ0IJYoC/
	Ysc68SHqdHtfYXlUVuTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVTi-0006ed-Rm; Tue, 12 Feb 2019 10:39:50 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVSu-0005rm-Cp
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:03 +0000
Received: by mail-wr1-x441.google.com with SMTP id v13so2092169wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
 b=ab0ASbTjE/ckR7IVCA4YfKj+IeTTiW229Kuce+qyg+52Erhivx+/2FhNz6L5q6IAHJ
 CZ6dpFUHV/8t5UAmzAZY6MPvKSIcBuPKrVfgYSyRmvv54xnEG2eRqd081L0RZxMsbf0a
 vMueLD0AQYWLryjUGqhGTZ3wSRKOCroqtuBDS0vjgvN4tfLZo87ZQHtTapRZYUesrDdg
 uLAFbUCE/PDrD8JnWoTBLbyJwWa25J3mFfA5AtZCmNFWC4AekZGnUEcGCy873PbFIMX0
 qaRS6Ff1kBOtcn+37uv/FqrO48TKTDXPcVB7PkLjPW1PouhtQ8GhRj0IQ6NUlVD1rDKg
 MyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
 b=ZshmqyhIjP5Gg+QwtfAD6j4XGGGSLG0NgkwmRuzs5UVEK+bHNmxmzNReafn5K25f2J
 dbbbFx+JW3cthqM2wiFudxTMvjfc333dmGyk+cCnZPrKVpvBbrYyEt+BAeFQXivI1OKx
 0hBh4ZIf2AVQ1v0TEp6jhSbhZOJTtH/KyfODGXXwj21fCDwhCjFAYP7o1N+pMpJsevDp
 MKXmUurMhuXMjZQfeaTYFAMVnNxF9NLol/DEQa5QHxNVwKbjhw42jWXw5meEWL433Ll3
 LX1WEHTVlQIJE6aquxlsmLaHrdTVWDYb1i9gs9WZetudELFfEdvewGixd4si1o8DxxLJ
 pQXQ==
X-Gm-Message-State: AHQUAubdtkmDHEV2279hCEKlVs9JEKfMWy+U5jH0ggS5K/i+3NwNl+Kw
 bYr312dKSkoOC8ULK3/Ws1meuQ==
X-Google-Smtp-Source: AHgI3Iak1wszZsWxYCmn7blit4/Cv0jSY38pVugKKoO/9rIYq3iJcLekYIiTe+Cthps43ITmUiygjg==
X-Received: by 2002:adf:dbc4:: with SMTP id e4mr2508066wrj.320.1549967938534; 
 Tue, 12 Feb 2019 02:38:58 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.38.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:38:57 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 02/37] ARM: davinci: remove intc_host_map from
 davinci_soc_info struct
Date: Tue, 12 Feb 2019 11:38:00 +0100
Message-Id: <20190212103835.7768-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023900_437296_3B975FBA 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The intc_host_map field in struct davinci_soc_info is not used by any
board. Remove it as part of the interrupt support cleanup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c             | 5 -----
 arch/arm/mach-davinci/include/mach/common.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 94085d21018e..67805ca74ff8 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -117,7 +117,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 {
 	u32 num_irq		= davinci_soc_info.intc_irq_num;
 	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
-	u32 *host_map		= davinci_soc_info.intc_host_map;
 	unsigned num_reg	= BITS_TO_LONGS(num_irq);
 	int i, irq_base;
 
@@ -182,10 +181,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 			cp_intc_write(0x0f0f0f0f, CP_INTC_CHAN_MAP(i));
 	}
 
-	if (host_map)
-		for (i = 0; host_map[i] != -1; i++)
-			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
-
 	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index b577e13a9c23..944afd57ee38 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -61,7 +61,6 @@ struct davinci_soc_info {
 	int				intc_type;
 	u8				*intc_irq_prios;
 	unsigned long			intc_irq_num;
-	u32				*intc_host_map;
 	struct davinci_timer_info	*timer_info;
 	int				gpio_type;
 	u32				gpio_base;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
