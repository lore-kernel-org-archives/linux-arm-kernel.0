Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF14C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B13B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q3h5JP/m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhxFSz/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B13B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YC9wi5bJJ8d2TNmosVH7OqKygS0bKMgRwiewZJB9aGA=; b=q3h5JP/muV5Irgv85xtdgyVJjZ
	nWogFU1PyAM3RE4j8LN7faDzzlWvwbzLuECkOMraZyj573zGOGu2NFjhw/YO7eUPqxNjiJUl8jNs3
	JghJl2VK8loI4KzZHLIyllia2vC5HSrBuryg11iiTV3LrWcXQXMBlJz7QfqYSIu9v1TOxAmmdo3/+
	dwjZhntFzSL7xEaIM25JoPpYtnPnw3MN0kAw9w4vuVGPBb//qi0BjJGCXlS8JmYMMVlpetpqa5s6l
	r15YI62Kax7N9F+n5EQxFMgSVYjejmPt4pnbc6+11N/BXC3xoqXY5oSaBZHlx+FSIaVwpaESTcKAm
	IUsqsLfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghVOT-0001br-CY; Thu, 10 Jan 2019 08:08:49 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghVOJ-0001PJ-K5
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 08:08:45 +0000
Received: by mail-pg1-x543.google.com with SMTP id z11so4532885pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 00:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bR0eeytQfv+glll7aoQHEqu8NdP2ZbsHgif8yrcXd+8=;
 b=hhxFSz/9yhJlDxwLfGoVRZRbWxzm7XPUcdTCV8qqkR291nrod6TNYNGIeOiLB76kI6
 2RcV/+FlwBIf7rPQngKDpNSieP/fe1J51pJGchptJZf5XKwaf6WCbPDdM0B7YF2XMggV
 Zj3+0j2+6Yp0QMxosahoGiHtpKntr4AfZsFRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bR0eeytQfv+glll7aoQHEqu8NdP2ZbsHgif8yrcXd+8=;
 b=Qd0z9RztF4DOskfMH0I9L0YuID3oLwu/JEdA1F4pDX+jmOre2u+0eKqwCe+Uw8FOMw
 W10lYBYDhYVzhGSnAlVvJzgXACP89ns2b5IRKZ8fKMYN36EhHIpOHpqvMjjYmSEMa2M8
 KkK1wTNwM/sN86sUm694DtBKnabblgMw4JIC+uIjQmo1sT1rGSsMLjOu3Hh5boGrt+5c
 IXM0O8DjQLUNS10TWjYz21B6R8phDhbWj+wtOTCmefASgtSabix7zEV7LVTFaUYvKbCz
 iukCxySWVNInKDbGkyqVokRrUqKdVjSQC1QYLF3DE1lY7y0yBx3CTtZgs/VZQ1BcjpX+
 9VpQ==
X-Gm-Message-State: AJcUukfxKtiYZVBiHXERDTRxhmzVO2uUOqaGeid3p3Ac+eJCTlLmFNHi
 2JxEMb0GzYABzwkTapXo0C8E
X-Google-Smtp-Source: ALg8bN7KIPDQvkcInyzp4AML13melQLbzch2o/v+mWcpv1ZL+u/0DQNe3JNt8SiQ2Nkh3mWcH8M9Hg==
X-Received: by 2002:a63:e615:: with SMTP id g21mr8627413pgh.290.1547107718782; 
 Thu, 10 Jan 2019 00:08:38 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:89d:654d:749c:afde:a8a6:224d])
 by smtp.gmail.com with ESMTPSA id w23sm27401007pgc.72.2019.01.10.00.08.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 00:08:38 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor
 Prefix
Date: Thu, 10 Jan 2019 13:38:19 +0530
Message-Id: <20190110080821.30280-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
References: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_000840_542333_BDCFA919 
X-CRM114-Status: GOOD (  11.01  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add vendor prefix for EBS-SYSTART GmbH.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..27a3da1e3a54 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -383,6 +383,7 @@ SUNW	Sun Microsystems, Inc
 swir	Sierra Wireless
 syna	Synaptics Inc.
 synology	Synology, Inc.
+ebs-systart EBS-SYSTART GmbH
 tbs	TBS Technologies
 tbs-biometrics	Touchless Biometric Systems AG
 tcg	Trusted Computing Group
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
