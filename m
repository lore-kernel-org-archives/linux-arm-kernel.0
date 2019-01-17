Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84320C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:55:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6FD20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="brtlNf68";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZsMi8eVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6FD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yq+GtS8cfoleG0MTyKAe1jKRTy1mPZ/m7Z15MEK0hf8=; b=brtlNf68NAnflHJUcvcYU/dBCh
	grp5WKhjoTZg6u9FmsIP7bGnfrNwWFpJQUy22cuBk9T0PF3IGiXxNq8rhqaUKd1s+AzLgYW/+5jyX
	QnWz2Xwq7F27ZR4FPEzFQrtm2BOjvl8+BKdSTtCPPNFhvkyuPvUhJqr6me5m1QAdenw8j3Wz3P9/a
	x4iCcG5wJ3J+ik3Ghd6pv59yl3IowHHDKOlWV5a9iUl32x6yN39eXpbsHyHCA5NnkDGom29g5I3PZ
	aDW6ZhMbPw4+KcEQ8GPbYs6SQD61BTHlIVKKrDHjDH2yiL76yUgersh1tFrg15uMS8ylWifm4poes
	6b0Tn5tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAwm-0002uE-9h; Thu, 17 Jan 2019 16:55:16 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAwF-00023B-A7
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:54:46 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so1812044wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 08:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=G6qRpn5S966nXnLaFTqmom3s0zt1yyX1JZ9+R2qhF3s=;
 b=ZsMi8eVmRGd4IWVBPniDrEC7YdNqZLV0NYZSr9mBYO6P7SwP4JnFSZP40bQnr3LNjv
 qp5mK0/2bkTXUYsbWsHBM1jhjsLIAyadx9LR1PROcwYFH/15/6zJdF1uTDJWt9RjIJbs
 P9329vyBke1U09hUibrv8TFkxPOa9MJFkzMOpREa3UJc8WC+XXi7i24diVOwgG9bFHz8
 sV4FzY3ejSL5zmTlMXqbbvtfWzAeuaw/ShTXPygNIe9tiARM3c+iMIbaTvRp+q1EdTP7
 bxE018wj9PWzfavYvT76dqoBfDOL+Dstt7t7J9Ny+hD9KcGqrXn2OfEjv5O0n3iscrW7
 OA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=G6qRpn5S966nXnLaFTqmom3s0zt1yyX1JZ9+R2qhF3s=;
 b=IRl/shi1/4ppNcq/I5saBVYrdqzMvH3dL07fOSq2GZqZlB8kCJFQSMHKkFBKSzHoYn
 +0ziHtfe4PtZ9crZ9fjsnhYMaijwXgkQdeM/EohexXw9V5y/yK7CrHs7yxXbvYCzKOUB
 tvoyZwXLgOXt6eYUPQ/G4zGBa2yB6RbbTpqriLKEMOcBKK/17dxQPpdjkIcOuf41M7G6
 7dF+vuMBoE3US8On93y/DeBBfigT4Oxc9c1BblGejalMvdX8eAq13uvW9eTCgHQl8pua
 AjnlSJfQ1OJkBpHbV0aBiUmGBEt64HtomJZ1Mwo0laysErKztM/FOImxAdk0fcoAUA7m
 I+qA==
X-Gm-Message-State: AJcUukfqDEkmQgFbC5du+4d7sQkVWEcw7GMGv1w8nsYaJjRnNlPXemEs
 briTI++Qo0dz+W1XysSr9yXPdg==
X-Google-Smtp-Source: ALg8bN6qTZ9AA5J1u/MzzOt4IZ/Gr4gZIYrLCp/2l3abY71IkSvX7wWxwwXRKtDYUij85Y1K+sMo/A==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr12737066wmh.118.1547744081818; 
 Thu, 17 Jan 2019 08:54:41 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id b12sm65309630wrt.17.2019.01.17.08.54.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 17 Jan 2019 08:54:41 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: Add vendor prefix for "GlobalTop
 Technology, Inc."
Date: Thu, 17 Jan 2019 17:54:31 +0100
Message-Id: <1547744074-28308-2-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_085443_356662_D99E768B 
X-CRM114-Status: GOOD (  10.86  )
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
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add globaltop vendor definition.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v2: Alphabetical order

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..d80a70343b36 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -150,6 +150,7 @@ geniatech	Geniatech, Inc.
 giantec	Giantec Semiconductor, Inc.
 giantplus	Giantplus Technology Co., Ltd.
 globalscale	Globalscale Technologies, Inc.
+globaltop	GlobalTop Technology, Inc.
 gmt	Global Mixed-mode Technology, Inc.
 goodix	Shenzhen Huiding Technology Co., Ltd.
 google	Google, Inc.
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
