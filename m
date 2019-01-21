Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826A4C31D63
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5016F2183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bFeM7Aix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5016F2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7PpnGNPGMY9i9UO5HwMPCsBNCBDMg+WblPSaxh2hgCU=; b=bFeM7AixK2uIx1iZ3PcUQuu92k
	7hEsei0uSGhko+bL4obVH6xtxKzb/eJz1gxhnm92TsSQGBbjwIT+ehfZxhEsZiPAPLvesqtqpYIsl
	hNgz97LjTsoAvp/W4z+XoRgIOtHxOyD9IGtGTYjedh5u7lg9y0p2DY35YyixootdlU7oLX0LIvs09
	g10qEeguC/BiNsvKpEQWimjgMN8gDoMZVtmCmR4ZTPGFeQ5KPp6M1WIM7hVyy+JzLtsPt3oAPDIzt
	KqY+Uh6ufKrs7jvGf28F90GovbRKRclCpJ+JDkcfPs4tk+M//O2r2gz0dsX7s8nsqTobES4z+2nRW
	es9NkKUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glTkV-0005st-CA; Mon, 21 Jan 2019 07:11:59 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glTkR-0005rP-SV
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:11:57 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MuDHR-1h3z8S1wOT-00uWEh; Mon, 21 Jan 2019 08:11:49 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH RFC V2 2/4] pinctrl: bcm2835: Direct GPIO config changes to
 generic pinctrl
Date: Mon, 21 Jan 2019 08:11:23 +0100
Message-Id: <1548054685-3781-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
References: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:HcC3YhsT+2bauKvdEEGOrPCXuQrBd9lStqMo5dmBpX4xU3iJ6gM
 vSG8KEpJ8KRon7BouYqrQrE6IKcM2Qb73sC3CuJom2lV5oqNyXvp0N4tdGlSUCLnA0f6HYx
 uFlBasQsMq8iYwXKMlJyksovmIVdkULh+Xm/ftm4/NUWonUx7fzElPixcUPRNwv5E0eqJZ/
 GZQA2bHV2Y7R2E3jTVDNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HRA3uxP+rKE=:Ql3UICRv7t4vPPIqFw4Dbl
 wvVj4wY89tP1Tfsn9tcyLpAQRVk8nhlzy9qDecKypkDK2H/j1sVO+IFcAf34iMf3rPzhYlpor
 2LtAPCRV1pSsXenoIcCGofs+in77bfW7GEtPc6FoYj+PdLPd+XxhsMULDc0tfROckeNruTreO
 bbU8XPwdqpQMJeaxwiM8A1+jnrQfy7WTwjK8A4upbP3u48IsTgiLDsXkv3dGR0WyBujq5CpwN
 IL02EP49VVx7rwFO1MoSvBGMCDuudLYmLATvtcMJ5UWnAXLgEGm7lUxcFPX4N5DhjGcnkSjLM
 maiikidHDycfY3SIcXhiH74GhpL0Xh7QD9oUp9VMGN2YF9K43yaLHprT61HjEu4WL0TBqubKi
 ZzbgLM2PM+H91YtrS8eRL7f4+4Lag+HeLjdB4C8qCaQNgnagVnSaTyw+BSbvBRR4+IvGoMyWX
 wJIjCpqjPJ38wps/0O70s9Utth028pOP50BfcQxQv1QhVVMKgO/lVwRo7eWPZsIk5NYWtmP9n
 RbcukqTgseVZoyeNNdX412nXTkljNZX7N85uOmqR5XaKMaa7XMqBlDnuf+nLVfr7wRpjMb2Id
 tvwS2E1tQgiD6aFUqyD6tJRThZKpvEIhKy36bKk5BKPeXE2tSdVveOsEvSxlypqWDgAxdnSfp
 jfExfHxoH7KB0LlBC67qAkSSs4MypRxjW1TYCGIjlym0N+y+Tvb3KJuZHenT66UKePI1Ir8Xc
 tXoTEkJ3FIQC5pyfPYAFdwnAS9pFts8Ol9vKDtGci/JXj5gjvQ5TMWOSTbY=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_231156_222705_F0BE686D 
X-CRM114-Status: GOOD (  13.82  )
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

In order to support GPIO config changes direct these to the generic pinctrl.
This also requires an adjust of the return code for unsupported parameter
otherwise gpiod_configure_flags wont work as expected.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 19eb4fd..183d1ff 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -341,6 +341,7 @@ static const struct gpio_chip bcm2835_gpio_chip = {
 	.get_direction = bcm2835_gpio_get_direction,
 	.get = bcm2835_gpio_get,
 	.set = bcm2835_gpio_set,
+	.set_config = gpiochip_generic_config,
 	.base = -1,
 	.ngpio = BCM2835_NUM_GPIOS,
 	.can_sleep = false,
@@ -960,7 +961,7 @@ static int bcm2835_pinconf_set(struct pinctrl_dev *pctldev,
 			break;
 
 		default:
-			return -EINVAL;
+			return -ENOTSUPP;
 
 		} /* switch param type */
 	} /* for each config */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
