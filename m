Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4FEC31D63
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A789B20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SpeDZyzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A789B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=np0YqZR4jfYJjpme3H9r1zck6vXhzQeEGCcSmyTBwdo=; b=SpeDZyzdcs6DvgzmLxyb1Aeb41
	B4w3TvhAkKxUtIrDISqYUEFJhTXuYqN3GHoWH4zILr7UkKU9iII9Ulz2ECSdOwSSAgssf1k3PZOIl
	8tlh6NMpm2hi4O403xeJt9jk0K3UTSQ2EO/zjdHz6iC4L7ophPeqjLpBtZjsUQ5bmwYS1hSk7iC+t
	OPAJxOPm+RDrhFVIVYFIqDTfbp42whedOPH9QuriLfrHPbyrLTyM1iTiH88ITHei9cTt3MvJiU6r+
	3UECXV9UGNOmrrFg/8QTgL7rkNniZYtRAnK+bx3uCwZ9FzYKKKLhbPqedGiSS7D0StBL80MvQ7uQX
	iP6w4qBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glTla-00075b-OI; Mon, 21 Jan 2019 07:13:06 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glTkS-0005ra-GV
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:11:59 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNL2Y-1gaxF10XBi-00OmO8; Mon, 21 Jan 2019 08:11:49 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH RFC V2 1/4] pinctrl: bcm2835: declare pin config as generic
Date: Mon, 21 Jan 2019 08:11:22 +0100
Message-Id: <1548054685-3781-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
References: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:W7iJvxvpubaR/TONDf2upar557qi01vEM4uRb3VUHw/fPALSWZx
 HBNKTCOki5P0HuBnxLg7pjiyYa6K/4CkgQdgRf5PFnK5iMmI10oKjhz0/Z8L226ikWIMUbR
 XJgU6E0q7xGBDvXHUdmlwFIz5kiTf0xP8uhHvwnmTQ9vI4fQHjs5w8GUsXtWLpb0ibljvdC
 VNI5q1TxAzwTbSSjY+ghg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xX4q+lVYgzo=:QUZs/UiJXc8jX8nUUwBYUV
 3684mmJveHLbUIKoUcMgaHJqwALTUH37Cj3B2OLTMXTESyLEyy+ncU7aYwSEGgIHKrZ3bZwpS
 Rw0rGBy/vXoiQN/lOJjtOPiL/VWqIQ8ihgBkQMsZ1COgjGS3c6MNX6bVO8y+66dnDo5xkkmdn
 AxKVYBFf93lw+fxz8iD47LNNo+JFijY1MuV757jnF5P8bk2TjxjToT+kDFraeSjsFObG18j9a
 KmTp7P+pyp39pW3UBM3T7aeVv5xxk4RmZ7tXlGyYEdrIJ4dCUFXHKrFuS1+KJs7+5j/s69Q0V
 j+lC6Dvs5RU5isKb2y8zA4dHiLMOR7GKCR7J9pf8lmdmgXNuGwFuNdXgo+0N5Nqernn0Cjphr
 boyi+eK1+hbsSyDi7yzdIlHUafXkjOidKpmA/Qw+QuRz+nNGu7xDD1hwDVjr6j6eiwV04CSB/
 d/J5a4NQohOz0XyrM0BmkdhkeioEWnM8/Qu8Jf31a0each0Bn4v2BDHMKDQ34fC6wt6rImJgO
 6nUi1oNI/VlAMv/NkMnoz3cu95Cb8wW64UgOfQJ9VPaKWEzJgwb3Bv7qSsX8mqqMLmHxtkZ9p
 0dmXAXJXcj8JQbE9iOiUfKe/wTMEeA77473CzOg9rj9DINB8wtTgRvDoDLVP0VoD6TGwNwy39
 X96w5gi6EoRPCGx9dsC70xrQJ4ndUnBFagwHo7uKe1m3PDvZwg18mlg2fprIIQfHmZ9vvUFkW
 0KAJyqp2VE2RF/1y0L6oUe4J0MCi2rtNPBbpn4kMyOH+FLXxf62g2EU1mYM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_231156_841469_ACF91FFD 
X-CRM114-Status: GOOD (  11.92  )
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

Since commit 0de704955ee44 ("pinctrl: bcm2835: Add support for
generic pinctrl binding") this driver is capable to use the generic
interface. So declare this accordingly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index f180aa4..19eb4fd 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -969,6 +969,7 @@ static int bcm2835_pinconf_set(struct pinctrl_dev *pctldev,
 }
 
 static const struct pinconf_ops bcm2835_pinconf_ops = {
+	.is_generic = true,
 	.pin_config_get = bcm2835_pinconf_get,
 	.pin_config_set = bcm2835_pinconf_set,
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
