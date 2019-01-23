Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BC9C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:31:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5571217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aO8x/LVD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n25oafAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5571217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Rsg83m4eSYYHlNjS/VSfTisxWNRAm5/Itdj4aMeBq4Q=; b=aO8x/LVDRQu5ul
	O1MfUNjD9wF7mdhRnYcGuOsiUXQt8yW6iIpS/d+Fw6YRWdVvjoBkldTsk4HbBkTVDyb4KuXlgblIv
	viYmOlW3MBVJhT/5+oVHseRJjTpg9GsuUa2kWeptqDGiJY49H1F+pbjCwm6H03ZOgksE465uOcxJX
	FYs3IB5o7QPJ2tJAKEmV27qqHrXF6MfHQyjaL+9Yhm5AqRz8RxuuLJuL+ElKiY2y/u8rCKkQmvm/M
	qazKTM201I7rNGRBAb6OP3lKm9mM1sJU29MVGz3vEfLwDpNFGeIhc+QMkWpRQzNOKqJComkvCkw1V
	LJS2r/1dG6VwukMnBKGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLRE-0004Ot-C2; Wed, 23 Jan 2019 16:31:40 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLRA-0004Nu-JW; Wed, 23 Jan 2019 16:31:37 +0000
Received: by mail-pf1-x443.google.com with SMTP id i12so1421190pfo.7;
 Wed, 23 Jan 2019 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=QM0WYe3U7IAOj7rprkn5WU3sgdnJny9GSGaYt8Q1O7U=;
 b=n25oafACOUYanlrnKebPd3iJ13BqM2BW6n4fwQL4nQBvaHHtANoyXXznsGMDDhTYQY
 ss/Wu5+iv0oXgbljpZJUX0JZWBBTMr042WuldfGPKX3STqAiwboOHAhvPvJbs7bNaII+
 pffTKj4waqcEyRbcR/RsbuiGxMzSLFZ+KU5QLHJzNkM4V6VVJUCqoKvjvzEdO3k+bxXM
 syqOwGFfxFMMh8wJL4jeVMzNp4WYZJiMdurYeaHG9Na0TkdfIBHn/94n9ySZVj3uN3OR
 LHkkR2+Y/O3s76VCp1JkGYbllK/LBbay526QIls2irX+6Z4mAjXInHFswggPB9hHZOAO
 rq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=QM0WYe3U7IAOj7rprkn5WU3sgdnJny9GSGaYt8Q1O7U=;
 b=HqiLRv6a1xd/iEMGb5Os7qdDXzxldzsQn+WcAtrWP4VD7Xgl4ONtS39jEA5/DIrgvC
 0f4w2ViG0eFKW38CJG3b0njT+ZAAWFycmLhQzTkd5Tl0CC1vA+PIZ37eLs9P4VL8gKye
 IS8SlKjErlnJvbbEsIB04Kjgm618xg+ELH8YjokBFnLz6WGkQ/JTZqs+VKs1nEnsNEzY
 AzbBeoH/zGUFQUvmimysdBdvirSpJGAe3OWjMjkF9b8Sp+EU7RqIGLBjNPi9n1uEQlFj
 x5hIsIuHXXOPwqvI4Bz1hXv6h7M8fkJk0PMdkWZXoMv2sOYrrXmeSygFYdvIgwUHIn1q
 vztw==
X-Gm-Message-State: AJcUukcse/JAOZdjr9RUwrhzyoOhpvO450HuzBICpoNv/GsV8GmLAtul
 KVPl8yXmwVqa6m9/OXm4O7M=
X-Google-Smtp-Source: ALg8bN5Vw4EAGT2vjtiHBEOpf4DQ3xc1PfY5ECeqXTlfEd3/qTqUw7x5cFKTdNidpv3KVEd+sp1SvQ==
X-Received: by 2002:a63:d949:: with SMTP id e9mr2594309pgj.24.1548261095381;
 Wed, 23 Jan 2019 08:31:35 -0800 (PST)
Received: from nishad ([106.51.25.107])
 by smtp.gmail.com with ESMTPSA id w88sm44568938pfk.11.2019.01.23.08.31.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 08:31:34 -0800 (PST)
Date: Wed, 23 Jan 2019 22:01:26 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: mt7621-pinctrl: Remove space after cast
Message-ID: <20190123163122.GA4807@nishad>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_083136_637656_A7F04256 
X-CRM114-Status: GOOD (  11.76  )
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
 Nishad Kamdar <nishadkamdar@gmail.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, NeilBrown <neil@brown.name>,
 linux-arm-kernel@lists.infradead.org, John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch removes space after a cast as it
is not needed.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index 80e7067cfb79..3e959fa73703 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -363,7 +363,7 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
 		}
 
 		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
-		range->name = name = (char *) &range[1];
+		range->name = name = (char *)&range[1];
 		sprintf(name, "pio");
 		range->npins = __be32_to_cpu(*ngpio);
 		range->base = __be32_to_cpu(*gpiobase);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
