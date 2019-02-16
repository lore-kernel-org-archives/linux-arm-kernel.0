Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B68C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:51:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE1F21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvwqfx//";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5tzB3hB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE1F21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QWYvdx6XBiBh8MnQS8T4jcnJKRVdevaQAAlNEhqOy0M=; b=cvwqfx//Mi0ax2
	sT43J14vFOgTRojpBZdYMG9GUHCusxsdy5plUW63ja4uzkJ2ZJaMteAWguetDoeKxBosu1lcufZkX
	GpH25iY/jgOlqmzWGfIL0N/+cTzqzrdPnoo5rb43stpA+3yOOa48yy11jqJbiP4HZqO8XL49KK8jJ
	fgb6O4Hf1UjAhDrvXcTgoCoakPGt32k+FFezsn4aAEkCWUjfyHXhuqyQ8kbiIQhkRIHJ+gjDRpd7V
	L0fHVNjQuBRXYJNPDPzVu8rvLHPo2EHCmQVo6A47XmY/tB4fcEyzBJPU64siZ2IuXVnQwmPrzGzUA
	T0n6gg9ynvEhKISkYFBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv0Nd-0003VQ-00; Sat, 16 Feb 2019 13:51:45 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv0NT-0003Oi-Uy
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 13:51:37 +0000
Received: by mail-wr1-x444.google.com with SMTP id n2so1048665wrw.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 05:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RESib+cEp4bIRrM/kzeVXaWtLnzhI8Y3cyzDLEEl3lI=;
 b=n5tzB3hBZb430T2F0yA9BA+jPcPidtJVAsM7Vo+8MqIyYmdUeUx59V27Vt9zmKihUH
 gZKo6ch2P/j1CW093hnOE1ezd3lgVe6d+JgSVjhHbXXT7EkSsV/7K+1mQx+znc7cTWym
 e36vJO+KWe2DWmFAvvle4IAfWHz8XptMWp3jpiiR2BtzaRSFuGXKl5mpGt3tPHBzH0/z
 HV/7acmkF/32SlzN/Bw/h4CfKfjQlYzPHDmYx63bulM43egJH3n2+8eLswMiIyvjSEnt
 LWHSy/kKLUjvFHNJNS0OP1yyh4osL2Ljd/sJlGXGO/aRDeatN5pz62J2iJ/7FOJXVxXc
 f5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RESib+cEp4bIRrM/kzeVXaWtLnzhI8Y3cyzDLEEl3lI=;
 b=fKEJNJJLufAl6u7hE7RKntfPngAPliNYySbBwscmfHg3xO2lltVy+K6Ih5p4RbqxLk
 /N4P9WPMQcpJhWyqykbzrBwTPj+obLltTNyXIDKhOaLmx8vGIED0Up7KzJmPVaBYarLs
 +i+XeyFNErea7WG2nBE0lArNZnYP4FU7dx1HHGGPCgj/2jene7xmBH6Te9ZbvehUwSwa
 5y28MND2nvOeg2TcykOw+Ivv+bnLKM4P3v7SJaIix2jgP2DwH5PNi8h+BEz8Q32+SXJU
 MvbNzPrfs6UBdNOZsArUT/6Ls4hDdizJVwQqcw7rEj+C/f8/jIdI4sxq2AHryxQumuzA
 dE3g==
X-Gm-Message-State: AHQUAubpmMeZ+XAsIWIA0q13Z961kUodZ30oQAVMTv2gCkW2DJi4epaq
 jq/pG2xx8b7dUnuFk+Gx2X/lsQ==
X-Google-Smtp-Source: AHgI3Iaj061jqNqS1nvqWUy+tbExwpm1La83V9JdcTlXI0oov7gcNHZxlhXJ30SZz6MZZ1LWE8BpVw==
X-Received: by 2002:a5d:6b05:: with SMTP id v5mr11329429wrw.76.1550325093889; 
 Sat, 16 Feb 2019 05:51:33 -0800 (PST)
Received: from sudo.home ([2a01:cb1d:112:6f00:8ee:778e:6c2d:d201])
 by smtp.gmail.com with ESMTPSA id z17sm7452339wrs.75.2019.02.16.05.51.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 16 Feb 2019 05:51:32 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 1/2] crypto: sha256/arm - fix crash bug in Thumb2 build
