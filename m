Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D3EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:51:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5800A21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TTMlC/R0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whdM0tjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5800A21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9iuc2rnu/RXpTemagD52KpuTZpFv4qCugKOj9eAnk3A=; b=TTMlC/R0q1q3zH
	amZOmDr3qyDmLxGImdPGaQp7eBS3ZblWe3imku2E76sh8zkNmYe6Cq0txLnBjQkSSU21tnQ7h2XJN
	AUSsbwDdA3PlZogVfnuNfEXYA+oDe35+ke/f3gdPuuPpx4lW5mCkHlx/oNZbBl4HaRQcNnbyB5bMK
	Ftp1ws1mYrzS2HlhvNGA+QpxQL7pdk2dEZ/Q2+A3EHiOYC7+IVB2mKQCs0pSCBmU5zPy0mkaJqUd9
	+hjyGzJXpZNXV4npe2oFaHCxkqr3r7M68CBASBeQFYCdfnLb2O8oCl8nOWijs8HGnDzL5rh11+ii7
	aeA3V+QSaXud7JoIzByQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv0NX-0003Pt-Hk; Sat, 16 Feb 2019 13:51:39 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv0NT-0003OY-DH
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 13:51:36 +0000
Received: by mail-wm1-x343.google.com with SMTP id v26so12395413wmh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZORToI5nt6PNzFypx/0DHWLVrDRL44b6utu7PDdTvuw=;
 b=whdM0tjclRD1wScJxqOwNYxB99LYPFcBvQ4gFrsnqwlw3WAJSlEp7zHIX8L9EiRUp3
 pAciCkaMh0GlFvPtdfKS9dEvnL2bCpZPfBwlg91Wp5ID8dn3Bvf92KuYSXeF6LmMT0M6
 mJ9s/G9pLVtqgav+KnOgw6hQxxkIL9IB/dB835nuJnc5rVA3F36Ao5qKX6qo88zqvMjM
 CVFXMCbjf3cD13MMPT91N+Z90/QLi1xPY5WVe90c4aNt9NfFqXUuqCS+5R+51x27M7kN
 vWtyqn6yi1ePJyMSae7WEeJNzFcihL9IHYxCdiScW3OWIDO8BBMT31BulfrvhLAObRvU
 NTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZORToI5nt6PNzFypx/0DHWLVrDRL44b6utu7PDdTvuw=;
 b=lC6hKzYdzIatE7eOsMu32kSnHAqSHT1nnoE588poj/nGeSKCFpF9Vh4YljnBzMova/
 AWuiYiAxl0CvzAbISDIEKnEwHfq4655z9nJBy1fF+YGAJL8QAESXWwPCfzGzqq1VPO6e
 cdR3/DpV0mPliR65T7m2VrejazptJEU6prHLhIHUkBzdyS18s4+TacJGhW45Ds+0nqvf
 cI1Byrx2S184ul0H6ZPHTfx6FX9VFFPTMQbHArTOMhxSpT6JFcrgFmfYk1yBA2IN/t+u
 oz1pUHQ7dvwjX+B8k19C7ulsSYXWxHtVhoTPl4owNzw4LXVbtk34xi3s48/S8jR9xzKc
 Z+Og==
X-Gm-Message-State: AHQUAuZTuYbXUg4BJJPGgXubh+wi3Pq/WW9WyB3CsRFC4QTTzXwkhlk/
 1bXEyfECyf8emskDRhGN6lAcrg==
X-Google-Smtp-Source: AHgI3IY1QI40TA/SFs722MYzKKB0uUt7YxmakGQVJNbaZsOmuHEPRtFbqKqxzekR9vjs5U3+71UQdQ==
X-Received: by 2002:a1c:e344:: with SMTP id a65mr1495617wmh.117.1550325092088; 
 Sat, 16 Feb 2019 05:51:32 -0800 (PST)
Received: from sudo.home ([2a01:cb1d:112:6f00:8ee:778e:6c2d:d201])
 by smtp.gmail.com with ESMTPSA id z17sm7452339wrs.75.2019.02.16.05.51.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 16 Feb 2019 05:51:30 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 0/2] SHA fixes for 32-bit ARM
Date: Sat, 16 Feb 2019 14:51:24 +0100
Message-Id: <20190216135126.17290-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_055135_573121_D76DEAE6 
X-CRM114-Status: UNSURE (   8.77  )
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
Cc: ebiggers@kernel.org, herbert@gondor.apana.org.au,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A couple of fixes for a crash bugs in the scalar SHA code for ARM,
taken from the OpenSSL project. This is triggered by a binutils
change, and so they should probably be tagged for all stable (v4.4+) 

Ard Biesheuvel (2):
  crypto: sha256/arm - fix crash bug in Thumb2 build
  crypto: sha512/arm - fix crash bug in Thumb2 build

 arch/arm/crypto/sha256-armv4.pl       | 3 ++-
 arch/arm/crypto/sha256-core.S_shipped | 3 ++-
 arch/arm/crypto/sha512-armv4.pl       | 3 ++-
 arch/arm/crypto/sha512-core.S_shipped | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
