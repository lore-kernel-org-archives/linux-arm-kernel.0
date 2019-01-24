Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC700C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:27:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4BB218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c45gQrNp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="deKJyZ/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4BB218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ql29Kq4HvxJMVYTbqBY9ut0hfj39cKfjIc3KaEJs91w=; b=c45
	gQrNpKi70MphCyAvuRrmcPMKXpd3VFclcMw3jqyAQdRf6zhhfNse+XumqaAykfesVUzbAPnq/60w/
	hpR3XvnF4h5kYFQBSgv41mAgZmtt2JhEoUWohKFHygHCLI1nyN4U7Sn+GSG3reV1k/gtW93/kGH27
	CJGDzExfBJeaGLl8RBCmdK6wU+GlG49J+qH9kGvlTCIp6JBBsE8QcRSIzOkjIRmwWmPJUaDxFsmhD
	iLzT7AH6PJZIRTzYaltOC5EdgRNYJ2iesp5Jf/BnTa1fwycwZFJ6QwYiKB3yjtFhITIUmuSijY+Me
	vzLiDImGKBaseZW5woSrMybF7vthR6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjim-0001wP-7W; Thu, 24 Jan 2019 18:27:24 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjii-0001vW-F6
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:27:21 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so7573513wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 10:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=7tEGsrVH4vTEegx+XVy42sLNU/2cmGY+71y3NY7A0uE=;
 b=deKJyZ/PaQWeaYi3RvRGdsFL7ARk2z4a/vRsoNRiIsYOWSdnNCM/DBfdAOznhtFOrn
 M8VKD5uklytChfX2Hcb4si2RlbTo3e8w5ml1sQ0qeR0L6AT8xblzlJrYakBclEcmNr09
 Y6SdVkPcSLtwPJaTUa09vPaDO0l/zXjWb34G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7tEGsrVH4vTEegx+XVy42sLNU/2cmGY+71y3NY7A0uE=;
 b=QLWrz8lzkC/SbrBvUPBUZgXDB1eToCeeYirdikL3x0WTFr0Wh239+vQ5iURI3Z5JP9
 nq671+MO/8FkwZfYVas7g+7WeBycD0HJ4aCjK9f1jT1zBCezB1nF0yOWltfBlRxgVszx
 Iesyu1b9lmYwcQwPonVV+SJQds4TrPXb3D/w9w5qneXaJHMxWkTdsv9u8AOJBx5LC5dQ
 bOiXGPlQZALblZb7K+y7naKbtjcmLL0DyoL6gzPRWTjhhYYxaTbTXkZAzO5hEIkOpC+I
 6yFX5VmFwrnJ9maVJsDvn9HqWsG5a9h9oOfjMZahotDSSfvfDPskjJE5zeQ/i3CYoJ/P
 G3zg==
X-Gm-Message-State: AJcUukesA3vWSXoOHC7WbJ4ayn+EqC5/L2Nt5QBtESagUSBdafSek0ZH
 ewDJKMODi7Qe7jPbvwu/h/v9ZQ==
X-Google-Smtp-Source: ALg8bN5vq3ftgSt0a6cgCodNgznETVhQQBwHKAaQZ0kaHcfamIGgBVpnJAfGOFSgFgpvjRrbvjvTEQ==
X-Received: by 2002:adf:8323:: with SMTP id 32mr7986927wrd.176.1548354438289; 
 Thu, 24 Jan 2019 10:27:18 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:bcd4:806e:230a:673e])
 by smtp.gmail.com with ESMTPSA id 202sm73247138wmt.8.2019.01.24.10.27.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 10:27:17 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 0/2] crypto: fix crct10dif for ARM and arm64
Date: Thu, 24 Jan 2019 19:27:10 +0100
Message-Id: <20190124182712.7142-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_102720_525243_754B10B4 
X-CRM114-Status: UNSURE (   7.82  )
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

Ard Biesheuvel (2):
  crypto: arm/crct10dif - revert to C code for short inputs
  crypto: arm64/crct10dif - revert to C code for short inputs

 arch/arm/crypto/crct10dif-ce-core.S   | 20 ++++++++--------
 arch/arm/crypto/crct10dif-ce-glue.c   | 23 +++++-------------
 arch/arm64/crypto/crct10dif-ce-glue.c | 25 +++++---------------
 3 files changed, 22 insertions(+), 46 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
