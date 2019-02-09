Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A6C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:09:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39872192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aqc5C56C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJkleny/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39872192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ETi+6kNyszV+k0/48vdGWj1e2+fR6EVoL3Oo78HlKWo=; b=aqc5C56Cg9RDYc
	Z8ti7ewFn95Z7YYDn59ky464daaREj0myKrlnSQ/EhLPqQz/gOKC7P2OLibuzpGV+VFBufoGD5I/+
	UxBPkJaeZ5U+kJI7N+o1x4NvAxv+LjnPwM0LEzpaCHgCQe+/Ea0txQDSYe6CA/xNM91vhVvq6m3hC
	lFGm9jXD8IXdMzWxa6zKyEQZxteTf9xO87PeklA/INyQraSomhRhhhxw8kz0Gc390JuyGIlr0hxQu
	Js2ufyvNfI9TJWJGfgNKca+kmsbQy0x2TKgHHrx7tcCzZbYP++1LJN7IsIm8V0YndVOlaFrMfzY9g
	Dwkj3owhP9L23fx/SnJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsW7z-00066c-3t; Sat, 09 Feb 2019 17:09:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsW7v-00066B-Ip
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 17:09:16 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2F6902192D;
 Sat,  9 Feb 2019 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549732155;
 bh=hh9kUpTU/t+T3LtaJNOcpFiksItwOq8rvl1bQx4tdr0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aJkleny/3xUqmV69ThEf88pEUZCKHsr8IOCiag9vsrnbTgK9desSe3m1urZ9j6JHq
 88T9ppO6vjXusmdBL8eTtpu8ZT+AJE7DqruL9u/mpBcE053cDIXED0OKBuHM36msBm
 QIekjxi4SibXZEJ6xpVAIt+LO6DvLCTibzDKUJ80=
Date: Sat, 9 Feb 2019 17:09:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 2/5] dt-bindings: iio: adc: lpc32xx-adc: Document
 vref-supply
Message-ID: <20190209170909.6f947a69@archlinux>
In-Reply-To: <20190208160944.13281-3-gregory.clement@bootlin.com>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
 <20190208160944.13281-3-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_090915_640798_5A8E1846 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Hartmut Knaack <knaack.h@gmx.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri,  8 Feb 2019 17:09:41 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> As most of the other ADC the lpc32xx one use a vref-supply property:
> document it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Hmm. This is indeed an oddity as you document. Normally we would
insist on it, but we can't because of legacy and as it is actually
queries, we can't even use the fact a stub regulator will be provided
to get around it.

I'll have some comments on the patch implementing it anyway, but
good to let this sit for a while given it's slightly unusual nature.

Thanks,

Jonathan

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
>  Example:
>  
>  	adc@40048000 {
> @@ -13,4 +17,5 @@ Example:
>  		reg = <0x40048000 0x1000>;
>  		interrupt-parent = <&mic>;
>  		interrupts = <39 0>;
> +		vref-supply = <&vcc>;
>  	};


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
