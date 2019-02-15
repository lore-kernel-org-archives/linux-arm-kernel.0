Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5142C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:12:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39882192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dfgBPNvQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy0HWcMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39882192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lkoI+Wv/5N2zdc+uNgkn46ob551290ZNpmGVHtJoIys=; b=dfgBPNvQe7x5z7
	OMAIDtxuhnFB1FMfkqUhs7XgB5Eb3qM55AygMlMUqqdSAKia07Mta+YDFQCW2YjdUTLPCuHjqkchx
	PF8wHgRNMhIAazLzNNxM0MH9ZtohZVOPACUd0LPvg89K37Pvg36ViGYffWV1I9qYS0NUQmDXrZVpB
	/G+daVfNKxXaR08Tn+8gwSo5hFULIjNgUwWu7Qf2tAEcoQpRp35t38ZTJm4DohYthwXi1Ap4YBYng
	+2aBux8UM8BRFm4NkpeXyCftAW76AMZPyq6Cx14Dd7zf3kHi/C/H4doUUbeq73jR81qZFlN3gszqg
	AT4XApA0BEWzXTbADRHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVn5-0005QW-Ht; Fri, 15 Feb 2019 05:11:59 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVlg-0003dv-IT
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:10:37 +0000
Received: by mail-pf1-x441.google.com with SMTP id v21so1255818pfm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KqtrslLkgT/Z6uq4EzyY3Q3MqlnW4IFEN8LtqbTqJJ0=;
 b=gy0HWcMJFNzcQxRh0u54KsaqeBjpRZwxN6Es5kV7Wprr4jqygzo7JoccJANpE8uoHq
 RKSD/+QZJGL70kAjw61CE+cnkIhKwxlH4E5TuP6wxA0IpVOIxDk9Issry+6I7U1MEZue
 TYyG1T+3GFytczGZRqKWGWgSyMmYYNhFfsG+3BWxm7NKls56e76vo4tc8RNuFGGadYEJ
 YPIKmBcbNB7ucZcN10pnr4DsecxcshIybVUPi6A0y0P7i0fh7ytgADOI1IA835P7WjoQ
 C+1p33Xt3bM1lciA4ZXtirC4yCdBETSvtbf75j9XSAxkGGV2AOWtyveUmqQ8/7T9753V
 C5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KqtrslLkgT/Z6uq4EzyY3Q3MqlnW4IFEN8LtqbTqJJ0=;
 b=c0zolR8fzh6yfZZshbvE/EigkxizetBFPSLF1j+nZynK9jBiuvEIJpcOlHD93uPy4K
 h0qObVhpoEot5Ex459bRZy3vp22+OgeL5WpRYJ2vA9r4fZrRPN/In/nIl1Yyk9AkghFP
 KO7W102y0S1FxGACAwOi+AVAtYNmXeTQPiMkTcFlXMgAdFgcMDgV1uRYY5w66NYedoK5
 GSB2SJoziLFbFrlLAcI9YmiDvshpC/zHkqrYOYo9f4GZYwhFHwugwU4V+x5JgWtrbnSR
 6G7AlFFyXC5zbIAjJ2ByPNo69BJSXFjnj4O+gR0KG3lpd3ERd/eQ7qrSpJupV7uueLtV
 QUyA==
X-Gm-Message-State: AHQUAuZ/EA5kBqOfMYwoz1tgbEb451oui/lkCPgCkAt9ucxcS2QUYive
 P7IaJaJY5dtC9OuywvUJK3M=
X-Google-Smtp-Source: AHgI3IZrP1AUeqxWSdR395Qu9FqCbvWLhJUu5Iym2GDJEYLZMcPw55JxKug5GLAul1h0RF10lAleAQ==
X-Received: by 2002:a63:854a:: with SMTP id u71mr3543271pgd.141.1550207431822; 
 Thu, 14 Feb 2019 21:10:31 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id m9sm4900442pgr.7.2019.02.14.21.10.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:10:31 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH v3 09/11] dt-bindings: Add Guangdong Neweast Optoelectronics
 CO. LTD vendor prefix
Date: Thu, 14 Feb 2019 21:09:55 -0800
Message-Id: <20190215050957.20755-10-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215050957.20755-1-anarsoul@gmail.com>
References: <20190215050957.20755-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_211032_646549_EB978FAC 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add vendor prefix for Guangdong Neweast Optoelectronics CO. LTD

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..15cfc265b644 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -267,6 +267,7 @@ netron-dy	Netron DY
 netxeon		Shenzhen Netxeon Technology CO., LTD
 nexbox	Nexbox
 nextthing	Next Thing Co.
+neweast		Guangdong Neweast Optoelectronics CO., LTD
 newhaven	Newhaven Display International
 ni	National Instruments
 nintendo	Nintendo
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
