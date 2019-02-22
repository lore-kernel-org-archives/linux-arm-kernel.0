Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E87C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:56:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D58207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LHrJ2ZQr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="N/CagzxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D58207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y7tEAtxdLXeGNsl1pL/VmNqBH8kODTSVMqVBq/w1Wq4=; b=LHrJ2ZQritUvf+
	Joj48QgkQpK5JOpTmk01PNlxpP1qQ93nWtRr8+4GIRb3UWIgnEGOVaM/J1rWVZnT8SOF7JuuhkpDl
	zdy20+0X5/0lsg+ROCvMvOjXc1JyA79tGcQGJM1N56fIWwqCM1FdeitXCkykFEf3k/s/WRj3nw0EB
	aYsWa3MWEkmT5c8aznl/cd1ZRK2NCYq5E6PcoIlubJ0+o2x78BpUC53FeY/Nb4mS6/ue97pZ7taZ3
	zRR4duM+H+W173eH5SglyTh5GgqdZan+xqLK3XRoz1GMTs0EMLU7p96wI84NRaY3oH/fWnzTixCTm
	HQZ/kj2hNbSGSeRyKJew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxANU-0002mt-D9; Fri, 22 Feb 2019 12:56:32 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAKs-0007LY-M4
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:53:57 +0000
Received: by mail-wr1-x443.google.com with SMTP id t18so2276729wrx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mpZDvMXD49QdxJt8wpvUxUfka//FLmK5Q3bpesHxKPk=;
 b=N/CagzxODuKekdv/276f71hXtTpFv4KVsTM9wpsQCTigrrhdbo1a8DtexWnL0uLpkO
 18omeTVoB8fzJ0j5vhRXb57XZU1dQgAzOHIdQfbKZw9pdxjklam5LDKdghq0pF7kUS4k
 TSktr+912xlWRX6ndEx5vBw3TcYrt2b8W0OjFZ0QWHqpApAu8Ul9v1iLffz1Em/x0Xya
 i4dGp/mgL49JMPe5c8rQczRqypr/Nip2+Eha9JF7UL97GTTb+ns7m5QrUYDBTdT9jbCq
 BDRsMTGNRmV1HHpb/DISeZc2DQhKRnEurBM5elN5TifJa0lXs64tIKkY6Q2oGNBe/Q7A
 j6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mpZDvMXD49QdxJt8wpvUxUfka//FLmK5Q3bpesHxKPk=;
 b=bEUQl/yJqY71nepu1ia/+YszNb1+cuKIhNxwDHOcFUe26sSobKE+fVtdqfAWid3ZYN
 L8FbUsr/HYyFqW8j56B6gh7Qj4ejjPKORHUZEaCVg0JmVbGuYanwsLgXaa8/LQBpIEDw
 o/toV4dZYqS6lCttEZ+TzLg53Gs2N5Hno3ICMqsUf+dKsS3Kt2JWvGL09VNPuEmoWSin
 fvTcer3E2IVf28nBwTjFs7Kir6VCcmXOX2jiVOV8rmRmNrQOe6S2EaGxxQpLgnhaV2VZ
 4pMcEdEhrfLmHLTzpX+nH7IQ29CD+sHx8xRTuDe0oLt/eFcUvFvlGGAfTt6HqUE62HFo
 NoBA==
X-Gm-Message-State: AHQUAuY7vfE03MS1Ho/qhG7T9JSP1USvWgiVMylxMO4MnQLuttt+JXXH
 T4PoUbm3fQJFLlF0eK7hhIAZpA==
X-Google-Smtp-Source: AHgI3IavQme072cpLVKWYOoRpuCla4tOdeXjezjFtFrbJI9VPdNaXp7MfZlgZAflIs5r0SUzqIri2w==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr2883485wrs.3.1550840029193;
 Fri, 22 Feb 2019 04:53:49 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:53:48 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <shuah@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 10/12] tracing,
 arm64: untag user pointers in seq_print_user_ip
Date: Fri, 22 Feb 2019 13:53:22 +0100
Message-Id: <99b59c349ed81d4b204353f54b89f930f01d6ee3.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045351_155783_F860B9C7 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

seq_print_user_ip() uses provided user pointers for vma lookups, which
can only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/trace/trace_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 54373d93e251..7c893328f97b 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -379,7 +379,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 		const struct vm_area_struct *vma;
 
 		down_read(&mm->mmap_sem);
-		vma = find_vma(mm, ip);
+		vma = find_vma(mm, untagged_addr(ip));
 		if (vma) {
 			file = vma->vm_file;
 			vmstart = vma->vm_start;
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