Date: Sat, 16 Feb 2019 14:51:25 +0100
Message-Id: <20190216135126.17290-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190216135126.17290-1-ard.biesheuvel@linaro.org>
References: <20190216135126.17290-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_055135_995977_B1B33136 
X-CRM114-Status: GOOD (  15.97  )
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
Cc: ebiggers@kernel.org, herbert@gondor.apana.org.au,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The SHA256 code we adopted from the OpenSSL project uses a rather
peculiar way to take the address of the round constant table: it
takes the address of the sha256_block_data_order() routine, and
substracts a constant known quantity to arrive at the base of the
table, which is emitted by the same assembler code right before
the routine's entry point.

However, recent versions of binutils have helpfully changed the
behavior of references emitted via an ADR instruction when running
in Thumb2 mode: it now takes the Thumb execution mode bit into
account, which is bit 0 af the address. This means the produced
table address also has bit 0 set, and so we end up with an address
value pointing 1 byte past the start of the table, which results
in crashes such as

  Unable to handle kernel paging request at virtual address bf825000
  pgd = 42f44b11
  [bf825000] *pgd=80000040206003, *pmd=5f1bd003, *pte=00000000
  Internal error: Oops: 207 [#1] PREEMPT SMP THUMB2
  Modules linked in: sha256_arm(+) sha1_arm_ce sha1_arm ...
  CPU: 7 PID: 396 Comm: cryptomgr_test Not tainted 5.0.0-rc6+ #144
  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
  PC is at sha256_block_data_order+0xaaa/0xb30 [sha256_arm]
  LR is at __this_module+0x17fd/0xffffe800 [sha256_arm]
  pc : [<bf820bca>]    lr : [<bf824ffd>]    psr: 800b0033
  sp : ebc8bbe8  ip : faaabe1c  fp : 2fdd3433
  r10: 4c5f1692  r9 : e43037df  r8 : b04b0a5a
  r7 : c369d722  r6 : 39c3693e  r5 : 7a013189  r4 : 1580d26b
  r3 : 8762a9b0  r2 : eea9c2cd  r1 : 3e9ab536  r0 : 1dea4ae7
  Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment user
  Control: 70c5383d  Table: 6b8467c0  DAC: dbadc0de
  Process cryptomgr_test (pid: 396, stack limit = 0x69e1fe23)
  Stack: (0xebc8bbe8 to 0xebc8c000)
  ...
  unwind: Unknown symbol address bf820bca
  unwind: Index not found bf820bca
  Code: 441a ea80 40f9 440a (f85e) 3b04
  ---[ end trace e560cce92700ef8a ]---

Given that this affects older kernels as well, in case they are built
with a recent toolchain, apply a minimal backportable fix, which is
to emit another non-code label at the start of the routine, and
reference that instead. (This is similar to the current upstream state
of this file in OpenSSL)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/sha256-armv4.pl       | 3 ++-
 arch/arm/crypto/sha256-core.S_shipped | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/crypto/sha256-armv4.pl b/arch/arm/crypto/sha256-armv4.pl
index b9ec44060ed3..a03cf4dfb781 100644
--- a/arch/arm/crypto/sha256-armv4.pl
+++ b/arch/arm/crypto/sha256-armv4.pl
@@ -212,10 +212,11 @@ K256:
 .global	sha256_block_data_order
 .type	sha256_block_data_order,%function
 sha256_block_data_order:
+.Lsha256_block_data_order:
 #if __ARM_ARCH__<7
 	sub	r3,pc,#8		@ sha256_block_data_order
 #else
-	adr	r3,sha256_block_data_order
+	adr	r3,.Lsha256_block_data_order
 #endif
 #if __ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
 	ldr	r12,.LOPENSSL_armcap
diff --git a/arch/arm/crypto/sha256-core.S_shipped b/arch/arm/crypto/sha256-core.S_shipped
index 3b58300d611c..054aae0edfce 100644
--- a/arch/arm/crypto/sha256-core.S_shipped
+++ b/arch/arm/crypto/sha256-core.S_shipped
@@ -93,10 +93,11 @@ K256:
 .global	sha256_block_data_order
 .type	sha256_block_data_order,%function
 sha256_block_data_order:
+.Lsha256_block_data_order:
 #if __ARM_ARCH__<7
 	sub	r3,pc,#8		@ sha256_block_data_order
 #else
-	adr	r3,sha256_block_data_order
+	adr	r3,.Lsha256_block_data_order
 #endif
 #if __ARM_MAX_ARCH__>=7 && !defined(__KERNEL__)
 	ldr	r12,.LOPENSSL_armcap
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
