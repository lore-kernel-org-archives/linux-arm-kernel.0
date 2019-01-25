Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D4AC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:08:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C857B217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lAhFWjz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C857B217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lhGGWlGsUVrOCq9mj6rlEpYMsv3moaQoKolWLjSR8H0=; b=lAhFWjz0w13vUF
	SKiCjXzcvPsZWrVGRvqg+MbLEwA9KXSV2GK1SJBV0h2UbfNtsNMtCsoxLzkMSBqOH44b5xLI1JbzA
	PRShJyUet9RsZAeMn2NgHuvYYL684FUJYvsr1kQ42RIAqKQfHSW04sY984cD2vchp3tqVLh74k2nO
	CrQVvHzz/9yzBlFikKjrg+wMhsoBKH/82b2+lc9gJusMX92CwpVdJLAEs72zO8TYrbenjj/TkJDZ0
	SKsmlbFSutL3qMOepLQhkTH9ZKWReWQouONIY56GWYb7rpEonaKztjGAm51jH6dPu+8ObITLiFad9
	Lw02lrGkDrnwQ5PigCwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxT9-0000Mv-0z; Fri, 25 Jan 2019 09:08:11 +0000
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxT2-0000KL-52; Fri, 25 Jan 2019 09:08:05 +0000
Received: by mail-lf1-f65.google.com with SMTP id z13so6376529lfe.11;
 Fri, 25 Jan 2019 01:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CtSiaZshpaEHWQ5nMsvhKse3z+gGNNoMcIPdg+hmKao=;
 b=qcYvODfuBfLRhT0LX/LD8pNyYndZkaJOivqMlSGxZ9Js7R/fNl+QswwGpG5PjKfPKp
 y5uHt7AmAggslhzqrzX8eh33YCWkqQvWdBjF/USuTV5GPhIgPKz5VQ9I3pDl1IhZ0xla
 6TsqOPAeaIvUh1ILgzMGEEjrhniHUzBwSf/cxyR/lsl+B5HtJ+haBDWmqh+pu5963AOa
 fmrm7e14WVIzDdF8ou1LNcXjHBE04PJ1v1eeDoJqgxVWsFBX03TF4C7j71P01b+4vzS/
 lsIP7bVVG/bx41E9ULGp/kOZTKySsz9OMtfQq/XlB7hYZardILtYGjyNzvlfKTAJA5Ty
 7msg==
X-Gm-Message-State: AJcUukea5OIYcOSdw7v7RT6zSclNnIAllM2K5zZtrLOLRyLxaNtge+7n
 UUSjB70ELokjV2u7iwVPVBA=
X-Google-Smtp-Source: ALg8bN4hjUbb2J0veFYxOi3Xj3vFjhLPqZsi5bvN9C4W0SeD9l+Gh4TE6iiMo5YCkesO/U5cVC2hsA==
X-Received: by 2002:a19:3b45:: with SMTP id i66mr8315754lfa.28.1548407281364; 
 Fri, 25 Jan 2019 01:08:01 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
 [85.230.190.116])
 by smtp.gmail.com with ESMTPSA id n8-v6sm1524606lji.90.2019.01.25.01.08.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 01:08:00 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1gmxSt-00085A-G3; Fri, 25 Jan 2019 10:07:56 +0100
Date: Fri, 25 Jan 2019 10:07:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190125090755.GB3691@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_010804_192840_66A3948F 
X-CRM114-Status: GOOD (  18.74  )
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

On Thu, Jan 17, 2019 at 05:54:32PM +0100, Loys Ollivier wrote:
> Add binding for Mediatek-based GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v2:
> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> Moved current-speed as an optional propertie.
> Removed the status line in the example.
> Added "mediatek,mt3339" compatible.
> 
>  .../devicetree/bindings/gnss/mediatek.txt          | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> 
> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> new file mode 100644
> index 000000000000..fd984b4a9a6d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> @@ -0,0 +1,39 @@
> +Mediatek-based GNSS Receiver DT binding
> +
> +Mediatek chipsets are used in GNSS-receiver modules produced by several
> +vendors and can use UART, SPI or I2C interfaces.
> +
> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> +properties.
> +
> +Required properties:
> +
> +- compatible	: Must be one of
> +
> +			"globaltop,pa6h"
> +			"mediatek,mt3339"

I'm not sure it makes sense to add the GPS chip itself as it cannot be
used stand-alone AFAIU, and either not way would require a lot more
resources to be defined than what you add to this binding.

> +
> +- vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)

The pin names in parenthesis were copied from the sirf-star binding and
were used to capture the various names given to this supply by different
vendors. Please drop as it doesn't apply here.

> +
> +Required properties (I2C):
> +- reg		: I2C slave address
> +
> +Required properties (SPI):
> +- reg		: SPI chip select address

While the mt3339 appears to support these interfaces, the globaltop one
does not.

Have you looked around for a small sample of mt3339-based receivers, to
see whether anyone actually provides these?

> +Optional properties:
> +
> +- timepulse-gpios	: Time pulse GPIO
> +- v-bckp-supply		: Backup voltage regulator
> +- current-speed		: Default UART baud rate

Looks like you forgot the optional NRESET input and 3D-FIX output (even
if the latter might be of limited use).

> +
> +Example:
> +
> +serial@1234 {
> +	compatible = "ns16550a";
> +
> +	gnss {
> +		compatible = "globaltop,pa6h";
> +		vcc-supply = <&vcc_3v3>;
> +	};
> +};

Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
