Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD5CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A45F222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NIIyrx2Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0rEWe/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A45F222D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RT9lWEELERMMmXLFkBTCIpO6Ent8aAMNZEBSCIAyTMk=; b=NII
	yrx2Z9Dh8VdRse9KAAvbFgeGuBKif7bJ1TVvBxh7rEcxfd1swdRLs76BlV3VZ4gLbdF3ygBSXZIxi
	taylkEiji/bwhAckNQ+Dv7zRM7Swgkd1WsOeC06J734xWPRnV/4cD3tnMGJQ9dTVWbJP9Zr03c7Ba
	5EhFqKoXXenqm1iAKnTUaRSKpQptRmTRmTfo7vNONWiaZSv+UD53x50pWi4WBGzvqAKDFWj7Qgmqf
	ogfLXIZzIMBIdMWECGPRgyxPqOeMAXUrIFPGz9rANmv6E7PGRAN82LsyTZmGf95NBC4YBszbBOzCj
	jI8LhH6Kt/DxlpfSQ66cOQ451QkODCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrHD-0001qD-9w; Wed, 13 Feb 2019 09:56:23 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrH9-0001p8-Ny
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:56:21 +0000
Received: by mail-wr1-x441.google.com with SMTP id t18so1759213wrx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 01:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=b7LgYP7807Tnr35awa/NURSdyjs5dTiNK4eNh7zXXq4=;
 b=z0rEWe/SC1ZIQotZJSjlDQmDv0V3/veFo9AbD8eMUFn7814rurn50b3i8NIEWkqzDH
 Ah5wb2f3GoNFvc/CGfYV9Ky6mUI85N/w7VoYtQsbJWlKO8AWBB0gbCbqiRR7fbtaQfIu
 voFCTOM7Rc45DZg/Y66KGPKvInf7gUEHNgIe9AYEtL3DrPuaBEZS4B5MRLdKtkZett9K
 vu/b49IeedXC8latHhxf5RkaJ0BVeEuO1QD53hX9gUDBckdwwLeQSsBonB9dF4TwkCNX
 YQ93Kf02hwq0XDo0VYi/r+FQFi5Kpi/GfCaJU3K1LWgcCoZT+iA24mfdihaVwPnk/omc
 kC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=b7LgYP7807Tnr35awa/NURSdyjs5dTiNK4eNh7zXXq4=;
 b=IqG2mMUNVD7wF61qLPsBd8kmVNPXdDpstXT8uao4Rjmo3kg3qUZoZmP2CHHTalH1Si
 swxT37AhVQsBD64hTY6P0iX0ARkAt6oL3dBS/GTtaX756Ey36w9Co1dWaB1v01Xl4iVn
 8o+A9ov+8RGvAwlT5u0a7wduPmJbN6Xipfo50fu3JwWPmeO3kqAFCue1Wvh+sgtqh4Zd
 6HQDpyqi2zbG4rjIzxEd2Nln79ZnqVs/KyZ5M9SJG6BLFN6VFrSIfPpSswgY39My9v5b
 agJPSY4OwzMBtRGNouTBCAOGjgClv25XPT4a8rNDYFtSDOHtWRt6AAiJhHzIeyekeEiA
 Pepg==
X-Gm-Message-State: AHQUAuaNWlHIsXBtLSyae9We+5wrrFr+6pjjpJA0BZeZwGXFdWF3sduy
 Fq6sRWE5ZsKlwSHgJm91sO13sA==
X-Google-Smtp-Source: AHgI3IZIkLpfc7Bzf8F/fil6wEK4jaYLb+K903quiEEfuCcp3HWcuwpiYbkZm9R1NrAAZTo9+Yw9rA==
X-Received: by 2002:adf:edd1:: with SMTP id v17mr6377212wro.300.1550051776939; 
 Wed, 13 Feb 2019 01:56:16 -0800 (PST)
Received: from lmecxl0911.lme.st.com
 ([2a04:cec0:1008:7bdd:48fa:e18e:8893:ae85])
 by smtp.gmail.com with ESMTPSA id 2sm41244909wrj.27.2019.02.13.01.56.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 01:56:16 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux@armlinux.org.uk,
	arnd@arndb.de,
	alexandre.torgue@st.com
Subject: [PATCH 0/2] ARM errata 814220
Date: Wed, 13 Feb 2019 10:56:11 +0100
Message-Id: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_015619_788845_4E974886 
X-CRM114-Status: UNSURE (   9.34  )
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
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Implement ARM errata 814220 for Cortex A7.

This patch has been wroten by Jason Liu years ago but never send upstream.
I have tried to contact the author on multiple email addresses but I haven't
found any valid one...
I have keep Jason's sign-off and just rebase the patch on to v5-rc6.

Benjamin Gaignard (2):
  ARM: errata 814220-B-Cache maintenance by set/way operations can
    execute out of order.
  ARM: stm32: select ARM errata 814220

 arch/arm/Kconfig            | 10 ++++++++++
 arch/arm/mach-stm32/Kconfig |  1 +
 arch/arm/mm/cache-v7.S      |  3 +++
 3 files changed, 14 insertions(+)

-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
