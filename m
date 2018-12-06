Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612A6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28384214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rPwTGEc/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlnp9BJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28384214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jceRdSsbPj+V8KpzbQ0AcltjgIwxSmFmP3/4ta4J2gI=; b=rPwTGEc/IS0UBiIbSqQ+OuqYqi
	OgXl/I12mt2otyUzQuxNVaFhxl1bVIi1VgM+1pcR2SDsBAiit3oJTyqH6NDwgUru5ZAbjCartTRUv
	jm2DH+9AiKrRrfpaAWrpzT2YOSfOuzmmykkUXu36SJ4sgwXxwlRNar27TgOJelGtjPigl2zsP2T/g
	/jbKKc31/BGRx7SHg2ae6T3R/2E9u48AqG3K3fIDDmEdVP2r507iDISCCWo0maYNzlTw/GRbCMR1B
	7GP/CtdbpwY7Dli/QiNAGB4fDi+kEON9dSmTbUTVL2VoL2Z9KqiHFMYaD9zbKKInHGr3Q/+gl+rLH
	G6TP9yYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtbt-0003G3-GX; Thu, 06 Dec 2018 13:22:33 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtbN-0002Zz-Ir
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:22:08 +0000
Received: by mail-pl1-x642.google.com with SMTP id p8so175393plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
 b=Tlnp9BJSUa7XFAwwW+GKNzzbXZKtZmfeo/5Fv/ovAsoFzIKqIjwypNVHiyd8+gfLPH
 Fb7gxuUGSIyjYPawgXDGQLme/G7CS1zch9eFiaKR3eqZzxwNMw+mwvBmpkEFO9fyaneg
 OiKaViiD9vXZiBlOie/V6BWRbKxML36lqpoJ8ecYC07oRzZlgbr0wxuh+KVfLrzla7TL
 fEFs607cmdp+xLpu/F3LiyEdN90SStH2c2b+HVYB1kjqezE+VFYvSrdpdsrMXhdyP129
 WKMGcGUEquPFViD0K0PBC7PYykx4TcQ+5CHmO8cT1Nn4YOBv4JJuWfOvwvS6lzwOiB+m
 /kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
 b=qeOnU1ukyFnY0m3VcmNtKZqfmxxy1F6vp4DT9P8I457hYqRQtjkhhTLIU4WsjUQpHi
 PTxYc9qjp4pIRE660kE4X/ODKoJRLO6Q/Mtfnd3ycnESIEKLANmJNl167uWYRsOh4p90
 /fmKBnQI/VQIdmHzDemd6H3zPrV5Md53yks1tTsHlcr2Zzlj4KXLDQ1PNH/EUYIOMOeC
 NHBlCeiTnpt3qyvuWroHnPfeJD/uO/vzWIsenkd9cXwQwhpDao4+pnmBqqLJ7gwoefvm
 bmkKyb7sh9ZTy/wYL+jV51DnNu8mtaP83smp+L9ahuQAXvdK3YBWjiBXo61LEOfcwej8
 yqwQ==
X-Gm-Message-State: AA+aEWasr3L9XFObbCT5Md0YDhV2hdSRDA9mkZcZISefFjAPmPKnquQq
 Uzr/awX4FVRJojCOzJx7ofk=
X-Google-Smtp-Source: AFSGD/UK1m2QlD/ekJ26senJEbu6Pb+HfQlL4cpRyq7HPE9fC51Z5WuWvOTYycdw7BrwYcyq06rLUg==
X-Received: by 2002:a17:902:2aaa:: with SMTP id
 j39mr28951899plb.335.1544102511104; 
 Thu, 06 Dec 2018 05:21:51 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.21.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:21:50 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 3/10] x86/Hyper-v: Add trace in the
 hyperv_nested_flush_guest_mapping_range()
Date: Thu,  6 Dec 2018 21:21:06 +0800
Message-Id: <20181206132113.2691-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_052202_563799_F4940EE6 
X-CRM114-Status: GOOD (  10.90  )
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 paulus@ozlabs.org, hpa@zytor.com, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com, mpe@ellerman.id.au,
 x86@kernel.org, linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 mingo@redhat.com, benh@kernel.crashing.org, jhogan@kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
 devel@linuxdriverproject.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, christoffer.dall@arm.com,
 ralf@linux-mips.org, paul.burton@mips.com, pbonzini@redhat.com,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to trace log in the hyperv_nested_flush_
guest_mapping_range().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/nested.c            |  1 +
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 3d0f31e46954..dd0a843f766d 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -130,6 +130,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
 	else
 		ret = status;
 fault:
+	trace_hyperv_nested_flush_guest_mapping_range(as, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping_range);
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index 2e6245a023ef..ace464f09681 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -42,6 +42,20 @@ TRACE_EVENT(hyperv_nested_flush_guest_mapping,
 	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
 	);
 
+TRACE_EVENT(hyperv_nested_flush_guest_mapping_range,
+	    TP_PROTO(u64 as, int ret),
+	    TP_ARGS(as, ret),
+
+	    TP_STRUCT__entry(
+		    __field(u64, as)
+		    __field(int, ret)
+		    ),
+	    TP_fast_assign(__entry->as = as;
+			   __entry->ret = ret;
+		    ),
+	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
+	);
+
 TRACE_EVENT(hyperv_send_ipi_mask,
 	    TP_PROTO(const struct cpumask *cpus,
 		     int vector),
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
