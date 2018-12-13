Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621D4C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:23:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C6420672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uyKO+rRA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Dj9m70el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C6420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=n7oYPOG/ryz1kXYywTf63kDCkWhFgzBEHmkuALd7TVA=; b=uyKO+rRAGIfi9Dev1IsSto5WoQ
	0BIHkO7DcqGUOeJnEEPQfxt9sn67UiGpwERkQ3Uoft/PX9hD/sGN19ff5oFFTfpQPoYf1h+3dnwJA
	XDF6smfWltaySfX+jkOhn70yQMEzL95MNIjRqubHBWoB2mivxioYeiBsf10ePUpXK+Y/IZZ4H4VN1
	Bd03YLY38dkQ+F4hcadVk/6+I006S2R34tciqovuQKgjH7B76IRBt7u9dljX3HPkb5mMJGnw0HRmq
	RL8tDT7ERhpZYVFu1kkunOVRw6/M8KnMAqAvxUkyuLtRm53H/JWJBwchF9zn8f9BLicd59Y05r4Pu
	Y0f+m/dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXJTC-0005gj-Cy; Thu, 13 Dec 2018 05:23:34 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXJT8-0005fl-Ey
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 05:23:32 +0000
Received: by mail-qt1-x842.google.com with SMTP id n32so831897qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 21:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T+bov1s7uPUUt2flzevFiGtl1wqIIJ2TOIfomd+w+To=;
 b=Dj9m70eleoZgBa8BKuA1YWEPUTpmJnw/74UHJOuBoD5eqOrACBo9OZIeQy6rZqX8vV
 xkWDwoYJRFOoySx9t0MJlH7lX1r7UXY1PQFuRdglNHjyJo33DSt/t/KzOdEeNheFIfbw
 95tzZeaCQql9OE9OgzsaKZpwPv/sJvyYGX2xmxdz1LRwZhSaN+FjVS6/4dWn5fH8hng5
 /lb4X0x8BT+xk4MuS0uI82bN+L0T/qxexHYFSx4k52Z8cIrsYE5bBQ+y48ozint0D619
 SifA6g8TkQoVniVsHZ5/ehsWF2kzadkYYpF4Y8gl2VhO1q6y2KWETqFnX3kmUNIPQ6dR
 rIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=T+bov1s7uPUUt2flzevFiGtl1wqIIJ2TOIfomd+w+To=;
 b=jgno4Leo09Blag7KOoAlOxD+Hi6vPEWzDwULCr9zfmO9Dx2adqgUB40ls/xHfiXn2o
 +ue3evzHSU05brg9mr1NdzG+Gfg6VOeGvSyV71QL8hgl494BGwnDjXj/UB8DiCbIheWV
 GNf5tKv5s7ZDpkN2xirwFXBaNVtYcLyh11SiThD47fyAFblFU0oP3tDJt0+6d7uGZTKI
 dtZlihRqEleVs/6mwDuuqBSq5w5q+7cXEmWNUzdd5eP992GfNiD4dYgWSxwKSAqFGV9+
 z34adNOQjxj4TKDGUw/zyD6/LLtH00HFdffHdY6qNSPcKtxh1NsQdLvVQ7hq1QN1XGUH
 Xu4A==
X-Gm-Message-State: AA+aEWYf1u9l424QEYt1hnTLA4vs5FD6DfUipTrUuqd/24QzQyDyPYbA
 Ii8aOAAbRyorN0rZ3fIcEvg426I57Ko=
X-Google-Smtp-Source: AFSGD/Vu5/NTqWAqWCepYpmLvF9kyNshrMAVmb7Ev3/8VWn4Zu9TNixizeNE6rpP1R2Ab3SakKtagw==
X-Received: by 2002:a0c:9239:: with SMTP id a54mr21531273qva.17.1544678598851; 
 Wed, 12 Dec 2018 21:23:18 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id u4sm460607qkk.51.2018.12.12.21.23.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 21:23:18 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: catalin.marinas@arm.com,
	will.deacon@arm.com
Subject: [PATCH] arm64: invalidate TLB before turning MMU on
Date: Thu, 13 Dec 2018 00:22:59 -0500
Message-Id: <20181213052259.56352-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <1544654224.18411.11.camel@lca.pw>
References: <1544654224.18411.11.camel@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_212330_503036_124219D3 
X-CRM114-Status: UNSURE (   9.98  )
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
Cc: ard.biesheuvel@linaro.org, marc.zyngier@arm.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, james.morse@arm.com,
 Qian Cai <cai@lca.pw>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
dump just hung. It has 4 threads on each core. Each 2-core share a same
L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
L3 cache.

It turned out that this was due to the TLB contained stale entries (or
uninitialized junk which just happened to look valid) from the first
kernel before turning the MMU on in the second kernel which caused this
instruction hung,

msr	sctlr_el1, x0

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/kernel/head.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..5196f3d729de 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
 	msr	ttbr0_el1, x2			// load TTBR0
 	msr	ttbr1_el1, x1			// load TTBR1
 	isb
+	dsb	nshst
+	tlbi	vmalle1				// invalidate TLB
+	dsb	nsh
+	isb
 	msr	sctlr_el1, x0
 	isb
 	/*
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
