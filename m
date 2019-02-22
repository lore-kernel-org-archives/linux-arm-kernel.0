Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACBBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:55:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50B52075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A/WfkDJQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bOHZq9Gt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50B52075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/PaCt4zHGqip9I3bNXDi5yvHCiw8enE8LhEl9346tco=; b=A/WfkDJQ8Qh5Oz
	IsA0rpnl0z4R4FsPa/6090l0l1F1tEtw1Ow5Jz75OeYJXIdJE+dgS1Isoo2c/cwXJMIjJkwQyHTIp
	Go48PsfKzm59cyB1ZIgseOWowr1c4hbCZwx+yYYYM4SXd7LFgtBTvs1VqqCHSkzpMiw/17tfJ7JDU
	DdsuCR2cunTQkt2FlC2vOHzVogK/GrC3vGw+YUxFa8Rn+UpKHIQAe4M4SCVhCiu2iHWj27/JT8DNu
	VA+WOwRVnBLK0gpg2IWCiwD9NyAfE9mx0yvmkbXV5wcCsV259nliCzDmA7GujpYL01s34JtO7xGEC
	2H1r+wkcGsP6/WPXjedg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxAM1-0000HC-4F; Fri, 22 Feb 2019 12:55:01 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAKl-00079I-9I
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:53:48 +0000
Received: by mail-wr1-x443.google.com with SMTP id l5so2256655wrw.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QRzSxiJgMYZtPmoiWjDl90NjyZgMYTYzeKBtn1CA2K4=;
 b=bOHZq9GtneVcqI+7dx1dPlGbKg1NqyMwC/3dQj65R9b+AaL1dEw6WnsEFnvda6QlbD
 lx5q7BJ+HMum/sxb5KUmNx4YqHmnliyifP16MSQibp7C2IHgTBNe1hU9pCqsXLkuat1c
 znpbV/DdU4KpgxO4goYtaVe+u2TyXP6kbQ1RoQds32uwFxEU5JLU4SpkXRt6LADYtjAl
 WI1hDIyHVRaaElIfgQVsUPN+J6MsWMExP4yrdvC2wBzICHHXVDfMEKh4sCD1RwZwqDI3
 3IZIK/md1m1LDI9VJmKIDCuhLJSumlID2vVjptcouY1GMsQmr4PDIVNhj6rbpSyQdU/5
 NOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QRzSxiJgMYZtPmoiWjDl90NjyZgMYTYzeKBtn1CA2K4=;
 b=L/qpjKAWJo1eJHu0s3mLD0ULmjxQDlSbseueZEIf5OKLMyT+Vu/y4hpRyYxkH69Esi
 oIoDGVWoZSUjKNYwrIr0JQCAum9vB6fF7dkqM0QNHN4zU8ZaisKciLl7MuVItJ0PzsH/
 /KpPn1IJrpeg5z5J+aP+JkdNorqkVCmZSMZJuFjw+ETd8qvqJd5glo7mQdQH1MXet9z/
 xXO9F6x8pqDBmaYTcV3y4d2t+6t1oIErQCdUTXZFU4JiGxzAequyhG6rZe0zTL3R6o/w
 t78frBKwZ8NiICTtdNpWfiNoFwCgtBH4IPeTZNfZhJXiQ6j+Qp2EdZMANZqmzDxGHcrq
 dRpw==
X-Gm-Message-State: AHQUAuZgl0N7v9yAK9gc87a2IQnDeu9C7dJOJJ19JyexzcC/m77ImM0g
 xU0Zx2M11RYQoRlM+wwFBt3MVg==
X-Google-Smtp-Source: AHgI3IY2qC70XZTghQybUySJZNUvHOQ7jsxQuTtoFLsrp3D/CO4zCTUsA3Qs8Io1jJiy1nb1Hyjy/g==
X-Received: by 2002:adf:822d:: with SMTP id 42mr2852354wrb.63.1550840021805;
 Fri, 22 Feb 2019 04:53:41 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:53:40 -0800 (PST)
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
Subject: [PATCH v10 06/12] fs, arm64: untag user pointers in copy_mount_options
Date: Fri, 22 Feb 2019 13:53:18 +0100
Message-Id: <a958e202cdbe6e1bac8a37b7f3d9881d1b22993d.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045343_804923_52A1E648 
X-CRM114-Status: GOOD (  16.01  )
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
index a677b59efd74..d4b7adef9204 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2730,7 +2730,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
