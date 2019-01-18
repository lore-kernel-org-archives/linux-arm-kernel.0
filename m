Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF42C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF61C20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hvLzwTbr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5is7oZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF61C20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8N/1FAhDuS1JcjuG7HUobI4ACw+Vzf98EoXq/cF9nY0=; b=hvLzwTbrfxgimd
	WzPSzh/PqXbKon4s4irEQyLEGYfg2co2JZzeZUvq+w6w/uMXk9qTal+/J+FlxpYIjfcO9N/uzJ8A1
	WeT2gE4TjOdspPqMAPROLh6wGRLqEZy0zv0+gg4D5KLXJ+Z9/5rSvLOrVtCy0UjFLp17dcbtbsYCn
	iP3OM74z++MgsKl/hWhdoxUG07oRyf6eOo/a2OgfqGvqBbsnK98eun6aYLBf7lNeOOYhqMXQosywo
	axw4HnSWQTInvsVUal+ykmcbRc42iiVD3ZVY1Cqg7p27Dq478XwdShZN0XibfUHbv5buS4qVexWIf
	bOVc6ciB+szMMvwwKEpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkRr6-00087J-UL; Fri, 18 Jan 2019 10:58:32 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkRqo-0007ov-Is
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 10:58:17 +0000
Received: by mail-wm1-x344.google.com with SMTP id f188so4038414wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 02:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KEDamF1G6iG0yJARiV0f8WcLBjigYpz1ziosX686/wc=;
 b=B5is7oZMBWOvsBwStWjLCig5yDrvlpDdrOQaVttA4OM8lJLR8PUJgLQJuSn3uOAbM+
 zfoXjGMTFKVFLsSR/uyYRuHpLI6LaXCt0F2x2foHcdKCMAKbVas/ppLo3H1u0lyBb8lB
 5+hBoZaZERPR79NwjidOakjyX/n+JWU0dD5xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KEDamF1G6iG0yJARiV0f8WcLBjigYpz1ziosX686/wc=;
 b=DUWcRo1riodBl7sNgrieFT7oWa197OY20UvZLF2Xo2G61MmZtU6v8RzuoCaEUl/4WX
 kzpzM4akZxUOMP5kQTR9haHZZKxBDQDue536EZQXuk0sKkPEl760ceMSaE6wVbEsaaar
 OtJhKOQiw6CZfORaqp10cYwvVGwYF70jbMFLooEOT4LoYsH1ue2yq0Z5mKo8NgogZwB9
 iPTvTXbn9oNvA8GtZSrU0v9wU5nvvyWxzdBGY/uZnPlUFfyhhJX/aptqOp72vbQq8kBc
 C4+Rr082EFRqdLPEwnDG8QUNHQfBaj28jOB5aBdaAJ6L9/eb2/DD9W/9QIqf13RZg3Ps
 zIJg==
X-Gm-Message-State: AJcUukdzI3j0NPmLt/zRsBpznPNFskF/16vEZfkhL38xh0gRW/5iWcom
 3Nr+cAiCuK3X3O18oEKRMlGSXQ==
X-Google-Smtp-Source: ALg8bN7qCWn/ViMIVnXJ1q67toJGgsTW8ewMP7OlvOby9t/lrnuCQtV3qoXuPoluDUv707tzxfr6vg==
X-Received: by 2002:a1c:a104:: with SMTP id k4mr14994971wme.54.1547809092789; 
 Fri, 18 Jan 2019 02:58:12 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-20-152.w90-86.abo.wanadoo.fr. [90.86.223.152])
 by smtp.gmail.com with ESMTPSA id y13sm65345467wrn.73.2019.01.18.02.58.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 02:58:12 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: keescook@chromium.org
Subject: [PATCH 1/2] gcc-plugins: arm_ssp_per_task_plugin: sign extend the SP
 mask
Date: Fri, 18 Jan 2019 11:58:06 +0100
Message-Id: <20190118105807.26425-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
References: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_025814_620487_42CDD7CE 
X-CRM114-Status: GOOD (  12.11  )
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
Cc: Kugan Vivekanandarajah <kugan.vivekanandarajah@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 re.emese@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The ARM per-task stack protector GCC plugin hits an assert in
the compiler in some case, due to the fact the the SP mask
expression is not sign-extended as it should be. So fix that.

Suggested-by: Kugan Vivekanandarajah <kugan.vivekanandarajah@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
index de70b8470971..a65fbefb8501 100644
--- a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
+++ b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
@@ -13,7 +13,7 @@ static unsigned int arm_pertask_ssp_rtl_execute(void)
 	for (insn = get_insns(); insn; insn = NEXT_INSN(insn)) {
 		const char *sym;
 		rtx body;
-		rtx masked_sp;
+		rtx mask, masked_sp;
 
 		/*
 		 * Find a SET insn involving a SYMBOL_REF to __stack_chk_guard
@@ -33,12 +33,13 @@ static unsigned int arm_pertask_ssp_rtl_execute(void)
 		 * produces the address of the copy of the stack canary value
 		 * stored in struct thread_info
 		 */
+		mask = GEN_INT(sext_hwi(sp_mask, GET_MODE_PRECISION(Pmode)));
 		masked_sp = gen_reg_rtx(Pmode);
 
 		emit_insn_before(gen_rtx_SET(masked_sp,
 					     gen_rtx_AND(Pmode,
 							 stack_pointer_rtx,
-							 GEN_INT(sp_mask))),
+							 mask)),
 				 insn);
 
 		SET_SRC(body) = gen_rtx_PLUS(Pmode, masked_sp,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
