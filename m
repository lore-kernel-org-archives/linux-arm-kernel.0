Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7A1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:59:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D7B218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iuz1851H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sYl++GS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D7B218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rp/HiOFa81QQzrf7QOeKFJfzrZ9cUw0WRbZhCoJuek8=; b=Iuz1851HjAMLW2
	TNwIO9uo3JtKSnfxrNsjF8PEMMyKIdWH5oG0Sa7A2HGJPnffjfpaBlcLDdrw4QyYfWz9nVKg7WXqp
	bM2VLMB7X2FZ8bl2rhEKmHFTFDS6V46AL2y/Rw++dFM1lMs360QWlA/hMrDuZtaw93EHDRAEKXlO2
	BSNNr1vF106xZte83IkN9+xWa11B5mr/ydlJh5UlQqkDbO4Sg1D0gNIkhi+YM8dF/KVERyPECvJdG
	Cvd/+jaTq6o9JaHSE/iuSdu9n0dJRgQxRJA5R6jXft/Dnync3Rxj4ap8etl1LGCzSVN84T3gqQFMK
	z4kWDcxCodNAZ/UNLmtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbDeH-0002Xa-Uc; Sun, 23 Dec 2018 23:59:09 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbDeC-0002WP-S8
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 23:59:06 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so10303749wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 23 Dec 2018 15:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U40zO9GL4zD6yrX5xswqexEhgjRlLBW7ucik6uA1XG4=;
 b=sYl++GS1VpnALdJTnsPCgiMOVc7LoMtrq2PJ2q770gSvCNsy+thaxhDSUXKDX3fevs
 epkRgGRyKZqgdx8TgrBHxIRFjwvl5n7BYXUH+AETM9BU7Yfq+9Q95XC9lCgbEbuCg/0i
 ZL9RITzknuSWf7YKPVpt5js6m0KlV9QRlUJB5ER6FSf4xgwwpB3fG2BLalylGhd9ux84
 jWvUzYL23Dc0gjYG6Y9ojwbNPhZokFKe7c7w2IQRyNf7+KlsfpOqHz3c6y9F+DDjtedB
 jtz81r37qHLUXD/yVE9f1eL7pegihCAy+r3qXJmpIhZCj/u5voxpwOpFiz9Nmd53N5Ni
 QCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U40zO9GL4zD6yrX5xswqexEhgjRlLBW7ucik6uA1XG4=;
 b=bUAG0lrkJfIVF4Pm+yDfJNPXSDr0lnfvbeIbzEJwHwTr9LsnAv4N67OhOeAyJBGFDn
 08+c860mxewnqIShfAiru9Npy97x3LGFOotwxyBwqN4oRKH/2aTpobCM65Jy7NEd+5Or
 Pju9N41k2BHMKABoApp4bZemj9kCUZnyUKdV1iNggeSdfWxOtLKbbGrSOC4f6l6ihir/
 EtwG74jNxSrsdA++9DR1eu9j2L7sx/F+pC9cv8e+jxrCFlREVG1uRpHqXZhLi5Cd+Gpa
 7rnb2JZt09fValQb1TYSg4fqWtVIupQ1mXu0Rmk7BIHg7QPliLfP0UuOCQe/u6TJp2hN
 uKaQ==
X-Gm-Message-State: AJcUukfiwisYJenN6p9JbLTsuVOwDejKBaIRNwT3wft/WpUzTX8o8c7+
 utUuBYdOLUsmKEn1wXlGwgI=
X-Google-Smtp-Source: ALg8bN5itQTecpIu57gojmWDKwJ2KhbmT4BF6CYSrtl66nXFXB+E4jF5k/oksj7wGCiXCgyfl9eeGA==
X-Received: by 2002:a5d:418b:: with SMTP id m11mr9229203wrp.8.1545609530614;
 Sun, 23 Dec 2018 15:58:50 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD711B0006842FD8F1E9F13DE.dip0.t-ipconnect.de.
 [2003:dc:d711:b000:6842:fd8f:1e9f:13de])
 by smtp.googlemail.com with ESMTPSA id s1sm28527174wro.9.2018.12.23.15.58.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Dec 2018 15:58:49 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jbrunet@baylibre.com,
	narmstrong@baylibre.com
Subject: [PATCH 0/1] clk: meson8b: fix typo "ABP" -> "APB"
Date: Mon, 24 Dec 2018 00:58:35 +0100
Message-Id: <20181223235836.12466-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_155904_962872_46D8D364 
X-CRM114-Status: UNSURE (   9.88  )
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
Cc: sboyd@kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 mturquette@baylibre.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It turns out that I'm not good at spelling "APB".
Unfortunately a typo snug into the clk-next branch and will end up
in the 4.21 kernel.

Currently there are no users of that clock yet, so fix it now
before it's too late (meaning before it's used by <something>).


Martin Blumenstingl (1):
  clk: meson: meson8b: fix naming of the APB clocks

 drivers/clk/meson/meson8b.c              | 22 +++++++++++-----------
 drivers/clk/meson/meson8b.h              |  2 +-
 include/dt-bindings/clock/meson8b-clkc.h |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
