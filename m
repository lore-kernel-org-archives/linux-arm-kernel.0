Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1725CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:55:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD10721473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="roeS1F7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD10721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o0cdLnzH8Av5htW4C1wvT1vWnybSBqMM5vUhs05cUMI=; b=roeS1F7jqXKCHG
	GWxuJvIpCQ1lrYxSnm0Mr44tVPhDDdvf0Y/rSQEP3GzAEun6R6KJv/v/pc9az15fY9btF/YNVxhiS
	E8DGgzPNTFY0XrDTnMsIxy//d83YcjAkwoqMkqdIGikczk5UXWjq3hQwkPPxaTNoUOzMbW6/CXZpG
	R77yySp/yNw0ooNx/7ka6XyHh//W4ek88+aAYrNWPGIf7lfIUhqOajwfMs3IDVuJn5QCeAVXFV4Ci
	6mbjdf0R/qQ2OLxVkMepC61P1b/B1V4qs4qINqJOb0GWsqKLDEjW5D4j7CTkQORdsMW0zVrCVs+Fh
	eey+TBkZo/FGRGWa3E1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkwk-0004Df-2p; Mon, 03 Dec 2018 09:55:22 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkwh-000428-8k
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:55:20 +0000
Received: by mail-ed1-f67.google.com with SMTP id f9so3697903eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ppQqETSEtQ8o22fzvv7O3C3bq1hMhcqdPHZFTNyzrq0=;
 b=h59qBTiPTaWFNGPG91w/Ofi7DXdBZAzjYIRUjGh/lQVcE9BOvnjsAzhSLVIgUd0QOu
 zV4fVBFDJQvo5rkpnzvyuCJRwP3ek1Nkq4c45AVLrT/lrtrmlgiG/0TxhFbGULSzv6pO
 5fYwZHJQJg57qNMiucge7lBZU1DXe4eVcGuzmBGumPNcw5iKpj2GuCZJzRX6LTEkyzfH
 8Z3LbeXRyoagjXrc6ieKRuQXUCMiiUAXTgpCQA8HHHGKP239SYyBbyMFzYPyiOkkTaLm
 vdDjj6CgHzn86H6xrkkebsbIH5+u6Da/FXd3oSJxcj+9Z7xZ8v8jhiItMDoIn25LZDug
 +8hg==
X-Gm-Message-State: AA+aEWZfhXi2jmiW7iBOJC1Sh4XWkbMOncIx6wmonMKrbtzL/ViQIUx5
 PUTDlC+940dpnVdd8NZq5KVR444mK9U=
X-Google-Smtp-Source: AFSGD/UFU7h1pX13LDDOxRd6wzuDsqv8cnfvLYpyPtg+LSatGNVlHamFPfZDJLljY/2/qr9OxtnBHw==
X-Received: by 2002:a17:906:a281:: with SMTP id
 i1-v6mr12307329ejz.86.1543830907138; 
 Mon, 03 Dec 2018 01:55:07 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com.
 [209.85.128.43])
 by smtp.gmail.com with ESMTPSA id n11sm3949637edn.14.2018.12.03.01.55.06
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 01:55:06 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id y139so5016369wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:55:06 -0800 (PST)
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr7520225wmd.111.1543830906225; 
 Mon, 03 Dec 2018 01:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-6-wens@csie.org>
 <CAMty3ZAuBM0s3eNhQBySSaUrUAkiF=Hk+Ab=gsN=QucLJv0zyw@mail.gmail.com>
In-Reply-To: <CAMty3ZAuBM0s3eNhQBySSaUrUAkiF=Hk+Ab=gsN=QucLJv0zyw@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Dec 2018 17:54:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v64dbDW9Fpb_B0d8wQW7WTELqGoUzasV_KXonfEkucRZTA@mail.gmail.com>
Message-ID: <CAGb2v64dbDW9Fpb_B0d8wQW7WTELqGoUzasV_KXonfEkucRZTA@mail.gmail.com>
Subject: Re: [PATCH 5/6] [DO NOT MERGE] ARM: dts: sunxi: bananapi-m2p: Add
 HDF5640 camera module
To: Jagan Teki <jagan@amarulasolutions.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_015519_309569_B807C777 
X-CRM114-Status: GOOD (  21.69  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 5:52 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > The Bananapi M2+ comes with an optional sensor based on the ov5640 from
> > Omnivision. Enable the support for it in the DT.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> > index b3283aeb5b7d..d97a98acf378 100644
> > --- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> > +++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> > @@ -89,6 +89,42 @@
> >                 };
> >         };
> >
> > +       reg_cam_avdd: cam-avdd {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "csi-avdd";
> > +               regulator-min-microvolt = <2800000>;
> > +               regulator-max-microvolt = <2800000>;
> > +               startup-delay-us = <200>; /* 50 us + board delays */
> > +               enable-active-high;
> > +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> > +       };
> > +
> > +       reg_cam_dovdd: cam-dovdd {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "csi-dovdd";
> > +               regulator-min-microvolt = <2800000>;
> > +               regulator-max-microvolt = <2800000>;
> > +               /*
> > +                * This regulator also powers the pull-ups for the I2C bus.
> > +                * For some reason, if this is turned off, subsequent use
> > +                * of the I2C bus, even when turned on, does not work.
> > +                */
> > +               startup-delay-us = <200>; /* 50 us + board delays */
> > +               regulator-always-on;
> > +               enable-active-high;
> > +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> > +       };
> > +
> > +       reg_cam_dvdd: cam-dvdd {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "csi-dvdd";
> > +               regulator-min-microvolt = <1500000>;
> > +               regulator-max-microvolt = <1500000>;
> > +               startup-delay-us = <200>; /* 50 us + board delays */
> > +               enable-active-high;
> > +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> > +       };
> > +
> >         reg_gmac_3v3: gmac-3v3 {
> >                       compatible = "regulator-fixed";
> >                       regulator-name = "gmac-3v3";
> > @@ -106,6 +142,26 @@
> >         };
> >  };
> >
> > +&csi {
> > +       status = "okay";
> > +
> > +       port {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               /* Parallel bus endpoint */
> > +               csi_from_ov5640: endpoint {
> > +                       remote-endpoint = <&ov5640_to_csi>;
> > +                       bus-width = <8>;
> > +                       data-shift = <2>;
>
> If I'm not wrong, the data-shift is not available in sun6i at-least in
> conf register.

Indeed. Seems only a few drivers actually take this into account. Since
this is just an example, I'm not going to respin it.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
