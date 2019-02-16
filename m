Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13830C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:48:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A49222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dp7h7zYp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FA8v36pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A49222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Xatmr78mLIvnqlOlg9xJD4RL82jk5mbpeMBIVCyNx1k=; b=Dp7
	h7zYpDClOdBS4jB2rTfudtGVgCWGQaAqJHsj1Jtjxlt6p8TJHd2N6hZm/pSj65wKzRSsbZkaWnIq8
	Gl5PYL7trSoBAi8QMnqw65tIv/yvdWgO3pao2m8YMQ96FO3p/Ma/B4kIwhFpgVvazCgjvV64Bmn1U
	Ws4/VqtA3+lmYWUx+EVR8/OjH3gsI+2hK7eV8BZdQSxCJc/3RfF/dLkB1J+LP5tUeYBtxV+SaJAmd
	pB5DYHzkvTfCqckeg3aHPY05OzHake1bvw+SzAZidQeuQ6QgkzIuMsdsBukra3uNFxB/6x+YLxtfx
	zX63XyiBl59icSBHcye2R3BHRXNJWIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gurtf-00045t-UQ; Sat, 16 Feb 2019 04:48:15 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gurtc-00043v-8R
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 04:48:13 +0000
Received: by mail-qt1-x844.google.com with SMTP id a48so13489119qtb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 20:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=4Ns8f1NOlbFa+bDM/2kc7cxt+HpGYEvJ8eNA1rANFU0=;
 b=FA8v36pl4Mv9lPhmby28TNRK60VyZdJkbx2Jcdsqj+tJv5sa07JsCytUigA4b/Ffpy
 r/kfBaE11V3b4nBX+LlV+AEqlHsdMi0oOh/fNYIZRFB0VAtBjL5j1nXf2+l+xtH964s2
 /RQWk6XGU1y+z5Stkoiqj4irKSmJmh3fct/23Ha0hEPGxuBnBYWlbtG2YslH0MmFiVGV
 MlS8oCkQjMLm1KN4KPwhqTEaF3kMAPP/jGpG4x9L19CPaLbn3cGG9sBFGTqvoCZbwsuf
 CnsC5HPeneACMGQ2gB4DLQ8AdAD32xA+Ysb/vlOj0XuoIvPREREg3YFeJsosSA9uwORh
 R0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4Ns8f1NOlbFa+bDM/2kc7cxt+HpGYEvJ8eNA1rANFU0=;
 b=fLO9ZlJgo42DAwcBE5/3LREjzyAYyZ0hMzeIJbg5lRPk/Q1vyNByFIBLJ2voNBNZ7n
 HDqVM9d2aRIh+Rmilb8/nVmRvUX59xppbvbn//7bDm9WT+oYp3X4wHvyGvygqZUJV8D4
 Ji/tFvHhJUf1gTLXbdkq3tZ+9UGZOSEkYCsKJR5ewk6ubwTqqtrIdWG8h11BYwh8t8Ln
 vanvRH+MvQG/SScz0f+nSkjvBfIvrIEnXQkbfv4N0nu2zXM395nLSjE++5RS6XQvWNrz
 Ube5gw4ARd5cl5athgf0x56vFzrOq/P+biZpg5pd65jo1tDJAFwt43dv8cZI6vUGsvNQ
 W6rg==
X-Gm-Message-State: AHQUAubf6qQYbGOA7/kxKZmJx2KkXXLE60yamN3Qc3DXBJ1lbcCUqoY1
 FSjLIJD2edU0OW79CH1cQQ/syQ==
X-Google-Smtp-Source: AHgI3Ib08PBuCodER4SLqWjIsyy4V7OygiJ7Fg6K/4bplyHXyUSAJoOegs5pXAusGu78AOsO3K2d4g==
X-Received: by 2002:a0c:9877:: with SMTP id e52mr9599309qvd.151.1550292489136; 
 Fri, 15 Feb 2019 20:48:09 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id a15sm3897809qtj.96.2019.02.15.20.48.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 20:48:08 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: will.deacon@arm.com,
	catalin.marinas@arm.com
Subject: [PATCH] arm64/mm: skip hwasan callbacks for pgtable walker
Date: Fri, 15 Feb 2019 23:47:35 -0500
Message-Id: <20190216044735.32315-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_204812_441405_8CFEE7F2 
X-CRM114-Status: UNSURE (   8.83  )
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
Cc: andreyknvl@google.com, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, Qian Cai <cai@lca.pw>, aryabinin@virtuozzo.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Page table walkers trigger soft lockups below with KASAN_SW_TAGS outline
mode on a large ThunderX2 system, because there is too much overhead to
call check_memory_region() for every memory access where it needs to
dereference every byte of the corresponding KASAN shadow address for the
correct tag.

[   76.531328] watchdog: BUG: soft lockup - CPU#65 stuck for 23s! [swapper/0:1]
[   76.538372] Modules linked in:
[   76.541433] CPU: 65 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc6+ #62
[   76.557697] pstate: 60400009 (nZCv daif +PAN -UAO)
[   76.562491] pc : check_memory_region+0x64/0x94
[   76.566934] lr : __hwasan_load8_noabort+0x20/0x2c
[   76.571633] sp : 7eff808ba0247ca0
[   76.574943] x29: 7eff808ba0247cc0 x28: ffff068cef720000
[   76.580256] x27: ffff080000000000 x26: 0060000000000793
[   76.585568] x25: ffff068d00000000 x24: ffff800003537b98
[   76.590880] x23: 7eff808ba0247e08 x22: 0000000000000000
[   76.596192] x21: 7eff808ba0247e08 x20: 0000000000000008
[   76.601503] x19: ffff1000100a8d64 x18: 0000000000000000
[   76.606814] x17: 0000000001000100 x16: 0000000000000000
[   76.612125] x15: ffff100013805578 x14: ffff100014085000
[   76.617437] x13: 0000000030373a2e x12: 00f0000000000793
[   76.622749] x11: ffff808ba0247e0f x10: ffff0808ba0247e0
[   76.628060] x9 : ffff0808ba0247e0 x8 : 000000000000007e
[   76.633371] x7 : 0000000000000000 x6 : 0000000000000002
[   76.638682] x5 : 0000000000000000 x4 : 00e0000000000793
[   76.643994] x3 : ffff1000100a8d64 x2 : 0000000000000000
[   76.649305] x1 : 0000000000000008 x0 : 7eff808ba0247e08
[   76.654617] Call trace:
[   76.657066]  check_memory_region+0x64/0x94
[   76.661162]  __hwasan_load8_noabort+0x20/0x2c
[   76.665519]  note_page+0x84/0x708
[   76.668833]  walk_pgd+0x174/0x258
[   76.672147]  ptdump_check_wx+0x90/0xfc
[   76.675894]  mark_rodata_ro+0x38/0x44
[   76.679557]  kernel_init+0x48/0x180
[   76.683045]  ret_from_fork+0x10/0x18

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/mm/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 849c1df3d214..4b9a7a50faaf 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -12,3 +12,9 @@ KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
 KASAN_SANITIZE_kasan_init.o	:= n
+
+ifdef CONFIG_KASAN_SW_TAGS
+ifdef CONFIG_KASAN_OUTLINE
+KASAN_SANITIZE_dump.o		:= n
+endif
+endif
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
