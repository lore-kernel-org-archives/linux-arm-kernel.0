Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7019C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:21:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7670F20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N/2xjlbY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LanoK9Fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7670F20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fK0R59qDFm7J5fcf5NzLFzsD1fw0NVz8Y3Wiv3+JLwU=; b=N/2xjlbYfYC+8+
	Mw6cHJ/YX2wCcPdITj0qPJWm07rua3u7kW2vcW4Z8atQd0ObotneLG6oYvedcjZAyjYxDNHAgdK91
	VULQkYdMEShjYztYioABcT+Fo4Jq7BEx7QcALnIblec+yN1eP1EWTZdUFgaVF7f1kNEmvqKTtHGAx
	12COEfuTpay3wWNkFmY1/nhfJmU/7hlkJNpAMkRhigOqJKBGEp4BcqAkTTxJgHjfSGo9SVNxo6cA0
	NNAs9ajodrAUpi5OSGjgx0uwV4vBPgmzuzRK4x0liRKI04x5is20zXQh0gREeeMh1dNNn76yUIeEw
	T9HGv+PQMeK07OAnkgtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjnwN-0004La-5O; Wed, 16 Jan 2019 16:21:19 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjnmm-0006NG-FB
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 16:11:34 +0000
Received: by mail-wr1-x443.google.com with SMTP id s12so7582232wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 08:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LDr5HA/Xz+XFJL8rSCgd+oCXVMfCO13lm4Kef3RvTeo=;
 b=LanoK9FolMz6mPf3K+0ED09NHHZR5+oRYTxu6VW5YCMcEsvZkM+MDQjs9+V+JBtjUr
 UkGQwHFVafDCQTPu8rkIR7n/2KuGjGqmcro5KX6f7fMFnHewpHEJgATvKWWDJzZjw40E
 6U2IFpyFROaEIcHTmOawdKGAsh/lBQR07pF0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LDr5HA/Xz+XFJL8rSCgd+oCXVMfCO13lm4Kef3RvTeo=;
 b=AIhvng8XXl7TasMiqKaa5L4wjj/9Jjg/02RHaB24APzwUvS3RMMx1onXvL76wOZDvg
 77KKn+uZF/zza2DsLaU1f1l0G4tAXGd+c6x6mn9Bi0PF5K2wiegDffGViHngjepxn7Iq
 EruG41fvnAkoTCKRzuoOtCJDErWg4wOqscGemTWXZoOb+7YuXzf98W9S8z2jmRSDi4fo
 vTE2zOmjbel0g0sKav97yUy9Q1jUCjz2oBV+/pW/KccCD6SK1sFlFlEpdoDbt1fnBJ4v
 TNwxD/h9Q9id4SRjPnoBk4rgBcbDZwlQZ1OPSTC76ZdBgqWonrUEDpTsV97hRqIw2KK2
 Wedw==
X-Gm-Message-State: AJcUukf9BDGhFPdh0T7CNVWMx0i5Nh3rB3MmU4KwkieVYoiVcet7QOaF
 aLFnIs8CoIKL7BM6cuLxuAQDgw==
X-Google-Smtp-Source: ALg8bN6CC3lM1Zi300TtDtZd4tlTOD+K7DXx9f0Kg6hP4L+7/r5db+LtNlCzNBye94gqLiSEffapgg==
X-Received: by 2002:adf:9542:: with SMTP id 60mr7901351wrs.60.1547655083058;
 Wed, 16 Jan 2019 08:11:23 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id a17sm78193407wrs.58.2019.01.16.08.11.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 08:11:22 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH v13 7/8] MAINTAINERS: add a maintainer for the interconnect API
Date: Wed, 16 Jan 2019 18:11:02 +0200
Message-Id: <20190116161103.6937-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_081124_877047_04A5787D 
X-CRM114-Status: GOOD (  11.07  )
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
Cc: sanjayc@nvidia.com, maxime.ripard@bootlin.com, mturquette@baylibre.com,
 daidavid1@codeaurora.org, bjorn.andersson@linaro.org, skannan@codeaurora.org,
 abailon@baylibre.com, vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
 khilman@baylibre.com, evgreen@chromium.org, ksitaraman@nvidia.com,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, henryc.chen@mediatek.com, andy.gross@linaro.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com, olof@lixom.net,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add myself as the maintainer of the interconnect API.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..00a12cd11aa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7883,6 +7883,16 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-intel-mid.c
 
+INTERCONNECT API
+M:	Georgi Djakov <georgi.djakov@linaro.org>
+S:	Maintained
+F:	Documentation/interconnect/
+F:	Documentation/devicetree/bindings/interconnect/
+F:	drivers/interconnect/
+F:	include/dt-bindings/interconnect/
+F:	include/linux/interconnect-provider.h
+F:	include/linux/interconnect.h
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
