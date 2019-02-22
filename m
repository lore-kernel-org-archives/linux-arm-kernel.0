Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2D6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:55:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D502075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uSmpwsb0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dFFShaLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D502075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W+ajrnQ2SXQ9dLD7ouDhl5QX5TpLxmtSXKH6wvTYUAA=; b=uSmpwsb0XOqWXi
	6FEOGlyE8L99wUGHV3kc7nenSxtQtwvj0v6CRnY1l43GbzsWBfEBUmCzjVYjTxKKoySoMAtSPlpTs
	dVZk9re64S00dS0VtZ+iqCwfZOTTLJgsHfqxCjwW3EZXm3oS6kCLNPcqBR+EV7e3eH+8JoP0ybfMf
	QE/4dmtfl831nSgvPJYsf2hTPPpKups8mok8YVpw8GRAuuB21DFuPKeoEOeE3pOaK85yredmBnsAh
	+zusp7Z0GzDfXyCcIedIryfzSPdjEls3ERgAAre6LDGqKbyTyyWiYRPpjpyk6kANN4tbRgq4Am/Xv
	dAaSguK8vwLi/ReM00Hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxAMW-00020X-Fa; Fri, 22 Feb 2019 12:55:32 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAKp-0007FY-6V
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:53:52 +0000
Received: by mail-wr1-x443.google.com with SMTP id l5so2256864wrw.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9mSxyMmz1xjHsHJUyT/WYIPnpYi9SCNSb/qUJqV67bQ=;
 b=dFFShaLkfC9Jd78NrGHT6+qV8Fa9yuKItk3VxryuG9FBzLyVutr/noYyEqX9rPsCPB
 4FR/7879ajA8ORjVk4I07QF8PQLg274w2Q+K0O39R3Ga3Hhea7F4g92KaP8LM4y5+Hso
 eJt1r7agSQJ/Q7Cx/ewAN6NsplIo0lNiUtrymbVmaJov1lsCukOg7OdDCcVG/G6dymSR
 5NrIRbGPjHAFt0tx/2kWNS9S69vHxnpOLSsET8RPCLmIYV5M4RxLn41hJi0rYK9TmjkN
 4J4iqkL9iIltHwkRu+ZKdYA7Xy0gQC5aG2HVCItmVD26gYOu7PxGByh9QtCwnvGsjRA4
 qTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9mSxyMmz1xjHsHJUyT/WYIPnpYi9SCNSb/qUJqV67bQ=;
 b=G0TJkJ2Allf/6DKkiJphILrlycRQ8g/4Wzjss8I8z2N1t/2pwQAxAB55LGux0sYg+U
 NLzGXsNssR8zNynmfkhA/+a71GQ25kUJhmCQF0kTaO01Ee4m11LdED4cXF7yI4oGxH+b
 B2r/x2lyUnF8Etx+PlEgeZ2cwXv3GqsevJFFDzvbnTx8dnCInAdx+UH92RUE2da4FKru
 jJz2Vr/P8TrDcKqcx7Nm31NxMJkq0jmj3O3Evmt2rvKyutkUijhCYdtsPA0tRaHRQLvv
 8O7xzKQSsrrrMS69kytWZ5QqIUuonwCPvactc3ownY9KrQTy3miWJi6bxmw6IIyKRiQz
 +y6Q==
X-Gm-Message-State: AHQUAubY2miOoFu24A8uqoWp7DuGs0ddPf0Q4bFsBnWs/f9fdoEtnmIB
 WEJMg6sBUYo5yVzMETbXiqCzQg==
X-Google-Smtp-Source: AHgI3IYB1rxXC3qLSPjqnlg3vyINEmisEJ9COGx3+BlbVTSYQsvRd/r4g+wzkk/8Tl6H/RsXQOXN5Q==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr3055201wrt.27.1550840025673; 
 Fri, 22 Feb 2019 04:53:45 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:53:44 -0800 (PST)
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
Subject: [PATCH v10 08/12] net,
 arm64: untag user pointers in tcp_zerocopy_receive
Date: Fri, 22 Feb 2019 13:53:20 +0100
Message-Id: <ebc80132c8ebf6016821ddffbb7e461bd2484824.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045347_841765_10049FB5 
X-CRM114-Status: GOOD (  12.06  )
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

tcp_zerocopy_receive() uses provided user pointers for vma lookups, which
can only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 net/ipv4/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cf3c5095c10e..80f3c1fb9809 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1756,6 +1756,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	int inq;
 	int ret;
 
+	address = untagged_addr(address);
+
 	if (address & (PAGE_SIZE - 1) || address != zc->address)
 		return -EINVAL;
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
