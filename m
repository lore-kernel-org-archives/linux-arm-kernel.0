Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F045C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A3520989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kMgqY4QR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6jMfcbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A3520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CETBppxViEUZDelN/b2ZxnNYRtfTzEaY9ey0dvd8EZ4=; b=kMgqY4QRIpDo5/
	oFs6rnSrnMWpNfSqiO6MeziN1uI3R0F3/EHQdr4t20arKSFHAPNFQB/Hh3JN0pXD4Oz8v5mXiyzrZ
	KnXr+5/sprrNnUThx+grx4A9wb1fzHTEMj1kuy5HVzgFQt8pF0b4EaXW6p9B/WXoA5SqA1GlTszbN
	ds2FavE781hERfmM8DUPf3ThuyltFd3r1OKnBcKCSl+MuNNfUK7E2hoBzUwLrFo6lkk+ORBtwlbaQ
	GzdnMJixwxWh6bN6+Qgr2lPJWkz74YFRg4NKOMwU6FZDiia/ANltBtml9Q6FAmWS38NVeMQQ60T7F
	+u4nFEsKClopUcQ3V0zA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUo8j-0005uP-Dm; Thu, 06 Dec 2018 07:32:05 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUo8Y-0005bu-5D
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:31:58 +0000
Received: by mail-pg1-x544.google.com with SMTP id y4so10234387pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kkAY0uwtC3pzcoa9SMsRh6f2Kqc06jM6mHbefciRqdU=;
 b=q6jMfcbPK9Q6wv4kcd6SGAEPVW/24N0vJwzcUrXVj3dFQPZrEfuaer9Ss0DufP8TtR
 cR655HQVn3R6Uzi02G8u5ZXwML2QVy08jwoK0OnVDcTPxPDJDG8bCqhwq0qiOnS2138m
 C65RCASjehWl6piK3oAQQEhmbjirjRKLzXqVq4IgnfKxTgVzOzHfUC1YUw3xrkVceQoL
 3Jkn77nTvvoQE+txnGnpCm5oO/PtQKMVQE37McIkZU+KmjVoEBtCsexZ4Tl/KqV8PPWJ
 oRPbXA/O0+hUgt94+fOLVCEhkfw/cDBaWCYKEBWbSUo12E109Ecaq/g3WYhjV/bfwY2J
 aURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kkAY0uwtC3pzcoa9SMsRh6f2Kqc06jM6mHbefciRqdU=;
 b=rRHbSHnL4KseS04vipgM4nLB594uwk1lh4kL+OEfxL/TXny3sPJcSLedNx4d04RsLJ
 fFEaoAO/JZrgZfm0zr0ozTSDfKhlA3QtdKr8sy6ueS/6k888k62sQnagRhzLiGbb/tMg
 cLUUtO8ZgKX8dtne8mits5umoLLRmA0Ht5FXcTJeeyhbg4J5vMvIm6/rvK9UcvGkqpXD
 k4zNgOU2NVTqur8jv/3jNIZO1Lic5e2nAmSLY/FaCHqHwbGL7aoYLzHVSRhFWHFpRJ2S
 gV/5vd/NwUgAFdr4kD7sHlYkOKCsV78Pgq5V0R01sLDZHqKoedfrvsPVcWM+vdWJgKH2
 Xy2A==
X-Gm-Message-State: AA+aEWZ5cwaemuitWZJnrEwhh94bMvDpClqs3UHZ7AooVX5o/T0NLckt
 3jRnhtGGNpu7+cjuatL+05k=
X-Google-Smtp-Source: AFSGD/WMOtb6cZMfYeLQBpszqzfZ4DnRpP2i2qxXLONXRKOsMpg50ncJoRSIOZLdNx1Dxrn3C0ofUA==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr23525671pgp.263.1544081502700; 
 Wed, 05 Dec 2018 23:31:42 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:31:41 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 0/5] i.MX8MQ support for GPCv2 irqchip driver
Date: Wed,  5 Dec 2018 23:31:20 -0800
Message-Id: <20181206073125.7255-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233154_720308_318B2400 
X-CRM114-Status: UNSURE (   9.39  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Everyone:

This series is 4 trivial (and optional) changes and a patch to add
support for i.MX8MQ to GPCv2 irqchip driver. Bingings for new GPC
variant were taken from [gpcv2-imx8mq]. Hopefully all of the patches
are self-explanatory.

Feedback is welcome!

Thanks,
Andrey Smrinov

[gpcv2-imx8mq] https://lore.kernel.org/linux-arm-kernel/20181116154927.16152-3-l.stach@pengutronix.de/

Andrey Smirnov (5):
  irqchip/irq-imx-gpcv2: Remove unused code
  irqchip/irq-imx-gpcv2: Share reg offset calculation code
  irqchip/irq-imx-gpcv2: Make use of BIT() macro
  irqchip/irq-imx-gpcv2: Make error messages more consistent
  irqchip/irq-imx-gpcv2: Add support for i.MX8MQ

 drivers/irqchip/irq-imx-gpcv2.c | 61 ++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 17 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
