Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F31EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:07:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C452920811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SPL7bvPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C452920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6gJ6rMgjnyX4TOEmvoGVItzVFkRn8nf9mQFY2nqiwe4=; b=SPL7bvPE4Lacsj
	eHjkY+71rl3Qf2jZmoKVXnpy4a2FgwK82hEVOt/rCW4PPcf9M97eaW8t5UNdLG9+y5zBAWXT8t5KI
	GyR/75xsBaCL5/pZkcdStC5rmS+nLOGoIpU8PQiz8qNTCSgcz2fczSETqDDN1JJmHsOqETavYwGRl
	joIybhczFPdBNtEMelunj5BGoQEl/uaB8cf6xG2JcscB2YxV7BpoQXQ1L7hlwK6HB0q94FA4ZtwTC
	MKqRtJQOyB2/Jyg1PWfipwG88tQGOV0k5v+06yIeMYDbd0X2/6T8kBbmvEkwI42KTvMFhU9sruL8O
	+tZAO49Y9VMS0Y9Av1rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsX2X-0001hI-4p; Sat, 09 Feb 2019 18:07:45 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsX2T-0001gk-Gf
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 18:07:43 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 6B54E44F65F;
 Sat,  9 Feb 2019 18:07:38 +0000 (GMT)
Subject: Re: [PATCH 2/5] dt-bindings: iio: adc: lpc32xx-adc: Document
 vref-supply
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
 <20190208160944.13281-3-gregory.clement@bootlin.com>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <8bc7bfcf-ad04-0615-1735-c2bbf20b7861@mleia.com>
Date: Sat, 9 Feb 2019 20:07:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190208160944.13281-3-gregory.clement@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190209_180738_461534_4EA673EF 
X-CRM114-Status: GOOD (  18.95  )
/bin/ln: failed to access
 'reaver_cache/texts/20190209_180738_461534_4EA673EF': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_180738_461534_4EA673EF 
X-CRM114-Status: GOOD (  19.14  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Gregory,

On 02/08/2019 06:09 PM, Gregory CLEMENT wrote:
> As most of the other ADC the lpc32xx one use a vref-supply property:
> document it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
> index b3629d3a9adf..3a1bc669bd51 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
> @@ -6,6 +6,10 @@ Required properties:
>    region.
>  - interrupts: The ADC interrupt
>  
> +Optional:
> + - vref-supply: The regulator supply ADC reference voltage, optional
> +   for legacy reason, but highly encouraging to us in new device tree
> +

here vref-supply voltage is 3.3v only, I think that might be a reason why
the property is omitted.

My concern is that the documentation shall not contain sections with
description of properties found in the past for 'legacy reasons', if you
like to support the backward compatibility in the driver, please update
the documentation to the expected state and add a stub to care about
legacy DTBs in the driver only.

FWIW I personally don't mind about breaking the backward compatibility
for NXP LPC32xx, it might be a concern when CONFIG_ARM_ATAG_DTB_COMPAT=y
is removed from the lpc32xx_defconfig though.

>  Example:
>  
>  	adc@40048000 {
> @@ -13,4 +17,5 @@ Example:
>  		reg = <0x40048000 0x1000>;
>  		interrupt-parent = <&mic>;
>  		interrupts = <39 0>;
> +		vref-supply = <&vcc>;
>  	};
> 

I kindly ask you to include me to To: list, if you send another changes for
NXP LPC32xx platform.

Thank you.

--
Best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
