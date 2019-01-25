Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF63CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:49:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C872184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UyKKC36o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGFcznkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C872184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bx7WOutHB8C4qE9OtxMnXIaxNhtEqIROr9QJlqA+Ecw=; b=UyK
	KC36oJJ5K6R3T608qfkYWa3MxBEF07y9lFVlW0Ui/bmo5kEGYlcDVYTz7noQ8ZxQyceacwlHjo0oZ
	rU66rFHLtk7hrT9vP5o/dGpXDjIRZh1IL3uPsGOHlJf+4Z+TBduFKa+wX0uecqYLmFqHXgRvw1Ss/
	HyI5N/tMDJ/UpDJZJuROsndzC1es98d4/oxSFqGdFBS6xTOU+eMLwaRzo6VxnXEwTUwTbpEYKBC9h
	vycrv59c8w0I4G8ZbeIAmy7KH/CxCYSeZNWNMNV1lng9LLa9t1WKaDtHDgIQPex7a2okBj7kJUZDF
	MeFmFxhRhiu0n0z8tITg5TqL7BjTufQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxB2-0001aW-13; Fri, 25 Jan 2019 08:49:28 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxAx-0001ZD-S5
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 08:49:25 +0000
Received: by mail-wm1-x343.google.com with SMTP id f188so5756076wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 00:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=xATq3/fy0c4eTzVipTFkHmC1O94IHtmhyA8aNY8Z5gM=;
 b=YGFcznkGQl85fQXyhF+3kGpAt1GohZCrt4sGhIGMqfkVeI0UB2cV75Uy+m9BrztM3E
 zO+gNgWSIO1sMMsMITpy8EOTbRWcx9a9CfasGgnQkL2pcF492nmIjmN6GSQex3govA1/
 51lwywEaIescOGlZrwONQ34Z3T54dNJJROhLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=xATq3/fy0c4eTzVipTFkHmC1O94IHtmhyA8aNY8Z5gM=;
 b=UPW7QyR01DvrlDwiKigm71LqCS0/Nr1HXephtFtIwqMFHdunuz+pWNK/uuUKfWoKPi
 CCn4W5d/nyjRugDbrnrQFhzaIt/7k9WVhYPk0XjjE1lZ33WuEqwuxIaBvnR9oHqQN3Rt
 wGL0uXYYbLf3B80eYP/jBeVkmBkQzjtUH+taN/GTasQymBZytgSyJUwCAr4esoCJMWP4
 nyX+7Pk4ovU28EIQFABymKX3IsB9h+83mJOlKl2N6z6+IIxKAV2BH21TfWo1dKo0pOvR
 nQln7OX5y/ZIiA0HObpX+acTSHPEKDCpVeEqr+QHjbwNYlTR8b4YfKHF/0TGKUgKyvKj
 YgYg==
X-Gm-Message-State: AJcUukcyxYf7Am4z1kS5bJKkVWBF581yNebuihGgss4LcrpCvwLKMVXS
 jyFHl7df4H5t5fnpljQACf3yrQ==
X-Google-Smtp-Source: ALg8bN5CIqXCZM/orVMFojC0bcJA0bIpWt5s1xxW7/W/6KvqBqonjkiFQMEabf/ChaLPruJ6YjTS3Q==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr5718422wmj.145.1548406159966; 
 Fri, 25 Jan 2019 00:49:19 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:bcd4:806e:230a:673e])
 by smtp.gmail.com with ESMTPSA id 125sm112594574wmm.26.2019.01.25.00.49.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 00:49:18 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH v2 0/4] crypto: fix crct10dif for ARM and arm64
Date: Fri, 25 Jan 2019 09:49:11 +0100
Message-Id: <20190125084915.25411-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_004923_912166_E07B11CB 
X-CRM114-Status: UNSURE (   7.09  )
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

Fix the issues in both NEON implementations of the CRC-T10DIF routines,
that were reported by Eric's new testing code.

v2:
- keep alignment specifiers where possible (#1)
- clarify/fix commit log (#2)
- add fixes/cc-stable/etc tags
- add patches that drop the now unreacheable code (#3 - #4)

Ard Biesheuvel (4):
  crypto: arm/crct10dif - revert to C code for short inputs
  crypto: arm64/crct10dif - revert to C code for short inputs
  crypto: arm/crct10dif - remove dead code
  crypto: arm64/crct10dif - remove dead code

 arch/arm/crypto/crct10dif-ce-core.S   | 27 +++++---------------
 arch/arm/crypto/crct10dif-ce-glue.c   | 23 +++++------------
 arch/arm64/crypto/crct10dif-ce-core.S | 11 --------
 arch/arm64/crypto/crct10dif-ce-glue.c | 25 +++++-------------
 4 files changed, 19 insertions(+), 67 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
