Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17172C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:59:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5025207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l2jbV+0C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sx+prSwl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MOsr+9/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5025207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BJwa4BwoFcueKpoyL7rt8AdKE6vgQYilTORn584zvb8=; b=l2jbV+0CNIV6PK
	fE2KXfRGJlD2MQ7DRZMBF5IG0g0DAwd1Rdt4tCZdc0NSqoqG8J4OTwmJlMeo3VKijF/c8jE/odlj9
	97SOdh1vB30NXam/EcN14SZ1GeynFIbyr7ST8K4ph1fF/aIB7sVQy0FCakZ77KahFa5i6CgV6skfw
	a6GHRlJOm51+i0H7TDALcEuIoDEDuWXQbdeB2ZYTwgS++ZkXAPfvUj8S7hcoSyTYHpDZb+jBTgW+8
	tOECnlEGERP2bxQ9+CM8IBA28SgC4qUW5CIflEdhF134++wXxPMWHLpHII9i5njFB00fUqmPfGKmp
	+JpkXgQvYPo73m3C92GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2lN-0004c0-OB; Mon, 28 Jan 2019 08:59:29 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2lB-0004TV-Q4
 for linux-arm-kernel@bombadil.infradead.org; Mon, 28 Jan 2019 08:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R80ISGMVnhZRl2upLFe3I27brJHngys9Q8b/N3uhZ/M=; b=Sx+prSwla0voi7vZiciaLOs5Gd
 SZi28BYwXLD+Ek3JEyQj+8PZ5kYLtooihqjXXwoFs44d3//9U/a9I/uDyCkpvnOFctYg72XwUtpAY
 OYI+ro/bGTudIDT5Cmb6JfepydJCLoQkFPFgZoGCGhAebDCgFi6V3f9xXGR9inOAk5Puc3ldhev1u
 Z7fA7z1YyzmnY18/hKvxIgRCOWxUzPCK+uG8pDehSkeqG7CZUPFtKN+JDNyYUuxc+eAiuV129nk97
 bIBWhx4LPlVwzjPg2YnAMlEtiwH/hBoIkBNE8EGPmowPp39idfNSAq+KxE7Te4wmFVZQp1J1IYPqs
 LJtv1P2w==;
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2l9-0005o0-9I
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:59:15 +0000
Received: by mail-pl1-x642.google.com with SMTP id t13so7441934ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R80ISGMVnhZRl2upLFe3I27brJHngys9Q8b/N3uhZ/M=;
 b=MOsr+9/dZrj2r3qjZ81FfEyec6T5ulVkdZiXhvyLn7o0S+uiJThV3PH//yyGSA+e52
 IcNpd4ktDhmYdArDsxD6tInv8X3YmrxCfS96jzOQFtdvOzMw5+lASERl1hnKParMz2Aj
 jIYXZhGqD5VqMv+C6r11JdRfTYTgNuYIk1UKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R80ISGMVnhZRl2upLFe3I27brJHngys9Q8b/N3uhZ/M=;
 b=FTCdA5FLAyxQrx5KTpYvLLDF1/BNpMHKWW+CMROyglt+bUqVLZ8LzWpsbC+l3OKYHl
 7IsvnffiYR4OgwtBf/7pdhQytYt7yWrRkpdrbl/MF0q4RI2jlQ3GJm2e8/VBt41d/H07
 vV57sG39kOQCOw8TJt0l3u5YeM3DAjEj1e9N7rqQ8MAyLGIEMuSK0y29v7VuNRxKC7gm
 5O3WAxovk2nVRPJsqBRe+6b69/HXdwMmcQQehjQnqOAcC+T20/lB7TRjNVTuJYf5GbmC
 ag/OaZxAFr4Mh34ZFnxuF3vc5C+7mYBkovApBcv5pstaKHmyL5iMr/l9bFV0eM1QqN3C
 tEdQ==
X-Gm-Message-State: AJcUukeIfLGX7BezZ6I2kBcivQyb08l+HflkEFvnsj73W6Ikm2qsxrKa
 WqxtNjoVfM6XKFscAhi4N8Phyg==
X-Google-Smtp-Source: ALg8bN4De1+KO0yStI4VWCLLvIMbH3xzhX2YVcCCkmA86K9Bl6JrLZrJpwhuY/2Jwjx4zZIqz22IbQ==
X-Received: by 2002:a17:902:2a89:: with SMTP id
 j9mr21296667plb.296.1548665950321; 
 Mon, 28 Jan 2019 00:59:10 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id o189sm60746245pfg.117.2019.01.28.00.59.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 00:59:09 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v8 1/5] dt-bindings: media: sun6i: Add A64 CSI compatible
Date: Mon, 28 Jan 2019 14:28:43 +0530
Message-Id: <20190128085847.7217-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190128085847.7217-1-jagan@amarulasolutions.com>
References: <20190128085847.7217-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_035915_338313_126B27DA 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner A64 CSI is a single channel time-multiplexed BT.656
protocol interface.

Add separate compatible string for A64 since it require explicit
change in sun6i_csi driver to update default CSI_SCLK rate.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index cc37cf7fd051..0dd540bb03db 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -8,6 +8,7 @@ Required properties:
     * "allwinner,sun6i-a31-csi"
     * "allwinner,sun8i-h3-csi"
     * "allwinner,sun8i-v3s-csi"
+    * "allwinner,sun50i-a64-csi"
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the CSI
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
