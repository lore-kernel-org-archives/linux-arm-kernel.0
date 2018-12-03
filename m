Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB09C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:52:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6359020834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G5l7CiJG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KHwOLNe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6359020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dtNTXUHaHEHN+4D3bh1dkjSDb/Tqo9aJmaiq/55SUYk=; b=G5l7CiJGZxTPWI
	USxE89zKZOyNmnlmnXdf1K0scnD18+2cQitZu87tEWcReW5IEaJ6ryGRyeA3V2Ybl0GNQl2Lw4H3B
	/z3SCvvqiDWfE7visoHRPnCu4M9wofXnMs5fx1l7U34PYeVJfO2nBRr7T2Hg0enU7G5XWEIJK6t90
	Cm2oj87z/VO5WmtTVmUvS10db6qnOMBGDG12owPKGYlmE29LI0OT8XYBaqEXnFPaCGXYacwD4jhgu
	fFsxk0fhDSITjhs5QsMU7Oz6f83zK2eE5aUVYQYZFPK8o/ciQN5w8frSmDt8iBP1JZKNu4vfcEOD1
	wbDTXGMkp8TguvzmYNFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTktl-0002Mh-8w; Mon, 03 Dec 2018 09:52:17 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkth-0002LL-Ic
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:52:15 +0000
Received: by mail-it1-x141.google.com with SMTP id i7so8257808iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qlA+Ve7B0ClpzM1pZ9TLkwyLB5aC59cq0OOd3p7iTDU=;
 b=KHwOLNe9jToVnytNapGRrK8uBcRyJB7uVy8FlJn8uhIVd52smg8Yx5x7/6eRlmOPVg
 AYPvZkKdX0XKxs7/rDMvdJPOHI11hv4c8WhWt0VgncYAjyjMvkjyw16zOThL6cd+PBIb
 KIsbEOgM41lW3adQafkRadYQb32J4dNmHnNTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qlA+Ve7B0ClpzM1pZ9TLkwyLB5aC59cq0OOd3p7iTDU=;
 b=A9BMvvFsvN1X9r49QzXLBNxbJ1g+4EAhNRQP06e9kHykyjaoY6NLDVhCC+Sja6TjNs
 5r1CPLSY/iLDcUZcIEy+I8OWx4AU7iOMGfdbzamiKrPaCw+ye9gciPdBY3JbKEq1IIjd
 DH76GBTF7bCXyPFXUG3/Kqm6RrbSUzxRLxNE0vWir3TQQhhwXATvD08Cz9BeZ/BQbtFK
 DE7WxwPuUMMAzlLjWhV3Zpn01i8w/gFXJEuG206nhwCHgEJIl29fHQ6WGuBRNX0qk2C8
 EahrJoQ1W8/T994opRYlhns72+pHOrGaQps0GHgROt7UiwTBfCCtDIYh71hui7RhyRPo
 UALw==
X-Gm-Message-State: AA+aEWYbFPJEBKzqIcR/3DCIct9nidPU1tn4r1dpzSGugWukmfq1JzEH
 u70NY2zZbVIlBjk03TlTSMBClNMRVeejkh9pyYMTHg==
X-Google-Smtp-Source: AFSGD/VSuBnkXddzpk+LOXKAE6/jzMC+dF5S8T4A9Nkvdk2RIzi0lduFAHRO3/G52qKhdWprKhjcwVkVSl2Z4IkWaWc=
X-Received: by 2002:a24:10cb:: with SMTP id 194mr7446972ity.173.1543830722223; 
 Mon, 03 Dec 2018 01:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-6-wens@csie.org>
In-Reply-To: <20181130075849.16941-6-wens@csie.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 3 Dec 2018 15:21:50 +0530
Message-ID: <CAMty3ZAuBM0s3eNhQBySSaUrUAkiF=Hk+Ab=gsN=QucLJv0zyw@mail.gmail.com>
Subject: Re: [PATCH 5/6] [DO NOT MERGE] ARM: dts: sunxi: bananapi-m2p: Add
 HDF5640 camera module
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_015213_622525_FAF5A274 
X-CRM114-Status: GOOD (  18.82  )
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
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The Bananapi M2+ comes with an optional sensor based on the ov5640 from
> Omnivision. Enable the support for it in the DT.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> index b3283aeb5b7d..d97a98acf378 100644
> --- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> +++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> @@ -89,6 +89,42 @@
>                 };
>         };
>
> +       reg_cam_avdd: cam-avdd {
> +               compatible = "regulator-fixed";
> +               regulator-name = "csi-avdd";
> +               regulator-min-microvolt = <2800000>;
> +               regulator-max-microvolt = <2800000>;
> +               startup-delay-us = <200>; /* 50 us + board delays */
> +               enable-active-high;
> +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> +       };
> +
> +       reg_cam_dovdd: cam-dovdd {
> +               compatible = "regulator-fixed";
> +               regulator-name = "csi-dovdd";
> +               regulator-min-microvolt = <2800000>;
> +               regulator-max-microvolt = <2800000>;
> +               /*
> +                * This regulator also powers the pull-ups for the I2C bus.
> +                * For some reason, if this is turned off, subsequent use
> +                * of the I2C bus, even when turned on, does not work.
> +                */
> +               startup-delay-us = <200>; /* 50 us + board delays */
> +               regulator-always-on;
> +               enable-active-high;
> +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> +       };
> +
> +       reg_cam_dvdd: cam-dvdd {
> +               compatible = "regulator-fixed";
> +               regulator-name = "csi-dvdd";
> +               regulator-min-microvolt = <1500000>;
> +               regulator-max-microvolt = <1500000>;
> +               startup-delay-us = <200>; /* 50 us + board delays */
> +               enable-active-high;
> +               gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
> +       };
> +
>         reg_gmac_3v3: gmac-3v3 {
>                       compatible = "regulator-fixed";
>                       regulator-name = "gmac-3v3";
> @@ -106,6 +142,26 @@
>         };
>  };
>
> +&csi {
> +       status = "okay";
> +
> +       port {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               /* Parallel bus endpoint */
> +               csi_from_ov5640: endpoint {
> +                       remote-endpoint = <&ov5640_to_csi>;
> +                       bus-width = <8>;
> +                       data-shift = <2>;

If I'm not wrong, the data-shift is not available in sun6i at-least in
conf register.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
