Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E894DC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:29:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AA42075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QhfyXHKI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tgVc5Dv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AA42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SjmJ/vr+R/T04ux/uZKC2DyQgfkATSOi1LWE5JIHfU4=; b=QhfyXHKIACaP6F
	w6Rwrrdov14JTlndnvHq+uun1WYLJVceESH96dvxSMyubX+ThuLf9n+e/zCuHJsdaB4gmFy20U2Wv
	025kk1gZthYRY+fzrrkEqjM87d5ZHb9/aqev7JgVuGVM3b+utz9hfeSNbSV7OlecKbzpb3GFpydT+
	NKPUFPm/pk7osncONs+Bup/Ya1/luyrN9DRxJQSt5D7krekVDFd8NheSrSueYnqaZJfo0fG8XGr/A
	+iT8quAkizq3mo4uCmSt3LzwBjEyeLqGDvKkXOhMNIkhXhXvrZwRfgdjqMcCNe38dbgGiK27CVFLj
	/kueZDhETZ4D9GNt2txg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtubU-0006VX-QS; Wed, 13 Feb 2019 13:29:32 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuab-0005O8-1V
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:29:07 +0000
Received: by mail-wm1-x344.google.com with SMTP id x7so2448118wmj.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i9o4DqUCQ064zKrRPoul8NXb1+SU7ZbGoV/daMhaY58=;
 b=tgVc5Dv4hEY7lyna2aHflwOA9joGrHmxd55hgh+/uuhjS7gWqrqjSkWdyP+M143eX3
 SBC8zBIfywCN6VLopKgXomVIs72byMXJp+XP9OAtco2ywcTP0ni5mYCWQPgT0qXxr5v2
 vcytiKa3zIBFA6O7PGeSp3E8NNQ4k+H7lraE32wzJjDYBu15hC36WKs299XkUTWasvj5
 T9rRbhmCFDj9kkXXlshKD8fsH/OVTbEAowv/5FtqxWGEHy9fLkEU2JebUlznGysWaGvv
 XMDL3AcjMoXz7tlTUOtLCZ+lMaaVchm2L85g1hLaN+1jyeEVJLapNSfO7xqxnKJmggz+
 mhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i9o4DqUCQ064zKrRPoul8NXb1+SU7ZbGoV/daMhaY58=;
 b=m0Oxie8XCnBx8T+CQJyOfeMo1++beBtZ60mV1Xi/8SITrymE1B0nb3TImcsxeSJ08g
 bUFUQvytzuzDNS8BnW5yeZdKqZ6HZSxXxbr5JcRknncn3TMOH3ocaon5u1ERxM0XILKD
 NLzBfB6Vp5egYcAafVWV6RJpS9peXwWIejog77EmjkIJeu5QodkXBFtqaRyWMqtrqVbi
 d70pnDAZaomG2GKDamJoDqU+LKM3Y6OaDqBpVbU8M7AeZ6gl9OknHhoB55CJHhqzf9xa
 BqCJ/u2ExEqRl5cx5ziPk5Kr8oysG3qwJ18XiugbYRgNLk8L8PorSvWz1qP4Agav8a9x
 2D0Q==
X-Gm-Message-State: AHQUAuZWBndohdeaxlBegXtPi/bYug4KS47IuG8cgXvvWfMeEikUZhiH
 BPXEtmuycDjEpBke/6FkvHchNw==
X-Google-Smtp-Source: AHgI3IYOYShdNWrBo9WLCcQPQjNJDR5XjZyTSju6bLJMQfS4QoGxCSwl4eBKNPTRseXx+ON3/FIk3A==
X-Received: by 2002:a1c:a941:: with SMTP id s62mr361881wme.16.1550064515364;
 Wed, 13 Feb 2019 05:28:35 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-27-200.w90-86.abo.wanadoo.fr. [90.86.252.200])
 by smtp.gmail.com with ESMTPSA id x3sm22841195wrd.19.2019.02.13.05.28.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 05:28:34 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH 0/2] efi/arm/gicv3: implement fix for memory reservation issue
Date: Wed, 13 Feb 2019 14:27:36 +0100
Message-Id: <20190213132738.10294-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_052837_903455_6188F628 
X-CRM114-Status: GOOD (  12.54  )
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
 Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
 James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Another attempt at fixing the chicked-and-egg issue where the number of
memblock reservations for GICv3 LPI tables overflow the statically
allocated table, and reallocating it involves allocating memory pages
that may turn out to be the ones we were attempting to reserve in the
first place.

If this is accepted as an appropriate fix, something similar should be
backported to v4.19 as well, although there, we'll need to increase the
memblock reservation table size even more, given that it lacks a later
optimization to the EFI memreserve code to merge the linked list entries.

Cc: Catalin Marinas <catalin.marinas@arm.com> 
Cc: Will Deacon <will.deacon@arm.com> 
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com> 
Cc: James Morse <james.morse@arm.com>
Cc: linux-mm@kvack.org 

Ard Biesheuvel (2):
  arm64: account for GICv3 LPI tables in static memblock reserve table
  efi/arm: Revert "Defer persistent reservations until after
    paging_init()"

 arch/arm64/include/asm/memory.h         | 11 +++++++++++
 arch/arm64/kernel/setup.c               |  1 -
 drivers/firmware/efi/efi.c              |  4 ----
 drivers/firmware/efi/libstub/arm-stub.c |  3 ---
 include/linux/efi.h                     |  7 -------
 include/linux/memblock.h                |  3 ---
 mm/memblock.c                           | 10 ++++++++--
 7 files changed, 19 insertions(+), 20 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
