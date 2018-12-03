Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23433C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:16:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E678520864
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TN8SAf+P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL8wE0Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E678520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zTiMBn7Ptn3YgAXtjUts8tGDjX57peHvcUkS2A0s7Bw=; b=TN8SAf+PrfNQzB
	BHphZiOKZhVyqbDuLud41ohY0UfM1RhQd9YdUL95m/3w5kcvloIzlWwbcz6Yuy9dF9Boq1ccMGknV
	1ZKYnwIoIKdRZoJCqJIteMMAKUKEen68GT8p0ngBtYf9Wo0GsJ3cRjAAumgidrgg0CiRUxtXUovih
	PbYsrnFxZqSVaeOoVoYAS01Et1MGr0M8rbqFzcVNQgmZcsWknAETiyoTvxlr9GLK64vlI/6VHoasU
	HvqMKeg+vU1mkduvygAYeGiewiefHGgz4kzy6romUrPCXj64wX8ozvTSQ8xAq3YEPb1Sfw8PgDk57
	dgMaiv/dKHB+y7OTOtQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwVp-0000N3-Dm; Mon, 03 Dec 2018 22:16:21 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwVm-0000MO-HO
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:16:19 +0000
Received: by mail-oi1-x242.google.com with SMTP id y23so12479502oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 14:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SiwdSymsTj3ZtXRp/+O99gQ6bsQ4WE3Gz6qmbgXlz1U=;
 b=tL8wE0Dxey9Yhik6AWk0JB45XV0bPwcG7aIa1o0wwsmXLY91UPR+48Vk51DXshiv4s
 Iddeja1kDN2XXelx1lE+GIfYsx2Ae9Ke22Xu5EoeO4LK6o1Kb/kDJoQdbrVrKq5Vlv0t
 fnaMcaCW/0nLuiUjv66CMylpmKsw8cHd/CwRAIui72X7Q5xLEj7MnRcm58JBlj/N3LV8
 y1foLTwPtfi68cH5dyrK/NCLRDU7PnSpHvuccG+EzzwTiAAOwgTdD351TUgtoyvJOiuZ
 ohHbpEnjtk1v4C3mh6S7+OUY/ixCeylu4v9vTFHZv6WWJ0vVIxN4xryxaMHAMDyqjpVZ
 LUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SiwdSymsTj3ZtXRp/+O99gQ6bsQ4WE3Gz6qmbgXlz1U=;
 b=XUN+AoegRbuKw4A4wVSGqx2Ni2htVqnUJUHSCuXwFrvhY3eXr7vv1uejYVdWho/pNB
 xSDbTS9XV2SjhAVJ1zRIyxyOm4hSr1gcMOOIg1hcigwnHpydtmkTry7cm4v4MWOQuX2P
 MoefO8RDjxU9lWDhGoMQRd7Mh0Z9q+i5CYjtlK/Ttp/R/pN72e7dhtCwztI+9tJsvMws
 7ZjT4KtvZaT/bRO2frvMm8nV+pEvIKCngVud5U498tiQsW4Tww249PUlrgnkY26AznV3
 UnqrIE4YcLuAik/j3Oa6wzal5UysRaXx3Fus9YCF9p4gfqVk+9CnOr1e25onLeIE22ig
 n9Hg==
X-Gm-Message-State: AA+aEWahlhyG2QTankhvy8pQYdejAI6XpCEqFvVvOwwbRh+nVIgjUohS
 dGHSLTZiDhK8CMMHWnKufSgfO8BZ0coDGdlZVhM=
X-Google-Smtp-Source: AFSGD/UtjJVaWJs3alDbTHxaigeC6s8HGas2aX3i30u705WxD/PHRtA4N0hRysMnQkVZuFMa19vjkMJtftCprGzj0ak=
X-Received: by 2002:aca:d056:: with SMTP id h83mr11499531oig.67.1543875366028; 
 Mon, 03 Dec 2018 14:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20181203211816.5129-1-jonathan@marek.ca>
 <20181203211816.5129-4-jonathan@marek.ca>
In-Reply-To: <20181203211816.5129-4-jonathan@marek.ca>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Dec 2018 20:16:07 -0200
Message-ID: <CAOMZO5B18DyZ0zvit6AgaueMifnMf2ctSo7pE_XndRpt7+bnLw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
To: jonathan@marek.ca
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_141618_579829_F57CADFD 
X-CRM114-Status: GOOD (  15.47  )
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
 <devicetree@vger.kernel.org>, freedreno@lists.freedesktop.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Chris Healy <Chris.Healy@zii.aero>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jonathan,

Thanks for working on this. Really nice to see GPU support for mx51/mx53!

On Mon, Dec 3, 2018 at 7:21 PM Jonathan Marek <jonathan@marek.ca> wrote:

Please add a commit log.

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

> ---
>  arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
>  arch/arm/boot/dts/imx53.dtsi | 17 +++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 67d462715..e9a7bbce9 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -628,5 +628,22 @@
>                                 clock-names = "ipg", "ahb";
>                         };
>                 };
> +
> +               gpu: gpu@30000000 {

We put the peripheral nodes in address order, so this one should go
prior to the IPU node.

> +                       compatible = "amd,imageon-200.1", "amd,imageon";

I can't find the dt-bindings for these compatible entries. Have you
documented them?

> +                       reg = <0x30000000 0x20000>;
> +                       reg-names = "kgsl_3d0_reg_memory";
> +                       interrupts = <12>;
> +                       interrupt-names = "kgsl_3d0_irq";
> +                       clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
> +                       clock-names = "core_clk", "mem_iface_clk";
> +
> +                       qcom,gpu-pwrlevels {
> +                               compatible = "qcom,gpu-pwrlevels";
> +                               qcom,gpu-pwrlevel@0 {

You could drop this @0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
