Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06297C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:35:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926EC204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uDKjbo5c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TJT/skcD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGftW56v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926EC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=apHTRZYUhfJwLAjm25z15jUXDZlD2OEWU7ogdkmF/BM=; b=uDKjbo5cXUzP4+
	rn5iKuKYalkMGl3/88ttmpVOfV+lj0tIS6a3Ah63P0fShTF4DNMLZdtCxPrUOZSKPzzOrgWL8Nbjf
	in4nHtaXKqAHRNQXEQtLothJ2CLZjfSTLFBxMfNpJEXGO4tQeB/TZKG3zycvQvmOx50gU4b5spkYj
	Tsj3qTVFRDSv41ONB3evCfpHAbjkFqhimxlNiUgM/ugmhGjnssYW8pZS2Y3raV6IyP28esuvCZQSl
	A0B4QcgD7Ig3aciGCziZ3wzTh9IsfcAx3q6gtmy28rz86RTktOCo1tX/U+TtVZrfHL4Q1pvCoSjn+
	/0h+H5TV6i2LYKW/0aLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOWk-0007QN-MN; Mon, 10 Dec 2018 16:35:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOWG-0005Qq-JI
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 16:34:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kE4etmnaKc8CCIMM9+iM09mAtFODRJgioPwD7J8rFyY=; b=TJT/skcD8xG8SCz2vNIztExlPC
 WblXEGV0yoGvOG38DQ6ioN82iq84g7W5b5us120UdSX/bSgEKzzwxnQ0O+Cmi2EfA4OAOtb31gUOj
 Caz0ywbvuu6rejQSiNW4Yn7YbsGlgYxgtTwLpxGihHqPFpLdnggnN6wWVy7HtMPyyG+qxB6r+YvtT
 qDcDbd3+nmRs11jHmUqK6TU+p7F/89kFGuAnQsunq/HZF/QT4ZoIP/YgZtYVFcSN++UWW8rR6+6Kl
 8KXZRBsc9h6UCXZIi9Q1OtgMNAujGiD0kNE4xm6WkrnH8lh2rJjMZDyFVYSoI0RxkH6L4rSJRxoyC
 ehbdTh/A==;
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWORs-0007ug-BI
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:30:30 +0000
Received: by mail-wm1-x343.google.com with SMTP id y185so7013610wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kE4etmnaKc8CCIMM9+iM09mAtFODRJgioPwD7J8rFyY=;
 b=kGftW56vjloq6Y0dVHgc8CtAts8HfPfrLBUKacWoBdG3Y7/PfpzvSAgiOrvyWIx6Xu
 K3X+SlNfuLAeD2hdqujTb9clgYV0PxYlwM5hT2RKLio3q+lW1y67NnsZ09KVt8dlSmau
 cufd7hNV1IzYU2mGjMclwODYnheS+OyqgOfXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kE4etmnaKc8CCIMM9+iM09mAtFODRJgioPwD7J8rFyY=;
 b=IdWowgHoLMHJVlyGoyv6Cm6dJRiBcBxenHyOBdOqtz7ZeFFdMx3Ubp3Iqr4DJoUaFR
 VhgTKHcK32Ik0wJ5qbFIPVgwQYnnlBJHLHFj9wzmZqcCX2W4rl+epEDwbbPV36g2R27Q
 KyziZ2XCc4y2lSEgrkklcOA5EvgLRNVIaZfqomc8COU3+s0XkkBh1w8skWnYMirGnHsr
 Cr5aMjiv4cG+hqtumuf8C22GyACde5LCnYkJ0+MpQZSmN9+rR7yxXQbdhMRkMXvBuX88
 xw7XuZDgYfmMYICSD1zzdjZ5XyDrZJQCRGldYFQNTtURUjcTeN/hIV8SQWQpzKxSUMB/
 9MvA==
X-Gm-Message-State: AA+aEWYlznU9aa90Z9GHXiyiuRB+/nfl9NoVIDfJeRQTmsbNfeiHz/zJ
 FWd7pCIXSFcYFUXnubchFbrZ4Psrp/uRtg==
X-Google-Smtp-Source: AFSGD/WCRvfYj+g/qb+cZqfqE6T37r8F6JoAwJfp2zcd7jNhC1+VkHzxf0Cu9qWpZ99oC0dosF3dmw==
X-Received: by 2002:a1c:a84f:: with SMTP id r76mr11290195wme.16.1544459410911; 
 Mon, 10 Dec 2018 08:30:10 -0800 (PST)
Received: from localhost.localdomain
 (astlambert-681-1-52-199.w90-86.abo.wanadoo.fr. [90.86.17.199])
 by smtp.gmail.com with ESMTPSA id i186sm3480531wmd.19.2018.12.10.08.30.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:30:10 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] ARM: re-enable EFI persistent memory reservations
Date: Mon, 10 Dec 2018 17:29:45 +0100
Message-Id: <20181210162949.8597-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_163024_391778_E0477F7C 
X-CRM114-Status: GOOD (  11.59  )
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

The EFI persistent memory reservations introduced during the v4.20
merge window had some teething issue, and we ended up disabling it
temporarily for 32-bit ARM due to the fact that the needed changes
were not as straightforward as on arm64.

So this series fixes the issues, and re-enables the feature for
32-bit ARM.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>

Ard Biesheuvel (4):
  ARM: mm: permit memblock resizing right after mapping the linear
    region
  ARM: mm: permit early_memremap() to be used in paging_init()
  efi/arm: apply persistent memory reservations during paging_init()
  efi/arm: re-enable the memreserve table for 32-bit ARM

 arch/arm/kernel/setup.c                 | 2 --
 arch/arm/mm/init.c                      | 1 -
 arch/arm/mm/mmu.c                       | 5 +++++
 drivers/firmware/efi/libstub/arm-stub.c | 3 ---
 4 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
