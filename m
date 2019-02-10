Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5337DC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:26:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF8B20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pik0GySg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jjJ/LUqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF8B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nLrTqeqsqHwGqbaznx2/WTWKYBoJe9EJwwvZHisRmqI=; b=pik0GySgTBJZJs
	za1yvZtKOTXx8I4zJpA8csL5v2QgMKajF1SH8SOGbtJsfJEyeXOVn6CRKjhioObZ5Kn/Ltb/cbAZ6
	dk4E095nhDSp6806lOEl+lCBkrFIXq1M/YhYJZp0hozCqb+kJayv4C/Yw0UU2KLvL3+HirIw+1tWd
	ih4XOMp9Wk52SVwMUhUChq7PJy7WN1t/9P4Rj4w8gtpuqe5u1mb6TElTYAs3LpEIiAhiXjMNRbrNh
	WyjOMH9r7odJ51JkPc//5ATcVx3Whx/SMnOFALcgsfDp5To9VtArU4s07RFKprU+NQyrTXOrKmzKJ
	bhT6EdPhveeRSY2I6gwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsxYY-0000tY-Ea; Sun, 10 Feb 2019 22:26:34 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsxYT-0000rU-ST; Sun, 10 Feb 2019 22:26:31 +0000
Received: by mail-wm1-x32b.google.com with SMTP id p6so13317765wmc.1;
 Sun, 10 Feb 2019 14:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mfga5LPr/J3+vtuLs6sE/4iTgznBPBA3E+j5LobqNYM=;
 b=jjJ/LUqgiivo4ybNNx8VXJ8xpv6uAvDtXSJzrKyfkTKApoia4xS0nG7OI7T0mvIuU4
 +HJH7CobjoW6z9FeJLiMP3fmfyPTG+j13M0Hd5184Tc6j6Sa0El4JhZZT7GQ7buWUada
 oteoPBKBReaD+TNTa/bDV2xcwRX9VXKPdvHu6oNWf59yDCVhd0dIK3kTLb/TMalC3sDM
 AcETk7TCmZuN6ZQoLfZLh7QnZ56OSCpTBFpKC44+IbfDvbmrqRarIHwGMdkQAVEFBnP3
 Ep4CriSqdmwX0fUz2F95mXKZ4nilUEtWOuxfCEOayUPhUyZ5+6OA3er059Ab+y1Plr4y
 y7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mfga5LPr/J3+vtuLs6sE/4iTgznBPBA3E+j5LobqNYM=;
 b=YSzV30K2jD5oeJFmWL4I/zlOiNbD8ffBVLXSsYuw2b6Urp6ka2RBrzLx0t5QtG33zQ
 rAG4RTFteWt4K22MiAeF2/zyUtLOk8lex0TbQ1/s2Q8BzJx7fsllEbThCj424yj8unwi
 8fHYbxcAwkigykg61TpmKNP2Ti/0myilam/434mlc0g47ojXJawFFpMFHTCOoOxJpKli
 jDrkx1zSy8Xpf74Czqi9+NE9XiDVq+WHDrBKuixcueYR/tloHnBlRA3RAumLGTr+a0pO
 CV6utcVXwv34AEM80OByHyhUuXUKHeTvMGfjUqQ5S96AWO7/o0VjWggRpjCh84TfZpnJ
 mFJA==
X-Gm-Message-State: AHQUAuaetzGFXTd7pI2BU9RyPRlJDQrM6X0j4o5GoH0ill+T4CVED2Og
 m3YxLSUync0DUjt0EFpFjSzd9shq
X-Google-Smtp-Source: AHgI3IaXjoT47lxbtsg47YPQ5DqyvjDltZAZSAX75NeQ0BzFEG8dXRQHyoZhkNt/5q7WwIQFRaAOzg==
X-Received: by 2002:a5d:43cd:: with SMTP id v13mr25276183wrr.194.1549837587435; 
 Sun, 10 Feb 2019 14:26:27 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD70B4600C064670D88EA61CD.dip0.t-ipconnect.de.
 [2003:dc:d70b:4600:c064:670d:88ea:61cd])
 by smtp.googlemail.com with ESMTPSA id b14sm15523330wrx.36.2019.02.10.14.26.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 10 Feb 2019 14:26:26 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
 robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [RESEND PATCH v2 1/2] dt-bindings: clock: meson8b: add APB clock
 definition
Date: Sun, 10 Feb 2019 23:26:02 +0100
Message-Id: <20190210222603.6404-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210222603.6404-1-martin.blumenstingl@googlemail.com>
References: <20190210222603.6404-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_142629_928485_5F2C29AA 
X-CRM114-Status: GOOD (  11.90  )
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
Cc: mark.rutland@arm.com, sboyd@kernel.org, mturquette@baylibre.com,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 8e1dd17c8b0e3f ("dt-bindings: clock: meson8b: export the CPU
post dividers") added a clock with the name "ABP". The actual name of
this clock is "APB".

Add a new #define with the same ID but the correct name. The old #define
will be dropped in a follow-up patch because each commit in the tree
must compile on it's own (the old #define is still used by the clock
controller driver).

Fixes: 8e1dd17c8b0e3f ("dt-bindings: clock: meson8b: export the CPU post dividers")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/dt-bindings/clock/meson8b-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index 5fe2923382d0..8067077a62ca 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -104,6 +104,7 @@
 #define CLKID_MPLL2		95
 #define CLKID_NAND_CLK		112
 #define CLKID_ABP		124
+#define CLKID_APB		124
 #define CLKID_PERIPH		126
 #define CLKID_AXI		128
 #define CLKID_L2_DRAM		130
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
