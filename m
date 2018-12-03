Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCC0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E83320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QIL6G+zw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PrRwAGZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E83320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d69i+IrcVutJmK6WAGanbtR7LZWXtvsVkX8yus05M04=; b=QIL6G+zwYhQMcF
	qzo10HDxKD9st/zoD1Luv91d6c572ihz1oYtYdr9qM4lLsG9hMk6pdNNjMNCA/IdnqEeMOCq5sp5C
	r0T5C4mSPoPsjeIdXnq8iHo7OkXOalGk37ZCZdUWNxhgeWCaFxGC5RL/zRL/6sL4NUhSW9xL7vo5j
	9V/ckDCGDwAB5jnSBKWdOo1thnrKZs9U4/KMv03Q9dx575UQo598DqSMWqA0/ZSQKHrSObbpgFYup
	gw93frm1h4X12UH+7JeaWjhDGkjQRFMlPMamKvDUtia8m7Lpi3eMDM4LUImLMvNDu69xYB0+xxzB4
	I1iTjPMgW1o+TsNhRAEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTl9X-0001y0-Tz; Mon, 03 Dec 2018 10:08:35 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTl96-0001JY-9V
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:08:10 +0000
Received: by mail-wr1-x442.google.com with SMTP id 96so11486738wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RQOdFC9CjkWwFX8rp28xoDvtflvd5veREOu6vb3xEl4=;
 b=PrRwAGZpg1WSrlH+nDKOti9QiT/ISdGKiiT4vfkKVsyTZVwnWnbKZPr7Obm0IpQlCa
 XabiZsDcWjoAP54MnwGasjqYwpsrdMVThmbNZ97Rz+2QOjIvgzfl8XrfbrchG6syivEf
 EPRkfutL2oPKkSfwvSzTDm2cbN7sz82/gGum8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RQOdFC9CjkWwFX8rp28xoDvtflvd5veREOu6vb3xEl4=;
 b=Y/tcQzkk9ULZjED5iP4oawmzq3vw3NNt6/FSWOZdeiXKHoutcaL2PlTWuCW2WQ9kwb
 0LxM5ZRnyzlyRDszcQ6G+Yi++6wMG13cbk2Gty1jaEfEqeNV59bRfbWYB4MkwrIUhi/0
 ATzYbaH8cSqME8Kc0wvh48LlxWwx4EmR3N/38pGfXqvpOaeTsNCLqR/BRWxnMAqtnTFU
 VYliRvROG25IL1YzxhB8xY31/Z4W8w2NP0T4zA5c+7wOyCcvKdMwWys7aMutBhcWFmu7
 pwvuRsj6M7qnzNX+6e7M6ysjzaR5jcE+mWdbAX/lqhMWMtahIW2iNJOsLkqqkwl2rqjZ
 BPzw==
X-Gm-Message-State: AA+aEWZ5FlrEQ4evg9Ky874S9awszp92J9F4Ky3P+pj4vS2bvJELVnJ3
 yXkIdMdpiAZSriYksBexrtATXA==
X-Google-Smtp-Source: AFSGD/VPp+6EJ1yRntChb1CpYmwMyPbxm1MNxORzNUzpMr2buG2vPfa1uRSYwFnePbVCUHlq6tSumg==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr12686122wrs.86.1543831676559; 
 Mon, 03 Dec 2018 02:07:56 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.07.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:07:55 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: media: sun6i: Add A64 CSI compatible (w/ H3
 fallback)
Date: Mon,  3 Dec 2018 15:37:43 +0530
Message-Id: <20181203100747.16442-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_020808_388202_4E590885 
X-CRM114-Status: GOOD (  13.51  )
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

Allwinner A64 CSI has single channel time-multiplexed BT.656
CMOS sensor interface like H3.

Add a compatible string for it with H3 fallback compatible string,
in this case the H3 driver can be used.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index cc37cf7fd051..e78cf4f9bc8c 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -7,6 +7,7 @@ Required properties:
   - compatible: value must be one of:
     * "allwinner,sun6i-a31-csi"
     * "allwinner,sun8i-h3-csi"
+    * "allwinner,sun50i-a64-csi", "allwinner,sun8i-h3-csi"
     * "allwinner,sun8i-v3s-csi"
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
