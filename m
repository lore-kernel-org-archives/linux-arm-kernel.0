Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14870C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:03:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93D0217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SQdimjWY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZLbX1Sy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93D0217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BWCq+HdnpWFYo4bLGIJFz4RMGahLkooOBvZ3+3eXb+Q=; b=SQdimjWYWQjKXH
	PBrSUS7y+3vofzY5isvYOLRQjm7jb2Um+7YqylPcM0046N/PiPu2+NyFDXJH5IRHYw7wQ/KajRgQc
	YKmcPoSeczZ/lpGx2Nuy6ainjDQ/4cSTAvtcecaHW8UiUlvWG4b/R77PEOtdcG/992aZ3+ouUR+IN
	EY6TdGHZDHh3Jx2qSbE19rXu3MnYNFDLhK7WmfYrWmvb1oZllj3JgmJY75cSDZwFV/JfGUyxN0VcI
	VSGpQLteczwCcSAaJJOA/gLhAt/nH0QL6YEOcgW9uCrn+HtSw/wAd59cEkM861nWu8uAlQ3nASXOT
	ZQ5fj4lJI+fGZuN79WDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvUWs-00038c-E1; Sun, 17 Feb 2019 22:03:18 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvUWo-00037l-Vg; Sun, 17 Feb 2019 22:03:16 +0000
Received: by mail-ot1-x342.google.com with SMTP id g1so25132695otj.11;
 Sun, 17 Feb 2019 14:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1jO9MzCC73MnV6m85PMkVBIfhuvLVlrxHdM19Ba0nRg=;
 b=ZLbX1Sy4vV2LLMwAEICGHVikesUd42wJAcf09IsEKd5G6hwutdPsPiwR+A1L7gIfTs
 vOv0DQDHhVZ9dgW1rQ6RzIgUEmu9fwkHNwhDpF0PUplojIGlGRUkhQIpo5pF6zLPnORt
 VyPCx3icKLH1IJrkmY5lZ37FMfHRD+KrRqXbOtlTlA+AjZghGYMmm4zm33IeNh+7h6cn
 +zxkWJytvYUnrJDDtw522Q1A7bcZkM5eXQGwtH+WyhifsFySSQnt/olhMFxdShDqYh6x
 LdlOXfHOOemkc2Cdycn6bz6hZO8R/jzP0M5/NhBDS+XzGgYQ8BF0jv0BSPEywcq3QYWQ
 0wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1jO9MzCC73MnV6m85PMkVBIfhuvLVlrxHdM19Ba0nRg=;
 b=YTI7FE3m7PKJA6mpB3ON1rqRJhLiFiAE2O+PukixAT+kbo2WcoiOqAsrNXaSHNMLy0
 TqeVadvMmMhgMdIx8D3WW2Yda/5hiqDh7NY8AvbdNpfCg5h0NtWpFyaBecCrEll5/yVR
 E2DVfvDjA/YQHl5uhCdnCO5/sXWiUPIJ2QtM1ToTLqyjyYnswKt68woCGX9HuKxGs2Qs
 eOUGAhWXGNpELKfPvdgPTZeb1dD0lDu+Iej8yQjY+cSlJ4DE8Uo612CUZmxU6brAbsnG
 ilPhUgnFaHUhbBhBZ/Kf1W7IRb9Q/9FmTfW0Kt6bj9Z4v7FOu9tYGWmoTmMLxeq49szl
 uaUQ==
X-Gm-Message-State: AHQUAubBPIplxViiy3spkM8UDgRas60bCS/91KZg8MTdFv8NSc/Gxck0
 pwdUYBIBGb4HhAUSuXnWoxRWO1cIfcDkITaUEk8=
X-Google-Smtp-Source: AHgI3Ib7sWjIbwwd6DEwqjxVJdURd1adkMhrvKp68Iwf4pX6EECEMQVfFIJ7yeo1e5BtpjFKFgEJYcpxRcHBG/bRMNw=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr13173460otf.131.1550440994225; 
 Sun, 17 Feb 2019 14:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-3-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-3-narmstrong@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 17 Feb 2019 23:03:03 +0100
Message-ID: <CAFBinCA37waCTqGrMqaLmb5n8XuGJof_7iQsWkBdAYr7s2en=g@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo
 PHY Bindings
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_140315_018915_1642140F 
X-CRM114-Status: GOOD (  17.92  )
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

On Tue, Feb 12, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Amlogic G12A Family USB3 + PCIE Combo PHY Bindings.
>
> This PHY can provide exclusively USB3 or PCIE support on shared I/Os.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
one nit-pick below, but apart from that:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  .../bindings/phy/meson-g12a-usb3-pcie-phy.txt | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
> new file mode 100644
> index 000000000000..714d751091f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
> @@ -0,0 +1,25 @@
> +* Amlogic G12A USB3 + PCIE Combo PHY binding
> +
> +Required properties:
> +- compatible:  Should be "amlogic,meson-g12a-usb3-pcie-phy"
> +- #phys-cells: must be 1. The cell number is used to select the phy mode
> +  as defined in <dt-bindings/phy/phy.h> between PHY_TYPE_USB3 and PHY_TYPE_PCIE
> +- reg:         The base address and length of the registers
> +- clocks:      a phandle to the 100MHz reference clock of this PHY
> +- clock-names: must be "ref_clk"
> +- resets:      phandle to the reset lines for:
> +               - the PHY control
> +               - the USB3+PCIE PHY
> +               - the PHY registers
no reset-names (like in the G12A USB2 PHY bindings) here?
even if you don't use them in the driver I suggest you add them for
consistency (and maybe to make it easier to compare the bindings with
the datasheet. I don't have access to the datasheet so I'm not sure if
having the reset-names is relevant for this case)


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
