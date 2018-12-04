Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E87CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:31:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DC920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BFCxkqby";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nfAZ6eGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DC920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=71HwBW5xYDw69QOd1BYhNmv60xWfFgL/iPb0st/fWQI=; b=BFCxkqbydZX2MY
	qYzQuSGfCgcC4h/hqqBe2z43OxPMkqn6B7fTRMXlaQi/ZNOfo5kytMkuDxhsq5GDSkPZkpkmZ/T/z
	kzQ0tJ8xCvgadcZloL5iDUFrxmCQpaGWI9H1v0wirB1TBPsBn5wzZWcI+dSo4vWQtoG1JCGiPfqi2
	U2Py6uuwkmQa0HwzilP58qNE3G0alnncyUvIQ9twzh5QuOpFbh5DMUiK4vG4AIYPj9PdsJ/8AAcoX
	3LDHqEdpcL6V+YBGKvW8w9/yftIgDiutaEtDm8nXYfw9ol/CWs07gi2lbNLxK8LBLupOXRwE40EAw
	rpnkm0G/X6njLTkrYwyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU0Up-0002km-A1; Tue, 04 Dec 2018 02:31:35 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU0Un-0002kS-7C
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 02:31:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hqPi4zZGrK0dHbeiTKo26mEXEc8hmopkzqu1a+dOmKI=; b=nfAZ6eGoAqy2ZGW8jDeOocdict
 EQJEyUhNayjOVn6gI3GUHGKD93OSjBaUGssToC0Ze+FGaMumwNZuHoMZHmmyDbgulCdZf3013SuwU
 kGO7dPH6NGMw5Bqz0k4zC8OfW4zdhWdNzSRmD0qViZCr3DwZZziTy8H7mEfxm9KRzmn/tWQlSQAVR
 JZDrae8BQbvKK+TbzoQqVcvJNiaEBDYbuwNsZmxOmU7oBUcXF8fdT5uSBKg6E7d580cdYIThdUOI1
 Gc45BIb6th8ovSrKMWYBKyyEQGeg6ofQRtXh/n3Xk+UTBlqHgsw6FqANfO9t7gDifyOfry7Z+Bc10
 S4oYbvmQ==;
Received: from smtpbg202.qq.com ([184.105.206.29])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTzl9-0004rU-PX
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 01:44:24 +0000
X-QQ-mid: bizesmtp20t1543887825tsiu9oqv
Received: from Macbook.pro (unknown [210.22.22.130])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 04 Dec 2018 09:43:44 +0800 (CST)
X-QQ-SSF: 01400000002000F0FL51B00A0000000
X-QQ-FEAT: l2be6KKOhXNUUTqoO7yT9bVKOQNTQSQGRoET4TqfIElbpwtVMhiG14lgaha6i
 KSe3yhMvuTTw/+U9xQVmX8qnT1wazmw68y6kMzvHJX/Yfnj0TZ3yCeQTY73U+3HUSXOJfCS
 9oeqpYbqCWHF20YorK7yqwfjymAhRhrmP3LDkMJEBV+VgAS/qKopEGo1vsNvfemENvEFx/6
 qw/8JCjb8r+TiHmGJytcC6wtp9dKEE1NXMPZwpxtsgiCwkQ1rlYu2mMFluUjHvex/5Yp84m
 z1mklR4JToZYgTfJnoQ5YidmqcIbuNfQBSn94E4ZV8AHmV
X-QQ-GoodBg: 2
From: Jackie Liu <liuyun01@kylinos.cn>
To: will.deacon@arm.com
Subject: [PATCH v6 2/2] arm64: crypto: add NEON accelerated XOR implementation
Date: Tue,  4 Dec 2018 09:43:23 +0800
Message-Id: <20181204014323.1438-3-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204014323.1438-1-liuyun01@kylinos.cn>
References: <20181204014323.1438-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_204424_055556_16AB5293 
X-CRM114-Status: GOOD (  19.65  )
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
Cc: linux-block@vger.kernel.org, catalin.marinas@arm.com,
 Jackie Liu <liuyun01@kylinos.cn>, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is a NEON acceleration method that can improve
performance by approximately 20%. I got the following
data from the centos 7.5 on Huawei's HISI1616 chip:

