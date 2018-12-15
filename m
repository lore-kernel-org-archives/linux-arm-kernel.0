Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D41C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 17:25:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0A721721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 17:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="npgA6A8g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3re4qa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0A721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IVJboenD3lsoQbBa/k+vLgWtmyZ6LTnQU1Xgy/3Ojkg=; b=npgA6A8gFOIEw0
	1iCqKXb362mk3VOCh8ABPlh5VLyD6LI9pVtsnvZm5fR0il6valJ54eOMGdn0Xj+FuKzBuMy3uWpz8
	LvrX3Z3nGMZly5U6IYqyIsa9WqQ1+jmDAq/r6PUFhsWzfYI6CWY45IJVgf7E5OmqxOi3T5XfDNnms
	LJ4g/L6aptF23dGKv9OyYkhK3dYR2h7TgQFduMR/ic2M3j0DZcXZ6F9DRiTMyc/WCvR4nmCnC3Hhn
	nINO5/OB1k9WGoX7qhtcWJIXsRBpYhFwL/48LimuVp9yvUTbbarQ+N/yw+YBFgbeoEmRWZKLiv5rY
	aIco4JzlR+u7/AFCfuyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYDgk-0006Ns-VL; Sat, 15 Dec 2018 17:25:18 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYDgh-0005Xt-5r
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 17:25:17 +0000
Received: by mail-pl1-x642.google.com with SMTP id e5so4187097plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 15 Dec 2018 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Twqa0PqKd5sSeB/EVWg5TA4JHl8nMWCmQpgEx5MVg3w=;
 b=M3re4qa0IBjgg3VsCWV/GtxRLBElgXrenRP8syI8xX0e04C2r2n1LCJpQgFf0fioDV
 ANC91ZhgcVlYW9lsbSoLM20gnvfQLtn+AxOE7EnpRrpaIC/h0Om1q+VddIVcJsKj+vMZ
 6/3q+LwAnQqHEOn1rnBgj+Q2vT3jOUkC4Efo7rddf/ixA/8TOWUa1wyy7uEUR3HK6K1t
 YHHLUj22B3pJ9MY7iS3hhIllh39ZBOIzzmwLpTur5jjI+Ff8TK2ejcwhFwCOGAC3PZC4
 U7MfooAPW4iUyORexc8NPiKT1c9+YpYWpzHR99sFPczELgWoARXtB/Ba4jbBskSm/1je
 N07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Twqa0PqKd5sSeB/EVWg5TA4JHl8nMWCmQpgEx5MVg3w=;
 b=XcSdWQm4pg9BeRD3vZbG3Uw5+DsWHd4teaRuJIipUH0QRM1ZA+qg1VQSy5VrUTk0Yh
 yFtCypQwmO0C0cdJyv+CUL0YCio266C/FBcfpqRiWXgVpZNddw9aCVhpSL3iLC0RslDG
 jozsXN6yCXPN+HPYnU/YAJQoxPzcvtn+FXNZULtP2dx6t1BEL2qZtkgr0dRCEvhW8lhG
 0ZgMnu/Zj7RYIjaNuL5VbITsfjHJkYnrn/8NGaJ8YhSGG67L0o99ZoRKcdrNSTZSWJQE
 QOYF1+NFx7YKD+zPYGcMBxTvutbonJ0a/E/nvz1vTZEdGDyxUcVW24hDhN+jHQhb+8+b
 /klQ==
X-Gm-Message-State: AA+aEWbIIcQhDt2CAaDHKjdsC0tc+v3o9kA8aPLrhfJ4kIX//T2Yto9N
 wyqWW72hKo7j5eYZ/2HwJhs=
X-Google-Smtp-Source: AFSGD/XlXObsa50qbpT2PrxlUK+6oIDgG3R8jfiYG6hB0PGnPgk9e8wJw3DBORE6RnwONmas6kwxLA==
X-Received: by 2002:a17:902:2bc5:: with SMTP id
 l63mr7169720plb.107.1544894704056; 
 Sat, 15 Dec 2018 09:25:04 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
 by smtp.gmail.com with ESMTPSA id v190sm12219596pfv.26.2018.12.15.09.25.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 15 Dec 2018 09:25:03 -0800 (PST)
Date: Sat, 15 Dec 2018 09:25:01 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 0/6] Add hw overheat IRQ support to Marvell thermal
 driver
Message-ID: <20181215172501.GC10311@localhost.localdomain>
References: <20181212093645.14752-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212093645.14752-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_092515_219587_D653A884 
X-CRM114-Status: GOOD (  29.46  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Marc Zyngier <marc.zyngier@arm.com>,
 David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 10:36:39AM +0100, Miquel Raynal wrote:
> Hello,
> =


I added the series in my -linus branch. You can also add my =


Acked-by: Eduardo Valentin <edubezval@gmail.com>

in your DTS patches (4 and 6).

> This is the last batch of patches about the thermal driver that was
> suspended, waiting for the ICU/SEI series to be merged. Now that
> everything is ready in mainline, let's add hardware overheat interrupt
> support to this driver.
> =

> Bindings and DT are updated accordingly. The interrupt will only be
> triggered if the platform goes above ~102=B0C (threshold set to 100=B0C,
> hysteresis to > 2=B0C). The interrupt property is of course not
> mandatory.
> =

> In the mean time, I add myself to the MAINTAINERS file to receive and
> review possible fixes/new features.
> =

> Thanks,
> Miqu=E8l
> =

> Changes since v3:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Added Rob's Reviewed-by on cp110 bindings.
> * Addressed Rob comment on ap806 bindings by removing the reference to
>   the interrupt parent.
> =

> Changes since v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Remove useless goto statement.
> * Move the hysteresis array out of the function using it and declare
>   the array statically instead that doing so on the stack.
> * Remove unnecessary cast.
> * On error, avoid returning a value not compatible with irqreturn_t in
>   the IRQ handler (and when doing so, re-enable interrupts
>   first). This is simply handled with a goto statement.
> * 0 is not a valid interrupt, take this into account during variables
>   validation.
> =

> Changes *not* addressed since v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> * Overheat interrupt configuration has certain limitations on which
>   Marc asked questions. I don't know if/what I need to change so
>   keeping it like this for this version.
> * Eduardo pointed that once a critical level has been reached, there
>   is no way back, the system will shutdown. I designed the handler to
>   recover from that and to enable the IRQ again if needed, but maybe
>   this is useless and should be removed. While waiting for his answer,
>   I am sending another version and will correct in a v4 if needed.
> =

> Changes since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Use a threaded IRQ handler to avoid a potential lock depency when
>   notifying the core of an overheat situation.
> =

> =

> Miquel Raynal (6):
>   thermal: armada: add overheat interrupt support
>   MAINTAINERS: thermal: add entry for Marvell MVEBU thermal driver
>   dt-bindings: ap806: document the thermal interrupt capabilities
>   dt-bindings: cp110: document the thermal interrupt capabilities
>   arm64: dts: marvell: add interrupt support to ap806 thermal node
>   arm64: dts: marvell: add interrupt support to cp110 thermal node
> =

>  .../arm/marvell/ap806-system-controller.txt   |   7 +
>  .../arm/marvell/cp110-system-controller.txt   |   9 +
>  MAINTAINERS                                   |   5 +
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi |  18 +-
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi |  15 +-
>  drivers/thermal/armada_thermal.c              | 270 +++++++++++++++++-
>  6 files changed, 317 insertions(+), 7 deletions(-)
> =

> -- =

> 2.19.1
> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
