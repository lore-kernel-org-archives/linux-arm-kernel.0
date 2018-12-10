Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD222C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDD820821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MxkWdPZ+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F3RJywn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDD820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lg68TdnR+FnWqR/fO4WQdFvraJY+IgUFbfzPTrIshMw=; b=MxkWdPZ+sUE/Hn
	opJdtZcHTEdsXTspFT4Xb2kIBdaAkDGdBPtyw6rVM0aHEibgxvYDkdze4vc2TMbDpfbCvKGC+dwOJ
	UmaslqB4xzr/DRNZ66NACFASQPHUx564vrexnfAP4BbzJLiCrGa5k+9uvdB+NxYktJ+kzhBiDrzSf
	Sit430EkfgnW+tpum+ZgwNWv1RMYh8Pqs6pClwG9G8njZVx5FUEeRmY/Mdh3+4xxrijyTffqaTikf
	OJ43FL73CkxhU5ofQKNlI0fnozl1o1eBq3ShcksQ0WQh0T1IRwm4fQ2guDu7ONg9UZynx4Gn61dyM
	t8DwuHtEBgBI4Bl2/QSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWK8J-0000r2-7a; Mon, 10 Dec 2018 11:53:55 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWK86-0000eg-02
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:53:43 +0000
Received: by mail-wr1-x444.google.com with SMTP id u3so10187969wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 03:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DjNL4yM0W8Erfy6DaB3BWV2eQAISU0s+SMFRfUHR+Qo=;
 b=F3RJywn/KIIIpXUSKDmTVuWAYAHFJvM/gBnPnf0FttlxzYKVbe9EovYGLDiyulgUGz
 yXajFrlRKuy/NTVAjwDLysgHEGB9498C5usxNM7GGF7myAIWLuBwIbpm+HH1DCOHBSDo
 rQnVjtUjTo09bCl59QBAxAbaPWr+NeursZkHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DjNL4yM0W8Erfy6DaB3BWV2eQAISU0s+SMFRfUHR+Qo=;
 b=S3QFPk2j3P8p4u1U0oMx+Pdpk6W6xL622n+LKJvl8Lw5XkozFSMEyUNa3kxzJXEF2c
 fXrOgX1I5S/OrXmHtZOomAUyTA1evuSejZSCV0yBpLtS8DR2NV4bEso9l7QwRTknL7Mc
 5ZhZYXVISv5tt+eFH+Ve3pqR0kaRU9hbp7Cfk2+l4z09lHqY4wmdLYSAQk9EZYRSQ/8x
 NU/0g61CqgHMJd0LpwiEmqC9LAk8o14h0JKBVN2Raed40XFTEaRTxpdrU1hMiZpeOyEO
 JSzBAlsbQ+XdeNziBmhdyPrx3neEiW/gTaVmtR0FzFZcEWlF0DYBP0eG4h3HU+tHJinB
 aNZQ==
X-Gm-Message-State: AA+aEWZvJl4F5AA2R0eeCxsNkx6abbRhi8YoyqLzeRJGuGW0TvUCD+8n
 Yv2FcdVToA/AXqFMzLrxMLA6fcH+JAc=
X-Google-Smtp-Source: AFSGD/UJfZHrJOS/Z96UvGeOwSEYmZLWTyIAlxZ/2QRMWB46KP/XmSNqIKJ83mVTVPBqhDUHuz3vvQ==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr9008517wrw.316.1544442810069; 
 Mon, 10 Dec 2018 03:53:30 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 03:53:29 -0800 (PST)
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
Subject: [PATCH v3 1/6] dt-bindings: media: sun6i: Add A64 CSI compatible
Date: Mon, 10 Dec 2018 17:22:41 +0530
Message-Id: <20181210115246.8188-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210115246.8188-1-jagan@amarulasolutions.com>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_035342_034155_E68F5C20 
X-CRM114-Status: GOOD (  12.66  )
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
CMOS sensor interface like H3 but work by lowering clock than
default mod clock.

Add a compatible string for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index cc37cf7fd051..376aade669a1 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -7,6 +7,7 @@ Required properties:
   - compatible: value must be one of:
     * "allwinner,sun6i-a31-csi"
     * "allwinner,sun8i-h3-csi"
+    * "allwinner,sun50i-a64-csi"
     * "allwinner,sun8i-v3s-csi"
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
