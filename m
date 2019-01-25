Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089ADC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:36:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9FC21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="csK/sjPk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2MKYAdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9FC21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=2NuXxMof8L3086s+onpGQpnYEh1FKyXdpvwH4nE9FdU=; b=csK
	/sjPkd3rIrjEQgg2HwIMtVtNF3yZkjTCHWxiRm0vKFG6CJIEQ0uxVmS6SWuFTh1kTL+3rytvlh/Ki
	lxM+wp4ENXlQepKVp4Q8zkm7JuNJS0Q2k404t7hEMyncg8TV+4R6Qa//BZM2DzmQ6cDHwGQd7vEtl
	V/LNznxQBMRtavRmf+KbJG+tvq/WEOp14EHt7D1oIqnT2QNhgyLbgg0lKgoFHZJezLIw3OO93KRFw
	uqg/YDihOdnGvCp5oazyLjYxcaUAf2t19y90ByOP6dyvvNk1GLn5TDEmUabbWwhBdvMQN8hbpO8mj
	/8pM2V4MjEovObf1O3ICvOUZCMoaXsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxug-0003tJ-6a; Fri, 25 Jan 2019 09:36:38 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxud-0003sY-GO
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:36:36 +0000
Received: by mail-wr1-x444.google.com with SMTP id l9so9474398wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=K82b4u0JeOxmjCgmJBy7RDWk5mZMmmjLdOOMm2/dRP8=;
 b=B2MKYAdGHJazbaVbP1PZkrkDcNSrjKTR9v9WP3oBqkyUr6SUSazVYMaosXXVikDsfR
 t4YjVHBbU8r5IYt/yd5oHVJCQgGr8sVR+m96D0lZEtfaExFlXcYaLhgFXYhbI3hckG4b
 Ee5yhVanr/Oj1fQZj1n9da4GuFiwD1cNSY7Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=K82b4u0JeOxmjCgmJBy7RDWk5mZMmmjLdOOMm2/dRP8=;
 b=K6wud4B0AEnncnsPiw1TTcc0Wxsh6Kc4dPyCv8Klkur75UiGf+d0vAl/nDPaLEPsIU
 lXe39Lb89mcgNbWSQ0Bxoh74VJiCwiqJFRFxJdyQti7WJ8SjSW25c1Y/anWDSt4OM2He
 gVzuAL3hmyjDch30zPjkJKoj7OOjf+7i5fBOqxsao2cSPU07oIAqGddunIlHnrVQF6H6
 Q9VpcHfmAJSXmYarPCaQY5IG1scgN31v2HpCMTP5iZ0SnlB9M1xXSVQam1xVZsOM2edt
 JjNmjbbRCcxyJqXvmbxVhoSI1jgTtfd5nqVc0aT0oAVU6n+g6sNFaFQUZM+QPN9CpKYa
 bPow==
X-Gm-Message-State: AJcUukcTrvOVzCu6gs5jddB0s2bbs8WUpUWAKsohoIye5pYYM9dwOSKF
 INxqfFKdoyyw+Kt5C4VizZYoEA==
X-Google-Smtp-Source: ALg8bN4eEFs0NiKZlfzz0vEKISQvY8Vmh6IoOT7PLzLliyKHbVNwE+FHVkOmm7pHuMj626GWI2sl/Q==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr11066521wrj.58.1548408993535; 
 Fri, 25 Jan 2019 01:36:33 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:bcd4:806e:230a:673e])
 by smtp.gmail.com with ESMTPSA id w80sm92323955wme.38.2019.01.25.01.36.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 01:36:32 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 0/2] crypto: arm64 - expose PMULL variants as separate algos
Date: Fri, 25 Jan 2019 10:36:25 +0100
Message-Id: <20190125093627.14288-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_013635_548218_52B85D2F 
X-CRM114-Status: UNSURE (   7.94  )
X-CRM114-Notice: Please train this message.
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
Cc: ebiggers@kernel.org, herbert@gondor.apana.org.au,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Both the GHASH and the CRC-T10DIF SIMD routines are based on 64-bit
polynomial multiplication, but fall back to the slower 8-bit polynomial
instructions if the optional 64-bit PMULL instruction is not implemented.

This means we can only ever test one of the two on a single system,
which is unfortunate. So instead, register both versions on hardware
that supports them, and let the crypto API decide which is the preferred
one based on priorities. That way, both will be tested, but only the
fastest available one will be used.

Ard Biesheuvel (2):
  crypto: arm64/crct10dif - register PMULL variants as separate algos
  crypto: arm64/ghash - register PMULL variants as separate algos

 arch/arm64/crypto/crct10dif-ce-glue.c |  54 +++++++--
 arch/arm64/crypto/ghash-ce-glue.c     | 118 +++++++++++++++-----
 2 files changed, 132 insertions(+), 40 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
