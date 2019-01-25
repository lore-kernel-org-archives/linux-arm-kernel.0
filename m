Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F9FC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68562195D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rd51ZSSV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qvsfBg6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68562195D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QMTSPLKDeGgPxzeUZTHhEkM5CrPwEMJ3D8MDKBNIvDQ=; b=Rd51ZSSVLTcnozr1t58mujUHPq
	MhSiaBcsm6vm6Y4pk5v+4WBYSAyGH7aIzLex8C6uWFpu86sDazQG29sgxPgVS1h6R7Jf0Y+0l630R
	71njh2NdSWnNdFndYWiiwijT2UfLES+IFh+Naa3loAx18UoJIJhec7JbfmqRv/A+Hr6GGeeAL3UWE
	Jaq0QuXZxVDVQDchTQYP+EUXP54Z1Z8q8S/lkzn/G1LLMLsm5cE1gnAljpOGLnoAkTO/FjiFZw3cw
	gKaiSqzbqWl/ltX2j0IASkCHJGy3VHrgqsGxqdWMNYKQadBl99R1tzY5ujJDm3bjRBtFVN76ccXwR
	x3lSOv2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmwNO-00005K-TG; Fri, 25 Jan 2019 07:58:10 +0000
Received: from conuserg-07.nifty.com ([210.131.2.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmwNK-0008Vg-NI
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:58:08 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x0P7vbeP015362;
 Fri, 25 Jan 2019 16:57:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0P7vbeP015362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1548403058;
 bh=phPwmRVMqEdjlJMQIKUpBp/wAJ1bDKhDrtq2/FhuRcE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qvsfBg6lhP3K8lJ5f5e2aER8yxllOXRbR5TuPecPiwH/S4cMqYJfmhKLleKz/KRnH
 dEmUPlFpx952SKIc4/N5AbW37AYSr3PzDNzsFxkvkC+MP6h/o7MzdlrAsBnHznPRDx
 xN6qRzZOSLab47vRI8fcfjaIoPlTy3bEWoywHZgnIJ8wKJhZuu1cZe2xpCGkOzhEML
 UhORY5rdioVdo0c5koqoL9Ydzx5UdGVxDURDDiX5T43vyOBcYx9CvVC/4kHw0qh69D
 FaGOLEvFc6JOJWYrkb7QgY8KA1cusuOeSjcfuQ67ZSMjUVWTjM8qyH+PQy+43Mg/td
 +/MtiNnBC0wHQ==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH 1/3] KVM: arm/arm64: fix TRACE_INCLUDE_PATH
Date: Fri, 25 Jan 2019 16:57:28 +0900
Message-Id: <1548403050-6585-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_235806_980943_C43E7323 
X-CRM114-Status: UNSURE (   9.20  )
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As the comment block in include/trace/define_trace.h says,
TRACE_INCLUDE_PATH should be a relative path to the define_trace.h

../../virt/kvm/arm is the correct relative path.

../../../virt/kvm/arm is working by coincidence because the top
Makefile adds -I$(srctree)/arch/$(SRCARCH)/include as a header
search path, but we should not rely on it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 virt/kvm/arm/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
index 3828bea..853f3b1 100644
--- a/virt/kvm/arm/trace.h
+++ b/virt/kvm/arm/trace.h
@@ -265,7 +265,7 @@ TRACE_EVENT(kvm_timer_update_irq,
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH ../../../virt/kvm/arm
+#define TRACE_INCLUDE_PATH ../../virt/kvm/arm
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
