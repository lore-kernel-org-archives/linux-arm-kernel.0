Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC94AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:58:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF7120811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C2QexNcQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeoyj+8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF7120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ocFXEKH5EUtKrxaM9hpShLZ3+tLS6NQjMOzsZNkGw7w=; b=C2Q
	exNcQw4HaUy22pRtLc6NQCaBGbJIl0HpCToHOWpI3g3sE50W/3Nnmdv0vhJ+Z33f5qetMWAlMZzJG
	Vpd8rh4S8MchvZOWi13jB6fP/YtNIHqw4aSl5gquXfIMeaQZJ0x4abvqVotuxfmNWqWMAWldjGNhQ
	TsN+wV6j++YYS118Yy0apyhdOmiRDnlbhTuBCLDuauTwbejvdzXnEptezagi56Wcy8QOHHN+UuJsS
	KfggEvc1r2xzIpAlc90R21FIqfkl2pjX9MCLZlCeRpWDaSMY2XVK9qjJw0xXpw1utJ5a35QW2lTA8
	kihWAtWjStJYxUwDtL/GOSZbI864ghg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWZBJ-0001Hn-Ls; Tue, 11 Dec 2018 03:58:01 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWZBF-0001Gl-4r
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 03:57:59 +0000
Received: by mail-pl1-x644.google.com with SMTP id g9so6279949plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 19:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=I3Et1lRyku9kNfBv9LJ10cT2UUplmBJDt4g4A+wa0tA=;
 b=jeoyj+8g0bmoqrzicRP/IyUc9ZYien3uQIFc+zUauKWSx8TQeq7GwVPRHlTE7h4Njl
 PN+3B4HS15kDwGHRR4Gv/dCV9rtvneZM4jkgUYDOXBDjPZLEaV6mH+n+VRvOteETbnaA
 zHZbqCdiDo+AE9rR8GUDPFZ8CscjGUmHtjVOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=I3Et1lRyku9kNfBv9LJ10cT2UUplmBJDt4g4A+wa0tA=;
 b=tVqoOrYBBbvSc7+ovnQCbXToZu5zcqd8Xbmzk8HlsqoBB7Uf4ih/2PRRE2D467UHbu
 AcKX0LLmgoinx3WfkIm1FTwUh4yNpFzDGLq326rbwPNQyqb8FpTZNpQCk+6zkDZbXBwb
 qylLJlyqA1MGusnHH2QwU5vrgbkgguYm/vA386/9durOWq5/SQPUdppw1ST6zPeg6Mco
 YKf6uSnQOgJg6rbGW74jo4Epw2o3nihWO7ybLqwEZTGO6YjIZOQvivoPMtM1DXShNplC
 pNY1M3j7UhiBnvrBvafH0fYpTgP6FAzlkLiSaAXHegzsyw4R/wTGrvJLqvdKAmIQRsKg
 bEsg==
X-Gm-Message-State: AA+aEWY61hTGWQ5DVW2GxABXVNm7YSn1T+UTinWRNUQa6DcSPF6/hIXQ
 xiPTWM6HlZpMDQ8lrFzVUjCE
X-Google-Smtp-Source: AFSGD/X7rpQwE46xNICZte+mamiQKkNt/rfViHq5q44L4D1Qo0shrM5Vc/FHbZ+/SEVnKgO+/W1L3Q==
X-Received: by 2002:a17:902:24a2:: with SMTP id
 w31mr14352262pla.216.1544500665015; 
 Mon, 10 Dec 2018 19:57:45 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6305:a575:8874:2a8a:cc58:a5ef])
 by smtp.gmail.com with ESMTPSA id n22sm22454944pfh.166.2018.12.10.19.57.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 19:57:44 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: orsonzhai@gmail.com,
	baolin.wang@linaro.org,
	zhang.lyra@gmail.com
Subject: [PATCH] Add linux-unisoc mailing list to Spreadtrum SoC support
Date: Tue, 11 Dec 2018 09:27:25 +0530
Message-Id: <20181211035725.5084-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_195757_183560_B0F9F34A 
X-CRM114-Status: GOOD (  10.84  )
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
Cc: linux-kernel@vger.kernel.org, afaerber@suse.de,
 linux-unisoc@lists.infradead.org, orson.zhai@unisoc.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, geng.ren@unisoc.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since Spreadtrum is now merged into Unisoc Communications, let's use the
newly created linux-unisoc mailing list for all discussions around the
Spreadtrum SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6682420421c1..d1f768fd4f49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2108,6 +2108,7 @@ ARM/SPREADTRUM SoC SUPPORT
 M:	Orson Zhai <orsonzhai@gmail.com>
 M:	Baolin Wang <baolin.wang@linaro.org>
 M:	Chunyan Zhang <zhang.lyra@gmail.com>
+L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/sprd
 N:	sprd
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
