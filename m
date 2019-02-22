Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59657C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:55:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B062075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NVfXslVm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BdeC2+jN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B062075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w+0ImLLopgh5aIHWl3q//aCVi6l7DNzsmSNjvt9jIFE=; b=NVfXslVmbmP53b
	SOrQvzmRyxRNdTO2aSQVWoVwd+1Nk2rGJpdyWVPad9POlqzF5npflMX5YlP+RIY8UKhffpK9WQCC6
	YK9YiRfp4+JDTBhRIsOinEcp4NEczYJj54iz9OXTrUHn6yVICOuiTzO54hZgXfN3kQVFCwV99wLEd
	veQoOSU4jdZJHZubHCXHj/RGlViTBZ7VHrUs8+IGNyj8YDoL2MHBDjvLNrwVuf6i1a6TYxdj//cxx
	DgkJDAEPg7iblmY7SlxV+zTZiRIH+BNWpJJYhz8eLU7ymEbwBQbj40pEGxAySJKEhD6GD5f62IE5F
	07Uq6ReSx2SRixqHUW5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxAML-0001nS-1m; Fri, 22 Feb 2019 12:55:21 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAKo-0007Ch-EB
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:53:50 +0000
Received: by mail-wr1-x441.google.com with SMTP id d17so2234873wre.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YCJNq7ywB4uaUqF1MkWtAuFgMYZGYk6wr0hn7fPLDX8=;
 b=BdeC2+jNB/4V8eMU3JsQLO0s40wh5+ubv8EL/H0OL5QAdcdUFTEdOl5givygFGSytf
 jcZdXVsDWgmBZF47af5N9ErRJWRqDdGFbYzwStmoYfWu3LPhdR15RoinUqaGl4Qjgq0d
 YCeMM+dJno0mPLko6w5cnWPaCxS3AA2Rfd/ZMWou0m13PSErWQBsV6d5R8egW63k1+91
 6M6Xf0kf8IIz0JxRxyv6eb8DSW3uJPeZp30Ea6z0EgQHP8RD6UikV9fQtwyB6NNbFht8
 Y6QmzmWpqBZaGR9Y754fPqzonuZULmj8ckN9DYzx0pIKOjOjbgjMmJB8O+P6iH8eCk5e
 9R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YCJNq7ywB4uaUqF1MkWtAuFgMYZGYk6wr0hn7fPLDX8=;
 b=L6b0LFUFXK/zl8zJ5IY0B07a50TQ2IFtd9HMwfadQM+qSnMpIxwWq1Ao8IqfCHHJE8
 gFIwS1HkPdQcWzxnCgQ4KPBWUXU+EDaftkYqM4/YdWsrKaTQgdCJnQ26pi+bM4QkPzVa
 DyAXPqQUiBcQ/uO+KvaxZobjRkU59So8vD2PhzaxigGpR1Tgf/FMhNDqZSJEwCpwYY4F
 v4P8WIkuIUvqUoBqAje+Rs/mkfQgnnLbjMfsxqf53T2GsAGNCFqYjZ8mLElO8Xp26KYg
 n2a0ItfFOFruw4JkVbxqDAXPP25i1Ubl4uvv+smWL9U64T+QvemAbsIM6IeKsx9Nobua
 aVSA==
X-Gm-Message-State: AHQUAuYQxEjpf8nnmYW/ikw8RJ6h+gXv0cBJh+U5jtX0iRuqtkfXWwTt
 FSSTSQU8Odi15A0bYhUAJ6/+Gw==
X-Google-Smtp-Source: AHgI3IZgI7h36o877UM1PUQ4BYpfOXhaodse0zlvLXALYRj1MboJwPC5054Yq8NVsgrx2Fr3cstKRw==
X-Received: by 2002:adf:efc4:: with SMTP id i4mr3192098wrp.42.1550840023746;
 Fri, 22 Feb 2019 04:53:43 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:53:42 -0800 (PST)
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
Subject: [PATCH v10 07/12] fs, arm64: untag user pointers in fs/userfaultfd.c
Date: Fri, 22 Feb 2019 13:53:19 +0100
Message-Id: <8343cd77ca301df15839796f3b446b75ce5ffbbf.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045347_007561_A3416B80 
X-CRM114-Status: GOOD (  11.99  )
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

userfaultfd_register() and userfaultfd_unregister() use provided user
pointers for vma lookups, which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/userfaultfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 89800fc7dc9d..a3b70e0d9756 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1320,6 +1320,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		goto out;
 	}
 
+	uffdio_register.range.start =
+		untagged_addr(uffdio_register.range.start);
+
 	ret = validate_range(mm, uffdio_register.range.start,
 			     uffdio_register.range.len);
 	if (ret)
@@ -1507,6 +1510,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
 		goto out;
 
+	uffdio_unregister.start = untagged_addr(uffdio_unregister.start);
+
 	ret = validate_range(mm, uffdio_unregister.start,
 			     uffdio_unregister.len);
 	if (ret)
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
