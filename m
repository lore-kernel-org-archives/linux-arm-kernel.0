Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D13C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:34:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF99217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BoY0e6Sn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugNh42NH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF99217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yjnR0iDuuVhhHhxLJNQ09xmasbAj277082E6BBm1hE0=; b=BoY0e6SnmWa4HY56Ig0PvxB1hV
	EUPgxdmuAL8/CYG2kKcfirpCWxb6SlsIYjTbYbs1KLxI1S+vx149XOfX2gQL78I1aoLv4pc6BGi5I
	UZG05QI22eipS7BPerkkwkBQF8gHvfO3linpwdZJFoVpyzh3H+cpbPFEbHkipLwpv3/eT1Lj/m84Z
	bdKpDZJ04IPAgbZCg/DP3CvD3GE1XVHXATmafElK3y8H5uH5Fttm8gHnZiepdcNRkEUndYkDZK2VQ
	vLhvMrmSzXfO8R0UfYWJZe+KocVdD3RNv6igpJk1cf0Xayfqv4J0dGqcRVgiRmE7904OhZ/crZd33
	nRv1jXAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm6Un-00051A-Am; Wed, 23 Jan 2019 00:34:21 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm6UL-0004Zv-CQ
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 00:33:54 +0000
Received: by mail-pl1-x643.google.com with SMTP id b5so213436plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 16:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tfGTIJO5m8NWQURx9g+bU65yV8N/3DpbsVgcNTCxXUQ=;
 b=ugNh42NHKJ4iuhT/CHr1m6eYLE8RjkCAjsWmnDTdjvh8eUgjuTa1ZYXyFKt7MpkPRp
 98VcQyMqN1iyydW+quiBl80XY6bUaTkgkdpA2+yb7QKFUAQAqXQch9loQVX/y60x5+ur
 6JFblbgbhFucwXuaypL2eY2hA5a7FH4Q10U0mTtH30m2ANuM1JlkB1hj6UdmBwbG3dRI
 aPvVvvwD93bw/zruuyZTsAzm5DS1SuDo9eeBuD9ZSqi0Ie2XHceGd5ecCiV176ixAOw5
 94LqTvnTDS0QTgxVfHnU81JJabz87rceMbJ+1cMxmHKUjVVcCGj9s1o1vNBtJlEWyXVa
 6wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tfGTIJO5m8NWQURx9g+bU65yV8N/3DpbsVgcNTCxXUQ=;
 b=WihmhgOijWAHlKdfqXz7GTeimDMFUUPEARYffuN/9fgs4BBffu6wuaTgJBd9abX1tB
 7n7lJLMk/rJqqTYqcWp5xEn7LOWgOTFsPHPuHfN9RiBgt+Z20x0Q41dNO3Uz6kfBeUF5
 f/0ld4ecuJhITK/VS5Of+p3JfLWSNCf/WhQJptEcaIijfGUh/QCn46YM7eYB0TRKHg0d
 kPT0NVliC8oSUsbEip0D0YVdu5B3R71wmy4I1H5zN+jocFTPAxlTPDxqjGNiORLkzxWK
 CdrJGTaNT5l33d1HTUEicUgQvl1oG89sDPatoF/gZBERiauG0bbdPESYy/Jml3QloUVU
 D+fA==
X-Gm-Message-State: AJcUukfsd6dLznuHL8Y7kE8SNXd/wx3v+xXawIo2LQc41Ws9bAwJq0cq
 lLUW5Q9P8CEzAAh52E2jehqmuFOU
X-Google-Smtp-Source: ALg8bN6D3u/lHxf23Y6GYqAbjBgb885VrYySsIy73j6QMoNSyHSAZ6EuoFY+qDgkn+v7+nleb7gYVw==
X-Received: by 2002:a17:902:32c3:: with SMTP id
 z61mr113791plb.114.1548203632158; 
 Tue, 22 Jan 2019 16:33:52 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id e86sm25465257pfb.6.2019.01.22.16.33.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 16:33:51 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH reset-next 2/2] reset: brcmstb: Fix 32-bit build with 64-bit
 resource_size_t
Date: Tue, 22 Jan 2019 16:33:45 -0800
Message-Id: <20190123003345.13750-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123003345.13750-1-f.fainelli@gmail.com>
References: <20190123003345.13750-1-f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_163353_418764_742B435C 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, sfr@canb.auug.org.au,
 rdunlap@infradead.org, paul.gortmaker@windriver.com,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, linux-next@vger.kernel.org,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 32-bit architectures defining resource_size_t as 64-bit (because of
PAE), we can run into a linker failure because of the modulo and the
division against resource_size(), replace the two problematic operations
with an alignment check on the register resource (instead of modulo),
and the division with DIV_ROUND_CLOSEST_ULL().

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: c196cdc7659d ("reset: Add Broadcom STB SW_INIT reset controller driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/reset/reset-brcmstb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
index 01ab1f71518b..c4cab8b5052d 100644
--- a/drivers/reset/reset-brcmstb.c
+++ b/drivers/reset/reset-brcmstb.c
@@ -91,7 +91,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (resource_size(res) % SW_INIT_BANK_SIZE) {
+	if (!IS_ALIGNED(res->start, SW_INIT_BANK_SIZE) ||
+	    !IS_AGLINED(resource_size(res), SW_INIT_BANK_SIZE)) {
 		dev_err(kdev, "incorrect register range\n");
 		return -EINVAL;
 	}
@@ -103,7 +104,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
 	dev_set_drvdata(kdev, priv);
 
 	priv->rcdev.owner = THIS_MODULE;
-	priv->rcdev.nr_resets = (resource_size(res) / SW_INIT_BANK_SIZE) * 32;
+	priv->rcdev.nr_resets = DIV_ROUND_CLOSEST_ULL(resource_size(res),
+						      SW_INIT_BANK_SIZE) * 32;
 	priv->rcdev.ops = &brcmstb_reset_ops;
 	priv->rcdev.of_node = kdev->of_node;
 	/* Use defaults: 1 cell and simple xlate function */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
