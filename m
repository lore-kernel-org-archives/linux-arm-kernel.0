Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC744C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:49:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FC520838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VVK7l7yC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FC520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rNbeBLJPhvXDpNduHMo7N/jZOk0NT7GnZNiKSDKZJn0=; b=VVK7l7yCLhpe0u
	/hkdaSdmW7WLqrlgpknU21LfBX8dnX/g83s/nUFgvTY8TGVZYyvV+DQO76yS38Lxc7XT5VJC6rBCn
	Qo5RMm9XA4hSF/ENa3k+PoK9qjG8y8CGagw/LkvlLGrKphgdBK/3UxFNALtI5tq9QLIBS/mKJGDDN
	LEgKO1S9iY2Q9JGOq2QK+0Wvwwa5yhOdEabhrpAr4sBATbyGP4BrB2rlGfubBYDVAyB4e6eOA5cRF
	WumNpEr23rlVfjE9P/E8q9eNicMBphNaO1uXy4NBBDev9DfKN2D6+LZSLwVs/G1jKRZQ7YHc9r1qp
	2T2snhDUKAENFgM6RfMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPsS-0007wm-Fy; Fri, 07 Dec 2018 23:49:48 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPsP-0007vz-Fv; Fri, 07 Dec 2018 23:49:46 +0000
Received: by mail-oi1-f193.google.com with SMTP id i6so4773433oia.6;
 Fri, 07 Dec 2018 15:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Kt6hWJv0hdJJNY/ems+6RGohkJkTkz4bkdrGemSL0go=;
 b=uksySyx5iyb24LPv9Kw4zO7qmGNC6cGxND0owSgbVp+0HWF8a+g4z0md0ZWwo8ngKW
 wrpp3aIoonnpH5Q2YmTIHdvXfgFNFA5GMdsWymVwrfCIN6p5p2+k9WAYdyb5b4qRk4iq
 FoedhoEsNONHZy8ijiiJlYlk3GLR8H9/A1A5IAZawtg8HD53y2LvygQp7PjQSDmN55hO
 zvJ9SStuo9+NneI9IyyHy99vmCCHUuMklerySZaCkNVRY8Jrtzri9DX29Qkmi18wGumd
 JFG3f6nMHhWvKRCZR86Pj9kRT0u1ziZD7hud9bwxlQ+gnfPgp8jEukGWMmw0W4J/3vPp
 wTqw==
X-Gm-Message-State: AA+aEWYhNktY0gVGnefef6ahnDcdGILIJCiR8ErwKAzXzlpt0twy9UHh
 T3G0V4Y3poIppOJE5FNHbw==
X-Google-Smtp-Source: AFSGD/Uu8c8EyQpmiw8gzXigTBMbqCXP964gJrTiDljnwx1YwFUIVwn0VW4/zQtBLc7ULVjEuwTJ+Q==
X-Received: by 2002:aca:aad8:: with SMTP id t207mr2289487oie.90.1544226574713; 
 Fri, 07 Dec 2018 15:49:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id f127sm2479298oia.19.2018.12.07.15.49.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 15:49:34 -0800 (PST)
Date: Fri, 7 Dec 2018 17:49:33 -0600
From: Rob Herring <robh@kernel.org>
To: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 3/5] soc: bcm: bcm2835-pm: Add support for power
 domains under a new binding.
Message-ID: <20181207234933.GA28189@bogus>
References: <20181130202743.20585-1-eric@anholt.net>
 <20181130202743.20585-4-eric@anholt.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130202743.20585-4-eric@anholt.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_154945_537618_DBF5A490 
X-CRM114-Status: GOOD (  13.57  )
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
 Florian Fainelli <f.fainelli@gmail.com>, linux-watchdog@vger.kernel.org,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 12:27:41PM -0800, Eric Anholt wrote:
> This provides a free software alternative to raspberrypi-power.c's
> firmware calls to manage power domains.  It also exposes a reset line,
> where previously the vc4 driver had to try to force power off the
> domain in order to trigger a reset.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/mfd/bcm2835-pm.c             |  36 +-
>  drivers/soc/bcm/Kconfig              |  11 +
>  drivers/soc/bcm/Makefile             |   1 +
>  drivers/soc/bcm/bcm2835-power.c      | 661 +++++++++++++++++++++++++++
>  include/dt-bindings/soc/bcm2835-pm.h |  28 ++

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/mfd/bcm2835-pm.h       |   1 +
>  6 files changed, 734 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/soc/bcm/bcm2835-power.c
>  create mode 100644 include/dt-bindings/soc/bcm2835-pm.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
