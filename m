Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21843C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:12:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C5F2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MGhfdytL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQj5ivsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C5F2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y+e7rzRJHDfVp/+yI40zoTNAbeSSi+Vyf2J9kxp5DDo=; b=MGhfdytLUvYx5z
	ns5ynU1EdVlXQru6E83hphLL7wrb7VmItTPrNFCbqsU/NNo8rULaJM5N51yIl2ODDtpMA5epU1IaR
	8CHyYq9osv5gf8OuwwQ57ay0z+7ZRWcn9VlZbKU5zNZNBmP8UVJEpnQXebvDFv1wo0ssroU+CFIAR
	JpvNmaL1S88AIbAZT+u90fZHD3XJ4YQaDogQCOOcDbHXA7p5eoUuJuvf4m8GSkZ/yVqUUW7HHMniA
	w7kQWC+GLE8p3R/w/73FNH831O3kNoQHyn9YS3M9MXbg2YfcppzRyBy99L4l3ZAe+awjIvb3kJVjO
	DJsLStzQGW1PJwhsgHMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guDor-0000gM-Cv; Thu, 14 Feb 2019 10:00:37 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDog-0000FA-0K; Thu, 14 Feb 2019 10:00:32 +0000
Received: by mail-wr1-x441.google.com with SMTP id w17so5712984wrn.12;
 Thu, 14 Feb 2019 02:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XN6xUCS+tZmGQkSmGy6ryJ1Zi47H6ia5G0Vkj8uZJkU=;
 b=bQj5ivsmZHdmK+/W3Cc5ieUJs/rugU/1ses5dj88GO5K4/VWj99r5GAaHrhQrL/fy0
 vAyoLuJkHySSOIMkZBJF3ITY2jyz21UXd08zp1hCFIX2A3qFG7JTtKFESvzj99E4AHlX
 9mNt0uSm9t6IFWt0IonKUqia7LHnNcmeYBgBynSdsYYnTnuLxpUFr4tdAtrIZJb9qpWo
 I2QKpNOAzoZpKoUFqTPWQj5FuXmw3C7xrVbx+s9zq/CV0bcEBR3uqx0ad8iwSVGg6PkP
 0Gd/xCV1Jps1TddnSMeq4VYXzWAqd/hvWs8E9e9Kc9/xRDQ1YrBnovhYPVm/fjv6kQof
 WZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XN6xUCS+tZmGQkSmGy6ryJ1Zi47H6ia5G0Vkj8uZJkU=;
 b=l0AlntlM4+Ul4n4RAb94asJtIDjyWhp8hdKf8lS56jmpjNft5xdxsfmUt1+Y9dtchX
 vSYPMrFXhluknyEHDbx53M9L+f5acbPkYseadDUgua+UESbW/4ezSWG/kenxxJ6AkKyX
 XFnY1KG6O9p0HeXgjo0IeVwq0nszYxakNxlyvppMSddKm9Ca5C+zlscPTLYwQSUWFYLF
 UYwWqcBLS3sihG2tpudCijDgtC8GcKwGyvNioWaFaomYVDPGhyR86Obo/Wixc0h5fSTh
 Jbcu32MfeDpcZnwPvp/zhSwuaikVYSCJzhyyHBa9WOFgrXiJlOr4P4pMD6lDfIJOOk1n
 NxmQ==
X-Gm-Message-State: AHQUAuZDiiaeoPHpZBCsfYJKHrCMUPf1xfXMPZrQE6yMdAVvEWzuQZvt
 tDY1Mc8KQWrSxDjgChQmg11wCTH7
X-Google-Smtp-Source: AHgI3IZHymyK33Jq1slZmcUXBX2W9bJzMFWZlQ1sJwTUvtpyybwojShoCMomxNHxC7VI/f5exxHUZw==
X-Received: by 2002:adf:ee8e:: with SMTP id b14mr2047002wro.71.1550138422919; 
 Thu, 14 Feb 2019 02:00:22 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
 by smtp.googlemail.com with ESMTPSA id t14sm1713142wrr.49.2019.02.14.02.00.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 02:00:22 -0800 (PST)
