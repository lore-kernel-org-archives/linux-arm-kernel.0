Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A58FC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E903D2082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OxYcFE/B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AvL9UiD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E903D2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4Wo9vGkvNaoaIA03rxFAOsbPGmP4XP9MzZ8T+qHyo6I=; b=OxYcFE/ByZXlQLq4aAj52qM+no
	YH62cF9QAAwYv5QJ3wCq9OinNtJPE8miY47w8w/WDerSxWv/alO3Pt7bm+WaN76jrrgYzMPHTXR1Q
	T4RAgLMEndZLzYGaO87xK0al2ZWgLR+6HeYzNlNwJ7V2VElXV5c8FBrHJ/VoAsJu+VGyaALrHiOF5
	uDphfMQzfxzgDXj3q9OsVt6EhqYlEGI4N82rPO1gEcsQQk54wX4BoqodlmhKLJhSPPN6CHyIFZuCf
	wYpbNkgoQ5VkD8b4zNnVOreuVVpyA8EpRXD/Ms8+H5NTr/pRd3EiKZzfIfSIIdE+HaaYFB8b+OvqM
	UBTcj05Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9wQ-0007h6-56; Mon, 28 Jan 2019 16:39:22 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9vE-0006jD-Ix
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:38:12 +0000
Received: by mail-wr1-x441.google.com with SMTP id q18so18781504wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DwXU/DABY03ITJwoWyaouwbE8TjJuTN6E6OnLCAmCoA=;
 b=AvL9UiD3J4AerEcQE13yxgFPcrNzEyvgVO/Oed9HUx52ap7/tMpLGzKcGWXRGxciNK
 ZdRFq9lnPpRcfvosrhlsegfVAVUgGprCIx2a1cscd0T90+lG1RfGJ+pyg90BTmK4JXB1
 +ifa2QS9EZd00bpcesusSxt9OZC6c6+v2Y8TlJL+ILgy2nG3wkyeVbaJZ0uV9TjxYOXS
 DNkQCUG28w5ZJogOBquDxyApdURnAZdJpFoMcU7vt8jwxyH7Mabs6MCuA3PLNlazBkYR
 IJVCZNnSnsei5MriMsg3c4hjn9z6IKnWjDEZ0ASkG5I9PgdHeOzA3NEHWSTyOistHo9+
 0Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DwXU/DABY03ITJwoWyaouwbE8TjJuTN6E6OnLCAmCoA=;
 b=GEvTHOHBPA/Z7OE4EiJ4NZQa2yaR4fEPfovqrfG8GeSYt9N/yT1UrKuH+76TlSdf6n
 x7T9PkjG4nmwwvHWyITPlQs+l1CtutEMWfmUc32RShie0gCgg8FvZ98XXqvMelhNVtqZ
 m6KfXGkSVg+0giBJg6m05iBT2XIbKs4OduzgkiAxQdkBP0LTEQzhvtjoePjnkqYXD2Dv
 x1oMC6X6EpWt7Yb3TG8UtoroEvb6Tnb1zytJ3taqNQI8Feg6wecunioDFlbqO6B4Wn7f
 WHeRoend1m5MPQ3iv5dOMF2/ppPW1vZlWTCQmrH/O51bfoUYwCzlPBclQnDG5s81kjVL
 qupA==
X-Gm-Message-State: AJcUukfWMUmjKofoVgU4HUBMXV1wxBG81sc/SdqjAbmj8FfT/lLPJgz4
 CKegvLmTkOGx6e2r0XhqdvL1ug==
X-Google-Smtp-Source: ALg8bN5KMG1QHbxfXu8KVWN1cLvVGhJydZpy2RUk7wZ6NpeR6bHPzOsCNI6QCr0tfyobn6ULK0jr6g==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr23651374wrw.113.1548693486851; 
 Mon, 28 Jan 2019 08:38:06 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 ([2620:10d:c092:180::1:d40b])
 by smtp.googlemail.com with ESMTPSA id s3sm52388982wmj.23.2019.01.28.08.38.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 08:38:06 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: Add vendor prefix for "GlobalTop
 Technology, Inc."
Date: Mon, 28 Jan 2019 17:37:58 +0100
Message-Id: <1548693481-1162-2-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_083808_626265_555A6626 
X-CRM114-Status: GOOD (  10.87  )
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

v3: No changes

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
