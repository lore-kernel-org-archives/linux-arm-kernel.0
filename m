Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A94C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:28:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD492083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J8Asix/x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="S/RxLFnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD492083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5V+4woAS3x36tp7J1LubtSWBIiqbSOnGHpHXSDne/uo=; b=J8A
	six/xsTkd149PrQSgq61WwRdyAaZGUGFGL82OTusge6zGnsejp71LFuhM3d6tMMmorK8oOHddT3M1
	7JMCetpYSiTDBCNIZ38LXzWn88KKGnAslniMQ2Rh5DTyVI6YxJaZgEQeLooMAsy4h2GqudyU4b9Z0
	dnagzeyalaB+yWhK3OtaE+ykNrULoxsRIYHVRPLj0gryxEZpaFgmqYYL9SFlFMuCnbG5FK+BJeYGl
	vi+gDjVUboAD+piWjZZZK0+pMIpMtvs1DCAGzDfpiPJJ/8skdwYRq1NO+x/QxKD8XsSvZlAUetLRT
	rB6FA8Vs8BAtXu/u8PL/G8H8r80Clig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2eL-000536-7B; Tue, 05 Feb 2019 15:28:37 +0000
Received: from mail.efficios.com ([167.114.142.138])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2eH-00052M-C5
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 15:28:35 +0000
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 8CBA1F969;
 Tue,  5 Feb 2019 10:28:22 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id Y3C_C66IFDpl; Tue,  5 Feb 2019 10:28:21 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 6E9C3F966;
 Tue,  5 Feb 2019 10:28:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6E9C3F966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1549380501;
 bh=Eissxu//C6TIPi4CXUeneX0SH2fIoOeeeUuZkt6w6Lw=;
 h=From:To:Date:Message-Id;
 b=S/RxLFnYrveue9XPv8jOwHD4Saqfp+SYKCpXAv+LCukkhi61RtLCOf0GXdqO13eB4
 wua1eZ9oTTLk3kNwQMM9aemESU0H5QOeoiJKBhGSypImDqqQs2LYUAMGCtJeo6zzdN
 fG6XQqBSZYcKDWK1ssq5JUu/2WiQD1OkpCQoPz0CWUaqOfgepuCODw8Od9zX6YXmY6
 K1i2GbumhZoQEH2JK7WnWq0xnFtMQQ2JAWJfANGhCdxWzkz8TEldCyn9WdRmfi+BtK
 dgELXgyQYfg2DFrZVM3nX+hmp/jIaDhyJV1HN5DLVGFo9A+pOmNWB50q5yBLTTLfCW
 7YlRAKpMChW+w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id QUKA5d_XpPdH; Tue,  5 Feb 2019 10:28:21 -0500 (EST)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net
 [192.222.157.41])
 by mail.efficios.com (Postfix) with ESMTPSA id 2A326F94E;
 Tue,  5 Feb 2019 10:28:21 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: patches@armlinux.org.uk
Subject: [PATCH 1/1] Fix: arm: kprobes: optimized kprobes illegal instruction
Date: Tue,  5 Feb 2019 10:28:06 -0500
Message-Id: <20190205152806.20340-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_072833_550119_816B02E8 
X-CRM114-Status: UNSURE (   9.19  )
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
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 "# v4 . 14+" <stable@vger.kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>,
 William Cohen <wcohen@redhat.com>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

commit e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
FORTIFY_SOURCE") introduced a regression in optimized kprobes. It
triggers "invalid instruction" oopses when using kprobes instrumentation
through lttng and perf. This commit was introduced in kernel v4.20, and
has been backported to stable kernels 4.19 and 4.14.

This crash was also reported by Hongzhi Song on the redhat bugzilla
where the patch was originally introduced.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1639397
Link: https://bugs.lttng.org/issues/1174
Link: https://lore.kernel.org/lkml/342740659.2887.1549307721609.JavaMail.zimbra@efficios.com
Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
Tested-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
Acked-by: Kees Cook <keescook@chromium.org>
CC: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
CC: Masami Hiramatsu <mhiramat@kernel.org>
CC: William Cohen <wcohen@redhat.com>
CC: Laura Abbott <labbott@redhat.com>
CC: Kees Cook <keescook@chromium.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>
CC: <stable@vger.kernel.org> # v4.14+
CC: linux-arm-kernel@lists.infradead.org
CC: patches@armlinux.org.uk
---
 arch/arm/probes/kprobes/opt-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index 2c118a6ab358..0dc23fc227ed 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
 	}
 
 	/* Copy arch-dep-instance from template. */
-	memcpy(code, (unsigned char *)optprobe_template_entry,
+	memcpy(code, (unsigned long *)&optprobe_template_entry,
 			TMPL_END_IDX * sizeof(kprobe_opcode_t));
 
 	/* Adjust buffer according to instruction. */
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