Date: Thu, 14 Feb 2019 11:00:19 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v4 4/4] gnss: add driver for mediatek receivers
Message-ID: <20190214100019.GA4197@Red>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-5-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550070569-18588-5-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_020026_075613_3A6243AC 
X-CRM114-Status: GOOD (  23.60  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 04:09:29PM +0100, Loys Ollivier wrote:
> Add driver for serial-connected Mediatek-based GNSS receivers.
> 
> These devices typically boot transmitting vendor specific NMEA output
> sequences. The serial port bit rate is read from the device tree
> "current-speed".
> 
> Note that the driver uses the generic GNSS serial implementation and
> therefore essentially only manages power abstracted into three power
> states: ACTIVE, STANDBY, and OFF.
> 
> For mediatek receivers with a main supply and no enable-gpios, this simply
> means that the main supply is disabled in STANDBY and OFF (the optional
> backup supply is kept enabled while the driver is bound).
> 
> Note that the timepulse-support is left unimplemented.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> v4:
> No changes
> 
> v3:
> Sorted the Kconfig and Makefile
> Retained the original Copyright
> Removed "mediatek,mt3339" compatible.
> 
> v2: 
> Renamed from gtop/Globaltop to mtk/Mediatek.
> Added "mediatek,mt3339" compatible.
> 
>  drivers/gnss/Kconfig  |  13 +++++
>  drivers/gnss/Makefile |   3 +
>  drivers/gnss/mtk.c    | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 168 insertions(+)
>  create mode 100644 drivers/gnss/mtk.c
> 
> diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
> index 6abc88514512..6d8c8027e1cd 100644
> --- a/drivers/gnss/Kconfig
> +++ b/drivers/gnss/Kconfig
> @@ -15,6 +15,19 @@ if GNSS
>  config GNSS_SERIAL
>  	tristate
>  
> +config GNSS_MTK_SERIAL
> +	tristate "Mediatek GNSS receiver support"
> +	depends on SERIAL_DEV_BUS
> +	select GNSS_SERIAL
> +	help
> +	  Say Y here if you have a Mediatek-based GNSS receiver which uses a
> +	  serial interface.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called gnss-mtk.
> +
> +	  If unsure, say N.
> +
>  config GNSS_SIRF_SERIAL
>  	tristate "SiRFstar GNSS receiver support"
>  	depends on SERIAL_DEV_BUS
> diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
> index 5cf0ebe0330a..451f11401ecc 100644
> --- a/drivers/gnss/Makefile
> +++ b/drivers/gnss/Makefile
> @@ -9,6 +9,9 @@ gnss-y := core.o
>  obj-$(CONFIG_GNSS_SERIAL)		+= gnss-serial.o
>  gnss-serial-y := serial.o
>  
> +obj-$(CONFIG_GNSS_MTK_SERIAL)		+= gnss-mtk.o
> +gnss-mtk-y := mtk.o
> +
>  obj-$(CONFIG_GNSS_SIRF_SERIAL)		+= gnss-sirf.o
>  gnss-sirf-y := sirf.o
>  
> diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
> new file mode 100644
> index 000000000000..a5aad08fb9d7
> --- /dev/null
> +++ b/drivers/gnss/mtk.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek GNSS receiver driver
> + *
> + * Copyright (C) 2018 Johan Hovold <johan@kernel.org>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/gnss.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/serdev.h>
> +
> +#include "serial.h"
> +
> +struct mtk_data {
> +	struct regulator *v_bckp;
> +	struct regulator *vcc;
> +};
> +
> +static int mtk_set_active(struct gnss_serial *gserial)
> +{
> +	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
> +	int ret;
> +
> +	ret = regulator_enable(data->vcc);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

Hello

This could be simplified to return regulator_enable(data->vcc);
Furthermore, after this simplification, the function seems useless.

Same comment for mtk_set_standby()

Regards


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
