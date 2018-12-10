Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C067C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:52:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B71920855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QIUz8Lao";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gls6f17i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B71920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MKWHOMN/iw4cpmH+SgZuJp9GvGb5dngxv4bxmQHZBPY=; b=QIUz8LaoYSxnXw
	o9SfxIy3HdkahjV4o4RpkK+ddlsG6CYsHo9pz7sQ4T3m5A1vzzf0cp3b9AdJQ6PnF9qh5VH1Ns8fx
	qwENkslwvDQlbaXddGb8LMcT6daKAe+jN5iFSSCNNaRTx2FsislM2jbLWwd0EpEsoqsHktDyVwoqN
	Z3eanC4LDIK3sPGZ+5HjLQBoNKjJ5ka+UWoDCr3saohaWGzKn8R6VlX96qr0NU3LqaE4UOmcy7qW4
	NryvtBTCydG8xAOGk7fXjrzFkzLLfnAm4HGmnBxbEaoPJBjqoXl0X+XlLcP6XZJNdZBrmjrCcpoOS
	xUatPWqeEkHGrnL38Heg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWL2T-0001nk-3h; Mon, 10 Dec 2018 12:51:57 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWL1v-0001Bj-12
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:51:24 +0000
Received: by mail-wm1-x344.google.com with SMTP id n190so10864528wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 04:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DGAUj6PSqqPDQJ5J6R6pKlBVa6bTvYS48OkmKh4Sulk=;
 b=gls6f17iFdY+aaMHKZj2c6iqSD/1QrF4roruo3c5l5rPA1aVvvzHjI2CFqg/lmlOS5
 QV5WzVIcjFGeG5EZOAQBUSLUhKGejG5O9B8bsP3m0ZDDbDXlypr860QwpgdjRFT3VtOy
 XxeDJnbsSvMDNeVg7Zd3WWKgfoYfCaUgEKOfQw5HnKoHFqbh4YmdPnz+wYY39XjVd+O7
 nOiFe7/AFJYVdSf7VYpOu//HoHkRLNS028ysC6yapgWia3lzb7Jo2WuChJRuNCDkW4mV
 cPqpApKuM6RsIoZYmQ0wgoKMKNyLL+EL+mT4Ax0maE+25TL9RSBHw3MXHz8+SN4ZTCt0
 F53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DGAUj6PSqqPDQJ5J6R6pKlBVa6bTvYS48OkmKh4Sulk=;
 b=bA/5M8T+GVPTbB+WVWAAvaPO9/fWGUEgKJp4H1JsppNeIeO2Rlps5lBiyhZHcp/17Q
 cW7O06jlgBQJZsboVvovUlR59/5ygiFCQtquI2A75XBMXUFlTCXeCZ27NJiG+spDCiyy
 ZWEpD+O+iTsOA3a2VvZ2FxX2FzpdkwdKYCeJsyTGE+lJj4wxU9BBPuzzeduWmFmlRQYl
 A+KXHUluMI0JL/sBP4K9XPUXVTR0KOOAqSI/Q34C1RfFp8c3al3J0xmaIT2sGqb2DXog
 LVh+8yv6ZU+HDBAL9KGGREeTTTF9Lsdd45YzJyI809bmOPRrRsUkmLWsSHAUPSUqdEtL
 p22w==
X-Gm-Message-State: AA+aEWa8Q2NetwTSJHvssjjJvnx2uV8M3vhpOBYDpR9j5lkLI5qbg4hV
 loV7wtueNiL3DjLUbzTvGG/upw==
X-Google-Smtp-Source: AFSGD/Wfd26kZrXesEpia2lo9KfLrUJNSZ6LeKcsVzx9h0ZIx3ectSG+FrTDJ+dLbEuGhtbGIsbJVQ==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr10123577wmj.138.1544446271115; 
 Mon, 10 Dec 2018 04:51:11 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 04:51:09 -0800 (PST)
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
Subject: [PATCH v9 1/8] arm64: add type casts to untagged_addr macro
Date: Mon, 10 Dec 2018 13:50:58 +0100
Message-Id: <07836d7852b5c2d9588e28e4081a6f783689377c.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_045123_085516_606F389C 
X-CRM114-Status: GOOD (  14.53  )
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

This patch makes the untagged_addr macro accept all kinds of address types
(void *, unsigned long, etc.) and allows not to specify type casts in each
place where it is used. This is done by using __typeof__.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 07c34087bd5e..3c3864ba3cc1 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -101,7 +101,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
  * up with a tagged userland pointer. Clear the tag to get a sane pointer to
  * pass on to access_ok(), for instance.
  */
-#define untagged_addr(addr)		sign_extend64(addr, 55)
+#define untagged_addr(addr)		\
+	((__typeof__(addr))sign_extend64((u64)(addr), 55))
 
 #define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
