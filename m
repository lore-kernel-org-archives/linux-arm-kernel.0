Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504D3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:34:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2038F21A4A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PWq/USTt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pL0aptnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2038F21A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=VbULBMh2a/IEGO5p4FlPxhvaBewjZDY6dz862RmbJ6w=; b=PWq
	/USTt2pSZWv5ibW2yUTtpj/Tzh0WUKLEvWpQiflI+bsq78vunic7gcmcqAJW8k2MN+aMiws2OwUk1
	4M5SJ/TVNLZ8kEBK2DfuC4ZhZ18ybJ5Ze5rylJA4c4JWzXBTFyPx+YxWwBNPaIOrTZFrFD1IrPBcZ
	H1N4ZEtgCBoXTHkA2of5GRlVJkGYSWD2EnkkNFX4iRI3W3A4h1SRCaqB43getXBe/NNg3G5VzMOx4
	+uO9JJW2I6SfkDXVqxufm6f9m/zCj1aYScgqsrsADWFcjTE76mB5XcwwtMzBUUk8RfgvcATUB2mHf
	Mj/vCI7esymTkQm7wpUojgZ9phTsOKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvEA7-0002YN-PM; Sun, 17 Feb 2019 04:34:43 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvEA4-0002Xp-O1
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 04:34:42 +0000
Received: by mail-qk1-x743.google.com with SMTP id m9so8207894qkl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 20:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=h6TKt4Hh8+6/IGrwTZ2yYrCHynxj3jrbFVaK/gRbrTk=;
 b=pL0aptnAzBDaovLZAhnwQfZk6XWrw8F8IisW06u6EOotGY6TsujUzuZDiNyOWIQw3g
 QWZkDmkJ3a0deDcuGM+IkyZAygSZcW16keE2X1jOfsNedsbpPcW39sUPRenJDBdU4JSu
 /AYKoSPnN5GeNgAPa2IzYVxjqhrug+XllHcjFDtDUVpM/BodH/JkDqQEZtJY8dVTZdKQ
 AmO8mUJSMWJv4WwE7F40u5A7I7HvpJsK9yD5S+JS6aHL8cz+GsF9IV86iftNVHO5tklE
 jG3lXd5ciFII4jaHbolrk4d6sA+9egEIHQhEKJsg0y64o2vOix5+toSwri0r+fTBTp3s
 kh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=h6TKt4Hh8+6/IGrwTZ2yYrCHynxj3jrbFVaK/gRbrTk=;
 b=mBt99bIpvO/G08Df1+Z+MBS7WTM5NjwrUrJvD6vhJVEnYMMbLgqe1tatAtnVvhzQpy
 lDqE0r4LsefWURem1vLUEhSxqdLhxnizWJ2WsyPkAtEHriXv26gJ49yjYJnhSvqJxpVD
 VZup4uO7R1aBHMLZW/gMaQURT6KKBcxta13qHTB+aBU5Xw1sqI8xTmT8FmyUAfH5lKF3
 RyoWV420TTI0HqWupxY4MK9SH8MrYrjO7TxhT4w1smTAsZ0tyyN2jS06VYhXEmBbOULY
 UWR46LVN3muyqhUXPAts2dNC2fpHcZd+FbEYEWbwsb7SSjo5jpBaBEaWAEFLggebe3Uh
 basA==
X-Gm-Message-State: AHQUAuZHi2IYTaYVaUjZEFlbgJR9XQF0wNbyuDU716ColaRLalhyMd9R
 z/xw8cSYmUz5Qt9dPmfWmS9hKw==
X-Google-Smtp-Source: AHgI3IamzFPnrIQQELRtEl+dx7SsghZSgftoi3VyNxrU/X4MvX8mIGFIFEBNrCd7x5MJR3cudv0C1Q==
X-Received: by 2002:a37:4846:: with SMTP id v67mr12866022qka.267.1550378078369; 
 Sat, 16 Feb 2019 20:34:38 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id n62sm5118369qkf.89.2019.02.16.20.34.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 16 Feb 2019 20:34:37 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: rostedt@goodmis.org,
	mingo@redhat.com
Subject: [PATCH] trace: skip hwasan
Date: Sat, 16 Feb 2019 23:34:34 -0500
Message-Id: <20190217043434.46233-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_203440_834046_0E8C91C9 
X-CRM114-Status: UNSURE (   8.11  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, Qian Cai <cai@lca.pw>, andreyknvl@google.com,
 aryabinin@virtuozzo.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
causes the whole system frozen on ThunderX2 systems with 256 CPUs,
because there is a burst of too much pointer access, and then KASAN will
dereference each byte of the shadow address for the tag checking which
will kill all the CPUs.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/trace/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index c2b2148bb1d2..fdd547a68385 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -28,6 +28,11 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
 GCOV_PROFILE := y
 endif
 
+# Too much pointer access will kill hwasan.
+ifdef CONFIG_KASAN_SW_TAGS
+KASAN_SANITIZE := n
+endif
+
 CFLAGS_trace_benchmark.o := -I$(src)
 CFLAGS_trace_events_filter.o := -I$(src)
 
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
