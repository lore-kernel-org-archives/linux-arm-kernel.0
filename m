Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88842C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:33:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BC0217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f3Rf1ImO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg4r9Dbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BC0217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=k64goEWZ95e9x+sSrnC+mIIAe8yHIQ5RPzLP8bISb+U=; b=f3R
	f1ImOjRrxZGWJVE1X79k8VS5xfgm72RFVswmY6hv+HzBTNIJAKa67LuIGwg2K78+Hl2YvDk6gvo7e
	uVy+vDTscvPI9nBBI+ZFNgsrx9NDpSxxEG33nuw0DnTR6nakvL/2TYCzrOPFa2QQIFQJHZJy0Fssa
	H3pkMuMkCP6UHLjP9npMfrhsVCwkgGErTzk15DNAijMWIFdau/f8rbUN8On7ml9SOabdJSPaOLomq
	FZU+Wt+9/D1Kx5HX5933kDHvnjkcyGxcYksdXVfjTbkwNoiM9dmEtTzDD9ytS+6xsz7CB3U+GIfXT
	6+8ESEj3ylMP9mzIEnvc4bTuEBN7M+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm6UN-0004aV-97; Wed, 23 Jan 2019 00:33:55 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm6UJ-0004ZS-AL
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 00:33:52 +0000
Received: by mail-pf1-x441.google.com with SMTP id q1so233313pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 16:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=JGX1Ly4z5f3bXKnacbZ85ykhGo/mX1yILkHHVN3dZqs=;
 b=dg4r9DbwnDaAsFdQ97K3S7DEkC8oLVejOyPGbeLMgqKZz9EC6Aazcs85yYI6gl4ceF
 uYKMZ8Dy8ps/8dEtZ3a4zCRXLmAuBd/MHeU/mJgdNUbXUP86+UqW1UyXYHyeX/taZ8eC
 FdXcuUurnGCHXl498YsDywouiYNeNId7NotwXUUGWrMQBt1kPJDCVei4YitVp5L+cnxa
 L5fBclneQK2Dbk423w1pWM50m02e5oW6VtgV9q7CexWj262f3Q8qSyuIECaENXPzpGWC
 TYZASVwBUfHWWp5u8KzkDWvtBeBtF3DYohCwvTvZ3biFfsJWvInAtyRGMPN9QjrtGN1s
 841g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=JGX1Ly4z5f3bXKnacbZ85ykhGo/mX1yILkHHVN3dZqs=;
 b=XXMGD00JRtsACFQLZ8MbnQiZ/U/IGd5IvHde5pqfcOV484KenQZEYOWy9kN+96+I/J
 lcDzJ2tVxF2PK2NRI7n7ydxWa6ihWEKL89qSKZIp/EcdE3An1L+L7PIemLw5ot3suQqr
 wTrpT33CneJSGfw2BZ3s9ycUCZggUFVvQfrgAQEZDbONB94/P0q1CFpOp4cWZYwZD3+E
 dKBpl1J9r4rJW+vqLkDVGKhnKG7lB9IShPnDU1KYNIBVZjUwu0USWkd2CYIRkpdNv7l9
 Up+M/puWm/5b5rAqd6XtFncRfX2a29T6PRCakMKEmBATtc5OIIUJPYh5xylyfEFnmrRg
 A0AA==
X-Gm-Message-State: AJcUukdv1nZrd1W3ZpxElPEjMvDF45ziKOOoJ9sBB9I12FPdQuxKt9hD
 i0ITlxfVgXbbxxqdkp05VZk=
X-Google-Smtp-Source: ALg8bN7dLxJAroblpO8C3P39gJe2W9L7DTNMwQpvqXH/iox7V2bPHjTtITuUU6IC2bEOGnK8TW1TPQ==
X-Received: by 2002:a65:560e:: with SMTP id l14mr109616pgs.168.1548203628775; 
 Tue, 22 Jan 2019 16:33:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id e86sm25465257pfb.6.2019.01.22.16.33.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 16:33:47 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH reset-next 0/2] reset: brcmstb: Misc fixes
Date: Tue, 22 Jan 2019 16:33:43 -0800
Message-Id: <20190123003345.13750-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_163351_381974_F550C212 
X-CRM114-Status: GOOD (  10.05  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, sfr@canb.auug.org.au,
 rdunlap@infradead.org, paul.gortmaker@windriver.com,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, linux-next@vger.kernel.org,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Philipp,

These two patches fix some recent issues brought up by Paul and Randy,
feel free to squash into c196cdc7659d ("reset: Add Broadcom STB SW_INIT
reset controller driver") since this is only in reset/next and
linux-next so far.

Thank you!

Florian Fainelli (2):
  reset: brcmstb: Make it tristate
  reset: brcmstb: Fix 32-bit build with 64-bit resource_size_t

 drivers/reset/Kconfig         | 3 ++-
 drivers/reset/reset-brcmstb.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
