Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33E0208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u8c27u1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33E0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=k2ULyRMjvZq8UNd4AVELgRIb9iuRUapC7OpMrfSN7/g=; b=u8c27u1VUFCdy8
	T8ZOFnxSd9b16m27orOavEbwNTScb9KXl00JfMbTeWFox2y/bJfXOXqBHVPPXajCePVjV1cd7sgTD
	W+x825js1ov0IBoM4GVrvoWcbmiT3YTWpBKEkyI0rg2lNRcNwRY6KMmXOdrOe+9Dqprne+XDE4JPb
	0ZTAEsFhWePXwZxNIl3FcTCVsk9BB5wMhjxYd9Xh3Gh/ql0NjoWLWZ7J1O+meNwjd1lt3Xfr/iAbX
	Z44TN8todt2ESb9kZ0o+iFxRrA35efORyEu4lljxR8hcV1cDsNd872sC52192TOL9yHvPn+RFNCIr
	gq7KbyGch8BFy1bpiUvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUdDM-00022l-U4; Wed, 05 Dec 2018 19:52:08 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUdCe-00014d-TH
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 19:51:34 +0000
Received: by mail-ot1-f65.google.com with SMTP id a11so19778119otr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 11:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MPG48+BHkPOoLEArL9+pShkufe1g9loOUtNtC/iMJ6U=;
 b=Y6BxKsztAh5ZLhrj4cCW0bOCE4FTa18xr+QK5qeTasXWot8GKF0S7NCrigwnYfccwT
 uMjALjR1SlpwSIAtLytCQPkpsbgPvL4VFVX5T+HrZ0itcHZlXsl016xDruwGtdFgjOyE
 qhcUdsdRb6q2qdbkm4yj33AVtV8FmgJTMQ+8DD2+z+UV+CICx4asikzcoj8/2C2n3p+x
 2nHUTK3jdLrYV4r97V7WIzftgdYuLO1mLEzj/nwreBu4v3lsJ3xQc4ypwRqa9br7Vp8Z
 ckSzi2DRDb1pSS+dCzMkNe7Vi498XnCigXjtc1VD1wc9qxB98a2KWB7/ED4XmKlW+sOi
 faLQ==
X-Gm-Message-State: AA+aEWbLAIO8HZ2SXjD/swU16HS4UXalPzBGyFNI4zOhY8RjExHaXB7q
 9qtBelYqLjzyO5qxqb1PWA==
X-Google-Smtp-Source: AFSGD/Xc8OIRmd4dkQH/FjRfjmRB+sE8C8oX13ZL74lqrkOR+KCm30hgliWm3EImKFf58i+LPeSkUA==
X-Received: by 2002:a9d:18f:: with SMTP id e15mr17158595ote.84.1544039473605; 
 Wed, 05 Dec 2018 11:51:13 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:51:13 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:36 -0600
Message-Id: <20181205195050.4759-20-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_115125_817410_EEF42C81 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: linux-samsung-soc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-gpio@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index ee6ee2338606..de0477bb469d 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1071,7 +1071,7 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 			continue;
 		bank = d->pin_banks;
 		for (i = 0; i < d->nr_banks; ++i, ++bank) {
-			if (!strcmp(bank->name, np->name)) {
+			if (of_node_name_eq(np, bank->name)) {
 				bank->of_node = np;
 				break;
 			}
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
