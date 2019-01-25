Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB04C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:30:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CC221855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MiQxVJxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CC221855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DHodzrvFTn+rgYBkHl9ITXFZtAO8SzobTte86Xo35c8=; b=MiQxVJxoJQESLV
	B0liF/lSVkof4LSjfbIvlsoX7VwsaSnpogqyGfWijd98gTlzEKPpcFEfZjuozZscvU1j7OjZtAI2A
	haTXSq/pznVB6Nw06NhmqmW3Qgc1h6UZMG/eDQ/eEGLo55hn8ZYHUP1mgcN8NlaZPLtaXcy4op9WH
	INnUoJSF9pE0Y3uxLQ7XDZxbMGBbOkhYM+txZIi4lCEC0DnQ44gKY0xowbzAw3stU5Lho2SBlkRV0
	343ADMUGHrEKYsoB8kaeX0BBb4Pep3enSU8PnxE/HGBcjY4LMuFv1dhv6biVZ5nL/2hYYyEoL3zst
	24WlbSO2nl3sxZrCMxzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxog-0001Wm-Ek; Fri, 25 Jan 2019 09:30:26 +0000
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxoa-0001Ud-AX; Fri, 25 Jan 2019 09:30:21 +0000
Received: by mail-lf1-f65.google.com with SMTP id b20so6421857lfa.12;
 Fri, 25 Jan 2019 01:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=d1dF8hLUpMhjJtda9RcMAKA/Cd7XgQRPFWL4srruzhM=;
 b=G+4J4RA1+0P2ILy8nE5FcU2nIwANpaE3CihljZ0YdJGCNSYX22SYHghPjUSxlMjVJz
 LubUHOzwSblBWSMfGWNcfOHj29ldsj2PL41qKKTundyh5RfiOMK+ebaCSl0EsK6Xp8Rf
 U11QVK8S+sYtFJJcHdv7/+poEN47kcoZceZBkUgPXFCcK0xrYcgvbEDalMknFFd1P6aP
 rudEp+h2p1VUmrIcShwewdTrZ9rrxFJZqCma97QVB983DecYX10ad3Z5OWmFn7s7pCli
 Hc8jcS5bxG6t3Pf2n9/tdB7BX7QYvcoA4JBsY+bUeBXamVW128sEsVJhbPsAsXSAmogH
 IFXA==
X-Gm-Message-State: AJcUukcTt7SwzjOjbtlQ4Pfy5bv6CdII1vMUsFCo2KeHrtVppDTqMT6K
 OykGnwsHO9GDhYWpWuAcHC0=
X-Google-Smtp-Source: ALg8bN7yEBGtS+JZv5a+QHP1LYATg1srUrpXJnCuKCLfo3JPjIapdTDxZE3cOiP76cl+EjOnXEFc3A==
X-Received: by 2002:a19:984:: with SMTP id 126mr8131773lfj.166.1548408618501; 
 Fri, 25 Jan 2019 01:30:18 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
 [85.230.190.116])
 by smtp.gmail.com with ESMTPSA id f1sm1374318lfm.22.2019.01.25.01.30.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 01:30:17 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1gmxoT-0001kS-1y; Fri, 25 Jan 2019 10:30:13 +0100
Date: Fri, 25 Jan 2019 10:30:13 +0100
From: Johan Hovold <johan@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v2 4/4] gnss: add driver for mediatek receivers
Message-ID: <20190125093013.GD3691@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-5-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547744074-28308-5-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_013020_470660_E1F7E072 
X-CRM114-Status: GOOD (  25.31  )
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

On Thu, Jan 17, 2019 at 05:54:34PM +0100, Loys Ollivier wrote:
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
> 
> v2: 
> Renamed from gtop/Globaltop to mtk/Mediatek.
> Added "mediatek,mt3339" compatible.
> 
>  drivers/gnss/Kconfig  |  13 +++++
>  drivers/gnss/Makefile |   3 +
>  drivers/gnss/core.c   |   1 +
>  drivers/gnss/mtk.c    | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 170 insertions(+)
>  create mode 100644 drivers/gnss/mtk.c
> 
> diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
> index 6abc88514512..51e6282d092a 100644
> --- a/drivers/gnss/Kconfig
> +++ b/drivers/gnss/Kconfig
> @@ -40,4 +40,17 @@ config GNSS_UBX_SERIAL
>  
>  	  If unsure, say N.
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

Add before the SiRF entry too keep the entries sorted.

> +
>  endif # GNSS
> diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
> index 5cf0ebe0330a..43318375aa51 100644
> --- a/drivers/gnss/Makefile
> +++ b/drivers/gnss/Makefile
> @@ -14,3 +14,6 @@ gnss-sirf-y := sirf.o
>  
>  obj-$(CONFIG_GNSS_UBX_SERIAL)		+= gnss-ubx.o
>  gnss-ubx-y := ubx.o
> +
> +obj-$(CONFIG_GNSS_MTK_SERIAL)		+= gnss-mtk.o
> +gnss-mtk-y := mtk.o

Ditto.

> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
> index 4291a0dd22aa..320cfca80d5f 100644
> --- a/drivers/gnss/core.c
> +++ b/drivers/gnss/core.c
> @@ -334,6 +334,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
>  	[GNSS_TYPE_NMEA]	= "NMEA",
>  	[GNSS_TYPE_SIRF]	= "SiRF",
>  	[GNSS_TYPE_UBX]		= "UBX",
> +	[GNSS_TYPE_MTK]		= "MTK",
>  };
>  
>  static const char *gnss_type_name(struct gnss_device *gdev)

So this should go in the previous patch.

> diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
> new file mode 100644
> index 000000000000..c91d4d251098
> --- /dev/null
> +++ b/drivers/gnss/mtk.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek GNSS receiver driver
> + *
> + * Copyright (C) 2018 Loys Ollivier <lollivier@baylibre.com>

As this just a copy of the ubx driver with the "ubx" prefix replaced
with "mtk", you need to retain the original copyright statement.

I'm not even sure the search and replace work is copyrightable at all...

I see now why you wanted merge this with the ubx driver, but I still
think they should be kept apart for now. Maybe we can move common bits
into the generic implementation (library) when we get a third "copy".

The rest of the driver obviously looks fine. ;) Possibly with the
exception of the added mediatek compatible as mentioned before.

> +#ifdef CONFIG_OF
> +static const struct of_device_id mtk_of_match[] = {
> +	{ .compatible = "globaltop,pa6h" },
> +	{ .compatible = "mediatek,mt3339" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_of_match);
> +#endif
> +
> +static struct serdev_device_driver mtk_driver = {
> +	.driver	= {
> +		.name		= "gnss-mtk",
> +		.of_match_table	= of_match_ptr(mtk_of_match),
> +		.pm		= &gnss_serial_pm_ops,
> +	},
> +	.probe	= mtk_probe,
> +	.remove	= mtk_remove,
> +};
> +module_serdev_device_driver(mtk_driver);
> +
> +MODULE_AUTHOR("Loys Ollivier <lollivier@baylibre.com>");
> +MODULE_DESCRIPTION("Mediatek GNSS receiver driver");
> +MODULE_LICENSE("GPL v2");

Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
