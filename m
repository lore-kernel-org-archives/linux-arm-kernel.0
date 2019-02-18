Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08931C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFBD21902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r/byhlmU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="oGtwGp0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFBD21902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/9GkLWYgAOOsyanoICZsCF77pz/0+XQj5Iy70cOSak8=; b=r/byhlmUm7Q9TBbgX2nY+jzYI9
	DyGm0yvJV/2u6cA2J7nmKVEKOcyjFCciheBx2Qi4B+6+5z3pI04jY4DaIQh57HAodbxhrDKJg4EYV
	cL5psqvKC+w6WxamwJFg0OBEHaIiPLP4ynv+StsIPq8wYUoY9+hOIT4fmbZj9/l5bq4peGpphyoBQ
	7yiU156P9JH2NTEMSSBK+sPrPy6mEYfjRn9Ej5IF8OJMiPgZolKPKrgjSz6EoNwmavPviqP9KIfbR
	UqwaKuwQ7ai4i4TsyWWTfmV3kOhHdP2MyRPYwOWdFxv4AsjDsolia1jQmmGdtHeqxXhnQb++eKsuL
	itlCSPDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjXB-0005Hu-2X; Mon, 18 Feb 2019 14:04:37 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjWV-0004YV-4t
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:03:59 +0000
Received: by mail-ed1-x542.google.com with SMTP id m35so9950711ede.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GTpjAPx1fakrDr6iX7ZaByuauFa8vRSnm2YIwlrmcQE=;
 b=oGtwGp0cHyc/ThOhI0NGYWLVDSrVX2SWB9ZJ86TRWH4C14DlC7FmlBqmeHKpbD4ucE
 vy/cFD//qkNVp/7JweqiNyeeg6fDH7HUF9mA0hk3Qp+XvmGXydwbBtQScNcqt99PQqJj
 fXJiLwhkrLzTHy8oWETYAmZeDKsH/sLeZhett9YfcfNF3hxuBS6vcRFn1IuHqEM0GQrJ
 scnLF3d9dBAcbYPSfUy/wulNDGyhsraiJpy/A78BMb5aGPAuPBzsm9QQa9gq2UtvAHin
 5jYZqBKuzSOiKZeBUYrIuuIng+KsDiIFRHsTEbrGCCOO34hD2CMy1H1kiXUMQDAfUcYo
 cHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GTpjAPx1fakrDr6iX7ZaByuauFa8vRSnm2YIwlrmcQE=;
 b=q9ZSZ41zCmuwrTkC6eRwCNOn+TDoC8rLHF6X0xyt5m44IEaP4SVvmly9JW0NT8013k
 DfoWD3VKyKp1d9e/hKMV6ZHdg0pALjyuRUqIKfe4aTDqIwDVLvnDT/2ZNrAlwAmNdFFP
 mzAbMDT6yU2yOQejHTm+iD/uw2I6kJFUsUtPR4CgHTm40RQ7eiqgSpEX9QbSIarCBawa
 i8f0wrEkGf+jFtzAN9FLBbwLqO0VxAu9xS1fTSTVRvuhrusxar3v78vkFf7znyYUjv0z
 ZdSUD7vYus9XyPePYszjqFhfEiLaB4x0QiC60kPW68aFDJc/EEdX6mfpqkj1COzpVK+h
 In+Q==
X-Gm-Message-State: AHQUAuYabxeTBvo0Qz1dUIXxBz0hhqhboWx0CGC7uqKB3KPs/XpOa6fA
 qAOGPvssbYHCMn872jkP9nRVGQ==
X-Google-Smtp-Source: AHgI3IaGiJP5XG+ub4Q/7liQMN3rjPdmMOiO1kL3JJ7SmjuWWM5ZIcTeHoTOJT8m3tJlRpqM6BKEYA==
X-Received: by 2002:a17:906:1552:: with SMTP id
 c18mr8653338ejd.64.1550498633824; 
 Mon, 18 Feb 2019 06:03:53 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:53 -0800 (PST)
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
Subject: [PATCH 6/8] LS1021A: dtsi: add ftm quad decoder entries
Date: Mon, 18 Feb 2019 15:03:19 +0100
Message-Id: <20190218140321.19166-6-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_060355_473903_E291FE4D 
X-CRM114-Status: GOOD (  11.30  )
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

Add the 4 Quadrature counters for this board.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index ed0941292172..0168fb62590a 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -433,6 +433,34 @@
 			status = "disabled";
 		};
 
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter1: counter@29e0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29e0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter2: counter@29f0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29f0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter3: counter@2a00000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x2a00000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
 		gpio0: gpio@2300000 {
 			compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
