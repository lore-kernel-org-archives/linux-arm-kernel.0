Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F56C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:10:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3332190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KvsRvV7w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UAdPGrQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3332190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZhGeL2AvLz3hbphnisPxdYmNxi4134rSbu/ID7nmOD4=; b=KvsRvV7wGpOoQ9
	fqRRO0xMSo/DIZ3FWWqlEtW6YucWjhEDu/D9IdywFk+ogG9GTjjtctF8owtikFJRHpBQ7mJ+1pghW
	pIbfcaL+hbV+s+I+xkQ1I34J3+TdOHfKv1HJSBqCHvUvY9xSeUWse/OtmAYKmD7wFpISjkpP83Km0
	b0lFTaXCEZWYJjt3kil4XBwrkwySkT2hbNSGNkXTqTHx9/qfVhHewQDlwEPMZB60EPGUtl5T7uOz/
	xTmvpDE6gFgM9aayqnfe7zEOkNk/tovo2fUq5peS/yjH//4N/XLHFktx8WQuoGhqB2iuXB3S4hctH
	MCIhDJVxpvBpS0H+2o8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlJm-0003Oq-Ak; Thu, 07 Feb 2019 15:10:22 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlJh-0003Nd-EH
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:10:20 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so200894wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 07:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=h5y4FDODq872pLT04GyZ8UAR5pFINUnNPPRuvtTI9MA=;
 b=UAdPGrQj/s2L6OGgGR700XCgw2OTQBDJ99f36Gke7+JFlUhBX5xakn2DMYKwlJvnTR
 KFUvWjJEgYwHrcGjUZVHvDdhVC38ZdlrQnhQNjyqYicS4/eXCU7DKsXUI6S50tc5bWlx
 ANMRuMXqxBACmrpvcuqsFNU/ZMNMByOKhhUohHw03RycsDfHW1XzwNbbpxrfBGaxtfXq
 eKbSlfPOKa8HVeNuFGdvg2XF2Fps6HJBglWncWEJ0aAb+7kHcLc01B2dgEy0Q9nD5Dm2
 sF0xqbUoMnfSVcoAdmIlgmUBU28zXwg+IjvG1CsKL90MkpUn/6oZRkszSI9FA3xmuqYM
 XDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=h5y4FDODq872pLT04GyZ8UAR5pFINUnNPPRuvtTI9MA=;
 b=ZCJQfIBTWcTAeDawzFJILJA5vYO8NKdCCEmz9plPDhczKjNH9QLNwfGGUTp5lNbTw1
 s9ZZoR1UIwOrB8sw6eT19CQMqzKrEbjxgVUAvRapWfGOd6aKZVXcA57ojxHoEeLSO5V1
 qLzsjKrYAhdB+en/D3wwcQbgwGcXAQ8iAk3hB7bG+q7fnzfXBkpwczUBkNK+dfHrk8r9
 9HGOsGx6+ppqXE0KMRYSdiyPYNXTlwpJGTMb7P/GCQHVdxw0CagktmBwBZdprfyq5ztG
 nBuKEqLMktcXFZWfPza9gOjwOFYgvZXgZPKDA3FaF90QEVAgPAdpyFKLeM0bRRvHoOPz
 OO8Q==
X-Gm-Message-State: AHQUAuYBP1ZhUwSHQvp0YNB4LhYjBYTglTp0jmlqxLYeofdZKWnfVmUK
 epANXXuXo7hX5Rq3u8etkeWpgg==
X-Google-Smtp-Source: AHgI3IY4Hde8uCVrST3qqGUSTIECToaeQzPsgPSz1Sg4cXrjB7VguBuyvXTKgeH2AXnnpIZ0CAn7Hg==
X-Received: by 2002:adf:a58a:: with SMTP id g10mr12625907wrc.3.1549552215547; 
 Thu, 07 Feb 2019 07:10:15 -0800 (PST)
Received: from boomer.baylibre.com ([2a04:cec0:1103:b081:462c:a008:349b:2f3a])
 by smtp.gmail.com with ESMTPSA id
 f134sm20032540wme.31.2019.02.07.07.10.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 07 Feb 2019 07:10:14 -0800 (PST)
