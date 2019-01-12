Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD59C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:59:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEA820854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LM8mz9eF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y3klEJ3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEA820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XeQIrTIHMv39lbAi3+PkZ7ObHawt8s0K2Bh+bsxQHXg=; b=LM8mz9eFiIK6Qr
	gh+m/ogLpvBsKLXl1axy0G9SDY+Ax0gPo/Pj8npO4g1bJuJWwpidz9MI8vVYuAVulENuH6uvA6pAI
	P5kqZEPYeuJiBxbiP74jAPHlNfdrFu9fa8T+ipGYd23u0GY0EE+CEeZwfWD0wnTLXUIxTQ1gU8d7k
	ooqEU8LSF4+GPwEP4pQtCK2slnKfb6yryN3yaMv1EGWYBTle3eKC4QZgvOlKP4hjHJc6qUya64YtB
	TqXxL8tFEaSF9zTaIp4HeXcRTr5iGJh48A/6GT+b4z6CVxGjWOFCEAxXfOvym3SARiylqd73vZjte
	waAFxbXTudUshezbCnlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIt1-0004RG-3x; Sat, 12 Jan 2019 12:59:39 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIsx-0004Q0-2g; Sat, 12 Jan 2019 12:59:36 +0000
Received: by mail-wm1-x341.google.com with SMTP id y139so4760795wmc.5;
 Sat, 12 Jan 2019 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eTpP1WjuCUG+0L8LD9GMYRrNbo3+PL/+r7PzDANtlnQ=;
 b=Y3klEJ3UdKzJf+eRpC+l0RjmvR85WZG3ckZ9KGcZCC3CZ78ye4aLXeZ7s9XY3gX80G
 uuv04pVOSzOCe4NCgb9G3RTkZBpM12rRy/HMT0a8GXyqBBu3t15JbYdTm657545TIeDH
 Uexf1F2TntB9iohM5fR75WYeaSWXaqoRI7KtrVBMXt0vBykoJkItl2xz/xqXR6bftqW9
 WB3dU2CCMWKzuRJ/klY19R4fjLcXe7McB7AciziYbEZc3OdK8HhpgESrI9J8GQuP9HWG
 L8IRE0ds8npiJaTBwshl0XU+tqxXNQQoAl/gFzDCuaPO+EJtcvRmRwjKx74pymVRY60T
 XpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eTpP1WjuCUG+0L8LD9GMYRrNbo3+PL/+r7PzDANtlnQ=;
 b=CRbze8KLfNLoZ9RveqL2ooJJTXR6um/fmbyn5L4pudb4pBdpJM3LRMnjPnLmVXviwL
 ujm+mV2iahE9+tD4MCfI0SEL59mLyLz2dPH8BZGo5LMUKCVGI6fkG2WwnXt3Bh+m+B5I
 HzivohPy9pGRKJg07qHiSDEjyO18dIMILwUlqAWLRNogKqiMHj62kcwJ2a0QOFpc/UA7
 rXfkxXTHJcdD/L2YFoLNTmTNEz/kT5fyVnQOAA4f6Wy6LXHWu8W2jxBOfuDNT2gAUEOs
 dM8GAMXD6eVlVpzgfUnTbOrNToUZstjw0qwczb2RRy6u52/a40rAKXFWSr0k0FKSWkO4
 TcEw==
X-Gm-Message-State: AJcUukdq06Ah/YpDHbKnrJxnBTI7U7ggDEqqYXeAOIZ9MykAueLOLaXU
 G+8zepzcUWoxfqOh4RW5HMN3FDCg
X-Google-Smtp-Source: ALg8bN7NbmwzeRYFuipzJXxW8+HEgYsF4LBXvU7a1Mfj6OqtR2+GpuKrrmef0y+r8k057RYxGFb1aQ==
X-Received: by 2002:a1c:990c:: with SMTP id b12mr5952834wme.106.1547297972773; 
 Sat, 12 Jan 2019 04:59:32 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7329F008D685E3E728ED25E.dip0.t-ipconnect.de.
 [2003:dc:d732:9f00:8d68:5e3e:728e:d25e])
 by smtp.googlemail.com with ESMTPSA id m4sm15034676wmi.3.2019.01.12.04.59.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 12 Jan 2019 04:59:32 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
 linus.walleij@linaro.org
Subject: [PATCH v4 0/1] Meson8b RGMII Ethernet pin fixes
Date: Sat, 12 Jan 2019 13:59:12 +0100
Message-Id: <20190112125913.22085-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_045935_116867_1C4C4EFF 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 khilman@baylibre.com, ingrassia@epigenesys.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series fixes Ethernet RX performance on boards using a Gigabit PHY
and a Meson8b SoC.
We now reach near Gigabit speeds in RX and TX direction (when data is
flowing in only one direction, full-duplex seems be have another issue
which is probably not related to pinctrl).


Changes since v3 at [2]:
- Collected Emiliano's and Kevin's Reviewed-by/Tested-by
- dropped patch #2 (.dts patch) as it has been applied by Kevin already
- include the linux-gpio mailing list this time


Changes since v2 at [1]:
- Thanks to Jianxin for providing the documentation for the two missing
  bits in pin mux register 7
- added a patch to add the missing eth_rxd2 and eth_rxd3 pin groups to
  the pinctrl-meson8b driver
- update the meson8.dtsi patch to include the eth_rxd2 and eth_rxd3 pin
  groups on top of the previous change which only removed eth_txd0_1
  and eth_txd1_1 (including the patch description)
- update subject of the cover-letter and the meson8b.dtsi patch


Changes since v1 at [0]:
- rebased so it applies on top of "ARM: dts: meson: meson8b: add the CPU
  OPP tables" which will be part of v4.20-rc1 once the arm-soc tree is
  merged into mainline
- updated patch description with more details


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-May/007274.html
[1] https://patchwork.kernel.org/cover/10744709/
[2] https://patchwork.kernel.org/cover/10744905/


Martin Blumenstingl (1):
  pinctrl: meson: meson8b: add the eth_rxd2 and eth_rxd3 pins

 drivers/pinctrl/meson/pinctrl-meson8b.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
