Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEE4C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CC02083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JoYyCzRl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NGEniBJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CC02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FqYz8AkDookaWDb6Yi3yXsZHgtD5yHdUvwLJuo9eAAM=; b=JoYyCzRld0BsvY
	Bm5lfBAgYnomc7bK8dnalar6rDnodI8ppHW3O5Bt7I8wULDyGaa1lheSZs8rl5BrCH5eHGE7X1vMS
	+U84ichRzmu+/IWOWYbzEbPbFtklPWQo2hlJTSTLnQZLlgu6GRGyiZWcTGSz0DfLcFcmwbL71o8eI
	peVihyEGVGsPkW9DS32AZntLLxsrvdCrzMX8nBVah46YoCSqUannUMY78wT/jaN9JArnxkc+cm41f
	x+RvxTcLhH+3b14WTHnA9OqDU59rY/hIkwyToNISd8GxwAvrfwOkvNuB4syRF1hJboHfPW+9cRzWf
	1t9un2MKSp7Z2tolK+FA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVgAi-0004Gh-75; Sat, 08 Dec 2018 17:13:44 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVgAK-0003bX-Gs; Sat, 08 Dec 2018 17:13:22 +0000
Received: by mail-wr1-x444.google.com with SMTP id j10so6588900wru.4;
 Sat, 08 Dec 2018 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5PXdW4UBpQPSOC7lPcUMX6pSS8TgUTrjYuc4GLT/lzQ=;
 b=NGEniBJ0JYstL6hTiODRxWJLzTOGQWgeJkhhOBS+Q3uv/oibqKRcvE8eHpA7jqz9FL
 rTol4mzf7PfkiOaCB7MTgAgnDrwMpuxznJF+EmtviYKU2vDQrBnJpDo4DjsLVDbLIGxy
 9kr1bAeJSL23fvgeW9LMx9vxYmFQlVWlJAV9HOQJCXg3hToPA9HuIwjq/lEr803nTvAY
 KlFXWO9tD5thZ4VP4qOkM0ZWr4JCbsivJXP3PXuL3QQh69L+JM6JTSSRYPxvqaCAJbbi
 TQFgdugXd40xcQ5/+9NDW3aAc8BWqYEyxIN2kArlFEjBpKIFFa58CjCQmaVsfU3yRIKo
 SvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5PXdW4UBpQPSOC7lPcUMX6pSS8TgUTrjYuc4GLT/lzQ=;
 b=AR4trAb4E8pEVitU1URNkn1gYMlCwYj5ozKL+lSb2aFC4IL5h2NQEMOUb8W9pHfeQI
 CdRyW1sEkDNd+f0Ev99/4CQWuNniFHkqo4W2MIgY7K2Z/fcssKZJ3/TnqkxY7UJ4Q9IC
 DlNMiroNzE1scM3AHS76mtgAA2WTeAodfc0qLt9S4mkjtR9toIU228Oh0OMKR+eRA3DH
 UKmIVrmXlpaRDgJNPXFwzAxAvURKgLpIVzWGR0snJM1IqG5ErDL2CBjN8UDCgTPYTbgB
 yBkLuAkkjHuWfMj97+9xRG6v7cOcZaE+FC+rjX7E+SrxZOoec48a+CZqY2ubc/CrS8EO
 +HYg==
X-Gm-Message-State: AA+aEWY/PlADMmg7vbRjC6dkwzx+8Fh8/p+aywN+eF+jK2hDGcUfwSpP
 3l70UsayIEHv4PS+BznluzqhepLy
X-Google-Smtp-Source: AFSGD/W0zwq0Qh1rO4lqFd/9JHkO8YGJaRm6Jm77JFfPyNgSv4afSqre0vlg4UaQvTC7XqoVAy7YJg==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr5411511wrq.182.1544289188552; 
 Sat, 08 Dec 2018 09:13:08 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id r12sm4995851wrq.3.2018.12.08.09.13.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 09:13:07 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jbrunet@baylibre.com, narmstrong@baylibre.com, khilman@baylibre.com,
 robh+dt@kernel.org
Subject: [PATCH 0/5] Meson (32-bit): add support for the Mali GPU
Date: Sat,  8 Dec 2018 18:12:42 +0100
Message-Id: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_091320_589747_66E0FB4B 
X-CRM114-Status: GOOD (  16.33  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series adds support for the Mali-450 GPU on Meson8 and Meson8b.
Meson6 uses a Mali-400 GPU but since we don't have a clock driver (and
I don't have a device for testing) Meson6 is left out in this series.

Meson8 uses a Mali-450 MP6 with six pixel processors. Meson8b (as
cost-reduced SoC) uses a Mali-450 MP2 with two pixel processors.
I tested both using the open source lima driver and a patched mesa
from the lima project as well. Since we don't have display support
on the 32-bit SoCs I used off-screen rendering as described in [0].
The result is (for example): [1]

The bootloader (at least on my boards) leaves the Mali clock disabled
by default. The board crashes when trying to access the Mali registers
with the "core" clock disabled.
Thus this series also implements the required clock driver changes. The
Mali clock tree on Meson8b and Meson8m2 is almost identical to the one
on GXBB (see the description of patch #3 for more details). Only Meson8
is slightly different as it doesn't have a glitch-free mux. Patch #2
prepares the meson8b clock driver so we can have different clocks per
SoC.

Dependencies:
- the .dts changes depend on my other series "ARM: dts: meson: add the
  APB/APB2 busses" from [2]
- the .dts changes from this series have no compile-time dependency on
  the clock driver changes because CLKID_MALI was defined in the
  dt-bindings since the first version of the clock driver (but it was
  not used until now).
- the .dts changes from this series have a runtime dependency on the
  clock driver changes (also from this series) if you have a kernel
  patched with the lima driver (without the lima driver there's no
  runtime dependency)

Other notes:
By default the GPU runs off the XTAL clock (24MHz). The lima driver
currently does not update the GPU clock rate. Different frequencies
have to be requested by adding the following properties to the Mali
GPU node (to run it at 510MHz for example):
  assigned-clocks = <&clkc CLKID_MALI>;
  assigned-clock-rates = <510000000>;


[0] https://gitlab.freedesktop.org/lima/web/wikis/home
[1] https://abload.de/img/dump0myic0.png
[2] https://patchwork.kernel.org/cover/10719445/


Martin Blumenstingl (5):
  dt-bindings: gpu: mali-utgard: add Amlogic Meson8 and Meson8b
    compatible
  clk: meson: meson8b: use a separate clock table for Meson8
  clk: meson: meson8b: add the GPU clock tree
  ARM: dts: meson8: add the Mali-450 MP6 GPU
  ARM: dts: meson8b: add the Mali-450 MP2 GPU

 .../bindings/gpu/arm,mali-utgard.txt          |   6 +
 arch/arm/boot/dts/meson8.dtsi                 |  58 +++
 arch/arm/boot/dts/meson8b.dtsi                |  46 +++
 drivers/clk/meson/meson8b.c                   | 349 +++++++++++++++++-
 drivers/clk/meson/meson8b.h                   |   9 +-
 5 files changed, 461 insertions(+), 7 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
