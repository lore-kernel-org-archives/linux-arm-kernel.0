Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC96AC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:35:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A40F2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m+wsqIn2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ekXVIph3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlpXGQI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A40F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZpzsOrwbVLrqxv0X+4D1aTdK+faNAcqw+LRWRGaEOjY=; b=m+wsqIn27PEsyu
	U/puLBCGJzAmWd6XrrRB/3Q0EpOQ+zo1WssNlzS8/68Itx92ZI9+r1IB8iCZVWpK05IW/OvztZjZd
	EU6KegytWFv5046rrFzCTitfwD4FFb93qjTXX4MAb2/XrTTklRaKyvKrXvizuxnFBxR0TzXbYe/MI
	hgqmSnRwumiY15hyudqfUgfJTrkmrygvy96ox91t8Xt1rithDrHfZUr+7R+1RUDepgYXWQkZm045Y
	fnOiv9WLtIEFWkSOrLODJT6V4sNCfAgIudmM0TVk5S2OxjmKLSOc8sIEtbkGIcuPNSC1GMBqER8Ga
	VorY4Z+HVsZ3SvPrJlEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOWz-00081T-Fc; Mon, 10 Dec 2018 16:35:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOWH-0005Qq-Ml
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 16:34:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rtHyHcOig6NGGoyRVno2ZvIoTH+Q2JyvE0Yh0rKDZ/c=; b=ekXVIph3oNrAlR3q8IeXcptIy3
 0iy3PbtHB5Nll5iWaepzUr0X4ji0fRemz4tQAwYql8x4KJhAe1yhBsZMdhTYWf1daGQE3GWD9gI66
 3wrgal9Dr5LqkixfEfJ+OwPZkPFI46u5Yd/XlbqOV6tFu+Za5CToSrYz8RSs9059Lh3Eue0rOJKEP
 1fS85oS7N0OM7LZXihOMjxVJ6O1bXfB7BT4aMGeUlhLjosAv4+xW2eYa/BnMUa76HJh2erCN69AaL
 g86cCHALj044fa5F+PlZdoCYzRygVcWHFQ90hDg9kljSW0G63vRm3whUve64Yi/b5awHSX3HywvrA
 xTFv6KEg==;
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWORs-0007uh-BQ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:30:27 +0000
Received: by mail-wm1-x344.google.com with SMTP id s14so11646331wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rtHyHcOig6NGGoyRVno2ZvIoTH+Q2JyvE0Yh0rKDZ/c=;
 b=RlpXGQI5zX+pO6mKB5La9GZAFqjWzWgwjAlgHxZ5eSGI+wJ88kL/AecM/tkArclxKX
 LTRsRVUhaZR7aFKVNAuUz0P9+iGPR0z0lKMu9SEerkOgCruQRtPMeIirUiWeA6pNzYCP
 py703Pqpvcni7aiyG5QThfwMYbiGrma/Q3sl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rtHyHcOig6NGGoyRVno2ZvIoTH+Q2JyvE0Yh0rKDZ/c=;
 b=LMu3//KQjxbwFxRJiMPvkJPr+ERjFzYOoNi7gKzKjJ0LdSlwPBOD0ryHIglWzskoQR
 QWWWNAAqbVVX0GrAc31hs2kDVetnv24DX22GE0pgwqZV90d2BUW1VYGt1Bpg72TXsfG2
 tutrcPC9XpaSDZ/0u8W7jZlSoyDdLl4SMtLY5vnvDmalQeYzkGeIF/wdb5yqiPDR/wyM
 QRKILjvEuyBOOsYj57yXT27PQaGfBQxjsSMm4ir+PcNRyY0Xp58jOkQ/+htoM+9Y7et8
 hOk6jqklTDCUSqMWv0BPBP/SAP4eMIrLLNzNGusfdZtCwzFl/NUzRO2cjuQ8R9mDoEu4
 G4Mg==
X-Gm-Message-State: AA+aEWaxGGJLl2N9/9iUngJ6FiPVGuQBOFFg1XsWhO0RvuC12wV/O0OH
 c4+J9exRf8KoLzXs+lB0+DY6SnybgOAq9g==
X-Google-Smtp-Source: AFSGD/VWQ5pGT6C+8GWP67KTN+vmE5UJACgaGvLmqSWSmj9temyuP09VMLTgrZcbUUrEVzsqDx+LYA==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr10967763wmg.55.1544459412097; 
 Mon, 10 Dec 2018 08:30:12 -0800 (PST)
Received: from localhost.localdomain
 (astlambert-681-1-52-199.w90-86.abo.wanadoo.fr. [90.86.17.199])
 by smtp.gmail.com with ESMTPSA id i186sm3480531wmd.19.2018.12.10.08.30.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:30:11 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] ARM: mm: permit memblock resizing right after mapping the
 linear region
Date: Mon, 10 Dec 2018 17:29:46 +0100
Message-Id: <20181210162949.8597-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210162949.8597-1-ard.biesheuvel@linaro.org>
References: <20181210162949.8597-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_163024_569853_CFD5BE0F 
X-CRM114-Status: GOOD (  16.90  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-efi@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The memblock arrays can be resized dynamically if needed, but this is
only done after memblock_allow_resize() is called, since it is up to
the architecture to decide at which point doing so is possible (i.e.,
when all the memory that memblock describes is actually mapped)

ARM grants this permission in bootmem_init(), but in order for the EFI
persistent memory reservation code (which may create memblock
reservations that trigger such a dynamic resize) to be able to be called
before shutting down early fixmap (upon which the EFI code depends due
to its use of early_memremap()), we need to do this earlier.

So let's move the call to memblock_allow_resize() to right after the
point where low memory is mapped and declared as the memory limit for
memblock allocation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/mm/init.c | 1 -
 arch/arm/mm/mmu.c  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 32e4845af2b6..797fad2b16ee 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -304,7 +304,6 @@ void __init bootmem_init(void)
 {
 	unsigned long min, max_low, max_high;
 
-	memblock_allow_resize();
 	max_low = max_high = 0;
 
 	find_limits(&min, &max_low, &max_high);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f5cc1ccfea3d..f6bf6686559d 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1626,6 +1626,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 	prepare_page_table();
 	map_lowmem();
 	memblock_set_current_limit(arm_lowmem_limit);
+	memblock_allow_resize();
 	dma_contiguous_remap();
 	early_fixmap_shutdown();
 	devicemaps_init(mdesc);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
