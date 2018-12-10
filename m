Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F0BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:59:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C78120855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rpq8/znL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VEgcxLaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C78120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PHvoF52Si2ZbH7dUIBnrIX5eXKSAgDDSCUpxHMoNsfs=; b=rpq8/znL/Try0t
	MLzXzPg2pWZ/tu4loH62zux1cpp2I0vZ8+cLkZymq9hQYo7zjTkEmKzHrQMv34HqtmG6LVF8jA659
	Cn9JvrCWNmC5RQNvIJ5lYw1Uw1fnPDW8/aMbfzXU/UfGWcDMd8fsMrSdQfpHlU2YLToTctDUQVdns
	hFTjqJVIuiElAMItH8s9JW2TekFNmb80nrgiiOCKoOASKRDlDVmq17uVEA+hZUgWJ5SuWzo0J9ZAI
	c5IIet+3ycS7pCa8rkJY4uQ4lFawzlJBS39/UFRGMeTIFHLuVlpSBeoyzfm47ZyCHP1/vfiD+RcWD
	qD+EQnjY/Yfwm6QbpStA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWL9I-0005Jd-5c; Mon, 10 Dec 2018 12:59:00 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWL20-0001Ci-N4
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:51:34 +0000
Received: by mail-wr1-x444.google.com with SMTP id j2so10379822wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 04:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pdp/ryV9bt4+HrjeOWrdnZnBI6aj8YPFqzbeaIQ9j68=;
 b=VEgcxLaXoi0dOKDXk3mvZgG3orCXpa3lyeE6CP4OJMDCNte/zoFeg72gBtyYRUM/+z
 dkdH0FX3oaVuoZ2TdAnAWlMAq2acZqiJrldMEieGTNK+3b5PjuVvTUt13jkyridlEMir
 ldYCNgQs6aUD15xGtoBy02lnJF80uPmFB1DrhlhknCsVZxjWvFv1RdkV5JJ5GSpCW5Fm
 4CiX7I8udlN21IjNRASuq0xeFFDULrKpoEaM9D2i67zp9cQXXr2TQKyBW/cdB/XiSE0/
 JddgPffO2wfeBRJJGAVFDqBC6nXfN7M9u/3FUN6B+81x1rMeN5f1CRtoSZFGlT6PrwZW
 bQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pdp/ryV9bt4+HrjeOWrdnZnBI6aj8YPFqzbeaIQ9j68=;
 b=D1QTHApMI9GfDEn7GRriybY4iXo+SwxEQwSfHP+6X2wxtFM4nY7sMkjYL7/UBtHzLU
 8wWoBjF/QPSEIMX3d4dK/VdxyH02oABDe1LSVZQGTr2sqm0UzxEtQAQPS5khLKKIujw3
 hKEc82o3yXBbPF61WawLHK8BqDn9Bud17lCSAVIhMl9Xtc0XThyZ8qEfwO4ZeziL6eNJ
 2nbYy1e1mp/feJlbiR6dzcgw9bIpmIVUpjb0dYbREq5vn9L0Dqc5Fl1GDTISiO1mT0zJ
 gCpEo8BXAysGLRAecYg8SlZMc3WMdOggKoYO8a6dSWMetkCmKfNiK8HuPSUjv6ldOFnV
 +1pg==
X-Gm-Message-State: AA+aEWY1hfEEPp4nJ/m7YQ9i8LfcUX9qMSAVPqDH5YnyNpniNSD/olMN
 auBH560tmCPGxew6FvUh9ZGrYg==
X-Google-Smtp-Source: AFSGD/WkZ2Ib7xqoZNcfNco/+WzWdTWYInohVyU59jy0CeiifxD2IPgCZSpbiMewGDrt/7AYo1yayA==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr9258512wrv.308.1544446278383; 
 Mon, 10 Dec 2018 04:51:18 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 04:51:17 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/8] fs, arm64: untag user address in copy_mount_options
Date: Mon, 10 Dec 2018 13:51:03 +0100
Message-Id: <07a4efa5983abec2355b2754812509a73f648332.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_045129_288865_E7EDF420 
X-CRM114-Status: GOOD (  17.22  )
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
Cc: Chintan Pandya <cpandya@codeaurora.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In copy_mount_options a user address is being subtracted from TASK_SIZE.
If the address is lower than TASK_SIZE, the size is calculated to not
allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
However if the address is tagged, then the size will be calculated
incorrectly.

Untag the address before subtracting.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a7f91265ea67..694dcedb7e7d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2686,7 +2686,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