[ 93.837726] xor: measuring software checksum speed
[ 93.874039]   8regs  : 7123.200 MB/sec
[ 93.914038]   32regs : 7180.300 MB/sec
[ 93.954043]   arm64_neon: 9856.000 MB/sec
[ 93.954047] xor: using function: arm64_neon (9856.000 MB/sec)

I believe this code can bring some optimization for
all arm64 platform. thanks for Ard Biesheuvel's suggestions.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/Kbuild |   1 -
 arch/arm64/include/asm/xor.h  |  73 +++++++++++++++++
 arch/arm64/lib/Makefile       |   6 ++
 arch/arm64/lib/xor-neon.c     | 184 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/xor.h
 create mode 100644 arch/arm64/lib/xor-neon.c

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 6cd5d77..1877f29 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -27,4 +27,3 @@ generic-y += trace_clock.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
-generic-y += xor.h
diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
new file mode 100644
index 0000000..856386a
--- /dev/null
+++ b/arch/arm64/include/asm/xor.h
@@ -0,0 +1,73 @@
+/*
+ * arch/arm64/include/asm/xor.h
+ *
+ * Authors: Jackie Liu <liuyun01@kylinos.cn>
+ * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/hardirq.h>
+#include <asm-generic/xor.h>
+#include <asm/hwcap.h>
+#include <asm/neon.h>
+
+#ifdef CONFIG_KERNEL_MODE_NEON
+
+extern struct xor_block_template const xor_block_inner_neon;
+
+static void
+xor_neon_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
+{
+	kernel_neon_begin();
+	xor_block_inner_neon.do_2(bytes, p1, p2);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+		unsigned long *p3)
+{
+	kernel_neon_begin();
+	xor_block_inner_neon.do_3(bytes, p1, p2, p3);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+		unsigned long *p3, unsigned long *p4)
+{
+	kernel_neon_begin();
+	xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
+	kernel_neon_end();
+}
+
+static void
+xor_neon_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+		unsigned long *p3, unsigned long *p4, unsigned long *p5)
+{
+	kernel_neon_begin();
+	xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
+	kernel_neon_end();
+}
+
+static struct xor_block_template xor_block_arm64 = {
+	.name   = "arm64_neon",
+	.do_2   = xor_neon_2,
+	.do_3   = xor_neon_3,
+	.do_4   = xor_neon_4,
+	.do_5	= xor_neon_5
+};
+#undef XOR_TRY_TEMPLATES
+#define XOR_TRY_TEMPLATES           \
+	do {        \
+		xor_speed(&xor_block_8regs);    \
+		xor_speed(&xor_block_32regs);    \
+		if (cpu_has_neon()) { \
+			xor_speed(&xor_block_arm64);\
+		} \
+	} while (0)
+
+#endif /* ! CONFIG_KERNEL_MODE_NEON */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 69ff988..5540a16 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -5,6 +5,12 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
 		   strchr.o strrchr.o tishift.o
 
+ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
+obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
+CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
+CFLAGS_xor-neon.o		+= -ffreestanding
+endif
+
 # Tell the compiler to treat all general purpose registers (with the
 # exception of the IP registers, which are already handled by the caller
 # in case of a PLT) as callee-saved, which allows for efficient runtime
