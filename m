Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2752C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:45:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F2A214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X17aw4u7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iky8fOpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F2A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=t/4RhV97YKMDXmQIy3ibNb6E7eUQOdQXt4rth6Dt9Wo=; b=X17aw4u7SN064T
	C9rGNBZLrOjcfeWGQIaGnWn/oKcRb5U2VAftRZ1MvPF28Wh6OJoRw4QhyomRcZ24JQX5v6GAGM8K+
	Hs5Jd3HJaO6zwIK/nifteD5/mxt10TFK3swbmOLWRdanjNhF+Swq1l80uHc4X/UTU9jQGn90ccq9k
	ymm6fCnL4mV1vpRaFoyay+ZAlihMWvD8ZAGY3hW5+zZLKvdu42KPuzwWiZHCmHDFkE8ikcDZuEwf2
	M+hhDoRd0Xsw2YyZqW+jjURVIsXOtpUX1G3hFna+igu7qA7W4o84wHRsksRLZw42IAvA9e/WEUOBS
	q8AUb5xV2TtHBA0DbcvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVZk-0008TJ-Dd; Tue, 29 Jan 2019 15:45:24 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVZg-0008Sp-MJ; Tue, 29 Jan 2019 15:45:22 +0000
Received: by mail-pf1-x443.google.com with SMTP id u6so9813885pfh.11;
 Tue, 29 Jan 2019 07:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=2hL+n8s3PZPDTVR3C3fsWQ4CUK8XIxnsp6gmvT4RKy4=;
 b=iky8fOpDKopaxVP5oB+m/gza7nNYX98IttZ9Ou3fFLtC0Q2Rqf8LzajWHG+agWM3Sw
 wHo/jk63ro7ORYasiFmXLcCClY7rx3lkYnjRSmbB4p3UcvkoqS/+uHB7Vh9S9c3rNC/k
 ffB5EYudjdgAoZ7O93gXMppWeFky4qU3qs7VxQXFuCug4gQV4C8wagJB2gILgZfSHKiM
 MdQSHljJhpXiH3KrXtrgTO0PSA8s423H9Qd1YwFJWdgbiVCEyBT1Zx9dd6MyIXZ7C3m4
 M9CCOwCfVt4lRLE5jzQVQttbosHGdgb5wZ6VyjWklz0D/LLvBnI8qCO7/YG5lfguLtZ/
 RRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=2hL+n8s3PZPDTVR3C3fsWQ4CUK8XIxnsp6gmvT4RKy4=;
 b=eiaE7DlSDCaYrzMIYT+yyvUmdFKefKfiq+kNp7X7rKB+VgHaEYmTQ88mKYGd+hORko
 jciHQ5p0YR4ZpakezGYABZq6uqADfmgESRhqoAFi1mkVElGkHmrN8U+BNYARNti6dLik
 H+9Y+byWRouwNnSqNsuwgmIDQ1DymYtWmTsMZCm8xGDPg7XiCztMtIhAP1kFP2BdG1Gy
 SmzZD9yXL2EQVLz4eFYi192/OBrTay2qzfIaO37szv6Otkza/d1MIGaQ9BMXeFy+9C9Y
 IHln3F9jnuuVyIt5v4A0NAVjPMqMmlEBxexs8lCTjChQyQCAPib+kdRP57KgslMhKXOY
 oXOA==
X-Gm-Message-State: AJcUukf54e/N6kyxJoB8F2FkbpG0RFQRpfd3x4NMBQcWpfE3Liqk8Avb
 jKNR4RIn/Cmp4UYvTlEqpIQ=
X-Google-Smtp-Source: ALg8bN5XE/W25hqzW7cVy6uuZTOVgGIDj/6VzVf76Uweg1cDJ9QLj+yuRPdAFWbEgoVP7RrzDWhiCg==
X-Received: by 2002:a63:e247:: with SMTP id y7mr23038857pgj.84.1548776720057; 
 Tue, 29 Jan 2019 07:45:20 -0800 (PST)
Received: from nishad ([106.51.25.107])
 by smtp.gmail.com with ESMTPSA id w11sm45165929pgk.16.2019.01.29.07.45.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 07:45:19 -0800 (PST)
Date: Tue, 29 Jan 2019 21:15:12 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joe Perches <joe@perches.com>
Subject: [PATCH] staging: mt7621-pinctrl: Test devm_kzalloc for failure while
 improving the code
Message-ID: <20190129154507.GA25365@nishad>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_074520_780570_067CD2FB 
X-CRM114-Status: GOOD (  11.30  )
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
Cc: devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, NeilBrown <neil@brown.name>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch tests the return of devm_kzalloc for failure and
improves the code.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index 3e959fa73703..9b52d44abef1 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -350,7 +350,6 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
 	for_each_compatible_node(np, NULL, "ralink,rt2880-gpio") {
 		const __be32 *ngpio, *gpiobase;
 		struct pinctrl_gpio_range *range;
-		char *name;
 
 		if (!of_device_is_available(np))
 			continue;
@@ -362,9 +361,10 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
-		range->name = name = (char *)&range[1];
-		sprintf(name, "pio");
+		range = devm_kzalloc(p->dev, sizeof(*range), GFP_KERNEL);
+		if (!range)
+			return -ENOMEM;
+		range->name = "pio";
 		range->npins = __be32_to_cpu(*ngpio);
 		range->base = __be32_to_cpu(*gpiobase);
 		range->pin_base = range->base;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
