Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A067C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:27:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAFB218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FTPRPVV8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yq5cItPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAFB218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mcj1pWRc0sS7G7tCqmVtKaycj0Y5wdSdiBkaVbl4T/Q=; b=FTPRPVV82oQ58B
	fdGFi47GYzpiFCNSDTfCchlH4D228NbKtJoX9VkGwySC9SGTQnpPcEtRvupYcJx0NDGHZG3E3O+NR
	qu/kNRbQVg0knZ2ZdNONulXgrD4LO7CQc2KT1YpdzrZD4U57iZQon0I2kk4LHhNqMpbjRtX0ljr3C
	dU1rEp/k5n8EBvLcGMZW3pmN5y7VxWkTagkzpvqgOdBVgPsyHtHjEhyC2z9O40+6r9Rfd0mkNOmH2
	7/PLSJCmpvtRcLF1OCeidrt1aDqrZICb1FMvpmKIeCHPVebIWJ8P5W3R1YTZgWReMcBwmmsBw8Hjq
	eqkVOr9scIW7aOWBWc0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glsL7-0005Ar-UC; Tue, 22 Jan 2019 09:27:25 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glsL4-0005A9-UW
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 09:27:24 +0000
Received: by mail-wr1-x442.google.com with SMTP id s12so26465826wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 01:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=cCrh+YVCx19BBdNeVg2dvCiCwiOMhaRj8KLLP1LDVlo=;
 b=yq5cItPKxIiEzJNtwONqID9UHnBdJme1bbcLuLE+Kp9q8t7aU7LgALgLHG0TlCZIvV
 QUzw9U/Afu1EAxgoMpfVAXlrMbNbSzA4V8YsMl2Jygxkhh1NTdc5mqFVdgHi1NDi8Ap/
 BRYaCO2+PtN+gUNk4lauEucshHw5YkxKeUgpnVbnvoHrltGT8O960GhIv455Dxkr/Wpq
 8zqLkgbH4cGToDug7zbDIhEhRT4OohO+uuNM0UryAs4qq/c6eiQDM+hIDZc10v/jApdp
 Jugjh0/TvrSHnTXzetMz+sYFIdes+UrNM+Nv/noB3HTcs9Dt7Hj+lFv0fc7ZN0zgdfZT
 B4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=cCrh+YVCx19BBdNeVg2dvCiCwiOMhaRj8KLLP1LDVlo=;
 b=a304YmhHn939GUel+cAbiYMPybksdP/7qoZtOD3j9vuq1Ytkg0W0ZC6ZgmgHPlQOBg
 CCLHvccec+NJhmH8orxmyWwMMbkzHf2towejgPMpCDdbFRi+fq3q5ngLOPwDZKnk3ECy
 sk3W4ZZ5XBuG66dGsXP8zOA8YRtwaq6/piBC/RuJioWiGhLm37r+F/dntUT+nkkOVPY3
 xZ0BR9UF9KJwRG1TYo5t/capeRSMSZuN1ktSfKu/jQYn1Ta1qTuE2N3/UvRMnpF9zB1H
 S9ujZIhZ0MWwU70qZd6YQsNdtmHP8GhaL0drI31xBkld+/oMQP9k7fq2FpJmYF1ra9Kv
 qPHA==
X-Gm-Message-State: AJcUukcsAuEpY0Mbz/0oeqVxdwKnrr84pfcnrUkV2ITaT9Jh/J3LJTgN
 d7kwb5RG0syihRoJTCgvL+9AVA==
X-Google-Smtp-Source: ALg8bN5ccmnAT9QO4I7OWHxkPXb9UZomGvZL3zjWSy9IO9sP7kQtrzYCuOl96VyhyTq78SSVSc/blA==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr31474975wru.222.1548149241112; 
 Tue, 22 Jan 2019 01:27:21 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id
 y145sm38786336wmd.30.2019.01.22.01.27.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Jan 2019 01:27:20 -0800 (PST)
Message-ID: <8d9b2f76823396c9caad15943d564e147c06193d.camel@baylibre.com>
Subject: Re: [PATCH v9 3/4] clk: meson: add DT documentation for emmc clock
 controller
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jianxin Pan <jianxin.pan@amlogic.com>, Neil Armstrong
 <narmstrong@baylibre.com>
Date: Tue, 22 Jan 2019 10:27:17 +0100
In-Reply-To: <1546955444-7549-4-git-send-email-jianxin.pan@amlogic.com>
References: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
 <1546955444-7549-4-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_012722_988544_A4B8DC51 
X-CRM114-Status: GOOD (  19.02  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Stephen Boyd <sboyd@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-08 at 21:50 +0800, Jianxin Pan wrote:
> From: Yixun Lan <yixun.lan@amlogic.com>
> 
> Document the MMC sub clock controller driver, the potential consumer
> of this driver is MMC or NAND. Also add four clock bindings IDs which
> provided by this driver.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../devicetree/bindings/clock/amlogic,mmc-clkc.txt | 39
> ++++++++++++++++++++++
>  include/dt-bindings/clock/amlogic,mmc-clkc.h       | 17 ++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-
> clkc.txt
>  create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> new file mode 100644
> index 0000000..0f518e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> @@ -0,0 +1,39 @@
> +* Amlogic MMC Sub Clock Controller Driver
> +
> +The Amlogic MMC clock controller generates and supplies clock to support
> +MMC and NAND controller
> +
> +Required Properties:
> +
> +- compatible: should be:
> +		"amlogic,gx-mmc-clkc"
> +		"amlogic,axg-mmc-clkc"

nitpick, missing is something to tell that only one is required, not both
for example `should be one of the following`

> +
> +- #clock-cells: should be 1.
> +- clocks: phandles to clocks corresponding to the clock-names property
> +- clock-names: list of parent clock names
> +	- "clkin0", "clkin1"
> +
> +- reg: address of emmc sub clock register
> +
> +Example: Clock controller node:
> +
> +sd_mmc_c_clkc: clock-controller@7000 {
> +	compatible = "amlogic,axg-mmc-clkc", "syscon";
> +	reg = <0x0 0x7000 0x0 0x4>;
> +	#clock-cells = <1>;
> +
> +	clock-names = "clkin0", "clkin1";
> +	clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
> +		 <&clkc CLKID_FCLK_DIV2>;
> +};
> +
> +sd_emmc_b_clkc: clock-controller@5000 {
> +	compatible = "amlogic,axg-mmc-clkc", "syscon";
> +	reg = <0x0 0x5000 0x0 0x4>;
> +
> +	#clock-cells = <1>;
> +	clock-names = "clkin0", "clkin1";
> +	clocks = <&clkc CLKID_SD_EMMC_B_CLK0>,
> +		 <&clkc CLKID_FCLK_DIV2>;
> +};
> diff --git a/include/dt-bindings/clock/amlogic,mmc-clkc.h b/include/dt-
> bindings/clock/amlogic,mmc-clkc.h
> new file mode 100644
> index 0000000..34a3c56
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,mmc-clkc.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Meson MMC sub clock tree IDs
> + *
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#ifndef __MMC_CLKC_H
> +#define __MMC_CLKC_H
> +
> +#define CLKID_MMC_DIV		0
> +#define CLKID_MMC_PHASE_CORE	1
> +#define CLKID_MMC_PHASE_TX	2
> +#define CLKID_MMC_PHASE_RX	3
> +
> +#endif



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
