Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A018720851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b4qN8PpC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qttEOSB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A018720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qq3G3fL92KTmybNdP61popk5zaTg7hGEtBzmbTAfVhY=; b=b4qN8PpCU474Sg
	cpW5KXxqXEzIuVrvLN3gjac69aG+UpyXpmrMOeLDZmbC89BbMbIhkWvcFwodloSEw2fTRwuoui68j
	K1NBh1d9zav3AUcODWTeJ334QPEAFn855j+09k13QnjYAyvyaNmkJG80zKZ/gpQlFQeW/uNFtCJQQ
	YYsrluPC2OBDebb+HOWZ+M2SgjhyxJfoqXHOkvzC1famE+ZCdFL3lAbCryQqU+TEjSuuVBjrPImQV
	cj5dPJchVKNbCTOKKxTb4++O10yTIA46PXiv48exnZjRnuTcNNyP5SewIUSeHB/s9Eu4qavE+u9HP
	qZAaemUuhsyUeSgzGBuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlHO-0000E8-SY; Mon, 03 Dec 2018 10:16:42 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlGp-0007zP-3y
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:16:10 +0000
Received: by mail-wm1-x343.google.com with SMTP id y139so5094938wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hgaDQkDoibMUUGBXHBCGeXaaQAL52VCnVF1GrXldIPA=;
 b=qttEOSB6GTEdB2OuW1Pefb35HbJoo1ypye9EEESvp0KQdEXeck7X/4G+NzF6sEtQ42
 lCBi/SoHtLsgVKHmFmKTaf6ZNA7Tx3aLcmdqT7PYckms5U03hBMQM/ZXfVTy5ViRecPf
 /hhgkKie+Sv+Tv+9WkcSPMJN22IFiBeiJDQ4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hgaDQkDoibMUUGBXHBCGeXaaQAL52VCnVF1GrXldIPA=;
 b=r0VVnQTcim5smMMkZZyedG4S3DxlGlo2f+3qXD/LGz7hJtEsQIIG0mQKvZHKjrqwrO
 KWNXSWDsetdVJ+n1awCi1dxpYY/VF2K3SLwpo7P2bw6qeVn2ZjkjPdn7+tuDKTiog5Pa
 6U6UYdQBCEdZR/kdJihqSFHI4wwuEdtttSxTtoGujxe4xdJthIVbCyCvElQ3gFWwFQ/I
 zwZd9GH85fI/m+K9xzYsy+p13/GiJ2sqZJt6MQ80Jbd6xBE+L7P5Cl7HwGBP/lF7Y8cT
 KcYays+OixvI91JwRipZUEcpk5kkxPh56gwOHkmEkdQ1IRM0NcPbmeoR103xbh8m03iC
 LrUw==
X-Gm-Message-State: AA+aEWa5sT02gElJaFqy21MOKUI6oNCmt4IGONtoDRWqB4d7EiUjv7H6
 BNXnJ8sZ9CLK4EbeIm+7gNWJYA==
X-Google-Smtp-Source: AFSGD/Xwlld3xeI/VFBtGMFL3KEijSd8n3gf8wwOqT+DCZYgY8B5vXaZDaW2545VwtZiaF1uGzx6sg==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr8051912wmf.117.1543832160747; 
 Mon, 03 Dec 2018 02:16:00 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.15.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:16:00 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-sunxi@googlegroups.com
Subject: [PATCH 5/9] dt-bindings: input: touchscreen: goodix: Document
 vcc-supply property
Date: Mon,  3 Dec 2018 15:45:43 +0530
Message-Id: <20181203101547.16835-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021607_183951_00BFE7C4 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

vcc-supply property is need for some Goodix CTP controller like GT5663
where 3.3V external pull-up regulator connected via controller VCC pin.

So, document the same as optional property.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..604766e347ce 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,7 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - vcc-supply		: 3v3 regulator phandle for controller VCC pin
 
 Example:
 
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
