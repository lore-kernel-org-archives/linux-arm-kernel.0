Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E2DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:24:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F5C206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mMPxW38L";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlSweSvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F5C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1306JkzmNSMUK7u7UEyC+LqQSVm2wQVGcGNpguF7VoY=; b=mMPxW38LCmBkm2NmXJ0K9joU1q
	leCSir/8C4nqNsSo5g1wt4aakSJEtLx8E2e8bTaRWw8bVNRRS4WIVbJJTQcle03uPovsG/Fsx+rXl
	XSW8cxgSmy0u3lYWnS+yOV7SuRFDK2e8edEGOJ+bZ4onjFBngx/7LhVBmPqgMDunar+bmiKbKd9jl
	YP5Vy1ppxgkbTy+itoGqyVmgpGyDU53pp6epbd9V2AE6OOhKGYCF0NAPKymjOuNP/kb+b2PBJHBRd
	cUBuYee5X6mD/SMazS3X1aACi3fExnRhFdoYN3ncsNm3kPtvcWMCCC8hYtrSbXhaR1HcQrKL+xHNv
	ZQmg338w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvPEj-0002xs-Tt; Sun, 17 Feb 2019 16:24:13 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvPEG-0002NP-Ca
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 16:23:48 +0000
Received: by mail-pg1-x543.google.com with SMTP id y1so7196701pgk.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v77WHuWVJ9n6wbtheA1rJs8RZVqdPCnng0NLiMUvMxQ=;
 b=tlSweSvVXkKcOP8R5lzLVzGKM9lPcWBl5axNcBu6LnPg6MmMyRXcezAGVKX3um7oul
 e1Bai21qB/EpeOV6kAKFRr505Qf+Zb8KxGGsKsrGllrJxoqe9gzWkOVuLAtjlYt4DIZc
 Hh9MjWa/WSYDAZREa2j70rohw1ai7ifDqxtonhbIitr2ypxMbqBOua7eZe9TqDMyDZug
 nAahWYq31pMHSd3BnquRY2BxfDGwCKbin4TQzzj87xMSsHJDtJwOt/QqGCvr5o92bz29
 WBNqPLUuyBMXet/XDRqDGm4IeS8blwEszu3xgwYNlyYKAVJASvYMKNAIFTtwC3Mi/SrO
 amYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v77WHuWVJ9n6wbtheA1rJs8RZVqdPCnng0NLiMUvMxQ=;
 b=I36RxxTyu7JbP3c4iDhTRDnAZJvhTFNryCfocbvwNJyyVvFuxy0rK42++jDe6anzZM
 wMTroictUzJc53S8SSxszdgn6+n9dmTpFFTsEGXNnW3v8WrdvYlFl+Ax7D3cWxCibbi8
 L0yxJ7RGFp3ARm3SLulDgU2bQXp8H0mQ1Qr+vJVfBXAw8j1SeJodvhRMe7EHdNZjQI1x
 yxMqWwqaQ+6Wy2abCc8+Weq4i70P1PfA/qujciE7ENUGCo1uH/F7iX77bBzpOeu/R0to
 SHb5/z/LWPGVJlnorvHTCgQyXeLcdlsEHk/7YnOEEgAPofApcQ/7Sqk4eYEk3L12vHzA
 HwWA==
X-Gm-Message-State: AHQUAuaKPEGjbbZcU5EYcTN4+Tsh6rKaEtoo+WAt3sZ6frm+AjZzrDDa
 ewx3eVKd5nBLeaOeeYhftLA=
X-Google-Smtp-Source: AHgI3Ib6zA9gcfCmqIwqd3zxgOlw4olUhTSpcqMgWWdRR+1C5plksRvth5wOy7EXDl7l17ylLEphbg==
X-Received: by 2002:a62:8a57:: with SMTP id y84mr19714966pfd.197.1550420622343; 
 Sun, 17 Feb 2019 08:23:42 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id b26sm17874576pfe.91.2019.02.17.08.23.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 Feb 2019 08:23:41 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: srinivas.kandagatla@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 maxime.ripard@bootlin.com, wens@csie.org
Subject: [PATCH 3/5] nvmem: sunxi-sid: add binding for H6's SID controller
Date: Sun, 17 Feb 2019 11:23:14 -0500
Message-Id: <20190217162316.14111-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190217162316.14111-1-tiny.windzz@gmail.com>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_082344_774435_2E8057D5 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a binding for H6's SID controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index d37017e343b1..cfb18b4ef8f7 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -8,6 +8,7 @@ Required properties:
   "allwinner,sun8i-h3-sid"
   "allwinner,sun50i-a64-sid"
   "allwinner,sun50i-h5-sid"
+  "allwinner,sun50i-h6-sid"
 
 - reg: Should contain registers location and length
 
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