diff --git a/arch/arm64/lib/xor-neon.c b/arch/arm64/lib/xor-neon.c
new file mode 100644
index 0000000..131c60c2
--- /dev/null
+++ b/arch/arm64/lib/xor-neon.c
@@ -0,0 +1,184 @@
+/*
+ * arch/arm64/lib/xor-neon.c
+ *
+ * Authors: Jackie Liu <liuyun01@kylinos.cn>
+ * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/raid/xor.h>
+#include <linux/module.h>
+#include <asm/neon-intrinsics.h>
+
+void xor_arm64_neon_2(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2)
+{
+	uint64_t *dp1 = (uint64_t *)p1;
+	uint64_t *dp2 = (uint64_t *)p2;
+
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
+		v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
+		v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
+		v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
+
+		/* store */
+		vst1q_u64(dp1 +  0, v0);
+		vst1q_u64(dp1 +  2, v1);
+		vst1q_u64(dp1 +  4, v2);
+		vst1q_u64(dp1 +  6, v3);
+
+		dp1 += 8;
+		dp2 += 8;
+	} while (--lines > 0);
+}
+
+void xor_arm64_neon_3(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2, unsigned long *p3)
+{
+	uint64_t *dp1 = (uint64_t *)p1;
+	uint64_t *dp2 = (uint64_t *)p2;
+	uint64_t *dp3 = (uint64_t *)p3;
+
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
+		v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
+		v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
+		v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
+
+		/* p1 ^= p3 */
+		v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
+
+		/* store */
+		vst1q_u64(dp1 +  0, v0);
+		vst1q_u64(dp1 +  2, v1);
+		vst1q_u64(dp1 +  4, v2);
+		vst1q_u64(dp1 +  6, v3);
+
+		dp1 += 8;
+		dp2 += 8;
+		dp3 += 8;
+	} while (--lines > 0);
+}
+
+void xor_arm64_neon_4(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2, unsigned long *p3, unsigned long *p4)
+{
+	uint64_t *dp1 = (uint64_t *)p1;
+	uint64_t *dp2 = (uint64_t *)p2;
+	uint64_t *dp3 = (uint64_t *)p3;
+	uint64_t *dp4 = (uint64_t *)p4;
+
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
+		v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
+		v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
+		v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
+
+		/* p1 ^= p3 */
+		v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
+
+		/* p1 ^= p4 */
+		v0 = veorq_u64(v0, vld1q_u64(dp4 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp4 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp4 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp4 +  6));
+
+		/* store */
+		vst1q_u64(dp1 +  0, v0);
+		vst1q_u64(dp1 +  2, v1);
+		vst1q_u64(dp1 +  4, v2);
+		vst1q_u64(dp1 +  6, v3);
+
+		dp1 += 8;
+		dp2 += 8;
+		dp3 += 8;
+		dp4 += 8;
+	} while (--lines > 0);
+}
+
+void xor_arm64_neon_5(unsigned long bytes, unsigned long *p1,
+	unsigned long *p2, unsigned long *p3,
+	unsigned long *p4, unsigned long *p5)
+{
+	uint64_t *dp1 = (uint64_t *)p1;
+	uint64_t *dp2 = (uint64_t *)p2;
+	uint64_t *dp3 = (uint64_t *)p3;
+	uint64_t *dp4 = (uint64_t *)p4;
+	uint64_t *dp5 = (uint64_t *)p5;
+
+	register uint64x2_t v0, v1, v2, v3;
+	long lines = bytes / (sizeof(uint64x2_t) * 4);
+
+	do {
+		/* p1 ^= p2 */
+		v0 = veorq_u64(vld1q_u64(dp1 +  0), vld1q_u64(dp2 +  0));
+		v1 = veorq_u64(vld1q_u64(dp1 +  2), vld1q_u64(dp2 +  2));
+		v2 = veorq_u64(vld1q_u64(dp1 +  4), vld1q_u64(dp2 +  4));
+		v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 +  6));
+
+		/* p1 ^= p3 */
+		v0 = veorq_u64(v0, vld1q_u64(dp3 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp3 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp3 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp3 +  6));
+
+		/* p1 ^= p4 */
+		v0 = veorq_u64(v0, vld1q_u64(dp4 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp4 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp4 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp4 +  6));
+
+		/* p1 ^= p5 */
+		v0 = veorq_u64(v0, vld1q_u64(dp5 +  0));
+		v1 = veorq_u64(v1, vld1q_u64(dp5 +  2));
+		v2 = veorq_u64(v2, vld1q_u64(dp5 +  4));
+		v3 = veorq_u64(v3, vld1q_u64(dp5 +  6));
+
+		/* store */
+		vst1q_u64(dp1 +  0, v0);
+		vst1q_u64(dp1 +  2, v1);
+		vst1q_u64(dp1 +  4, v2);
+		vst1q_u64(dp1 +  6, v3);
+
+		dp1 += 8;
+		dp2 += 8;
+		dp3 += 8;
+		dp4 += 8;
+		dp5 += 8;
+	} while (--lines > 0);
+}
+
+struct xor_block_template const xor_block_inner_neon = {
+	.name	= "__inner_neon__",
+	.do_2	= xor_arm64_neon_2,
+	.do_3	= xor_arm64_neon_3,
+	.do_4	= xor_arm64_neon_4,
+	.do_5	= xor_arm64_neon_5,
+};
+EXPORT_SYMBOL(xor_block_inner_neon);
+
+MODULE_AUTHOR("Jackie Liu <liuyun01@kylinos.cn>");
+MODULE_DESCRIPTION("ARMv8 XOR Extensions");
+MODULE_LICENSE("GPL");
-- 
2.7.4




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
