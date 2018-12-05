Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2550AC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8C8206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K5i480a6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8C8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YkfYkOM5GncWBhbmZCg0h5YZggqCMakmYs+D2u/kf8o=; b=K5i480a6k79dwK
	gUO+YY7DNgK3Vw2G52M8pH8cgSVDMo+8+JNjhdE9K8JmjRp/+FsQ91i//6XN6MPBlPa4onxCJQ0UW
	95dPg9NiunIRqX1dCCzoM5tXlIMjyrOXzMdPkfg1vsaMD7jMlcCiVmBhdSjMcN/5CUG/dXsXuRvT5
	6t/iPNs17lyytyE9O4C5IFkppBBvtCk2/R+Zrg2Vz2orkjP3kH0ncQ6FkKZM5B8G706ViyhtkK1jM
	jJ4KHg0TqunK59iKBIijcyPXgFThjuw0U9DXj2h0w0avubMH5psv1yKkZ7ZGXoh7IMulEo4xgWBwh
	kYQBk/X3+KexAbz7MmkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUA7-0007ph-0W; Wed, 05 Dec 2018 10:12:11 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUA3-0007n5-UV
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:12:09 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 50CDD5FB79; Wed,  5 Dec 2018 18:11:53 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 0/3] ARM: sun8i: a33: Audio codec improvements
Date: Wed,  5 Dec 2018 18:11:49 +0800
Message-Id: <20181205101152.22983-1-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_021208_116045_18257749 
X-CRM114-Status: GOOD (  10.79  )
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
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This series improves audio support on the A33. Like other Allwinner
SoCs, the A33 requires the use of a sigma-delta modulation fractional-N
PLL to generate the correct clock used for audio playback. Otherwise the
pitch would be slightly off.

Patch 1 enables sigma-delta modulation for the audio PLL on the A33.

Patch 2 is only slightly related. It sets the CLK_SET_RATE_PARENT flag
for all audio-related module clocks

Patch 3 lowers the audio codec's oversampling rate, so that it can
play back audio sampled at beyond 48 KHz.

This is the same as what has recently been done for the A64, which
shares the same audio codec hardware design.

However, on the A33 it seems the PLL doesn't always immediately lock on
to the new clock frequency when there is a rate change. Also since the
codec is only put in standby instead of turned off, runtime PM never
kicks in, and the audio related clocks never get turned off. I'm still
looking into this.

On an unrelated note, if you get pops when playing back audio on sunxi,
it might be related to cpufreq. Try setting the governor to performance
and see if that removes the pops.

Regards
ChenYu


Chen-Yu Tsai (3):
  clk: sunxi-ng: a33: Use sigma-delta modulation for audio PLL
  clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module
    clocks
  ARM: dts: sun8i: a33: Drop audio codec oversampling rate to 128 fs

 arch/arm/boot/dts/sun8i-a33.dtsi     |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 43 +++++++++++++++++-----------
 2 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
