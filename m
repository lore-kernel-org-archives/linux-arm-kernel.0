Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDB0C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8593E21916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="smh/bqF9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="KJPSI94h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8593E21916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wVHb7futA5N/X36e44DUQ5jEOAyhYMoeh+3trd5y/NU=; b=smh/bqF9zwIxmpt6p1sQpgWU6a
	L6YjONk1qJFmA8VK4RZ0MucEIAVHBEEuLu52kKnprPzlduUHYVQdcv1f+wl2XGH55zts6m3bcPkBL
	5Z/W14dNy2ur7N1Canine2wJtgHjEdB4Q1F//SZb7M0ZCmF5iWC/W2SqseNkGHyw7Z3RbaHpb+Dlb
	u8NVYcA4JuC8xOY9/XQ9pFNB9sd5rvZrjc7svJXJsuFc6Crvmk5wsMympqjzxWcJFJCgutoM7odcN
	DB5OiAn25nCPwStu0aWIMgBTzDlR1ly+9+E0CkpNFGFuv8SgkN39Wm04p4kejQp2nZaJd321zkBqD
	EeeSUnJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjXs-0007I6-Cq; Mon, 18 Feb 2019 14:05:20 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjWW-0004ad-W3
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:04:00 +0000
Received: by mail-ed1-x541.google.com with SMTP id m12so13903224edv.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 06:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TMKsmtSeB2s1AaZbZadZjj3xF8b5OyVicGrn8cs6Cxc=;
 b=KJPSI94h/3tr09gSDgWJ5ok7TSJC7JE/SFp+CPCPi5fV/xhzlIP8m+1T5aj3kNAVCS
 xawDKsAC8POcScc1qfEU3Mx7JR/0TIz2paMShO/Y2zlRdoxPpLXQcVNXOi1BkhNbvT5t
 k0Dsnts9zdDl5ya7+AE5PYVl1eet6ZUddv22gxrkx+FfPCHE1QFt1rqHB425oMLtX2dH
 DLj9oeRh/NaIiuETNkVr+lgZUDEJeC/mlCLreb/nV4Sgwr66LdO2XTOmd/gnnQ92GugB
 s6PgCWxnsmxMFnaVMIB24Cm2z6lH0e8xo+pB9gUvDoZQ5IXH9k28jMdD5ZInypUxMlVn
 vJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TMKsmtSeB2s1AaZbZadZjj3xF8b5OyVicGrn8cs6Cxc=;
 b=mPETp4SpGsnyBTescQmnIWZjJbgUDySqFszvD0n75DYMBE7ifpgu8/NvadHFeh6vYu
 shnUcCvCtdwyuB0dZpA8dARus0GdHacgMdo6yAY21XEz/YJKsBk0JX9/dKvVmVnLnU2E
 sVsSLyIP5SKTUNOZADBrfPnY7rW/buuwzEwwyyKHDPneyjyxp77tmSY1F2bhENtitOPm
 MBwrkRTXqXAd50WFzBsYLYohwWm4Ndsmmw+pkYqukxQoP41Lmb9lfJY4G7GSEtMrSLdJ
 yagpUpO1BNw4bqP1Q+jUhRxwAnvdWC9wI8dAzl46Uoa4SkKL8mcbEEmpuiW9U8Bi1X1j
 Jd9Q==
X-Gm-Message-State: AHQUAuYkrR6WyE1aH8BG8hvBFte/1zrL7/GHRKBtTijzHD7Zjwmepqnj
 YPm+QaVKO1VKI+wgzJH3Rlcggw==
X-Google-Smtp-Source: AHgI3IZWqJlESiACGZSBuFtcSlgUTXzB5UwYLjy0fJjTMr4Yq/bz8Bc0PoTINj2B3ihTtaQ8an9+iQ==
X-Received: by 2002:a50:fc12:: with SMTP id i18mr19300418edr.149.1550498635286; 
 Mon, 18 Feb 2019 06:03:55 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:54 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] dt-bindings: iio/counter: ftm-quaddec: add poll-interval
 parameter
Date: Mon, 18 Feb 2019 15:03:20 +0100
Message-Id: <20190218140321.19166-7-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_060357_415628_ADDA6059 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: Patrick Havelange <patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

New optional parameter supported by updated driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 .../devicetree/bindings/iio/counter/ftm-quaddec.txt       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
index 4d18cd722074..60554e6c4367 100644
--- a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
+++ b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
@@ -6,8 +6,14 @@ Required properties:
 - compatible:		Must be "fsl,ftm-quaddec".
 - reg:			Must be set to the memory region of the flextimer.
 
-Optional property:
+Optional properties:
 - big-endian:		Access the device registers in big-endian mode.
+- poll-interval		Poll interval time in milliseconds for detecting
+			the under/overflow of the counter. Default value
+			is 100.
+			A value of 0 disables polling. This value can also
+			be set at runtime, but not to less than this initial
+			value (except 0 for disabling).
 
 Example:
 		counter0: counter@29d0000 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
