Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC169C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8CA218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lR0sGZKB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUF0VKIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8CA218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BkmMu9s7o3aOUo2HhPyropgaslV84f8Loi0dhnnvy0I=; b=lR0sGZKB4dZA31
	BH6QvUJQeQsGrKt84Ggls40DCPwXs0ni46qHtd4ESkLy8PsyLib8xF7WXxpvokMcqBdHDXub8vfBp
	fI7PVJ8Ao15HFqOVnfA4mbWB2O1EFNz2tK8O4KrvYEdUZvd9A+jX9sIpDysv9L45V5mptddJ/TND8
	zdQ9dJntsbEF1OJ5RVfRE2Glzl10wtMPO0txsaYloQrgL++jrbcHPj+DAUtQZE73lGG7vi0wccXUi
	Nw97c6lD3y5+rBmFLJeOBx4V3Cs77CklSwITxYUgOw+goI31QwmjWOOfqcsEkk8wQzPLqZHd+GZQl
	0HXOgRdWVHm6hUs2mzkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWg1-0004Fk-Hs; Mon, 18 Feb 2019 00:20:53 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWf8-00023X-DJ
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 00:20:19 +0000
Received: by mail-pg1-x544.google.com with SMTP id q206so7528334pgq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 16:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EoaCOkUk5gTo3YGBlv0mXfCaFcXwFz99tNXwoGoos+Q=;
 b=CUF0VKILEd6e5TC6U/Lk5nkkqDiX0VIWU9IgUFZ0ZfyXaueXbEzZeuCCaXO9tpa9Q4
 I8kHcc7SmVIrzdHiDayDq8QvKu4uxVe9gQVPuQuaIJ9+1vJ14bGcim8gMUvVX0MHGNzl
 GtjM/DGj27oZ3U5QVJwyXdYxdq21B3yo7Jdj12x56ffl5eboITDSRjrbLmhBFPPvmbDH
 3hZ4WkqE5nUdKUAKT3Uwbh/x6KYP4V9rGz68rnKD5ZmOWu1V+DvcFbhyuW62pIBXShrc
 NaCyWyTXM9e+6isJJTm8aq6aFiz5nHepCVopinJSUqgk6M5DOoszn5LXdumiimzXUq1A
 5jOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EoaCOkUk5gTo3YGBlv0mXfCaFcXwFz99tNXwoGoos+Q=;
 b=SwK31SDUeDz2R+sHKZbWPoyjEhhdwAch+kEUfPqdjwDNQv1phQmlmFSCN1JtWs/pUG
 oGTBB2fcdNFjpX++AjKJdUr6QxC3+75WoSjTpZLdDX1Fo9z4DTsoWacmzfT3cW8qm9Xv
 4ptEC3WYyD1Hz3UDT8U6Ib5/pi0SRLwZxQJ+cq5YYJa5OyHxEswNIDzT1b6jnS3ppwVI
 GO2NSN9C5LEsohY8j78GPUgy+1t/4CmE9dBjEujiIXadoJnRzRcbqWUjM7MUcCsMqvm5
 aKlRjst1LWdWKrw68sh/v0y+gLVgDHTT+eQoGFzAj2Rxde184TJwrO+SOC7LaTtNt8X6
 3yZQ==
X-Gm-Message-State: AHQUAuadwbZkfI613D3LO5hMefXGxUEN0gszF0kh2DmvI8ER7tI+XorO
 geaRlxOP0ehpJs0iCIThwj8=
X-Google-Smtp-Source: AHgI3IY26M/PoAW6QKgiAoUGCwB26eIUUKSsASUJvxvJcrOiGbH+GGYwoscq7O/Hmqh5WqIKoSHuVQ==
X-Received: by 2002:a63:2312:: with SMTP id j18mr16365991pgj.344.1550449197904; 
 Sun, 17 Feb 2019 16:19:57 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 16:19:57 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 6/8] ARM: tegra: Always boot CPU in ARM-mode
Date: Mon, 18 Feb 2019 03:17:24 +0300
Message-Id: <20190218001726.16785-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_161959_333436_890502A5 
X-CRM114-Status: GOOD (  14.00  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CPU always jumps into reset handler in ARM-mode from the Trusted
Foundations firmware, hence let's make CPU to always jump into kernel
in ARM-mode regardless of the firmware presence. This is required to
make Thumb-2 kernel working with the Trusted Foundations firmware on
Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index a9f13230da2f..c827b185d281 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -112,7 +112,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  * NOTE: This code is copied to IRAM. All code and data accesses
  *       must be position-independent.
  */
-
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
