Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F00BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D712192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H8LgRuqp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD91lDlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D712192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Dr+mPLZpiGxNIxpai6npsBO72onde/beCwoJv5kCwC8=; b=H8LgRuqpqwRdYx
	iT7x/vnqvHP/cuqdDW8nZNqj9OkW8HaEiGSRKb3w8Gk1h3uyrBcOnr8xo4tmnIc3qv66p/sPItC3+
	1rCYNXUkgKWtt+gQIHlgMaYZqpNa5QBYfYE2rGcCBj4R45uLsrQJgALsx2Jz8cUhIf80WzliD3qRK
	uGggPDU6Jkx8ewOWxcrWJmF1UKL9FcjXXJoQoNY/qRP+dI7+zWT3wrW+2IP+RQkpLPGxcl+fSFDaY
	wNRul+FEcH3LJckg42xMz0DC0zlBI9rxLDzje+7nxyLAC+f/SttRjWkuw7+udHrEI/1F9+sar7ad4
	OGHdiVIAWMR9a4pTCXmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaMcD-0007FL-6o; Fri, 21 Dec 2018 15:21:29 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaMc9-0007CX-6O
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 15:21:26 +0000
Received: by mail-lj1-x241.google.com with SMTP id x85-v6so5072179ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 07:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ffmZcVfSfeQA3nmlJnD8pY5wfE+gHGqpjgHkWfO9544=;
 b=SD91lDlOM/WdjbURKKFSIHqQ0g0Gza3k7dVUJuwxrVD9duJAgtW3/Br9SYYSinDk0o
 skLAClHMdQVoxMtT4oYo1BwQiUs7+29V9GeZg1Xxf2JAXVGHCEgfpQagwJL3wSeDFobU
 k4lHJocQY3Zy9n9n1RQ4sPQDxPEAZ0LCfnlBO+frO9XOTJqddKA0KN/WNWUH9/8T6NWl
 U/bp/XG86ixxNN1aCGvZVwfBNnVUnUaiIAh6JOPhY1q6RyqepS52LPtUv7nusrfMQ0vE
 DBl3U+8b2WXVtwSz1jOOsGDII7pHRxvzQCqqSy4sdrqyeHxAKzOz/kwx3tSLdRpxddXM
 brUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ffmZcVfSfeQA3nmlJnD8pY5wfE+gHGqpjgHkWfO9544=;
 b=su8pG6dYSyyVvd3P57tHyXGy+1h5e7SOoHwLJfL+mrw2nAV5rH/mLVX8kE6aqzC/hq
 b9Qn67AZUbO29BrUcpTGxwT+HOcrKxw7l1nN216qo46dYgyVgLc0ILHl+y3XX+Nt87hk
 RVnxrxi1ri3A7PmJnfzVbAmKGTrQrm9yRzYHAMLEGunkauxKDMn82CmX6NyYPBFIg/MJ
 k5wF+auBdR3KrVX29prG3Qf+LZuVrLxtfKMkr32riTuSQCC97KOfoS6F+Y3r1mf175vm
 ekpmP+aUqnqB0PNVZfXmh3KxvNMq2N5Vlka60QhfnttlfMDA5hN5HJ6mLqaEKiCyzYOc
 pkpQ==
X-Gm-Message-State: AJcUukfph/FhpadJwJlOWabPAHcT8NTV7EuJNYjRwDwXIdR9n2t5RHeX
 GG2J1CwCLA3iHUXPcJbdNXY=
X-Google-Smtp-Source: ALg8bN6aGwsBuFCCEliK6zyyS9ARcHvGGy/zL+6jGizSb7I2yBBOhhkBUQo0Pxs7Kzj0EMUKRsOZAQ==
X-Received: by 2002:a2e:97d7:: with SMTP id
 m23-v6mr2099630ljj.18.1545405672729; 
 Fri, 21 Dec 2018 07:21:12 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se.
 [90.142.43.138])
 by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 07:21:11 -0800 (PST)
From: codekipper@gmail.com
To: maxime.ripard@free-electrons.com, wens@csie.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH v3 0/9] ASoC: sun4i-i2s: Updates to the driver
Date: Fri, 21 Dec 2018 16:21:01 +0100
Message-Id: <20181221152110.17982-1-codekipper@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_072125_230354_F89193D8 
X-CRM114-Status: GOOD (  17.08  )
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
Cc: alsa-devel@alsa-project.org, Marcus Cooper <codekipper@gmail.com>,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, be17068@iperbole.bo.it,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

here is a patch series to add some improvements to the sun4i-i2s driver
found whilst getting slave clocking and hdmi audio working on the newer
SoCs. Since the last push there has been some activity getting surround
sound working and this is included.

The functionality included with the new patch set has been extended to
cover more sample resolutions, multi-lane data output for HDMI audio
and some bug fixes that have been discovered along the way.

I can see more usage of the tdm property since I last attempted to push
these patches and the examples currently in mainline sort of the opposite
to what I'm trying to achieve. When we first started looking at the i2s
driver, the codecs that we were using allowed for the frame width to be
determined based on the sampling resolution but in most use cases it
seems that a fixed width is required(my highest priority should be to get
HDMI audio support in). We're using the tdm property to override the old
way to calculate the frame width. What I've seen in what has already been
mainlined is that the i2s driver has a frame width that is fixed to 32
bits and this can be overridden using the tdm property.

Anyway, I've moved the more controversial patches to the top of the stack
as I'm expecting feedback.

Have a great Xmas and New Year,

BR,
CK

---

v3 changes compared to v2 are:
 - added back slave mode changes
 - added back the use of tdm properties
 - changes to regmap and caching
 - removed loopback functionality
 - fixes to the channel offset mask

v2 changes compared to v1 are:
 - removed slave mode changes which didn't set mclk and bclk div.
 - removed use of tdm and now use a dedicated property.
 - fix commit message to better explain reason for sign extending
 - add divider calculations for newer SoCs.
 - add support for multi-lane i2s data output.
 - add support for 20, 24 and 32 bit samples.
 - add loopback property so blocks can be tested without a codec.

---

Marcus Cooper (9):
  ASoC: sun4i-i2s: Adjust regmap settings
  ASoC: sun4i-i2s: Add regmap field to sign extend sample
  ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
  ASoC: sun4i-i2s: Fix offset mask
  ASoC: sun4i-i2s: Correct divider calculations
  ASoC: sun4i-i2s: Add multi-lane functionality
  ASoC: sun4i-i2s: Do not divide clocks when slave
  ASoC: sun4i-i2s: Add set_tdm_slot functionality
  ASoC: sun4i-i2s: Add multichannel functionality

 sound/soc/sunxi/sun4i-i2s.c | 399 ++++++++++++++++++++++++------------
 1 file changed, 267 insertions(+), 132 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
