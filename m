Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDC9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:58:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F2420855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PtTBx7GA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFDzySXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F2420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZwpqbVkB6mCPNKbnV0EvRsW+R1pvduqh5guSx90LIDw=; b=PtTBx7GAmQuYCZ
	T88aHainYd4RWvUytDCKbE8qUw/STAropBCpRrm4y3zMA0UpA1o/FQkGNwToKaHIhL9l8oSJleEOJ
	/9tYaAMjhF2RpoFHDDtWHg+wjVdsQImNaGgAc4F+gDz2wY/VNnsDStwMIFMs4FXnUEDBieer155hq
	8t0aBxN6XH5RvMDRDIxA0drsQ/qysBJxBrli5cfuHGKA3RA3bGvHXF9r/TTWTJDky5ffcS94BrBM5
	y8NB960zHDa2+J5h7ylhUdARTtfNMSTu/sTXgVYqyRiFSqPvVpGoghJehYr5uJuKylftX6bTaFARW
	yvDa8glfQ0v0/xqc7abw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWL91-0004ze-8Q; Mon, 10 Dec 2018 12:58:43 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWL1w-0001Bk-8t
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:51:28 +0000
Received: by mail-wm1-x342.google.com with SMTP id f81so11065126wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 04:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EnNoEMrMgUcWWKorAen45ktTirJw06vWZl+y3HjnYKc=;
 b=ZFDzySXH+RcGKbu7apwOJhQV89JvZa+gIzkdi3lCpAr8rANmuaA696lcNSMihz5jsd
 Mgc8z5GDqlKqPiGIFUGFJV5LZ6mPD1yG7h/fXqDnZeBSJrvzsxOfDPf/WQ2TgUnbPF+K
 BulPEM7LRkLz/+A0NCyQ10FFjDpEaoS17rWmhBEhu1vWUWzxbXcbBgiYI+GWlU+bKJpF
 hbHErYklHv8F4KC/8y3KrbRg/WdRewnyb+I6zzpz2QW0JhyjVBllF1qeuzcMDR2q476/
 85vwRgG7I3nE+1b5PDbnOhjIJiH5ILXwm/PcvsVjUrvLOA0sv3kgXe81o9mc0j3Nhaf+
 o9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EnNoEMrMgUcWWKorAen45ktTirJw06vWZl+y3HjnYKc=;
 b=T8pjNsMDYzINV9Zf9oK1a12euZeJq/YCQTbRiCZuc+FHZryyhsbBzQOznyr1FePRkg
 jD/RJdjmv0RHHMgVBdM+frCxwErnJc2HpiPQDAXlNzdZcdM8zICHyjtUS7acxoyrkPxh
 s8aA+kx9pSxUt6ETB1sW9ryCP8IvTsAJCEoRkLC5q+mW1AiHaonuS8KFKrKOrn9j+QbE
 /cJPn7aFj9p5nu43MwIjyQ16krSI/voVf+PwTgvz/5gToHtqVfNTP8EcsH2VN7mIeBr+
 BfEdAckIVEkFrJa1lf1kiyB3H3E0fwrXRoRxKPAfeC/MMcF/gfulhKImXy0xAqyfZtlx
 26zg==
X-Gm-Message-State: AA+aEWYgv09Mgcv+5ZcsGCleFZ7054UpRWl7X/HXxsNxi0ZXfcAX3ZgZ
 CLDc4WGQyphwGJTEZmgZIrsvZQ==
X-Google-Smtp-Source: AFSGD/XfpH+7b2MBHMbSzaZiRmsmRTBYGLOi6i4h/Gy2a0EmicqS+e3KfIv69EriIxjgI+TvTV5Ofg==
X-Received: by 2002:a1c:d08b:: with SMTP id h133mr10494086wmg.8.1544446272635; 
 Mon, 10 Dec 2018 04:51:12 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 04:51:11 -0800 (PST)
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
Subject: [PATCH v9 2/8] uaccess: add untagged_addr definition for other arches
Date: Mon, 10 Dec 2018 13:50:59 +0100
Message-Id: <35f97a89d5cc881f0f4052f43d56b3b7ed736581.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_045124_325154_3C392345 
X-CRM114-Status: GOOD (  13.52  )
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

To allow arm64 syscalls accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel, the untagged_addr macro needs to be defined
for all architectures.

Define it as a noop for other architectures besides arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1cdd47..42b7a4ac65e2 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -13,6 +13,10 @@
 
 #include <asm/uaccess.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
