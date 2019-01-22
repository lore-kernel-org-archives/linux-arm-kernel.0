Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE2AC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:23:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396C520855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G4LuWb2F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRjXiJpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396C520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=OVqf68aHhgXhPpJvyDmuwMKABsXjCnTk1Mhabhi9J9I=; b=G4LuWb2Fkxon2Sse0aDzu/eIXM
	XfVagApUyFAkID6Am7pjc9IlZdLWDlhCfPzv2hwj9exF/WgzU1EEOe6OgviPqIQPokLMb2J7RoDwC
	Z7fYP8rv+Lq0Unqi97THOV4vJcLhugZGLr3Y38gen/HmZJpGSDN9o5NgeQOBvUxwhlrBrtaf+FGw9
	X7gTbo18CnLcX89dLIlBUhn8D0JSnaurIU9WDeVPQqSFaRhaIUSX1lT5sJd2k6JmW3rNffjwe2eZg
	0XYsXNcRsZxmu9hiFJquEFN30FtJjbClD2gVu8bU6gOzYapdtdofyjWRQbfepUbcTpRbYWIM01Hsr
	bQxVMYXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glnaU-0001nk-Fm; Tue, 22 Jan 2019 04:22:58 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glnZn-0001Ct-8H
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 04:22:17 +0000
Received: by mail-pl1-x643.google.com with SMTP id b5so10807045plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 20:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cmQKGebSmYlEhX3wS0v8qxCgnG+jTMlO7/QfZGmiwZM=;
 b=IRjXiJpl4uBg12TBCSEcYEEe8zNLgJE7fL2fTd/uxbKTOWP2JeA9xsggqOOMpnaSbm
 i5Iaht0A8rjCxY9mCqU53OPKa35u7R7/Y7JD/bQg1B3qOEQtVrNXoq5qppmt8kGNTIlj
 Lz4UTlNSxfktgxkUmSnSBgedauyisvGRhYvqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cmQKGebSmYlEhX3wS0v8qxCgnG+jTMlO7/QfZGmiwZM=;
 b=jtPVnEIh7odb4HWkKgNgbrm54czqakSUEKgdwDagwl8k1syCo3jo3sU1kbbbIg8JJz
 sRmEGfjZnp4M7MlmzhM91TxadxCyKOvm9VOxnzdbPuW4XwVBt8179k0iuR9VBnCK4MCn
 hJgRAqLXhf6UL/rn+fXqEVR9lPETzcWSeyDZtrv6M4kklY6M1b4s66O92p4W9YqfigZ5
 j7jA/rLnY/Agb/7j34ViO9E5YKYl0rgr81M4D1SfRbWU3FEjBH3YP8c5/k2K6d6QNL5G
 G/9YtLtGJt2dr0NclyfbCCbsHIqSH1mnWYHdz/Fq4QFcgK6UEocbuiAS+dQOdBoKGwKN
 Ng/Q==
X-Gm-Message-State: AJcUukfiuZ77vqKSQOAOkUS+gUjbXbRNH6IipqMADLL7IAdcrKddOkXR
 XWW56hAvZ29jemWimrKQmiya
X-Google-Smtp-Source: ALg8bN4ONaQX3pyCELUDzLLOvIJwuPAy54B+U+smYGOPAQYfDoCNM74kuGFJ+AdrzqSAbmtOV5Mwaw==
X-Received: by 2002:a17:902:30a3:: with SMTP id
 v32mr32996277plb.26.1548130934796; 
 Mon, 21 Jan 2019 20:22:14 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
 by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.22.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 20:22:14 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH v3 3/5] dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH
 Vendor Prefix
Date: Tue, 22 Jan 2019 09:51:45 +0530
Message-Id: <20190122042147.5424-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_202215_326972_D7420999 
X-CRM114-Status: GOOD (  10.60  )
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..38693105b5c6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -108,6 +108,7 @@ dongwoon	Dongwoon Anatech
 dptechnics	DPTechnics
 dragino	Dragino Technology Co., Limited
 ea	Embedded Artists AB
+ebs-systart EBS-SYSTART GmbH
 ebv	EBV Elektronik
 eckelmann	Eckelmann AG
 edt	Emerging Display Technologies
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
