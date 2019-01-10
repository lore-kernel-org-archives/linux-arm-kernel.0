Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30CAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:29:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CE5214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cf+OAup4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X66BFFfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CE5214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=j+JcGuDuXCcq8iuJzAjQpkfpi12ncfPxaxq5Wud+rtE=; b=Cf+
	OAup4gD33McB1IhtvCO2IJShSt4n9rKSz9QyzfluRVsz2hjJSXykoMwVAbhwZOra5odAmmuqV/U+5
	nujaq+Y03AqjZrdgRaog/Tp3wFjph+mkDYd9K9jomi8kip9IIK6e9HdQNUPo8T9qES4TPBPuDZpYO
	d0lX7YHIM6TVae/zfaitWhRcHA/q45wTuWdVD4kW+rS/FFETFKS09i6UQox5TNWG9hLgl0iZCY6HE
	1FRIWkX63yX4Q/jaRaKzhJyJGrOLHScfIis8FBrlVhFcuFKZ92CNEOCjkBTV2xDAdQvrjGY7qzuV+
	wU7avp0qnzvF50ce1k4aWKh2pqLaEKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghUm3-00025t-Bs; Thu, 10 Jan 2019 07:29:07 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghUlz-00025W-Gq
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:29:04 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so10105286wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 23:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ZtXwwgJ9jns1Sfy4Tyle1yTwi4X+cfbXqDXoJIa31BU=;
 b=X66BFFfwVK6hs8FEPRjQlqbXYcIZqcNUyMXN/AiT1VprSKpxjEtoQXKQ0FnX0D6Q9u
 W3wB8T1lSbYh877QKJAQSq6L06aByxN6VMX4cm+Zb92T90ndGCcitbsvU4UeXejCN/xp
 sWfnI1FolLL8YaH654IsqMXgPyB3eM77Aef8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ZtXwwgJ9jns1Sfy4Tyle1yTwi4X+cfbXqDXoJIa31BU=;
 b=paHUsyDppBHns/Y37uJarq7VVR61sasOMI0UP2KoCmlOA5/mt2n8yGBiX1sXVI9MJm
 t4SPU2s0pRsTQGwcHGYE+DkWa730pyP9jENcn+Wcp5o8zmYpezCNt4/oO+1nIqqJd5lm
 O78ydBbU1IW44jH5a79aaXYAZMRiLzwJ7lO+j8ElTV31P3XJSN96fqdM++BaM2e24zPj
 S1weFyJ077CKpQVxwm4Jl6+tPwObvJN1IcFFMNCKZCKy07+k+aSE/8o5dqGkAhYcL5fS
 eGjsP5/Cc93UnwvU5YmtpmmXawt50RbRCoa4ptObz+Lt28v6BFuHNlm4B0I7ilX9DShs
 Nd/w==
X-Gm-Message-State: AJcUukdCESEUTyP4Dtk+Ows09UENj2G++O1MlxKXzU/ul2oJKR18qLT4
 aoJ7t1mMspFWs0dze6PPwF5Ycg==
X-Google-Smtp-Source: ALg8bN6JYAJnNmdLeU8FdAN1JA2feccocZGuVk0j2D+N2pAyBiausHSwhmeg0uynECoW3jINQHu/Cg==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr7485670wrd.20.1547105341517;
 Wed, 09 Jan 2019 23:29:01 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:311a:55a6:a895:3ae2])
 by smtp.gmail.com with ESMTPSA id w12sm53846614wrr.23.2019.01.09.23.28.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 23:29:00 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Date: Thu, 10 Jan 2019 08:28:41 +0100
Message-Id: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_232903_565452_1DC01504 
X-CRM114-Status: GOOD (  11.15  )
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
Cc: Carsten.Haitzler@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 David Airlie <airlied@linux.ie>, will.deacon@arm.com,
 dri-devel@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
 Junwei Zhang <Jerry.Zhang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel@lists.infradead.org, Bernhard.Rosenkranzer@linaro.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ARM systems do not permit the use of anything other than cached
mappings for system memory, since that memory may be mapped in the
linear region as well, and the architecture does not permit aliases
with mismatched attributes.

So short-circuit the evaluation in ttm_io_prot() if the flags include
TTM_PL_SYSTEM when running on ARM or arm64, and just return cached
attributes immediately.

This fixes the radeon and amdgpu [TBC] drivers when running on arm64.
Without this change, amdgpu does not start at all, and radeon only
produces corrupt display output.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Junwei Zhang <Jerry.Zhang@amd.com>
Cc: David Airlie <airlied@linux.ie>
Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 046a6dda690a..0c1eef5f7ae3 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -530,6 +530,11 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
 	if (caching_flags & TTM_PL_FLAG_CACHED)
 		return tmp;
 
+#if defined(__arm__) || defined(__aarch64__)
+	/* ARM only permits cached mappings of system memory */
+	if (caching_flags & TTM_PL_SYSTEM)
+		return tmp;
+#endif
 #if defined(__i386__) || defined(__x86_64__)
 	if (caching_flags & TTM_PL_FLAG_WC)
 		tmp = pgprot_writecombine(tmp);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
