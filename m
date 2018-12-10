Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A93BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202FF20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MA7o9QDe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yDImZfCI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKY3AgxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202FF20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FWF+sBomPRIXok+ZFtOtNGCwy9Y33ZG/y9xSMkdB/RM=; b=MA7o9QDeJvp9lX
	el9GwsYaGd3OYYvryCG1h24zvD+SAygR2eGB+r/7S6L6jEo4ZX+W8YY3pBwFI9jKgufisEtMT/kgw
	yQfi+oondAdXsR+oYoS1mxRmfws3nUqR/J2NulsLRGlJ04eKo1syJEco2MpBRyWhBJWoTRGTA3WZo
	qR3jZG7YM6WMsC6uYMafkhMhCZQUoAcj12UTp7zhR1Sw/NAT8OL28QBA2o4od5i52zSVZvwYstGA9
	hvNC1KB9QFnfaOls8Sk/jclj39E5ibXNJt79A4AK7v6bkpmLpQyh+VfN8SJhLcXEdivuB8xpsDNbn
	xYwa4qO2tTx/jPHHFiwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOTo-0004dX-4N; Mon, 10 Dec 2018 16:32:24 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWORy-0002sP-I0
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 16:30:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lz9cl2063s35V8iKDCeCGlB15ecDD/QJENBVOnRhRaw=; b=yDImZfCI3tnby8cjvZy8vzbX5N
 bqn54vViz5ODgDzCb4WdkCGGPeASsPbItNFi9RszrKgcF4QZ1VxkUt1XcoCaLT5san/slgaOQvqId
 /Vl7rvu1FrVhJT24pT5rsTvFNKhCDMyOrgzI3etyotOWVGmHsvoxwrbaKlN1/VrFP9OFf1Q8W7z7v
 QVPlnklhwjO+nHfYrAh3gZhj2lLK84Ceg2rSMKXI74mgFrEzuRsO36t/MOSqC+EIi34Bhof8bzFhQ
 7tShh3ZKhW2nzNT+uZtSGFbErXmcLFDcub5MdAtmhDw8CFc5muwz/qOA2rvdIBwAqE7WKQPR+zOLc
 VpovXX9w==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWORw-00051Y-F3
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:30:29 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so11086244wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lz9cl2063s35V8iKDCeCGlB15ecDD/QJENBVOnRhRaw=;
 b=iKY3AgxNBVgdUBQYyW2FEBFqU10aU92NdgP+jq7/Q6tVFD7yMTboJvZ5KCTd6P40d5
 VDzyKlyl/7lc5JBrRycE/il7YzRjaoAt7hB5IPlhe0VRn4D/rhS8OeRYmpu2wMWIIHKH
 cl/S/LQyyDr6ig3mdbCYgVzbAE1tmPXsTMWGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lz9cl2063s35V8iKDCeCGlB15ecDD/QJENBVOnRhRaw=;
 b=cpfj46QuDBmrM+CUjFHJejzxfGT7ZvBlEtAYQzHMFaU/zial8nlLk2zRtZys6CHy4R
 tsqjlTGrRy0t6HM+5o4e5sz43yhM9zrUyyCQShClPUV4hoklgzlCwejZzo26kfAVgaTe
 /gZCbJKM7ntaHBSluxUCRxQpEnAGEwN4QNchFCW+PIe2pQj5XsM5MrmhtqgGiZA5uNtK
 5GsAwBrVYdp4qYFunp3HbLmdNf7IrJGu8hjKexBfDVxNWYKSsDCDgROokwxJLyN3N+NK
 yE8kDX+CgEMmNWwJip0i7Iutq9YM7Oagm5EdIFFJ/n0f+dBzB2XME3inX4rBRvwVTmXu
 7FSA==
X-Gm-Message-State: AA+aEWawz60NNZF5Ik3vtS7Bh8zXD5PaTUH6JUH6zMJIa55m0RY3SYHo
 WiDpVVcwGJeDrETMAgJr65OclbKBql07LQ==
X-Google-Smtp-Source: AFSGD/VsdXJVVR7EkXzW8eu00TwcRMZ+tLuwkTqZVeqZ4AW1V8T9F9ftigoSjIA2Ln7QBlml5zI20Q==
X-Received: by 2002:adf:b6a1:: with SMTP id j33mr10493657wre.55.1544459416126; 
 Mon, 10 Dec 2018 08:30:16 -0800 (PST)
Received: from localhost.localdomain
 (astlambert-681-1-52-199.w90-86.abo.wanadoo.fr. [90.86.17.199])
 by smtp.gmail.com with ESMTPSA id i186sm3480531wmd.19.2018.12.10.08.30.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:30:15 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] efi/arm: re-enable the memreserve table for 32-bit ARM
Date: Mon, 10 Dec 2018 17:29:49 +0100
Message-Id: <20181210162949.8597-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210162949.8597-1-ard.biesheuvel@linaro.org>
References: <20181210162949.8597-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_113028_519672_BB2135E0 
X-CRM114-Status: GOOD (  12.04  )
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

Now that we have readded the call to efi_apply_persistent_mem_reservations
in the 32-bit ARM boot path in a place where potentially creating
many memblock reservations is permissible, re-enable the MEMRESERVE
table in the 32-bit ARM EFI stub. This brings ARM back in line with
arm64 in terms of support for efi_mem_reserve_persistent().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/arm-stub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 3d36142cf812..30ac0c975f8a 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -75,9 +75,6 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
 	efi_status_t status;
 
-	if (IS_ENABLED(CONFIG_ARM))
-		return;
-
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
 				(void **)&rsv);
 	if (status != EFI_SUCCESS) {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
