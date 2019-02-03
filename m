Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C15C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:04:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3AE218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="beqefetd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3AE218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2xyoyxPcKGduF08qBQpAZ1K5AlaFVj1jxnCpVio6ExY=; b=beqefetdFxiE5k
	XNSq8YMbZSmzeJMJ4vxWQ6dC3BMkBPoZkezNL9+stSf+IvDh5dkKlsyCQFEPXHOng2JX7p58Lf7vC
	WSW/lFrW4bA7VjYle29Akay8m+z6cYtYzlULaAsuc0N+DFsWVEhyu05Xjd3qOYqQfjOZxdzmLxhh+
	9j5OLv0W7ny/ScE4vliV23nEKI7iqlfjmSLfm1uM9L1c5CnBVMnThGBB2YAMihURSsHofHu+bF117
	P37guP3iQBe4aNq1Fl+BNA/P3VCaACggMWVYwfUbOm3cDo4Xitlu5hhr067hCxKjnB4zdiZWSl355
	13PS/Ksko1hzEV6o8vmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqKFa-0003ye-OP; Sun, 03 Feb 2019 16:04:06 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqKFX-0003xP-65
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 16:04:04 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 9547A5FD06; Mon,  4 Feb 2019 00:04:01 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Yong Deng <yong.deng@magewell.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 0/3] media: sun6i: One regmap fix and support RGB565 and JPEG
Date: Mon,  4 Feb 2019 00:03:55 +0800
Message-Id: <20190203160358.21050-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_080403_369000_DE14CB6C 
X-CRM114-Status: UNSURE (   8.78  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This series is adds support for two (three if you count big / little
endian) media bus formats to the sun6i-csi driver. There's also a small
fix for an exception I encountered while working on this.

Both modes were tested using an OV5640 sensor. To use JPEG, the patch
"media: ov5640: Set JPEG output timings when outputting JPEG data" from
my "media: ov5640: JPEG and test pattern improvements" series is also
needed.

I prepared this series on 1/18, alone with the "media: ov5640: Set JPEG
output timings when outputting JPEG data", but ended up forgetting to
send out this one.

Please have a look.


Regards
ChenYu

Chen-Yu Tsai (3):
  media: sun6i: Fix CSI regmap's max_register
  media: sun6i: Add support for RGB565 formats
  media: sun6i: Add support for JPEG media bus format

 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 27 ++++++++++++++++---
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 +++
 .../platform/sunxi/sun6i-csi/sun6i_video.c    |  3 +++
 3 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
