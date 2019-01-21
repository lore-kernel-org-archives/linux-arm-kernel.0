Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075C0C31D63
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4C9217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CE+Ei1/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4C9217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JyaKpcxauLksqVv5s1AuvEuE99zp+vlU9PdWQMA+0VY=; b=CE+Ei1/ftQWdh7De5mOuOyD7Jh
	UyhB/DhVk7MsbdyORkYucpKAqMgRJjLzphM1eYuLbbgUp2TQiwb/iHiAXNLKTvyb0Zbwdm6x+l810
	rhIYfdY2/qU0MkGTI3ab3KojSfTBCXE5cz5lldIDVMNyhfPxFHhFxEg96kF6baZBzK/hTO4XeEm3w
	PSjChbIE1AHr/h0a4gImXpAzZrCyEP88ZINP5phKiJWVQxqjVZmtiMHKS2u1UAVIs7+2xuPs3Ku+e
	o4pdI18L3d6dr8zA59LP0vxoJW8oLMqiyq3RMXw2qOGWRFwgWfsCowNUQtk6iLj112g3b2efvyOv4
	Cd0hyflw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glTl9-0006er-26; Mon, 21 Jan 2019 07:12:39 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glTkS-0005rZ-AC
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:11:58 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N1g3U-1hE7TR3Kye-011z1m; Mon, 21 Jan 2019 08:11:49 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH RFC V2 3/4] pinctrl: bcm2835: activate strict mux mode
Date: Mon, 21 Jan 2019 08:11:24 +0100
Message-Id: <1548054685-3781-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
References: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:ga2DczEZGpOuwlKg3MRUo9vhM1cvRDr82fvOI9/as4tY/HxulZ4
 YJ+LRkXiTMvHTwNZHw4TXgYs/UGoHQclCwgibkEQG00cw1z7tOQsEdfL9+0+s4O/sn74WAN
 0bTRix8nrXzfU2t8Zp9ZjZNoQpKe6voZcDqaPwdy2VcvGPYFtFNpbXAHr1JXj/ow95AXrTD
 DceuXD7F4GKoD7AYPR0Og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VANX3WKyw58=:QQAH/sCi2M9FImUYl1jnMB
 VeeJsx4A6YBGIDce6qkURKNgBLyMTEsIXy4r5d1w2BvtuY0LE9O3u2yusfsnMkqOExlITYz3Y
 2TEh0vhovCJPmZ+pbkmn1lFeMbx/Z4dzwxjfmEcqdX4Gj+Q0jbGhKkj0+2OtctWQYM8FEZPm8
 /viEnhbUxRQnTPmRB5fNrK8mZhHfvh8RDonYcnkuYjf5szshCkgZ7YstnxL8L+S+tq+Yw7Sxq
 BlKlEc26+lQK3kG0D0lIdrFuhUojonCLL5gFwNtFwuT8qNbP//BQXuuPJ0EDkBUSG0PmoIj/V
 pLZ5KuMi4ZvwuYfPruR/FmiTmjSaXJ1tHX2Q9p2LG7RPw1pGQsAirdnCuDpbfBFGZpxClW9h4
 XdQ/I7YTYp38oZGvjhEvO1XDUJbz12ak3Qh13RFsMYerW9Ia7b0HxvV6DwcgchCOY5EW0IaV/
 gbSUWI3TPZgGikfXxEYDf3Cez7WR2KqZrMg3doh9Z75SPB4znkujVwYrXSUrmiZDsbnmd/nGN
 J0YFspETKI4pyGXQEWHA0oK8TryhVzuSAuoY6d409t1X4dYf2JblRJWkDNBUxq0mt0RjwAvVd
 kknMKBS4qSMZeRa1Q3R75cjbPBPSguBCn79+5UVUWVsvqqET7F2QDjfu7jFmuxOH/ac3ii15o
 nuUDkqfu2QtFiyzed3FdjE2WJL81zKHPw/vRBrQCFiOHyTcA27JytMsBXbjvBe29GocsyzXYf
 TOItXZlCmP3KSDCwxHqQVOPl2W7J6j5afB77v3jNAPCDr92EohWWvCylQ5U=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_231156_646148_A49040D1 
X-CRM114-Status: GOOD (  11.25  )
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

This activates strict mode muxing for the bcm2835 pin controller,
as the GPIO Function Select Registers do not allow GPIO and functions
at the same time.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 183d1ff..452e734 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -894,6 +894,7 @@ static const struct pinmux_ops bcm2835_pmx_ops = {
 	.set_mux = bcm2835_pmx_set,
 	.gpio_disable_free = bcm2835_pmx_gpio_disable_free,
 	.gpio_set_direction = bcm2835_pmx_gpio_set_direction,
+	.strict = true,
 };
 
 static int bcm2835_pinconf_get(struct pinctrl_dev *pctldev,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
