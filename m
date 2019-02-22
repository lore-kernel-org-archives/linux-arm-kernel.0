Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:56:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0519D2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nl58nRay";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="B3gwK58H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0519D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m/r7aNJK/X5QfcQUeerfK9FbOtRb1CUCDWfee3Cmabk=; b=Nl58nRayk+H8RB
	KMi9n9tbdhcwsMTGkrwrjtzt2erC0lHICS3BZHfhnZcHbGzbBOrJy/ouJkMgmwitQ8/zJ3OFkBwJo
	jGEVZxtkWvZdtStIII2nP5nJyPLLbZ0EVxyAYh+m0LZYGKtCutQPIIdywHott+6LpKM6wJ3C04RvL
	rtaG4SLtLMvrb24VWEijJRDexpbo0kh6n5BrzHT1kemoYz90GuoQEYFA10xMHrMmJV6CZGcGhxeyg
	CZGWGvMfvlgxSJgrFoDGPmACRjidEnnGaZ3wOPXoUqzfSUKFYu5Gm2sGWFpWPE4kZ0rHogDhQiGge
	KDy3Q0T+q95c4dCY1Oeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxANG-0002VB-TC; Fri, 22 Feb 2019 12:56:18 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAKr-0007IU-43
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:53:53 +0000
Received: by mail-wr1-x441.google.com with SMTP id i16so2223906wrs.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2tCXxaQ0AcT215cB6TyMBJl5HSukg9TNH5t025IrNLw=;
 b=B3gwK58HnJ85CmTL2efZvH+J/Nm20KCnydLNY0dw7gbtvGIUGcldP8npiWTUpDXgKz
 /u11H7eQqGQOsrUx9Bjjx9CGJcxvqjtgzrsVE+c4Cnr2aH4wSMA3cBw28f4m5dvZcDtW
 dE9QsCl+18tkcm6KtqrSMoS1/n9nvYZMf6UFWkly4U8pHmTr2bgB/2tzCG5OvgHPbq1p
 LygIpIzOhXUWhS3SS/cArJu5XyCYKaSFAA2Xlb21EPCN/ry2nFAF1xMDOUEnala+awoK
 ndjVy074STqch02YUSBKRqql7aX75kVTJAVZrchuqsIoYuA52Cu849nBt6+cAxrGpU8H
 43FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2tCXxaQ0AcT215cB6TyMBJl5HSukg9TNH5t025IrNLw=;
 b=ks4MAaz2vGy/mBQOh5osvQx0KYajklzM+qXJJzo2HiT0AGMIKb91MUizCZ89jQFVNu
 PwRlOKnsrF1yIw0Y0I8Ad/F32pTzTx08At1G0Vea5A77tsCmhsunDRJfyYRYBJ48oCNz
 H9Ex5EPiBnzhCK1zm0HPhJFmNQnnEseiuUjp6vVMY8L7eqUdqNtvVwjXXZXPsqqTf9WS
 KYAIN1QCA3Dhjr1uLiDyx4UEHp8Jq6mLh2LK7CucFKJ0+tVkjnTsNOSOw7s4/Q+jmQBA
 BitRYOgI8+IMMZFU8k3eus3+poPb+c7LrVIpq7V7CV10bavX83s5Ly3ICE55krHJjkAM
 xLMQ==
X-Gm-Message-State: AHQUAuZpgNtM6ZoqnGdabhzJdmQbBdyfr81p6Y8XpF9m5MLQCEDPdWWE
 V6VCb8Ol1EFpx4VUocmcNiOS3g==
X-Google-Smtp-Source: AHgI3IYJ4JqjThJgosMpQUX8CWU96fplWtblPpUxW7NKKKm/ffsucHxns87xgSXmASXlP8q7nFWW4A==
X-Received: by 2002:adf:ed0f:: with SMTP id a15mr2881069wro.249.1550840027447; 
 Fri, 22 Feb 2019 04:53:47 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:53:46 -0800 (PST)
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
Subject: [PATCH v10 09/12] kernel, arm64: untag user pointers in prctl_set_mm*
Date: Fri, 22 Feb 2019 13:53:21 +0100
Message-Id: <d6febfc14cf0190f4ccd84fc1bf9bd077a6d6a9f.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045349_541770_135983F8 
X-CRM114-Status: GOOD (  11.59  )
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

prctl_set_mm() and prctl_set_mm_map() use provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/sys.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index f7eb62eceb24..12910be94b7f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1992,6 +1992,18 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	if (copy_from_user(&prctl_map, addr, sizeof(prctl_map)))
 		return -EFAULT;
 
+	prctl_map->start_code	= untagged_addr(prctl_map.start_code);
+	prctl_map->end_code	= untagged_addr(prctl_map.end_code);
+	prctl_map->start_data	= untagged_addr(prctl_map.start_data);
+	prctl_map->end_data	= untagged_addr(prctl_map.end_data);
+	prctl_map->start_brk	= untagged_addr(prctl_map.start_brk);
+	prctl_map->brk		= untagged_addr(prctl_map.brk);
+	prctl_map->start_stack	= untagged_addr(prctl_map.start_stack);
+	prctl_map->arg_start	= untagged_addr(prctl_map.arg_start);
+	prctl_map->arg_end	= untagged_addr(prctl_map.arg_end);
+	prctl_map->env_start	= untagged_addr(prctl_map.env_start);
+	prctl_map->env_end	= untagged_addr(prctl_map.env_end);
+
 	error = validate_prctl_map(&prctl_map);
 	if (error)
 		return error;
@@ -2105,6 +2117,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
 			      opt != PR_SET_MM_MAP_SIZE)))
 		return -EINVAL;
 
+	addr = untagged_addr(addr);
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
 		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
