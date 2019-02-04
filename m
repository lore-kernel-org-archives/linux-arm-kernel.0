Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80611C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:21:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5C32082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QhQX8HPv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KCLZCedu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5C32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2LiiGHhNKoZQzAjWZlvWFUyGJa77PwWAu2LpJTqPobg=; b=QhQX8HPvc5uIYr
	Dnn9onXkjvxFtkEwuFEV7M18gi/cPDCRmfMhMnpVR5raQg6gRj9V3GTLZeziWI13HIygENLa1DmDA
	ycSwvrAH/0k+e4Ifv4wNQ6hmkqvO0+q5GhhJu24GS3a9dIivCf2f2mjS8uEPHeLK0duNQRz5KWYfD
	/xqizBOZarun9gGNIhcyFkJIOJvmn7afg2jzIQpZsG3C9UaD0ntjvjfeGLDepZ1CUrLrA1KOv6TDl
	iCaqtPnHly7CAQ3dGLgMdZ8Vz4+/0SRCpQWxk1c9+2DlwWnJIbjFFucOtoR62d7NhlSoA6+5oINCL
	bBt5UYSWxMN7JookM96Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqeBX-0000hT-Bl; Mon, 04 Feb 2019 13:21:15 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqeBT-0000h7-Vl; Mon, 04 Feb 2019 13:21:13 +0000
Received: by mail-ot1-x344.google.com with SMTP id v23so12828286otk.9;
 Mon, 04 Feb 2019 05:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uZVG5DUNwChyTDNZ2apKIXVpZJJyZiLAB7MMLhzKa68=;
 b=KCLZCedutreYPysnbSc8b8RxwO58xZsrrQBi9JekcpkBQVWntBqAzQ0wYixP3ytunc
 cAHlqUUsEi5iD7MUHQNo2UZP1MX9zAiOllMWi6FmnkUAT1MF9pqJZJWsA9LMVVbnzr0V
 fOcHAJgb1tNhTKbKkeU68ajpXaBk3O+HOFBnfJoWwE7+S8pfyiG+s/ut2tpJlZDmet+U
 rMR/t6xO/0lueaTn+Snl85NuhqF9wP1MRltKBb4DXc6LREL3CwGyLaH1OMxDCe5RSySz
 dGWBfXvIW0fO0Pgr14Cp2CS+NpFSC5XGmT/oRgg5gwDoQXOIqSbCNUD8Uk/ZbenqF5Rc
 PVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uZVG5DUNwChyTDNZ2apKIXVpZJJyZiLAB7MMLhzKa68=;
 b=EbjelTuSZBsdua94X7OWP7s0qyL6SwHcIAS6hmGljtE3kGvHUqBcRPfyd+k9tmiRUu
 PIeRQxPmNZVwGIh8sip3jRCln+VCn6w25RxJH496GxY8HS17v4150972U7iIAf5WfQF3
 0wq5UtKbT5ssztobjdM3Tv+mRXRk3fQiYkF5V5HEZdH87hebbCSdI30MmPEFWPcvQUfi
 WSj3zJQ4rIVqg/fe2Y7FQlnUKhxANPK+L58fjQRBfTDToO1WytDjGpCGqxMVk+BxBhLY
 r08ToGEZ287ZnJF7zfLpKT4r4S1YUZPVVRMGhMZbtBKY6StNEnAphMJbEXxs5dKMF60B
 QLGw==
X-Gm-Message-State: AHQUAuYoWAQHrSapdL4DitN+JV8G0NZ4EwAvs7OMw6GJ6rBGntzDyH70
 wl6TFV1mV11VpnMs7f5Url998a+BmtmcsYQMjoY=
X-Google-Smtp-Source: ALg8bN5D/5xTQtm5YXR+JIeIdc8P/hfby9TCD9bpta4V9UwzGzyXvvkuHr2n1wlH7noN51JEHPRZLsKsP78Cwovx428=
X-Received: by 2002:aca:3586:: with SMTP id c128mr27585274oia.47.1549286470256; 
 Mon, 04 Feb 2019 05:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20190123151209.2080-1-linux.amoon@gmail.com>
 <20190123151209.2080-2-linux.amoon@gmail.com>
In-Reply-To: <20190123151209.2080-2-linux.amoon@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Feb 2019 14:20:59 +0100
Message-ID: <CAFBinCCOQ_GqHZuYf6n8ba_ZMbOwKmUzc4EJAuXRpn4tTTCUKA@mail.gmail.com>
Subject: Re: [RFCv1 1/3] phy: meson8b-usb2: Enable otg phy controller on
 Meson8b SoCs
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_052112_050786_E0EEB238 
X-CRM114-Status: GOOD (  18.75  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

On Wed, Jan 23, 2019 at 4:12 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Meson8b support two USB phy controller, one with otg port and
> other usb host controller. USB OTG controller ie. otg port can
> be used to power on board or host port for usb device.
> Changes enable usb otg host controller when dr_mode is set to otg.
can you please add a sentence explaining *why* this allows enabling USB OTG?

> Currenly otg port can be used to power on the board.
typo, should be "Currently"

> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> New patch in this series.
> --TOTO enable OTG port to work as host.
> --Currently we can power on the board from this OTG port.
>
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
>         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
>         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
>         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> ---
>  drivers/phy/amlogic/phy-meson8b-usb2.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
> index 9c01b7e19b06..1333c77e9172 100644
> --- a/drivers/phy/amlogic/phy-meson8b-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
> @@ -109,6 +109,7 @@
>
>  #define RESET_COMPLETE_TIME                            500
>  #define ACA_ENABLE_COMPLETE_TIME                       50
> +#define DCD_ENABLE_COMPLETE_TIME                       10
>
>  struct phy_meson8b_usb2_priv {
>         void __iomem            *regs;
> @@ -188,6 +189,20 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>
>                 udelay(ACA_ENABLE_COMPLETE_TIME);
>
> +               if (phy_meson8b_usb2_read(priv, REG_ADP_BC) &
> +                       REG_ADP_BC_ACA_PIN_FLOAT) {
> +                       dev_warn(&phy->dev, "USB ID detect failed!\n");
> +                       clk_disable_unprepare(priv->clk_usb);
> +                       clk_disable_unprepare(priv->clk_usb_general);
> +                       return -EINVAL;
> +               }
> +       } else if (priv->dr_mode == USB_DR_MODE_OTG) {
> +               phy_meson8b_usb2_mask_bits(priv, REG_ADP_BC,
> +                                          REG_ADP_BC_DCD_ENABLE,
> +                                          REG_ADP_BC_DCD_ENABLE);
where did you take this from?
$ grep -iR DCD arm-src-kernel-2015-01-15-321cfb5a46/drivers/amlogic/usb/dwc_otg/310/
-> I only find code which clears REG_ADP_BC_DCD_ENABLE (your patch sets it):
  adp_bc.b.dcd_enable = 0;

> +               udelay(DCD_ENABLE_COMPLETE_TIME);
from Amlogic's code: DWC_MDELAY(T_DCD_TIMEOUT);
while you are also using a delay of "10" the unit is different (your
patch: us, Amlogic: ms)


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
