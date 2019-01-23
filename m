Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6D1C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:24:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B1220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lNILIuC0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mNP8SFDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B1220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vZmGndEwq29EMNWrBWot2g3k0Rcp093iFL0JRxDtpKQ=; b=lNILIuC0Gw8XJa
	EoMl5oPLy1xFJF/R+zf1I75cLeQKBIieHvAxNDo48b1/IUZf9nuubSVxZamNSk/77epSeUTOabggQ
	nudULSepr5U3c/yZsDXQFVSWSTgBSzbrNb5KA3PzzbLgL9nQvANy9b+GakGom2J0n0LHP9v8NUgg1
	V8t3Bu3RfIzqRpBW0z9xa93TggwlvjeYw37H9zb6hHK8EQSmYMAzJb+8cpgDRbrpsP/OCZ+tSz0Wq
	jy4WKzg2ndknQarRlcdH16TZSi9tGOfAamVMU9n/boCcW4mxOo8k0EoE1fZgwZYyXQzPMkyTaZh/Q
	GPtvu6zqWtweBWD086vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmJRk-0000Ir-Tl; Wed, 23 Jan 2019 14:24:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmJRj-0000IN-6B
 for linux-arm-kernel@bombadil.infradead.org; Wed, 23 Jan 2019 14:24:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oj6UkrbIipnqrcEXz+3huGL78265BcJMGHyhO7tYjOo=; b=mNP8SFDPubtNhwdYTE0nfr+DKm
 kYr0iy/tg+Oz9nn4WXwADl+KqA85BB3mb8ctv0BxFaull+nEgIo0/J7dQIIl268s6FJHFMKE7qANT
 CpFxrf+8CshNPufRP8/bwttduvHDPCdGLSkhWP9tY5Sr6K31ab43TYom+16zXPV/TxlzdxYB+iSDT
 n5KUobG6SvhOb6yCrsR7OrSaiHftvKLMHJd+SVeobpA6+kJYa+zDtGa1520OVAuPZfUd12qHkgURb
 MFwEgA0estz5E4U4nIbNOtOezCM8gGt0l3G7JzjabCV+h4rlbExpw2r6WaWoYnABRZxeC0IBODYIs
 rBgOJlrw==;
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmJRf-0007MW-L3
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 14:24:01 +0000
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-96-RPexb6tkNqayX_AY63Fdow-1; Wed, 23 Jan 2019 14:22:56 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 23 Jan 2019 14:23:24 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Wed, 23 Jan 2019 14:23:24 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Florian Fainelli' <f.fainelli@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH reset-next 2/2] reset: brcmstb: Fix 32-bit build with
 64-bit resource_size_t
Thread-Topic: [PATCH reset-next 2/2] reset: brcmstb: Fix 32-bit build with
 64-bit resource_size_t
Thread-Index: AQHUsrNq0VoVkQnybEi+NjdGBGm2EKW86Kgw
Date: Wed, 23 Jan 2019 14:23:24 +0000
Message-ID: <43155ea7637e45d6aad04f5747cbb6bb@AcuMS.aculab.com>
References: <20190123003345.13750-1-f.fainelli@gmail.com>
 <20190123003345.13750-3-f.fainelli@gmail.com>
In-Reply-To: <20190123003345.13750-3-f.fainelli@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: RPexb6tkNqayX_AY63Fdow-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_142359_720034_35F14B42 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND
 FLATTENED        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Florian Fainelli
> Sent: 23 January 2019 00:34
> 
> On 32-bit architectures defining resource_size_t as 64-bit (because of
> PAE), we can run into a linker failure because of the modulo and the
> division against resource_size(), replace the two problematic operations
> with an alignment check on the register resource (instead of modulo),
> and the division with DIV_ROUND_CLOSEST_ULL().
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: c196cdc7659d ("reset: Add Broadcom STB SW_INIT reset controller driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/reset/reset-brcmstb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
> index 01ab1f71518b..c4cab8b5052d 100644
> --- a/drivers/reset/reset-brcmstb.c
> +++ b/drivers/reset/reset-brcmstb.c
> @@ -91,7 +91,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
>  		return -ENOMEM;
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (resource_size(res) % SW_INIT_BANK_SIZE) {
> +	if (!IS_ALIGNED(res->start, SW_INIT_BANK_SIZE) ||
> +	    !IS_AGLINED(resource_size(res), SW_INIT_BANK_SIZE)) {
>  		dev_err(kdev, "incorrect register range\n");
>  		return -EINVAL;
>  	}
> @@ -103,7 +104,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
>  	dev_set_drvdata(kdev, priv);
> 
>  	priv->rcdev.owner = THIS_MODULE;
> -	priv->rcdev.nr_resets = (resource_size(res) / SW_INIT_BANK_SIZE) * 32;
> +	priv->rcdev.nr_resets = DIV_ROUND_CLOSEST_ULL(resource_size(res),
> +						      SW_INIT_BANK_SIZE) * 32;
>  	priv->rcdev.ops = &brcmstb_reset_ops;
>  	priv->rcdev.of_node = kdev->of_node;
>  	/* Use defaults: 1 cell and simple xlate function */

Isn't it enough to assign resource_size(res) to an 'unsigned int' ?
The value is never actually going to be over 4G.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
