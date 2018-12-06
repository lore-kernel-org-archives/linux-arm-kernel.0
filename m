Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5C7C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B600214DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VvWIqqIv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cikb10eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B600214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BGr3awI7IZ3MFS/SyWaDOzNob9olVvV+AHlqcz5Vokw=; b=VvWIqqIvPgLclT
	KYU6DHfTatHWsjR6R79VnQGz+r5vINaCSXHSDOOhEyPcFCmCQgcqV0JVC2hQWmAPCQ7l9HgA62h7C
	0QrVbWgttBVkGfc4TGbll/bPvrgxe5pGheMGUzDk72+JCoPsrxWbr4F2FDjwkfthjGh6E2mqMRoEo
	nRX9MQXcL5OVzNUU7O+wcWOR2fiuv2likeZGlN1n68ttK6wWBzSynvFMqlWYc1Iw3/hrCStiC2n6a
	hinKrg+AIMGoQq9vwd+YrtiIWzupmG+zavY0WTqitKsbRnJogm+UttcvqzuBvIk70s0aKGBYrvRXt
	YRfFfWQ61DvU7Z/kDPRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw4w-0005CT-NM; Thu, 06 Dec 2018 16:00:42 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw4C-0003Am-T3
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:59:59 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so985645wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EBf2ddABzNmUATNTkk2NnIWCCRz0jpWPHKnmmJ2ur1E=;
 b=cikb10eScMgEpPy7mtJP4RXIN8T1QZq9WVgYZi95AR+i7To5iS+heCKoRM9014xRYT
 Ur1lV8CjLtLPaiHFc7wRUaDcfjjrmA9TvhtO503Qjkft00Bz8qad0RgXK+dBAKCNrjXj
 FchhmDN30ABh9EurnN30vGYzRdHREgSGwqJ1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBf2ddABzNmUATNTkk2NnIWCCRz0jpWPHKnmmJ2ur1E=;
 b=WgPmXh5SIGFb1XAI2j68DflqPquRW4yaIyiJ8b8UI2pR+Rv+xjH3jYw7RCq8d2QaFf
 48jHQQJAaRU2SDnNIX0JSj2Rzk+ZyQK7GZiFbM2ai59zPDTLhAs/zUYNg1zuW32czTLh
 1n8ntbBaAssIGibMX+p/r9NE+169KVY1nIHhay5ih2WDdFBv9KjMLhNvsnjfRp04uCcM
 FxzltFZ95GRq31TTkc9OUYjU0tlIR7wAb44p3nAnU6YjscziB0pYPfrT/iy+G9z1WD2p
 jkrbDlQ5IIWwMfdPghrjTZ79Zo/LFk7D5SJRrwZ+2KiunRcWfPlMDPNntYtrkJd3hFq1
 eJfA==
X-Gm-Message-State: AA+aEWbc+epcFGLhLk1NRUOJ1TNYaOkgu/D+oOXsms/C19xP0ix3nwP2
 xGFgf1VqqdtmsVEkFGLsgCx2Tg==
X-Google-Smtp-Source: AFSGD/VhyKKwFtrwEwbxdn3T97eS4TuHFuszki85hwbAkAZOws3n+QUG/oNY3bRdVyJabPsG+BScbg==
X-Received: by 2002:adf:b201:: with SMTP id u1mr25976578wra.165.1544111985333; 
 Thu, 06 Dec 2018 07:59:45 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 07:59:44 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64/alternative_cb: add support for alternative
 sequences
Date: Thu,  6 Dec 2018 16:57:37 +0100
Message-Id: <20181206155739.20229-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075957_211919_86B7D96F 
X-CRM114-Status: GOOD (  13.26  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Permit callback type alternatives to carry a sequence of alternative
instructions, and leave it up to the callback handler to decide how
to use them.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/alternative.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 987c1514183a..6b7726ee6b0a 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -156,7 +156,7 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	.popsection
 	.pushsection .altinstr_replacement, "ax"
 663:	.word	\cb - .
-664:	.popsection
+	.popsection
 661:
 .endm
 
@@ -185,10 +185,21 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	.org	. - (662b-661b) + (664b-663b)
 .endm
 
+.macro alternative_cb_alt
+	.set .Lasm_alt_mode, 1
+	.pushsection .altinstr_replacement, "ax"
+	.org	663b + AARCH64_INSN_SIZE
+.endm
+
 /*
  * Callback-based alternative epilogue
  */
 .macro alternative_cb_end
+	.if .Lasm_alt_mode==0
+	.pushsection .altinstr_replacement, "ax"
+	.org	663b + AARCH64_INSN_SIZE
+	.endif
+664:	.popsection
 662:
 .endm
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
