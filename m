Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC9AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:41:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62033218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CmfEoSIE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qY/5uKYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62033218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Kk0cHCkoUSVl8X9cnBZyhAPsPPR21DiOOokNwUdHss=; b=CmfEoSIEncyTno
	fOb0o3jccpCZqjZJJttmd1MXowlM5DptWWS1SJYaGxTDUHB9IZzy3n8snuH85RCkNUis7SaG8KVwd
	DPr5aSmScUve/rgyGyQk87y/MAxTRy5+ZVQXtkdxgnvKOdqMRy6YYKHQh7tCX+rSgIJDU58w57nFn
	YC1G39iybNTNbBxvB8nA1eJdBHZRpPbQY37hs8NR3ObYgFp4kZPBXVG89ouw/n955eK6UHsL/yfa9
	eSUsmlnMshSxcyg2CqpzaUNcaNGw/dM1c8PLXFA8QJa6i0TAe+TM4timZvs0qnV/i/k7fcgnO4IV5
	Fmrjshpz5XBY3t+0YusA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1graZ0-0005mk-8v; Thu, 07 Feb 2019 03:41:22 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1graYx-0005m9-P5
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 03:41:21 +0000
Received: by mail-pl1-x642.google.com with SMTP id s1so4145309plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 19:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=uMuloIya06N5A9GdiaLReWcolG5ZdkK2sZNqmiTqnB8=;
 b=qY/5uKYdvwPV//MjdA68aYO0jpgDujWJfK81NXVxLitrSqpNEiOfeLt3aeP0ssvmpL
 1AjS3nE+JzV/1s96IamSHrIGEluBFk6lrl4QXk0AO3zNQxSmAWbWxc5axe2qr/XtPNYS
 lXHVKeHCJ9m8sOP8JQqekdDeqP0A2oGcw64f22K+KBNNo2gMnu6SWwBhdI23R1G4v7sf
 tHz92TLg5FrzkuLhWDgHVBHZVjIP/vyQRk0IFXtPAkxGACpL40eyTcuVmcjMESaotqiE
 Cwn6Njwr0kFYfQckFSy1td/4pg3FkU7n/NM8D1QjSNeb+Ytt0NdRFw0+8t59denPCxad
 YWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=uMuloIya06N5A9GdiaLReWcolG5ZdkK2sZNqmiTqnB8=;
 b=slGNmDJFfWb8B5OcAUW0XX6XDNFTQJdGTze1BCfxEksPT56YKlt1ANiUtF5ZEPS19p
 RasJ+S+rUj4t72bNs7nZ44ny4mk90z7EIrTF+1WIgsYMT0C26Hdt1qQdCyVdYpo3zr2D
 KR+nSY3TZ7XYeXmRCmMpcgG/3bc8QXUGr5fSDpNmhsV9PyJa6+hJMmacHU20EbYJEF/P
 opHrfhPiuxZg/GcqJdSJbleULMoAYRaUX/tO/wrfKIXlbotVP3mxMq4kx2WHZ8nkIB4r
 Ab342mrCgexOabmfOooHXmOAr7NZTO4GnTJPa4ik2wOwlSTCXbkZn4WHhD77FcAwGIqG
 xVFA==
X-Gm-Message-State: AHQUAua8G5sNOjyv+ZrARMLGmVuO9qFjd5Ah2ZzCl2drV9zJIKXowZ1u
 t4A3Mn476YBUPedcqfMuZifBZg==
X-Google-Smtp-Source: AHgI3Ia9J8s2kFyaF6VMICIUMNqZyitDN3VgqC8egcSZOxuOR+YuEMFnTK6K7A7yV8yLxovmBM2DNQ==
X-Received: by 2002:a17:902:bc81:: with SMTP id
 bb1mr14074231plb.223.1549510878986; 
 Wed, 06 Feb 2019 19:41:18 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
 by smtp.googlemail.com with ESMTPSA id 186sm12404828pga.36.2019.02.06.19.41.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 19:41:18 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 0/7] ARM: dts: meson: chip temperature (hwmon) support
In-Reply-To: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
References: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
Date: Wed, 06 Feb 2019 19:41:17 -0800
Message-ID: <7hsgx0gt9e.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_194119_819650_7BC3C30F 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Now that the Meson SAR ADC driver can get the chip temperature on
> Meson8, Meson8b and Meson8m2 (see [0]) we can add the missing bits to
> the .dts{,i} and enable iio-hwmon for all boards where this could be
> tested successfully.
>
> This was successfully tested on multiple boards:
> - Meson8b Odroid-C1 (me)
> - Meson8b EC-100 (me)
> - Meson8m2 M8S (not upstream yet, me)
> - Meson8m2 MXIII-Plus (an earlier version of this series, Oleg Ivanov)
>
> compile-time dependencies:
> - none
> runtime dependencies:
> - my other series "meson-saradc: temperature sensor support for
>   Meson8b/Meson8m2" from [0]
> - multi_v7_defconfig already enables CONFIG_SENSORS_IIO_HWMON, so
>   there's no patch which selects that.
>
>
> Changes since v1 at [1]:
> - added patch 1 at the start of the series because patches #3 and #4
>   require the HHI memory region to be a syscon, which is what patch
>   #1 provides. Thanks for spotting this Kevin!

Queued for v5.1 (branch v5.1/dt),

Thanks,

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
