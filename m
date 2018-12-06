Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B6DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:23:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E005620892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FjNrkUns";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nZXdsfZr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="izBcePJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E005620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6zaYvVH5KHgEWrccXJCstGRyVDx+4y9DXp+gIfEKlic=; b=FjNrkUnslPrstp
	/+pGKLH/jJwhnoe01inb92wFjFLVTzBdT78PbJ99yJ1idLw4+IP5/23shS2CCWqBLtkRZAfEDjOrD
	U3GpEjmXXgurCt0eVaVhaZMOP6b3EAt0q7bvE6yJONWiHm+IDNn/Li2eitPQWZ+SiaAgS+z9DF7pZ
	2RJVpLlglftZRaO3hQvt4nhTkl0J/YO2kr5q+iguqJefSO3gWTMEBscz3cK9orTi9Ie6aC6F0UcSR
	Ywpn9aUT/vFZWJIsEYhBMavwC5yNiL1lvMckO71uc5sRzOp40R9hPkKkaaub8hvNf4SKC1tCTIPdP
	h3onymRntBSn/MauBnyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtd7-0004YF-TW; Thu, 06 Dec 2018 13:23:49 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtcs-0004Jc-Lc
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 13:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lH8MSC1qJfoEJpVsttBDBCEiyuKYx7BBIW3tep4lLgE=; b=nZXdsfZrx0fZ/3qAqK8doIUnhj
 4TZvq456P2bitvn///iz+vXA+5Q9uMtdKHhYtfkFWNDEZRhEvqDOp9vJv1Rsw/ijd5z7gJcxQ8XWz
 B+xORKWxA0TCFqKThSEBsMHHp10Y+PucNIIaK7/a+leVjsl6LwQdMJ6E6w2SRMRvKmur3JipTmiZb
 gAkJErAqgdEsiJBEGJ14GCvHcWkm4qYn+VpKw2LNOOSyvZxmAf1fC0/yv6WbQ0e/XzyjoqUrLeLIe
 GtpGCZWjPj/VTB8480KTc7QmosVEbr3YeMSXPky9XQsfbhwP+wy1YPWBOMFqX8Fz7aklYwqdWsmUj
 5jJwLzuA==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtcm-0007IT-MU
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:23:32 +0000
Received: by mail-wr1-x441.google.com with SMTP id v13so478100wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lH8MSC1qJfoEJpVsttBDBCEiyuKYx7BBIW3tep4lLgE=;
 b=izBcePJwngom7M05Pi1POPhFnLrxIqyzp0/SrtubjB/rn8rIS71ucZU7r/+xku7YIZ
 ginbfiYIh2iOr1BDWUgtyKSoqynYP7XJFFbzejnLLDk5D1TWPgUjT4Y7JomAyJZU5wW7
 6deJXvK8lww4KcLr08rIuoIpxDtNmBE37PFcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lH8MSC1qJfoEJpVsttBDBCEiyuKYx7BBIW3tep4lLgE=;
 b=i1Wcsfcvy6l4uyt2F9V2nySzqkVUxNTHeSemPkd0pwXv++V0TECMcHmUWNBH7y4iCN
 QCAGqV3CpxEtEwxDh4cvJDUk7z30OI2bL3DhoV8kDMBxh/Vek0CFFgwR8nJgeIJQiy9X
 8oIARI38cJBOVJcVdcwNnmvedi8K25C1qe8ksiAo801QB5BgLpGO21gohgWKkgiewjYM
 kV9B80XxGvSNPrGgT5kRAbK4N4TSwfT0ESSXKskR/bDiRGLtlLTjYtEQEVY+NodMRgDV
 NiVReEFNwhGfERjIfEOtCutLGL/xLuZsUoNinBKyxLbRG77UBXOkRPpdR8sUCpLZWiYB
 eQBg==
X-Gm-Message-State: AA+aEWbAsRhOrCJl6vsRo6++p1gpvenogQoVXafwcHryXXXfSelC//8K
 dU6/qAkhpeZWlNOJ5cOC4No28Q==
X-Google-Smtp-Source: AFSGD/UQgEyKM22wgolckkxm3SH0B2kK20abQuKDke00P/LEHKjHBfCCKFpvXH/bX0/6JvX9B+tE6A==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr26842238wrq.133.1544102593867; 
 Thu, 06 Dec 2018 05:23:13 -0800 (PST)
Received: from localhost.localdomain (ip-161-243.sn-213-198.clouditalia.com.
 [213.198.161.243])
 by smtp.gmail.com with ESMTPSA id z13sm363769wrq.19.2018.12.06.05.23.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 05:23:13 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 1/3] dt-bindings: media: sun6i: Add A64 CSI compatible (w/
 H3 fallback)
Date: Thu,  6 Dec 2018 18:53:04 +0530
Message-Id: <20181206132306.11843-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_082328_754075_C9FD45CC 
X-CRM114-Status: GOOD (  12.54  )
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
Changes for v2:
- none

 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index eb5a14b828d9..5fb6fd4e2c7d 100644
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
