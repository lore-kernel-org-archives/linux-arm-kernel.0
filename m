Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D756AC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:01:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09842175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LOq0p4DO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSHrv0jl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09842175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hGxrFLnQrGYot+SZNIF23aCtqz0FB3Z2ORwZoSkuh3A=; b=LOq0p4DOs88by7
	fGXsEA/tFZ7v6xqNruwBX1QgeU6Sn0TDxNKbEIMl5EcfEdofCwulk/QUP2BhpShsuEvbTU9R/dmii
	R6HG9Bay+U2W3RDtpcZJdtILAmGyeWifXWLkjk2RTR2BNu88qBBwn/PxcsRKTCj5isTUdhTnBPD3l
	q0iJlUNVj6Ww24QqB/TwIgy4UT3DcSNf+4/91jljN11KbSdr5eTdyh/ct54tgDSAcEZCHru15rxZR
	0LfgqmGg8Qd2Psj+38FEaAcxwY7D16BuZNuV0BDtFtIGRIxH/XelHgcNn7+eFdk7hN6PCZ5HW7vTR
	kS1GAbY2UQ4wMm22rL0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr5xu-0006R5-DG; Tue, 05 Feb 2019 19:01:02 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr5xp-0006Po-Nb
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 19:00:59 +0000
Received: by mail-lj1-x241.google.com with SMTP id v14-v6so1057546ljv.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 11:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9Ii1zkpJMnUP4gV1GDZFzp7asIhaprUu1dNgN/0w9hY=;
 b=hSHrv0jlbQxfkkR+ZTsf1C/QyvKqgbBkz8drQzZnTF4AfCoIAOdm+GoZEdFd7SbypM
 UG+fk99FditjoHSwikN2qKergCEb9HWHc3mPT9FnG/XOz9/Q2bNj/EF50x3bfhZVireC
 x5r/K/1MCZF4QEoACZ3qffJDyQRy9EWJy3u4SfUK1L+c4KXy/XnmaFKyxEOsH/xnks+k
 d46vCCE+JX57og7oEX7wxOUycSJ6L4p6yX0TzlnBRiLq0PVRqF+rRE0S+EMOm+/WmZRs
 xlM9PSUcBuX/4EnEn6nm6GEGaqJSmO/N7cR6jQbmuEfB0JYj68InlsY4e11q8r2ejCLK
 I+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Ii1zkpJMnUP4gV1GDZFzp7asIhaprUu1dNgN/0w9hY=;
 b=oC/U0MS50x20R/K099kMuU835ZTqrLBMpngTBnTIBNVh03YXH/NPfDr8b7kPV/m1Vq
 pv3xRX/+TACSGLWeQGym5ofU/Hdm5MZG0KSGTHQWFS8AzBUo4W0iv+WDoPSdY0dTFk3+
 Any7u1sKfbjmfehaLZ+e1M/hkb2aWkgZ2LuAgYA4KabrUYinq/8JlU8vXOR6X2cZC7mU
 utXtMP6kSpbUmlSmCbOK3891HUJNCmwReXeXF0wrE39Bz2Js4OIj3M8EDxl//lNQwd21
 8vDjucNqKFC0O2jP6XVt/wEOQiRijEvz1o4K8hNpqGyU0vcAplFpvqB/0IiBAOWYgosH
 BBbQ==
X-Gm-Message-State: AHQUAua5TWe1D/9TE/49SgD+lg952q9CxJg30V+xs+ERXf95Afg+v1FK
 TCmET8e5asTeNOtCaYNYU3Ibo7wKHL6eNNVgOvwDew==
X-Google-Smtp-Source: AHgI3Ib+ob7GlrP05cPcePXjRO1T3vArIJCAAT72qlUnxxqX8WgwX6UmHhNISqA0qOSCs44u6iSUSN3VzHK4WoKuKR0=
X-Received: by 2002:a2e:8087:: with SMTP id
 i7-v6mr3802701ljg.179.1549393255057; 
 Tue, 05 Feb 2019 11:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-8-manivannan.sadhasivam@linaro.org>
 <20181221023554.GB3233@Mani-XPS-13-9360>
In-Reply-To: <20181221023554.GB3233@Mani-XPS-13-9360>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Tue, 5 Feb 2019 20:00:43 +0100
Message-ID: <CAP71WjzWiCg-NXDnh58N-5O7kvNj+DDndSK04DeoPxFE2L8W0g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: apq8016-sbc: Standardize LED
 labels
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_110057_805469_A3BD0183 
X-CRM114-Status: GOOD (  14.75  )
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
Cc: devicetree@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, linux-rockchip@lists.infradead.org,
 Koen Kooi <koen.kooi@linaro.org>, linux-leds@vger.kernel.org,
 Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hey Mani,

thanks for sending this out, it should have been just like that in the
first place ;)

On Fri, Dec 21, 2018 at 3:36 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 03:12:45PM +0530, Manivannan Sadhasivam wrote:
> > For all 96Boards, the following standard is used for onboard LEDs.
> >
> > green:user1  default-trigger: heartbeat
> > green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> > green:user3  default-trigger: mmc1 (SD-card)
> > green:user4  default-trigger: none, panic-indicator
> > yellow:wlan  default-trigger: phy0tx
> > blue:bt      default-trigger: hci0-power
> >
> > So lets adopt the same for APQ8016 SBC (Dragonboard410c), which is
> > one of the 96Boards CE platform.
> >
>
> Hello,
>
> Any update on this patch?

Reviewed-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>

>
> Regards,
> Mani
>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > index 46feedf7c989..35f95154316b 100644
> > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > @@ -300,28 +300,28 @@
> >                       compatible = "gpio-leds";
> >
> >                       led@1 {
> > -                             label = "apq8016-sbc:green:user1";
> > +                             label = "green:user1";
> >                               gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "heartbeat";
> >                               default-state = "off";
> >                       };
> >
> >                       led@2 {
> > -                             label = "apq8016-sbc:green:user2";
> > +                             label = "green:user2";
> >                               gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "mmc0";
> >                               default-state = "off";
> >                       };
> >
> >                       led@3 {
> > -                             label = "apq8016-sbc:green:user3";
> > +                             label = "green:user3";
> >                               gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "mmc1";
> >                               default-state = "off";
> >                       };
> >
> >                       led@4 {
> > -                             label = "apq8016-sbc:green:user4";
> > +                             label = "green:user4";
> >                               gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "none";
> >                               panic-indicator;
> > @@ -329,14 +329,14 @@
> >                       };
> >
> >                       led@5 {
> > -                             label = "apq8016-sbc:yellow:wlan";
> > +                             label = "yellow:wlan";
> >                               gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "phy0tx";
> >                               default-state = "off";
> >                       };
> >
> >                       led@6 {
> > -                             label = "apq8016-sbc:blue:bt";
> > +                             label = "blue:bt";
> >                               gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "bluetooth-power";
> >                               default-state = "off";
> > --
> > 2.17.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
