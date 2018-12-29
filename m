Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61013C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 14:36:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE4A2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 14:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eo0A76Sa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gNpo5E4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE4A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cTIEoboYqHR6BURU98TbmpHA+lecw9W3MWS/YztEpFs=; b=Eo0A76Sa1hUUuM
	nvkLdoOd8hpwonoWJFXZhZ7zMmCtDxoEtrbS+OM9r30Txi1rTH7ud/oGNnkAsXU5GNwfYfSRt7C3o
	zVTH/AIF5Ko5/Lei9p6rWwRBabHRHFThKi91BaEZiiD27ztQmmpRMz6issygNxGg1eGIVyoC5bQXF
	F/QAdfOVdwrfFufvrSjzkABvjGEk3mbTt33UEPWNrvCj+s3jFTU49w4OgpX7h/t982xy+7SKUeiV6
	+4jb4Ae5maZGAc4bdXyu9ZOk0vmXKu8Bc5qIzIVbZ+494rf5oOgZPaz1gMreI08pFuYemvZIuyCYC
	K+ZVLCRpfCUrfpF1Hnjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdFjA-0003Zg-5M; Sat, 29 Dec 2018 14:36:36 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdFj5-0003XT-9b; Sat, 29 Dec 2018 14:36:32 +0000
Received: by mail-wm1-x343.google.com with SMTP id b11so20808396wmj.1;
 Sat, 29 Dec 2018 06:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2DlGmc2NFsu0CtSBpdnlMMk72YXVAb3M+9shp7ULxmo=;
 b=gNpo5E4SIbWv7IzCAPD89UINW8H4koN7LPgnmqWE1QfSWsSsXk92637g+rhVnxzDc8
 mlqHsqzGtCZ2KKwoU+KBULkCdJPVo+2msHsXJgK2c4unGwptRCLBVvARtJrQrnun0HFG
 +oVv+18IFoGAUliL8/iCFL+DwCgeOb/zFD+GsPajtTJ+8XkPYpQZsZ1CP822nMqVn4N0
 5GzjPq21JnYN1WxgS5/wVME2PQoy2AR3z5OhZtSWi5g0LYjGbwZGxq3/kqFbXA8T3ZrW
 oNwUyC/BiRhRaLC+cvVpxFUQZZ9RsZaq9Ppd06gbyjgHPs4t8j/M/4AhVSOHne8pqZZM
 fe2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2DlGmc2NFsu0CtSBpdnlMMk72YXVAb3M+9shp7ULxmo=;
 b=B1x+fyhwaSAiGAP6GT4IwRq/eSjaFK+fAOBlkvkymYe6RxvFSiWxkDh7bejD1ua3Ft
 Rudi26zi/lk5lh3VZBzjgLgWEd6xqXHzChIxFJbDfVR1KrCDJStL+LI8jl8gAxzzE6oG
 NHGpEvHclrQ/KZ4du9tbO+ZJ9VZsSunKUKEzJ8aiHDj7yNsNCwUKSdOijMutKo6VwFAM
 b1ywcT8J3OetuvnoTO9C9hv1gn31NjtofFZ+IImfoCTyEtp1SmciBB+10843gKWVvdIe
 RCCPiV0vHOUrEi1XTy/wYPo2eAp9TjE0Gkklr/yGCGRX8sPOIlCUgPjNcPN8fA37nVcx
 5ZFg==
X-Gm-Message-State: AJcUukeWFjiNELZgKTR3gaxCExbnj/KJ8+JgOMyJWGeOtSwufWKFY6Bi
 34O78LGa8RncQ+fU+NtHghN+Q4+V
X-Google-Smtp-Source: ALg8bN67CHcSSdbwZXJZt51FLfJfhkR53cW/+Hvpng1q/u7lqmQjat8t+qXeY7QRZVyrKKz9KwYmJg==
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr2807530wmk.152.1546094178435; 
 Sat, 29 Dec 2018 06:36:18 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7294600914F24DE1716D3FC.dip0.t-ipconnect.de.
 [2003:dc:d729:4600:914f:24de:1716:d3fc])
 by smtp.googlemail.com with ESMTPSA id
 k135sm53626412wmd.42.2018.12.29.06.36.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 06:36:17 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com,
 ingrassia@epigenesys.com
Subject: [PATCH v3 0/2] Meson8b RGMII Ethernet pin fixes
Date: Sat, 29 Dec 2018 15:35:54 +0100
Message-Id: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_063631_363846_4A2A7623 
X-CRM114-Status: GOOD (  14.04  )
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
 linux-arm-kernel@lists.infradead.org, jianxin.pan@amlogic.com,
 linus.luessing@c0d3.blue
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Emiliano, Hi Linus,

could you please test the patch from this series on your Odroid-C1?
I tested it on mine and Ethernet seems to be improve Ethernet transmit
speeds greatly (at the cost of a small drop in receive performance).


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


Martin Blumenstingl (2):
  pinctrl: meson: meson8b: add the eth_rxd2 and eth_rxd3 pins
  ARM: dts: meson8b: fix the Ethernet data line signals in
    eth_rgmii_pins

 arch/arm/boot/dts/meson8b.dtsi          | 6 +++---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
