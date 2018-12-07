Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05901C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:12:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C790E20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uXSZJpIJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgRhhQF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C790E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iq1jfpFGbQlVFrx4uSbVEV/0OvqwKlpMDQ9anBiXR8A=; b=uXSZJpIJ0He9ca
	iOIXLTx7wDQuSYzO+7p3sr2XjXgv7vWOHG14h6IZRv764ABBK07OraAaDwUzRDY1UG4dS17lpu+EA
	imzQ9C0nM5O5b3DoXwD1yQRdX+TvC0CnmEM4D6qlAjZqqkt1b/RBE5seKE1LzT22exPNiMufqDI2i
	ObAkYdzg4cwyvU62nCef8yhc2NamKm8Ntth5aNnnxCbmhAoPF64C+pVdu0HcP/ZSWz8KJ910d+332
	F1XxtgnI7A00/yI+hW04tlM6LGiS1Fovv7ZrC32K6n4uaIiexznTdwdkJrDuzrplX3A7wjAZLEpmH
	xseJ54KNVRqqwJq65gyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLXs-000122-Le; Fri, 07 Dec 2018 19:12:16 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLXd-0000kh-2o
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:12:03 +0000
Received: by mail-lj1-x242.google.com with SMTP id k15-v6so4451269ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 11:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZR1ed9GSG9BdMzcMINLqVwYYXkRWiGYuUR9UH9XRe40=;
 b=SgRhhQF3xVp1KDgp08fv9DffIShhwiKHj6YQB3vVOnMBNVehZ+6WLxHJs/XR/x3XXV
 RramA5k69woEyGjasX7pehsmPFYvkRhX/S0slAOaIzvMolsZRg60hUTNvMutC2/PF5fH
 Mhv5lBueMqG7UFveIq8Jzz4m7AIXB3mTEWpNLe24PfeggvJy+fg68OtUXSmJk4CL3u+P
 S5mvI+m1n0SV6jGe5pxaXLKeH02sLq477sxQAmm6DhNrFrNQoQ66enLNNtpvAf4Hou1n
 LgplXDKSW9olCiMv/1W7VKQ7a6BkDWkKWZnf58p+jaFZb1d2C2eS+iweyyfdKHTs+kmr
 CHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZR1ed9GSG9BdMzcMINLqVwYYXkRWiGYuUR9UH9XRe40=;
 b=jyX5yAql+sJ4ZGfib0yfkVWAqEYU7phJTiVBFP1XU3hfQttHDZOODL+A6WtfrB4jWw
 ynbOYLmWa8laTgBsKig9BjRgmHeqtDIcEX5JfbheapbYSkmkAJMAKX/Ogk0d6WCXs6AO
 SzGG8EMf5OufwcHpw/MEtOYWwNWSanzrJlxedoAkiG4Zgx5gjeu/7eCWsy5ogzZZlXZV
 LxeLjekHUg+p7QQBqi60LU0W6WKESGOXMG3bYZTLrSG5z76qvLxA3vGDzj2HEp9MLCcO
 Rm5Watgv2EkQB5KkobrVsd87KRP4aLom/sFQmvrthUPrx9wSvhqvOVX+5XUVxfQ1HAvu
 gDsQ==
X-Gm-Message-State: AA+aEWb3IC0ZHen3cR0LbinAkKdRIhvhQZwFKNPY789frtBvO/4aOZK9
 hM5HkJfCeyaoGnDbFU7nb/U=
X-Google-Smtp-Source: AFSGD/XSJe4ggEk3jerCBEO2iFMLtGWx+AlfEUveHZQTQTwrAR8Za7Xm1j6vkGbY/KwGqv2VgZ+9OA==
X-Received: by 2002:a2e:1f01:: with SMTP id
 f1-v6mr2001283ljf.129.1544209908606; 
 Fri, 07 Dec 2018 11:11:48 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:45d9:69e8:d41f:b616])
 by smtp.googlemail.com with ESMTPSA id 12-v6sm727915ljs.29.2018.12.07.11.11.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 11:11:47 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 0/3] iio: adc: exynos-adc: Add support for S5PV210
Date: Fri,  7 Dec 2018 20:11:33 +0100
Message-Id: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_111201_127325_0DE5EDEA 
X-CRM114-Status: GOOD (  10.49  )
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
Cc: mark.rutland@arm.com, linux-iio@vger.kernel.org, xc-racer2@live.ca,
 pmeerw@pmeerw.net, freeman.liu@spreadtrum.com, marcus.folkesson@gmail.com,
 lars@metafoo.de, krzk@kernel.org, linux-samsung-soc@vger.kernel.org,
 kgene@kernel.org, geert@linux-m68k.org, pawel.mikolaj.chmiel@gmail.com,
 devicetree@vger.kernel.org, smohanad@codeaurora.org, vilhelm.gray@gmail.com,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 baolin.wang@linaro.org, rdunlap@infradead.org, arnaud.pouliquen@st.com,
 linux-kernel@vger.kernel.org, broonie@kernel.org, knaack.h@gmx.de,
 eugen.hristev@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset adds support for S5PV210 adc variant to exynos-adc driver.

Jonathan Bakker (3):
  iio: adc: exynos-adc: Add S5PV210 variant
  iio: adc: Allow selection of Exynos ADC on S5PV210
  dt-bindings: iio: adc: exynos-adc: Add S5PV210 variant

 .../bindings/iio/adc/samsung,exynos-adc.txt        |  4 +++-
 drivers/iio/adc/Kconfig                            |  2 +-
 drivers/iio/adc/exynos_adc.c                       | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
