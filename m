Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDA6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:33:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0A320883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MxWzl50l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JfEea0Wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0A320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iJkVrAbakoBZGYa4GZGoYhzeVjlFTZAjchsV3RPdVfw=; b=MxWzl50lCM/VzX
	181hW4zfMlO8KIp80M8bBLipoiKba/dttYGAvkUAXT5DkOVydG7L+T++E5wNXgpcFMVRAscUcsyAy
	1RmmQZdHo2NPp7l0DxK2RWR543p+UB5/CPM1aPDDbriPA/ZBGapXwMl8cyozX5sdQWHh8EY8OjKlh
	ob0PzeNXQhppgJhflZPXkNEiBhgByo91F1OB/EZRJwUHi/MP+GnB3k+q4pJdX6pPczdEFCR+e+PeJ
	iaMDSZU9s+U935K54PwHA9FRE1Hm8/wLSnOfnqeTmtLLig6xiKP7owDA5gXoaXwKl0unEoPFeZUnx
	sMGAajEOFcZ3fro7m8Xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX4n-00064l-34; Fri, 18 Jan 2019 16:33:01 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX41-0004UP-Om
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:32:22 +0000
Received: by mail-pl1-x643.google.com with SMTP id z23so6594234plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wXbv4EStlt/WSU+EIZH0OlN5Zo9WGSHjVKnuaGSJ7JI=;
 b=JfEea0WrjPfkCG3tH7f9t+M6PSMOT5SjF9aq6cqyT5W20z1o0YkrEOpfsMuPdhzzpw
 IV8zPBwdsdVJUzYFcmHLKLJ9VXlCfC5QV4ppqQYjdxDu/eZjvhoatEriJ2uoI+MhZLHk
 yqmENxEAsw/86d4iktkdOzIMg6NJXcPhBR6cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wXbv4EStlt/WSU+EIZH0OlN5Zo9WGSHjVKnuaGSJ7JI=;
 b=d01fnI9ufmtHHKtTB9aI3+nHdhTNW0TsDJUXl6see+B6LIDdzeEWfYNzMZJWMp8eET
 MFR/Ty++D//cK8zYE+fXPIUoyAFtW/MfPcDKeuj/KK69VIMaCI4DQDJmjHxtifzaAjcE
 7Z1DGNQhsIsvduFZiseYWH+9UxW/DW8D0EDAqMlpGyOaIKiaY7M9iyLB3eA/B+nmSDMW
 hlTRs3aqOeiC/lrFmXjX9bWRSw9Vvw2rRGY9cfgHitSIjsuZR1L0tFxO5Y/kCDk+TPfk
 jGS6YKqJc1UZQE0LWOfi/gG6GI+uXWLL0uAGJio4SC+ZUbfgwvopGt6zX0DLo9lLZMew
 zXKw==
X-Gm-Message-State: AJcUukdRyZXesigwQU90geezacZf7K9Jv2YAEpZdhWwQb69U6k6hRvQu
 ykDKZea/NjTUkPrVaTfARe3sPQ==
X-Google-Smtp-Source: ALg8bN4/H0QR2+ASRowTivs5hAZMKosQvkhXOtMeI+YzIuImn25KZJOQ+nZVn5foWwCH78GrOPiDuA==
X-Received: by 2002:a17:902:2867:: with SMTP id
 e94mr20077723plb.264.1547829133059; 
 Fri, 18 Jan 2019 08:32:13 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
 by smtp.gmail.com with ESMTPSA id z13sm13967086pgf.84.2019.01.18.08.32.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 08:32:12 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v6 1/6] dt-bindings: media: sun6i: Add A64 CSI compatible
Date: Fri, 18 Jan 2019 22:01:53 +0530
Message-Id: <20190118163158.21418-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190118163158.21418-1-jagan@amarulasolutions.com>
References: <20190118163158.21418-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083214_022480_B01DE0E6 
X-CRM114-Status: GOOD (  11.63  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner A64 CSI is a single channel time-multiplexed BT.656
protocol interface.

Add separate compatible string for A64 since it require explicit
change in sun6i_csi driver to update default CSI_SCLK rate.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
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