Message-ID: <2f03298e4d1ca0aa08d683d6db14bc194607b974.camel@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: clk: add G12A AO Clock and Reset Bindings
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, devicetree@vger.kernel.org
Date: Thu, 07 Feb 2019 16:10:12 +0100
In-Reply-To: <20190204091331.9298-2-narmstrong@baylibre.com>
References: <20190204091331.9298-1-narmstrong@baylibre.com>
 <20190204091331.9298-2-narmstrong@baylibre.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_071017_533176_C38936CA 
X-CRM114-Status: GOOD (  17.85  )
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
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-02-04 at 10:13 +0100, Neil Armstrong wrote:
> Add bindings for the Amlogic G12A AO Clock and Reset controllers.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt    |  1 +
>  include/dt-bindings/clock/g12a-aoclkc.h       | 43 +++++++++++++++++++
>  include/dt-bindings/reset/g12a-aoclkc.h       | 18 ++++++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
>  create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt 
> b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
> index 79511d7bb321..c41f0be5d438 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
> @@ -10,6 +10,7 @@ Required Properties:
>  	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
>  	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
>  	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
> +	- G12A (S905X2, S905D2, S905Y2) : "amlogic,meson-g12a-aoclkc"
>  	followed by the common "amlogic,meson-gx-aoclkc"
>  - clocks: list of clock phandle, one for each entry clock-names.
>  - clock-names: should contain the following:
> diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-
> bindings/clock/g12a-aoclkc.h
> new file mode 100644
> index 000000000000..997aca16c94f
> --- /dev/null
> +++ b/include/dt-bindings/clock/g12a-aoclkc.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2016 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
> + */
> +
> +#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
> +#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
> +
> +#define CLKID_AO_AHB		0
> +#define CLKID_AO_IR_IN		1
> +#define CLKID_AO_I2C_M0		2
> +#define CLKID_AO_I2C_S0		3
> +#define CLKID_AO_UART		4
> +#define CLKID_AO_PROD_I2C	5
> +#define CLKID_AO_UART2		6
> +#define CLKID_AO_IR_OUT		7
> +#define CLKID_AO_SAR_ADC	8
> +#define CLKID_AO_MAILBOX	9
> +#define CLKID_AO_M3		10
> +#define CLKID_AO_AHB_SRAM	11
> +#define CLKID_AO_RTI		12
> +#define CLKID_AO_M4_FCLK	13
> +#define CLKID_AO_M4_HCLK	14
> +#define CLKID_AO_CLK81		15
> +#define CLKID_AO_SAR_ADC_SEL	16
> +#define CLKID_AO_SAR_ADC_DIV	17

Do we need to export the internal part of these composite clock ?
I know the other AO controller do it but it would be nice to avoid it, like
for the EE controllers ... unless there is good reason of course.

Same for the others below.

> +#define CLKID_AO_SAR_ADC_CLK	18
> +#define CLKID_AO_CTS_OSCIN	19
> +#define CLKID_AO_32K_PRE	20
> +#define CLKID_AO_32K_DIV	21
> +#define CLKID_AO_32K_SEL	22
> +#define CLKID_AO_32K		23
> +#define CLKID_AO_CEC_PRE	24
> +#define CLKID_AO_CEC_DIV	25
> +#define CLKID_AO_CEC_SEL	26
> +#define CLKID_AO_CEC		27
> +#define CLKID_AO_CTS_RTC_OSCIN	28
> +
> +#endif
> diff --git a/include/dt-bindings/reset/g12a-aoclkc.h b/include/dt-
> bindings/reset/g12a-aoclkc.h
> new file mode 100644
> index 000000000000..bd2e2337135c
> --- /dev/null
> +++ b/include/dt-bindings/reset/g12a-aoclkc.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2016 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
> +#define DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
> +
> +#define RESET_AO_IR_IN		0
> +#define RESET_AO_UART		1
> +#define RESET_AO_I2C_M		2
> +#define RESET_AO_I2C_S		3
> +#define RESET_AO_SAR_ADC	4
> +#define RESET_AO_UART2		5
> +#define RESET_AO_IR_OUT		6
> +
> +#endif



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
