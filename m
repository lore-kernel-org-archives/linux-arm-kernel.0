Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AD0C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:26:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1C220837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ws8OkFRT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnXjqWs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1C220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N6dKJYD1QDAdtdcxkVh0/KV5Uo9xJcmEifwAhNFBy1o=; b=Ws8OkFRTwZrHcZ
	ahekwA3bM1Di4oYOz6WI7DEdrfpdLxdWGzB9piekS/B8LrBAndXG8DH2dGVtDkhllXXij53YAZOmo
	1K9Qgu81TrHQu2WC6EnZb+UUsAp7501qxbojnFtwgWpOGhulQsYm1k17tlcDZG5/EV23U7syP3v61
	94HfsWSjM3ZirHctkm0IA4I8XOCLy7oiD9n6Y20QB7ETurhYqy2FDfgktQ5NliqRyAmzr1QeH8fFY
	+xXkRnQwXJq3Wr85mulSc8Abc30OIoOap7ea6bjfg30c0zRd0BXtUH84FGT2nhK1PvlMX3oN3Gsun
	Rx9kKje8V1oQGIbEhLVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVH4t-0006Z0-I5; Fri, 07 Dec 2018 14:26:03 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGx2-0000ut-9T
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:17:58 +0000
Received: by mail-ed1-x536.google.com with SMTP id z28so3825333edi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I2yqTczYzdkWd0b7MUGrKc7Dv+h5YXpjTPD2jkWEH/M=;
 b=FnXjqWs/jlvD79u6DrXpFJT7GfyYymmZW6w0IPDefm09xC27NTz5B2+NFrY/GY9kky
 cYu6Z6XXw4iDk44GZpL0Xvus3gVRsN/6x1T62ekFVha6gr1JkE/dY4bylaAn+vMyQVfG
 mThLCk0bk8akcCEezcnDpSaY64gcir0nZyqS7w9KfG4B7WX3L1jZMHQ2W3PNHaxS7bov
 rD1ojyKTCfHUq1UeJIwEAfvBqzqtdopuzL0G1S3SGdBWjf49M3HrA5laHExpUqWIdU0v
 hzA9SBedKKUkoPJ5huyzcJtYjpYHGZFFhcY1AtC7e+CwjX4rRQFUnGPRCooGUPp4Wn6y
 A5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I2yqTczYzdkWd0b7MUGrKc7Dv+h5YXpjTPD2jkWEH/M=;
 b=Gw3J92bD/hUILwlJEH7TRpEhS2OWc2gtBaaV3dmRW9mmu+8h5h/6tCOY+T+OrFIbJb
 tTDeMDndKnid9G79w7Uc+fd/ezcCr1SpYWoslMmwFM4nAz5IwNB70hFuSYkImo//E0Wu
 2KUS/rP/gTfG4l2GU4KethOKO0iCyBMiu1f4uH4wI5cKiPgebZAp7/pG6lWfo9q38P2Y
 tnL2P4J6JujVHdTmToT0kTgoknINHx0gX0ShfYNdgP1nL4/uROA97lJPwSfjYP4kBLtY
 yO0UAcx3LbDzmBS/UBiU/6/AkoXz2l93dpXawEeRah8nFuGKOUWmeTpfhXDaFc3mKGgd
 wn3g==
X-Gm-Message-State: AA+aEWayJAAOBmKrWjIKZDabc7Tk59TK9GgAD5wagvmG8br3eRKJB3H7
 NFWVxnTyqfh8dzbHG2o+15g=
X-Google-Smtp-Source: AFSGD/WuwXJ0f+JpYERRX6goU/NYJN/xPkk+GefXCZvFlf0MXaYPEQPj0xfsIB4nVYyTmqF+/DetUw==
X-Received: by 2002:a17:906:3105:: with SMTP id
 5-v6mr2123586ejx.122.1544192264413; 
 Fri, 07 Dec 2018 06:17:44 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id k32sm1050231edb.42.2018.12.07.06.17.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 06:17:43 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 3/6] firmware: tegra: Changes for v4.21-rc1
Date: Fri,  7 Dec 2018 15:17:36 +0100
Message-Id: <20181207141739.9085-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181207141739.9085-1-thierry.reding@gmail.com>
References: <20181207141739.9085-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_061756_326781_DDD6EAA4 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-firmware

for you to fetch changes up to af51c25fb59d4365c259ab93f388462e0998a2ed:

  firmware: tegra: Use in-band messages for firmware version query (2018-11-08 12:49:26 +0100)

Thanks,
Thierry

----------------------------------------------------------------
firmware: tegra: Changes for v4.21-rc1

These changes update the BPMP ABI header and implement a new variant of
the BPMP firmware version tag query if supported.

----------------------------------------------------------------
Timo Alho (5):
      firmware: tegra: Add helper to check for supported MRQs
      firmware: tegra: Switch to global mrq_is_supported()
      firmware: tegra: Print version tag at full
      soc/tegra: bpmp: Update ABI header
      firmware: tegra: Use in-band messages for firmware version query

 drivers/firmware/tegra/bpmp-debugfs.c |   29 +-
 drivers/firmware/tegra/bpmp.c         |   77 ++-
 include/soc/tegra/bpmp-abi.h          | 1188 ++++++++++++++++++++++++++-------
 include/soc/tegra/bpmp.h              |    7 +
 4 files changed, 1024 insertions(+), 277 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
