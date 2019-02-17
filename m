Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7815AC10F06
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:07:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D662184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qB9N0/cH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="A7oN0MY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D662184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ijfh5TsD7ssqMQRSu7ZsbNyNb7b3tJ8pOKNQ4W9unwE=; b=qB9N0/cHtLVlid
	A93F2Ra/htmswI+LrSQ8ZZu0XTAC+nLDoC4Es8cTso3tg/hIuvwvW4bdXx4NSw28BMXTMAn/qLMPY
	6qmCJfgWx5yHKgnRs8bmvUSTMVSboBX/FNto+MxOBmo2T/BQiuyw6EQ/tix/TUvE/BO7PmoetDTFN
	1bf/bYnMNs5uEYU9yGoXVPV4Jltp5AoKBk4Eu4qYcsxG4kjq4Sq6sT4r+Avxk8nbfSdBiztowGgtY
	T50ZQ/OTwTEzo4ojCLqOHU+C6XrKd5f4wBy06jiMJlrjPxt7dCjweOqgKZ87cyNFpqnIY78nsP6Gg
	WajvfJz/+7dwJ3t4+eMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvUbB-0004lk-PU; Sun, 17 Feb 2019 22:07:45 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvUb7-0004kl-TL; Sun, 17 Feb 2019 22:07:43 +0000
Received: by mail-ot1-x343.google.com with SMTP id i5so25174218oto.9;
 Sun, 17 Feb 2019 14:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fb34zk0pI4o5Yrm2AzckhgwIT5jFzU1CY3//3+bCSd0=;
 b=A7oN0MY1nq9XiqE4fU9+ijO7qYjmTi2Z5sQYDo+7t3bvAHG7Q8MbP4TUygf6sSW1pN
 6K+7fa1+CmfXP6TFi3FHVlPA15eaD1Cuc8J5wjraCWWrD+cee1aPjnaB68qTs+o+PsQT
 EeNcg+H/n04u0VxjAYndEJzuIWOqBm9lrlu8dasBkHVQTGDjAR2WX67tGYbQD8dU7MJp
 nwH9cepymQFmk3vKI3BWbIg61bqo2MvK5JzI1MWCVQwzuBaOsdxBkl1gEjhEo+POtlyq
 BAYVAYqUZrT6YAFuOCW1RFaEt4L/b0SYaBwha4WCvQMZUlZAR3avxnxTaAZYZBtFQ1z4
 tawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fb34zk0pI4o5Yrm2AzckhgwIT5jFzU1CY3//3+bCSd0=;
 b=cmalvG0E5G1I1GIbzzR4z9Nv7FnwbUf0OUavCeZ/yy2U3mHI8tI1Wo/SXZU8UmCgM3
 88fuV8rgkc8Tct8JJ45sBdgcY3qJQEYuIhBufhVyO4Id6MrSlcFHlYXe92uVKgq3g1JY
 WB+68mEMEpQLvde3ZgBjU4vgJ5PzHYgdhEs0mxoWlCO8eOs4SgnAdY/Ps13L6xSIz+TV
 CcmgI+/pLLpq1XyAEJnH37amN7D/tvDIcAM7yNUldPR/J54gPgd0HLdIOkx9zPlgaxFX
 KfVI2aYo9zugMSeoIlSFpQKqtR79BvrK1i8ijU/PTxq5+R0Fx94Aq2eyydaWGWwJ7qNk
 7U9A==
X-Gm-Message-State: AHQUAuZDiMOUAxIihum1FDA4UABJWrJI3VoHnsWXwI+KLI0tvnw9uXtC
 oOdnWUKZvzqjppdftQ9gTERzf1GJ+Jo5XlFUmzQ=
X-Google-Smtp-Source: AHgI3IYF/eF8fEVvtPrPZpkO1gTS5g5/omwxFYl/mMCwZWICPyeLgArW+TSfazpEo5v5xBnUUV8mbIBAlthSrVXUlEo=
X-Received: by 2002:a9d:798c:: with SMTP id h12mr4342848otm.86.1550441260987; 
 Sun, 17 Feb 2019 14:07:40 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-4-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-4-narmstrong@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 17 Feb 2019 23:07:30 +0100
Message-ID: <CAFBinCCHy5-kxFoAGUvA7KgOFTjvRFjVE962U+FS1UZnGKEOXA@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: usb: dwc2: Add Amlogic G12A DWC2
 Compatible
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_140741_972209_309AAAB8 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: devicetree@vger.kernel.org, balbi@kernel.org, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com,
 hminas@synopsys.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Neil,

On Tue, Feb 12, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Adds the specific compatible string for the DWC2 IP found in the
> Amlogic G12A SoC Family.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> index 6dc3c4a34483..e150b7b227c9 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> @@ -14,6 +14,7 @@ Required properties:
>    - "amlogic,meson8-usb": The DWC2 USB controller instance in Amlogic Meson8 SoCs;
>    - "amlogic,meson8b-usb": The DWC2 USB controller instance in Amlogic Meson8b SoCs;
>    - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
> +  - "amlogic,meson-g12a-usb": The DWC2 USB controller instance in Amlogic G12A SoCs;
if anyone is curious: starting with GXL (not supported by the dwc2
driver yet) the dwc2 core is "peripheral mode" only while previous
SoCs had one host-only dwc2 instance and another OTG capable dwc2
instance

I also discussed the compatible string with Neil off-list because I
was not sure if we have unique compatible names for the dwc2
controller and the "USB control" registers.
The "USB control" registers are named "USBCTRL" according to Neil (I
assume he got this information from the datasheet to which I don't
have access). Thus the compatible string for the "USB control" device
will be "amlogic,meson-g12a-usb-ctrl" - so we don't have any naming
conflict.


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
