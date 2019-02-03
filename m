Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B168C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:03:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEC420815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g3CP0E0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEC420815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=np0YqZR4jfYJjpme3H9r1zck6vXhzQeEGCcSmyTBwdo=; b=g3CP0E0xsQXajXY47S+/WeJ+LF
	QheCooF/+ypkvrWKg+0G/uay+ZnGADQxP9NKHAhvfWDc6+hijYw69uoEvE1Wl7CcojmwDzM1f69e1
	8Rl7nPmp46lZQpNT5LZDEvMRPdnqjbeqynz7KYqopIUjUNpdVjRAKzKo1OIzJJ2PwHAVw+7lnp9fv
	Ac99Pjq/m2vB2Aq9fBFOsN7TkNtqlRyKPcecpon/v3hEjLE6C3E2LlHsYcn01t4QblDxaR2wCWXdr
	5BwAta1D7Wi4D0bQf163X98Lx+gV5HxNll3BULrfU+IN9dZq6UcL5Na0gL6roV/L24V9rodqHhskf
	z54Iglbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqHQh-0002xI-OL; Sun, 03 Feb 2019 13:03:23 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqHQe-0002wH-De
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 13:03:22 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N4R4o-1hEmV73hgc-011Qew; Sun, 03 Feb 2019 14:03:12 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH V3 1/2] pinctrl: bcm2835: declare pin config as generic
Date: Sun,  3 Feb 2019 14:02:33 +0100
Message-Id: <1549198954-4711-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549198954-4711-1-git-send-email-stefan.wahren@i2se.com>
References: <1549198954-4711-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:RDpL/kSlysZ6fI4hy7NOzuhS/Z4sy74A0n3IpI6+yVmaq/zetoL
 d5TIEK5mzkUQKxCu3J6EijedX23tyFEg9g1xTB03v50sp/bLsu35zR+aOK7NNRIFzjvIbsN
 EZ7sfVKYTGCsngriT66vacoXdPzAoPvVyYKZjiG2C7sUejb0UzbKTE/cbQ17vmJO451SIgr
 wtDaBbUyn8GrqgyoHjlFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kyJ1SNTl6ew=:VJgBRWtQ+/DQKgA3hPrBPV
 zhvVT4vgkvJMBdGkKm8LQwbG+lxGn2xQy2guTEMnP1bSejEDgJ18Z00dhJnKgh8/pVtKTheDW
 z0rM/0kg7TpDO3YHy0Z1Lu1GhPTjoHX8Qax9N5b5gBQY+TeELAi6NT8xHp16mrSC3hkE8X6Ee
 q/ZxmRPfC007aBHa4KEgL0ghaQY9eQYxZOeLeA5CoYbc1fJbVYRe7PGzAhXpFojWSSnaPxQJG
 6XR6CiYgb7qCKw1Lt+oGSFsGWCerRhxiVRFkHYi7Dh10j3+SJAFfbTBquLtkp5R8GqvuGr7Z+
 mMUdhJxYFP1iUw1+yCW8eJWnZtS6U5Ua/DVhl3ovIVhA/VVgxXcDxujXbqJp2MJTcmD73WEAP
 nWFLtM4vThIYcy5iSnzj/QEpOhQ4JtClOOZdTFgAUVj29kMBKp6yzhU1poGrcMnBUxPxWPKO7
 195onovSb29bOBVdMjUpnZVRHL4Npyj3Cu4GP0JeTHwd8ciUMxQ5nQSzlzB500no5yORtRV70
 N7GL9jqUNMZqzK8LitWTTUyvF3xII7kRm8WZxrplm7rVNVPz6cB7Qiwk4CzTssCNf4TFhG1Eg
 rJbuphJ5psiYQf0n00oAb1y5BpbS6mVoDBu4K6YxXaWCPXqmU3dP4phZvdXhHAsuyo+7/2MLg
 3if9MmwICahG8mj+xvk8hWBoOwcn/eUlhzaq1Rvi9DDmoDXhlB3D2CNIN4Z9rU1OkFpk7QMoW
 YCKxLbOARSHpa3lbcSowXmsqoB4KsD+FjZKYlL62NB3zs3NBlTRXlJNJzh0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_050320_756194_59DF74EB 
X-CRM114-Status: GOOD (  12.40  )
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
