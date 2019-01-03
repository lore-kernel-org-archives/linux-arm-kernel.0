Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED40FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:46:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3C12070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bSoVF/gB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fPC/Ugby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3C12070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=URF71mpV9EHYnYhcmGYcJcjFUgwyFyAtj8vsiBt0y3w=; b=bSoVF/gBiCUL74
	PPgOfUthnf8juY2jkcPOtNJJfxgCOByx2vMUmQDx8hQBVrLTRLB4FJ+UluY8VwuoMp0ug1Cdf11VM
	CCCtzFuofFcFg24jS+e9fJ8BT4SHz+o5Oxx9QbL8Wj2kR5/BoiPnRo/cXwmhk5Wedx9PJKw0FfRFt
	FdRTOMAAsjYlERs139lANldaNYsO+mIsY3rp0ZRvp4JbmlsMzYX3Co+FQhMwmvl7q8rI8jRmj/DeO
	ScoiKGNU+5AhkF7FPP0qnC/KKH04RheWU+JQd3c3yJL9yQedZ+G+k7pyC07jhNePrkZzZsl65WQ3g
	BZtdMT1DqpsdkUa3pQfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gexhu-0000rH-GD; Thu, 03 Jan 2019 07:46:22 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gexhr-0000qo-MK
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 07:46:21 +0000
Received: by mail-pl1-x641.google.com with SMTP id a14so15550384plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 23:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XZyVPDcuIHzUbEPySa+rOarYwWqnomdmWUj5ysGa47Y=;
 b=fPC/UgbyuvbCL/hAZlFV1Ol29Fut22cOieFeUzWZrmgm5KjQsIzj4KBNDKHdeeFZkY
 56Voxg+Rj8irow1ZTOemIC7faMEb6RhR6Usxd5aE+KsC0Ag7LKGyL4KyLNuOXPZPxlrI
 PfJJdy6povcMowQwG5ydj3HwdJxzipbWSR3uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XZyVPDcuIHzUbEPySa+rOarYwWqnomdmWUj5ysGa47Y=;
 b=lCMgp1+JaslK8ERYr5e/16uvL/JrS0xRWuqB70Dqn2ra9er/TCPOHpZg3igOMTIJ3N
 DwbchsWTpJksVFR5EKks5O2Afdsg9mKxa6XfldGN020Gr72XgRZa0OXPrVritViRAbpQ
 zEN1sR78LFvxjZnN5IQmXcGusg1i6y3/mRvTN8iYP8Vy/krhQPXVmvCQifPDJySZ1iRd
 MCnhxDAYAbjjGv2X4FJ2kYZ63kneDgKXkDpOGPBY/x6gwTdcC9gcHLwCuMjCFfEaErr9
 eniifGRXRppsCd6QCi3BTcsq2awTWrCYNdPVfgvyWSI3QKqu6T7+C1dBaTa3deffpPfQ
 i8PA==
X-Gm-Message-State: AJcUukdLQBXHa0EmatClDZOPoku/IndRUgPjFPmvkNa+lvzyBiS3nZeu
 eqKwM3PMAR9iNpJd9P++eCecxg==
X-Google-Smtp-Source: ALg8bN7d/ohzkjzL9CO9xMIMV/JusJ+9BFh39i6/ij+ocb0v5Qhpq0kVP3LmPXVnmxkhMgUkBWCzsA==
X-Received: by 2002:a17:902:9045:: with SMTP id
 w5mr44213463plz.32.1546501577642; 
 Wed, 02 Jan 2019 23:46:17 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id t5sm82569539pfb.60.2019.01.02.23.46.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Jan 2019 23:46:16 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [PATCH] arm64: Mirror arm for small unimplemented compat syscalls
Date: Thu,  3 Jan 2019 15:45:47 +0800
Message-Id: <20190103074550.217421-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_234619_755423_761B61EF 
X-CRM114-Status: GOOD (  12.18  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 open list <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Pi-Hsun Shih <pihsun@chromium.org>, Dave Martin <dave.martin@arm.com>,
 "moderated list:ARM64 PORT AARCH64 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For syscall number smaller than 0xf0000, arm calls sys_ni_syscall
instead of arm_syscall in arch/arm/kernel/entry-common.S, which returns
-ENOSYS instead of raising SIGILL. Mirror this behavior for compat
syscalls in arm64.

Fixes: 532826f3712b607 ("arm64: Mirror arm for unimplemented compat
syscalls")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 arch/arm64/kernel/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 8f3371415642ad..95fd8c7ec8a171 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -21,7 +21,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
 #ifdef CONFIG_COMPAT
 	long ret;
-	if (is_compat_task()) {
+	if (is_compat_task() && regs->regs[7] >= __ARM_NR_COMPAT_BASE) {
 		ret = compat_arm_syscall(regs);
 		if (ret != -ENOSYS)
 			return ret;
-- 
2.20.1.415.g653613c723-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
