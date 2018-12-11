Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4255DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:19:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B572084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FRIp/nks";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="jYUbVwAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B572084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Iw6gLptH3jObIS0r7dv2YfizrQnr9YYM9NJHrmVzl9w=; b=FRIp/nkso9YW9u
	gvoLavBRO7FNqHzeOWN1giICFAC9IsbjU7U4BfEYtJynFSPMbVjPNMPQDqGQsvsOcBGI7OA7U6rSV
	Uf6MpuoaTkak4mvTEvsxP5ZUQyi0ZT3q4dNXCQ9HjdDEmcgvEuTHeQ7PvU1HzlK/Wj40VPXfBCGyN
	JpSq/HUbpG4960ueMUxcBBlz03GC2eVj16WlSxTK2rS0VXW5leO2PkEQus50rdHQu5aO7szkKL8Wo
	f2nP71vn7gOKLbao4TNSnki1SAKIH3PV5jWhUBOLzD45eUd8bqtZMIEpfM1ibOWro/2lQ2n2oRwm2
	3bVygjuOiSVq6/KIk9Vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjoU-0004O2-K1; Tue, 11 Dec 2018 15:19:10 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjnM-0002wn-4S
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:18:09 +0000
Received: from localhost (unknown [213.204.46.240])
 by plaes.org (Postfix) with ESMTPSA id 8CEBA4002F;
 Tue, 11 Dec 2018 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544541438; bh=S8BNeKvLxc6P0mccM/eGqU9/SJtyfkGuSNMjcrz95q0=;
 h=From:To:Cc:Subject:Date:From;
 b=jYUbVwAwEU+Ks14U9hxHnz1W1Z+AajLY8FLKaLDkxhfOCcp8KrxamqMJnXaDKzZc2
 T/PlM4wTaRyWv/ZQlSU8udCP6sMYqh+LCIBQQjSezPg8lrK2dnKlgd14KwNAeV5KZw
 bBB1jvRQfzRxV12IKT1w10owr25TGh1OV1eriwn/b7lkNdpXDgL5CfvrkEb3DmUsyR
 X+VC0K7Gm/ES3TZpv8rxU8o7jZas+Oi0O5pzYop6e42Dn5cgquvkR1F5DcQxIVq1Ni
 TZljWgch2phhJx0Rg7hRfNQUxvkEig45LtH44n2U5u19zeXRWY+QseBdxqOjyg5RgX
 1dQrFhQ5WQydg==
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Olliver Schinagl <oliver@schinagl.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>
Subject: [PATCH v2 0/8] regulator: axp20x: Stop AXP209 from crashing when
 enabling LDO3
Date: Tue, 11 Dec 2018 17:17:04 +0200
Message-Id: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_071800_833472_FF3210D4 
X-CRM114-Status: UNSURE (   8.17  )
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
Cc: Priit Laes <plaes@plaes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is a second edition of a series that implements voltage
ramping for AXP209 DCDC2 and LDO3 regulators and software
based soft-start for AXP209 LDO3 regulator.

Both features are needed to work around a PMIC shutdown when
toggling LDO3 on certain boards with high capacitance on the
LDO3 output.

Similar features (or workarounds) have been also implemented
on u-boot side [1].

Changes since v1:
- Rebased on top of next and dropped already merged patches.
- Dropped LDO4 full range devicetree change for Lime2 (prev patch 9)
  in favor of general pin-bank regulator dependency [2].
- Fixed paths in devicetree bindings (patch 3)
- Added note about software based soft-start for LDO3 (patch 5)

[1] https://lists.denx.de/pipermail/u-boot/2018-November/348612.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/618459.html

Olliver Schinagl (8):
  mfd: axp20x: name voltage ramping define properly
  regulator: axp20x: add support for set_ramp_delay for AXP209
  dt-bindings: mfd: axp20x: add support for regulator-ramp-delay for AXP209
  regulator: axp20x: add software based soft_start for AXP209 LDO3
  dt-bindings: mfd: axp20x: Add software based soft_start for AXP209 LDO3
  regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2
  mfd: axp20x: Clean up included headers
  mfd: axp20x: use explicit bit defines

 Documentation/devicetree/bindings/mfd/axp20x.txt |   9 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |   2 +-
 drivers/mfd/axp20x.c                             |  13 +-
 drivers/regulator/axp20x-regulator.c             | 142 +++++++++++++++-
 include/linux/mfd/axp20x.h                       |   4 +-
 5 files changed, 161 insertions(+), 9 deletions(-)

base-commit: 14cf8c1d5b90a0cf6a8ba51ef59db8da8c7a2622
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
