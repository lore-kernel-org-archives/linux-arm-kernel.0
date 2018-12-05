Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4102FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:15:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FCC20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FiPaJfrG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i55Gn+qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FCC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YvjuhgZyF3Oga8GUyu10r1YIB2MfEHrYGY4hFiXTOmw=; b=FiPaJfrGbb28cY
	62BVOJ57seqoXAZ5+W1xThnZENTY2VjjAN5H+1MH0Ra1Acctjzre/+mHlq6a9GMo6Yd6PNn+Rt8af
	DB1hAwbV+j3WAw/2bj361z83cwI19Lhlum/byBnuvsl7Vyn2jPn6UYYwA1yYxo5+rqeg16Oj0jhWD
	mZ7TZk5vUwc9ywLNe3Anp7el7SBo9kopQt7pHHxYh3J14OKRpJKHDxFj9DNxnd3ikVI+gRrmxo5cL
	zQjMpuKqtA2FVlFFjyNJSBI0eqkPqWkLyQgQ2igKml0zIWlVuklm3QUj3KuoofKMlz6MiZbIqICMP
	nkcAgHUXYTJ85q75RpbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUW5H-0003B0-Sh; Wed, 05 Dec 2018 12:15:19 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUW5E-0001z7-Pa
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 12:15:18 +0000
Received: by mail-oi1-x241.google.com with SMTP id v6so17318480oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 04:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GBUSQk2PdOZFKYA6A63N18LCzBPvNkM379cJypVZDM0=;
 b=i55Gn+qUZw8+y65bQTAfeP94ZFm+9BnhUqA1rKpcXN+YUuwcM8lU+960a4gEL154j9
 Fr1ZRP1UBpmy621uTAI1JDeOuwuKWDWkZLizqrXy6GrXhrM1dgnkeJVHPoE0GuBxQmSL
 6vHK8WsnyA7pvvHwPHSjtALMyCGZ/vCZB+AHqnvpxIPVTW0CG67qNUs5F+GPtXLlwa3O
 jiYGw4fr8FdoDp2/R4gpUhqdNFyOLP703ijyOzqQM7KOHetJC10iKwK2i1bus++/y+sR
 bbcGPfMbxJBgjqQKByMABjGmQXbaX31BGR116/3nwON2vCqHKMCgDLQZ23Cvy7sfY05h
 Heqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GBUSQk2PdOZFKYA6A63N18LCzBPvNkM379cJypVZDM0=;
 b=QoLs5c/nDRYU8XHFSBYcKGZuB3G6fAaQlLKl5gyMQ3iPspPqfS491go/tpvHBmj06H
 ksGEWPBJkqddieKwvI4N+T0sVKVRs5KCC5S15E97rx1wdVRFbVfhaDi1xK13heD04yWG
 BKaTqZ7A8W5r4FbGkzZTQO5nRTeMU5EJpUKlA9iTBxv5u69Wfi2o3bJ342lXtY5DNVys
 eMCfMzk2VEvKfmTFvXrGD0EX98exfc30FL4frt2sIZh6ItQqHXIDjpa0f1rbbtegVsTT
 e6gsXMMSWg+mQyhpeL8X2DJFJbN2/oyfPsFz78CEJxqgh8P0A1J+p6PbGvhtLKGjiBb9
 HPLg==
X-Gm-Message-State: AA+aEWYB5unV3xjN+y/uC/5DYtaREGFVQkB/qsFdHkyQwmtYe8fedH61
 7+H7cmFeje9edqhYC1leB8IfJ59CGUBnZFIRvjY=
X-Google-Smtp-Source: AFSGD/X1JcPRDrP2vleoUg4EqcCzdoBIbgHS1sqhjpYkrt6Bo4J6K5ZKLzrijF+TP2vgoy+wbnJI5XL6MJaqSHArHvc=
X-Received: by 2002:aca:4d47:: with SMTP id a68mr13926177oib.43.1544012102512; 
 Wed, 05 Dec 2018 04:15:02 -0800 (PST)
MIME-Version: 1.0
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Dec 2018 10:15:06 -0200
Message-ID: <CAOMZO5ACrqY9FusUG7E-vMWJ4pKpVgw-yLOYqJncOJ+H9A5k5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6qdl-sabresd: add light sensor support
To: Yongcai Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_041516_832806_F31B36EB 
X-CRM114-Status: GOOD (  18.17  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anson,

On Wed, Dec 5, 2018 at 7:20 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add isl29023 light sensor support on i2c3 bus, the light
> sensor's power is controlled by a fixed regulator, since
> the isl29023 driver and most of other sensors on same
> board like mag3110 and mma8451 do NOT support regulator
> operation currently, they are all controlled by this
> regulator, so this patch also adds the fixed regulator
> support and make it always on.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index d7389b5..f96ae54 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -62,6 +62,19 @@
>                         gpio = <&gpio3 19 0>;
>                         enable-active-high;
>                 };
> +
> +               reg_sensor: regulator@4 {

I know that you followed the existing pattern for regulators in this
file, but it is not recommended to put regulators under "simple-bus".

I would suggest you to make a first patch of the series that removes
all of the existing regulators from "simple-bus", then you add this
series on top.

Then this regulator becomes:

reg_light_sensor: regulator-light-sensor {

> +                       compatible = "regulator-fixed";
> +                       reg = <4>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pinctrl_sensor_reg>;

pinctrl_sensor_reg is too generic. You could use pinctrl_light_sensor_reg

> +                       regulator-name = "sensor-supply";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
> +                       enable-active-high;
> +                       regulator-always-on;
> +               };
>         };
>
>         gpio-keys {
> @@ -420,6 +433,15 @@
>                 interrupts = <7 2>;
>                 wakeup-gpios = <&gpio6 7 0>;
>         };
> +
> +       isl29023@44 {

Node names should be generic, so: light-sensor@44

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
