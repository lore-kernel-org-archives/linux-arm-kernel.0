Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDCCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:17:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D3E218DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="My0vv9zM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpmR2Lan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D3E218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yA/F9V8kuCN98Vyr8kyahjD2OCBAAoYeQLBh7w/pJUQ=; b=My0vv9zMsk1FVK
	G3vI7jt92H0VYxDOdsEGDtvyJ4a7bJTYOopS3j9uufRl4eeRqWmQK8NYp6rH+Yzjgd6CTgkAEEz6n
	3/HGNn0zo2fQuk8wndnLldwiPwuPI/IPpWKRXf0IM3/mUjSg8TxLwl6XZeBCR4/rWPx9I1B/ZZjm0
	l3Oym2f5MGbAexF//KmqTBxz1+i9BUAQYpKw01GTmWEEmmUrw0xJ4GZVxdn2bCGfBf03fhaQJVrKm
	MPP4EXhYfss+i5cNDOSxg2KoiCXG56C0We72Be9uLkBb7Vu97yqrfdQoJ7f9y0q/H/XtOoBpY8t9B
	ZaVaD65U+nCqa8VYK9Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCDl-0002uK-B1; Thu, 31 Jan 2019 13:17:33 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCDi-0002tj-E6
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:17:31 +0000
Received: by mail-wr1-x442.google.com with SMTP id p4so3232593wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LokwCnM6QH5K+j/Y/3/ofxT7riLCnmRvfzQjNzPJiu8=;
 b=NpmR2LanJI3qZ8C2bmuFEfa322o9WydkZ4DiCnoMnNW6pLz+V6+9O2NBLi/SIf5ft2
 4qF5dSuGEI19RPY/y7flTbQHbZyxD4v8iWreVzHs3v23P3RJ7lmefB8gGBWZX7BgqwjG
 6Z4xnhQ0JUxapKTekTqi79eWC8nhGbm5dkKX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LokwCnM6QH5K+j/Y/3/ofxT7riLCnmRvfzQjNzPJiu8=;
 b=IGOBuJUrvgvSCzFpsRkL++xbXl+j9JGqeomgGrqKtiDzdBFhWmeZI7ejCLelzIlf4t
 riekKkPP5GuygtyV+lK76EnYCI5ZpSeheD9UYb9HE8WYfPfIbVbijBQ//k52jdqdIXgg
 N0B3D3HU4ykrKD7TuXm+OQkYBpWMfm+vc/bYfHMcmKyyZXdZXngYumNezvnHeFyRN8ak
 gE4NBY1tG2Pyuz11kjvWXkOVttCri0LM1djFXWRxHHalX+WmWt+qOFrbPuxS/ilLc0dC
 rEHHZ/ql7Za4E8QjhIES5jnOPUugj3sI5BzdTa/YcFVJW09+M+PBVi7iJNbr8oArpNch
 Rt/A==
X-Gm-Message-State: AJcUukfEmOIY6hgy+hDf6+4+oYEeUHDb5h8AfHafVjwBCNs54wrLQBBp
 zEI4yoYdsXfeoQNVAp39Ps9ecznE4Nc=
X-Google-Smtp-Source: ALg8bN4FCbPIrkkjoKhDjCuim1t36nDDQ5xS3R99F8Cp1jkduVr5c8GT2PQTS4b6ISoKdN8Cr8cdKw==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr33427071wrv.161.1548940648346; 
 Thu, 31 Jan 2019 05:17:28 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id d16sm3211495wru.52.2019.01.31.05.17.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:17:27 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] arm64: kvm: cache ID register trapping
Date: Thu, 31 Jan 2019 14:17:16 +0100
Message-Id: <20190131131718.1627-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_051730_473633_ED7B455B 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: marc.zyngier@arm.com, christoffer.dall@arm.com, Suzuki.Poulose@arm.com,
 kvmarm@lists.cs.columbia.edu, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While looking into whether we could report the cache geometry as 1 set
and 1 way so that the ARM kernel doesn't stall for 13 seconds at boot,
I noticed that we don't expose the sanitised version of CTR_EL0 to guests,
so I fixed that first (#1)

Since that gives us most of the groundwork for overriding the cache
geometry, it is a fairly trivial change (#2) to clear the set/way
fields in the CCSIDR register so that it describes 1 set and 1 way.

Changes since v1:
- fix incorrect mask value (#2)
- make trapping conditional on whether either of the issues is being
  worked around, and it disabled otherwise
- add Christoffer's ack

Cc: Suzuki.Poulose@arm.com
Cc: marc.zyngier@arm.com
Cc: christoffer.dall@arm.com

Ard Biesheuvel (2):
  arm64: kvm: expose sanitised cache type register to guest
  arm64: kvm: describe data or unified caches as having 1 set and 1 way

 arch/arm64/include/asm/kvm_emulate.h |  4 ++
 arch/arm64/include/asm/sysreg.h      |  1 +
 arch/arm64/kvm/sys_regs.c            | 74 +++++++++++++++++++-
 3 files changed, 77 insertions(+), 2 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
