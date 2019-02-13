Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09A6C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F251222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y198686J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oz4kZU1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F251222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6u4q53dAbWpQtFzyUUPEn8gq6Hyn/8g+HhR/u95OX64=; b=Y198686J6m2N+HRApybsLJdyfQ
	rXFBP44ckI2QNRPFFxQ1JfE9buRDgO/UugopoBSpyLYamz0AUCZx4EA4NoFjRERcPEc7ltC3ETnTN
	VFerY3c1hZbzjinzullXu59atPJbp0lkRvGM6NSxYzmzQsVDi57ST8zp7DdKAGUpUxjXVWjDalJTL
	VPOWvI7xzQUZU0TfEuGacS2YCYV43F50vIcjUOn+wKF+OG36wBYlpf2NklgsMefneknlM3tyhabU/
	OuVYO/2CBA8XRc2juA5k9NkXkryTFi8DG4VnxYgHaKuuoayfyciLwLt0NQqQzSCM9utqgCrPE5HB5
	2pRXvakw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwAe-0005vI-3Q; Wed, 13 Feb 2019 15:09:56 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwAO-0005cq-SS
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:09:42 +0000
Received: by mail-ed1-x543.google.com with SMTP id h58so2218144edb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=swOxzW9vMk4pzi3UvIEu4I0VThBe9QbWma4JZoUhk5o=;
 b=oz4kZU1zvj7oAr/tvZuyugE38V7Y1AP5XsNMajS1ZIWonUiDl4HDeF4IZbUGJsot6x
 itKQBwOKUfXN2e6CJKPOvKG6Gui+HBa6mhBorBw53pA09TBkkTti6LrTmrU3za5/HoU+
 +PaMpjg/BOSphEMthFSdaIIN39t/aLmanQ/wj+DTbwWfI49+o9eKhwFCu10qjnazKLeL
 lyxbYctZGEogsFpmvp1upxzqYRVx5sNmtaJE+j7GUbUFKsy0vNW9gnzI6m+XRKx5p+Et
 +WxOyC0KUWrIlbjmaqCr27SM+lfqiSmjUFY1rgIpuVH1aX569wViOpReuKvqXd19y4iR
 v5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=swOxzW9vMk4pzi3UvIEu4I0VThBe9QbWma4JZoUhk5o=;
 b=NZcKg4yX/shi++VmQfhjLc1K5syiD2WIZ0cZzjrS/cvD3GYkWw1mX15wUpJDXUMwNq
 8ZEd0PJa4fyW/jBaH9nHT6TFU+GOu5H7knXY+i6X4PMS2NJFVDQ+KdDyH+C3msIEWUBA
 B4XEblmXzkfZf5OoYhxCdoK+ewZ/zqZQEYbM1OVdg9h4PnIsK9vN5/LcoujXOtoaI7S2
 fgFTBFV5HmWSjSwWAkCnXfvpzdJsgLeZOdkqMVpI7HFVyHFHsX56z1B1AtBumvohuuBx
 KkvAj7F+wRLFecCN3FWaPwx31V1v9Oj0M7W6OiX/Kse6kZZqRk6yQHyf314f+42qGScU
 e0Tg==
X-Gm-Message-State: AHQUAuZFwaXouMY5s2f+PMlR/CZGzgZplLvSirwLKNJVWwPGaTJVMqWh
 1gU9m8YDVb6EWx8RUhV8FLYdfQ==
X-Google-Smtp-Source: AHgI3IYK8BjdKw5IxA6WwhOK4/YgwYQ9tO0sg+FqNKjbt184GrurwgEAufFPexUsdgvkOn0euwheRg==
X-Received: by 2002:a50:84a9:: with SMTP id 38mr747853edq.185.1550070579497;
 Wed, 13 Feb 2019 07:09:39 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 ([2620:10d:c092:180::1:4505])
 by smtp.googlemail.com with ESMTPSA id k26sm1903941ejv.63.2019.02.13.07.09.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 07:09:38 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: Add vendor prefix for "GlobalTop
 Technology, Inc."
Date: Wed, 13 Feb 2019 16:09:26 +0100
Message-Id: <1550070569-18588-2-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_070941_025900_5B29D830 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add globaltop vendor definition.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4: No changes (Reviewed-by tag added)

v3: No changes

v2: Alphabetical order

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..d80a70343b36 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -150,6 +150,7 @@ geniatech	Geniatech, Inc.
 giantec	Giantec Semiconductor, Inc.
 giantplus	Giantplus Technology Co., Ltd.
 globalscale	Globalscale Technologies, Inc.
+globaltop	GlobalTop Technology, Inc.
 gmt	Global Mixed-mode Technology, Inc.
 goodix	Shenzhen Huiding Technology Co., Ltd.
 google	Google, Inc.
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
