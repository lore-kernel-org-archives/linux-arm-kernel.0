Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CA4C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:17:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5409920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="flL+pw3p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="uXzafqju";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s0JaWZ8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5409920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EWK5BD/4h+fzakQU0M0tcfoK9KEYrYsgHhfgW5KZSP8=; b=flL+pw3pcv6SI9
	Q9MXJLVy2Ox0VZhcwGkb7vFGBjJUAAXPQnf9ukASs7YOR++4ao74feeDgIEIk0xAPlaZQvtxpgjQp
	JC6F2wtoRQsj/EaSqQKVGgTvefvkMV9TS6LVbAsYSL5fT9jhntz8bhT7EPm00DQ691ItovZqDk6s2
	4VTKfllT6w/PjrXr7FzGN39sUKMbR5y7hcS6FfXzyQXqVcvreHKYYQbLBlazjfHf4nZbWRoBWzY8R
	Kitxk1qQSddpzOgYq/R0GYAjoUmlaNhu/1DvFM0hPG3UHc5bHUI0/VIWmVRfLPPoYHH0ETHUX8gNK
	dtVn7PhF4G1iFagZGwDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giVLE-0001Cq-Qi; Sun, 13 Jan 2019 02:17:36 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giVLA-0001BW-QW
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 02:17:34 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 5889521AC2;
 Sat, 12 Jan 2019 21:17:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Sat, 12 Jan 2019 21:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=fm1; bh=KCeY86tv8Fiaj4hdrOr70454H4
 fi8ibvju0WHHAlmjw=; b=uXzafqju/gEunM7j5YYOVCAE9o3jWJ6bBUlae/2THr
 qx23gARtsLmDeNJ23EarOlYvRwec8Hy+ehHucTiuRY0poYiIrY7WVvcxGGuSyvph
 l44N8kXcIzrL6iTkmuxUtSFEahxxz1w407YmWupw/JJhzhV26JfTyWvag37VLjkc
 rt8RHu9sMYw6XnwSlET/B1Y4ZSP+yWMRama1kD8zyykKVal2604bgDp4nJN/2f1P
 m7LZc4Iq8a3Fm5/xL3w0jK1gDHFi/J13OkCgxs43kxY4QY7em9JBxMHCBxPofH7W
 TpmEkeIK0Vt8bLrIbL1HF9iHnpvRwDJFAkdKIXpxdr+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KCeY86
 tv8Fiaj4hdrOr70454H4fi8ibvju0WHHAlmjw=; b=s0JaWZ8XxK8p7bgGqPHxzC
 iG+uq89ijriMn6nEuh8j9Db5lP74foF15X2aWlTIjZvbm5S+03YWinYtLgesOP9W
 l7eaHlU4wr4cjrSXsyNQ9gruVg7ON/806f8uXpkpgHUko6bO0ES4v6uip9HvKsZI
 ITTRdnvdentRDix4ifgyCWl3WwZc4smQbLA8i3IPix2ouyZ5dJpadl5wsnPooMMj
 jcPTAYDaBy1vtUlM/Zdh5/hHmTlHV1wLjkmNaN5W7g5e1fj3HCYWlUU96s0qiO2D
 jq9l9+GfI7rWIsf8kgpdJUlhcgPuult9N43ckpO49ztYhBo2wlz+nAMvjy2OYZdg
 ==
X-ME-Sender: <xms:sZ86XFXL79dIySXZmmCBTqj2IXn2XV7z8Ufji_2DpEqJVfrvDn3vnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrfeekgdduvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogg
 gtgfesthekredtredtjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgr
 mhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtddrudefhedrudegkedrud
 ehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
 ohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:sZ86XJQylYF5Ces5VkQCt2DEIC8b1GAIiVCPQi-S3234O-aIgcZePg>
 <xmx:sZ86XLPbKnmebN_ov6Aw1Qh8l8J-QuRwYaOrMl-cBOvedvE0gAeEpA>
 <xmx:sZ86XPTMk79NEc3z3jaMqVP1Kk6hC7-Sanr8l5MoE9WXYMRXRj6DxQ>
 <xmx:s586XLeNL8vHzfQfwPk4mxA36HBx3KkvYmEOpMQUOmgxFWeUkOHCzw>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id CDF3B100BB;
 Sat, 12 Jan 2019 21:17:20 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 0/2] Allwinner A64 timer workaround
Date: Sat, 12 Jan 2019 20:17:17 -0600
Message-Id: <20190113021719.46457-1-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_181733_001244_83F2B1A6 
X-CRM114-Status: GOOD (  10.62  )
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is the third version of a patch series to fix system clock jumps
and other timer instability on the Allwinner A64 SoC. It has now been
tested for a week, and I've received no reports of date jumps with this
version. So this is, as far as I can tell, a complete workaround.

See the commit messages for a detailed description of the issue, but the
summary is that, when a high counter bit rolls over, indeterminance in
the low bits causes CNTPCT/CNTVCT and their respective TVAL registers to
jump forward or backward. Backward jumps (or the next read after forward
jumps) are sometimes seen by the kernel and interpreted as the timer
wrapping around after 2^56 cycles. This causes the system clock to jump
forward approximately 91 years.

changes since v2;
- Reduced workaround threshold from 11 to 10 bits based on reports from
  other hardare and the U-Boot version of this workaround
- Added TVAL handling based on Marc's suggestion
- Added erratum documentation and renamed symbols to match
- Added Maxime's Acked-by

changes since v1:
- Add an iteration limit like most other arch timer workarounds
- Added Andre's Tested-by

Samuel Holland (2):
  arm64: arch_timer: Workaround for Allwinner A64 timer instability
  arm64: dts: allwinner: a64: Enable A64 timer workaround

 Documentation/arm64/silicon-errata.txt        |  2 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  1 +
 drivers/clocksource/Kconfig                   | 10 ++++
 drivers/clocksource/arm_arch_timer.c          | 55 +++++++++++++++++++
 4 files changed, 68 insertions(+)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
