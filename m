Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41FFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:21:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10A5206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jmtv6hcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10A5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ocKOIeH7kR1tcRyzZ7kQRO0ybkv5/NSGhkxr3z1C348=; b=jmt
	v6hcstfT1tpxYoL0digh+9cMBAju72tHzoJFOUy3ri3vQ9znpNm2rPb72uoLVsnYQV42vTbFuq773
	XUvIS8otAeIOQedX/jVtCeU5QUO3+b4FPEnCYLkS4cJjAeHAtV3etgL1LNb6vWWtWeTrCoZWH0J2t
	GAv03LsyXDvAzNxahM2i/uF0NypNz3i6YmIP6hj5/MXzgWCQN2g55yL8TEgYbzIgbWnZ1ODbXf2PS
	hHAUXIywR38lQUgg3vCpczkehRvmp41UbI4RbvVmHHxfXqnnU9EMWOOABiunO96Ec+2ZL7Rw9PZvk
	2crUr0M4wRwag4je3z4IvfpK16XwTZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs59v-00045b-Ea; Fri, 08 Feb 2019 12:21:31 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs59s-00044b-47
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:21:29 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9W78-1gmYq93Ydo-005cPP; Fri, 08 Feb 2019 13:21:17 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH RESEND V3 0/2] pinctrl: bcm2835: Improve generic behavior
Date: Fri,  8 Feb 2019 13:21:11 +0100
Message-Id: <1549628473-4485-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:RFVwJSPD1zAqP8p3IEKiknocZv5TVG0+TOPj2KW0ayt9uCWosjr
 t9Q5EpIs3zc46xGm2+pgqUadgcdw3DiM93XFL0lEoH6NXoL8w+82TCqVeqnbXgsskIYGTMt
 Se1YhxkPS9RqZvWtz+lLbUnm1KAZ7HU9w+fk+YEIxHsxZwBNy3U+VlKZE4WRHe4ojNUc2/u
 BmVD/dlyOc0PWWeUV1DmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VNrQw2oA5RQ=:S/aCAuaH2xYYduBO0hN5ch
 LH9oNOCMaPUXenpRZvmiFcID/PqA5EGhG8tDhaUrz0F8Znjt4CtwvgI+2PtQXTGlzhyOvXzq4
 sM0q48n0ux7yInB7Lp7NdUG+lY+8AzjjnZ+bZHUu/sC0xV6azqHbtE2zFIAc9L4Q1kAWklMUc
 Cx3J+p50BYjg7c2cvdy9HbMrg2GCk+DftUqlT0KHX/fEXRawdnQtqh/MeA4CXW3qXnb1Ln0fm
 5vH70l5vhvm85m6S1io1p2LOf8/Nj8l6HfR+fLZnBQDA1YExyUgvTHQPw9maRs31jphQpqQcd
 d0IM7rm030qT2LQvHTXP4Lvw1jmMClv6scrZGK7mHmKus+l9yeP4maCreu3bctUpIaEvJrzmy
 j77QcbcmTr6sOPSaVRBuI3nh+vjREIRxiYTy/027vH1KKDD2YBwZ5RZVM1W+GLTDiSXipZPnc
 TkiyPvY/h7BU0e3OXLL9r/Ucjk+qd5ReTZF/CU9LnuBpgrnqb3dZkm5+2X/rOwezMbPbLuisE
 52HFOmj0gc2zav+Pki7levkFi9uvMAzpkHvavIkTfG4TQQlvVPBBkMjhVv2lVX4OblY+lXMTv
 yjN1Rc04ETKRYDHpawCAyzQX52sqoJz3tuKXvwF4uiOpxJ5HexbBo+yysUSDbf2wbNwifKmJv
 +1CRbMcwpclzT7dQ/A8jR8W7DiqDiEn+thQi9rCLtTGNglcCpo32eq3tjN0L/2o6dsUMQ+9HK
 6ke+661fVi9Vd+NlGBYM6lTQxP0OkxA3EZA+6h/y4ilCXGd5bgn1zZtQ8fQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042128_480394_FB98F633 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-gpio@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series is the non-controversial part of "pinctrl: bcm2835: improve
libgpiod output". It has been split up in order to apply for the next
kernel release.

Changes in V3:
- drop patches #3 and #4 from former series

Stefan Wahren (2):
  pinctrl: bcm2835: declare pin config as generic
  pinctrl: bcm2835: Direct GPIO config changes to generic pinctrl

 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
