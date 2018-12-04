Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:32:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA92C214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 02:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P23my4tL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zPraIrN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA92C214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9rtaaxa+T/e3mE16DsnrQXaaNRQ2pEbcgeuVXUENXMI=; b=P23my4tLgHH7Ix
	eymrfYQueWyYc/8ydlELNZelTLpw3LdPDBdM1hJoQLynR1VRLV+latkQd1KcFIni6ArtEzPFZ0zxV
	ayv3o79TCN3qMmaK5QKJIaYTVWlI0Aq/zpQdXqXg0DSYjXDLirQidOFkF41lYqqxxEcVlbHguZhuM
	IzZEykMlSNnkJD1vgl7oFzZ6vrNJ2lpdoimi/vRhXDxunWcFlntcqIrpEYMgnQqkWRHcqv2oNg1Je
	tiSs8eXkutnOOABKtoe1mOXIWNYSK0o51EMuOaNafNgWOWMLV+CZ2ptZ1FfHjpVNYN/itAGiv9I8+
	11qFIv6UxDwfRCHiT5+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU0VV-0003aq-Dw; Tue, 04 Dec 2018 02:32:17 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU0Us-0002kS-6o
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 02:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q0DM+2EA8yZwSVf5Ecy3pj6EhOMMwbV+nNL+1UVyo7U=; b=zPraIrN65wmDY1OIv8Fpx2zYWF
 C4jPi+R8f7QRKYHxmyx0EQxG8IIls7WgJ/nTXb1OpQ5G/R6juG2PLWB4m1n3bCNZHUZKrpUnXjfaX
 mew+2zpKmc1hreRmRpzL/9dygJXN7OV9FIaBSQQebIRxM/VWDePgH0FoI9Ggo0aNhty9UhYbUZjOB
 tYmvdc5wVKYlO2uPxI5SrrMqjSR44enVIFWo6yqWDZ9nYwHb5AeOGRZ6wEOmRpXo4GXD/hLTnjRi4
 wxAGQ2IBUddZFoFKPImN7OTZs1waOeXyXC64LoIU9NwiBRa7u0RnqEhue5CZQhiCNuQEbcpV/LaQ2
 4WXBVkTQ==;
Received: from smtpbgau2.qq.com ([54.206.34.216])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTzl8-0004rS-FT
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 01:44:24 +0000
X-QQ-mid: bizesmtp20t1543887820tyf77hx2
Received: from Macbook.pro (unknown [210.22.22.130])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 04 Dec 2018 09:43:40 +0800 (CST)
X-QQ-SSF: 01400000002000F0FL51B00A0000000
X-QQ-FEAT: Ngtn/3KK5eqQH0wmonB9HmbmCTviEUv0aKolIF3J+RmcBenNIfXy4X133KqYr
 di0Ut7Y6gOQd3edGuY9ksmrg5gEn4rwW9XWUvaWPUUhvApZJVYxZcSc5VN8WMkA8akuaPY5
 pJIs6cCc4c/qWico5QuKZcTsNcnYeX0wq5WpHwww1vEL1u5jNlJpYbn3PRQl05D5IFp/qVp
 7uezWaKldk7+1bKYY8sroPSV0xBxi0Of95YfDpbR5m1Zga2Zj6TdCEfPjPTwomGxO5xyGgB
 e4FBf7aiB5l/Q556qZqnXSBEc=
X-QQ-GoodBg: 2
From: Jackie Liu <liuyun01@kylinos.cn>
To: will.deacon@arm.com
Subject: [PATCH v6 0/2] arm64: provide a NEON-accelerated XOR algorithm
 extension
Date: Tue,  4 Dec 2018 09:43:21 +0800
Message-Id: <20181204014323.1438-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_204423_434423_4EF38C9F 
X-CRM114-Status: UNSURE (   7.27  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-block@vger.kernel.org, catalin.marinas@arm.com,
 Jackie Liu <liuyun01@kylinos.cn>, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

v6:
  neon-intrinsics.h: change _NEON_INTRINSICS_H to __ASM_NEON_INTRINSICS_H.
  neon-intrinsics.h: add header LICENSE declaration
  neon-intrinsics.h: explain part of the code with comments

Jackie Liu (2):
  arm64/neon: add workaround for ambiguous C99 stdint.h types
  arm64: crypto: add NEON accelerated XOR implementation

 arch/arm64/include/asm/Kbuild            |   1 -
 arch/arm64/include/asm/neon-intrinsics.h |  39 +++++++
 arch/arm64/include/asm/xor.h             |  73 ++++++++++++
 arch/arm64/lib/Makefile                  |   6 +
 arch/arm64/lib/xor-neon.c                | 184 +++++++++++++++++++++++++++++++
 5 files changed, 302 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/neon-intrinsics.h
 create mode 100644 arch/arm64/include/asm/xor.h
 create mode 100644 arch/arm64/lib/xor-neon.c

-- 
2.7.4




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
