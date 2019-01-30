Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972ACC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:58:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E4B20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hbLu6jGl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMSgM/g5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E4B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g7dFmouO7sNqyOfSLboOAyEc1fKG0XEYqm9UR6lZc90=; b=hbLu6jGlW3K+Lc
	SGASKxPBegbxTK6yMI0TSoyVcl+y29kkhEDPyxzPSHmSm07wt7C6R3o+xTcpc7AuVkxSTm8x7/d+q
	7KI9NSG00inWul99Xi0sPDoCvBPC6EccK3vUh6XTSuEXcRSn/WiuauJFyko0Ozw/A8P6/3prr4EFm
	CIIwJdShoWUkuQS22WY9TB3GbRfXutclH5DGbDv+EiZPfXbzwj0JHZ2SJe/0MpFXbmTa1jU37DwVC
	1bRKAnMHxR4cA2K2x5m8HTn7aMRaxF1bvsiVXg5KaZqWNA0pRvrEXv5khvBBc9kgtasWsu28Ee4TZ
	W8NZsTrt8fR/HwQumI5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonZq-00079f-F3; Wed, 30 Jan 2019 10:58:42 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonZn-00079H-LL
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:58:40 +0000
Received: by mail-oi1-x241.google.com with SMTP id w13so18828385oiw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZnpmrekZy8eX9iUCKudMDj9y6uslCdZc154WXffoPWs=;
 b=IMSgM/g5g8Tce1NQim8T8b509pUiiyy5MqpxfKm4NB6w2rinxrEH4573ZN3keUqggo
 lfwEtsTPTrWHip8WVDJmZL171+2DliSOLsb+V0kKquyOUV6dix5ncxJZ4GcgA4dzngsg
 44FcSOXCCvch+0qE3plvPan2s2O2gAd9zm+cYl0Go6juQsxfFW7g3hDEkKGr1fT1H4tQ
 CzS/buN6LqzHNuVK0GLeb+t5s4gLRnZ0ZDainYc9BNMf200gKU6dDVgmoV27Oq/UabAW
 A+g9Z60vcAkakjRBWIKR9AfThySNjQi9OuvO1YrZInl7ZiJs8k9N8BwaJf+M9HCY16zt
 4krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZnpmrekZy8eX9iUCKudMDj9y6uslCdZc154WXffoPWs=;
 b=Zkqv42UUpIwCZj8PV8CWmcFpmScHtPJj4fw9d1ifnblgpsV+01MgQd0yfAfOY3bzoO
 SulDuCmdwSryHOioO1/Dk536js5ybWIrH+4GOSkxewFTai81MFkuwhTOrqM0mLdcj/FG
 s9b9me9WXr0N4r1f4lCY4ZhBKh2m/Kom4Z7qBeYRM/5cQ85qLhxbYa8G8LEIaPFzcoJ7
 5bGOYcGUHxy5wYOJF6dZCryJ84UiO6EhEzjYL9TuSqPbbOVLk2ciDi7Rcay/AguRI/aS
 NAcIxe4uc/CI9mXdSeI/PCf5rZlWRFTS/v6J1R8yjKwyS0z+AlL3BXpUaCrhu9gFTeJv
 M51g==
X-Gm-Message-State: AJcUukd6LzN7UDh9WrnFYJYFQ12yWCdzC0jTd/p4GTZBlrBJB7hJ60jc
 PNqT/rHvMO61n4ccnc5i2er8JHL5MRh4+ChMhbQ=
X-Google-Smtp-Source: ALg8bN7PV9DPPR2feLbj0XwIkSKQA4GsXhAEqk4KY4i9xmPvI65hNJm3Jy2dvCj082zMvE26pIUjlZYP3GtsYBcttBA=
X-Received: by 2002:aca:3092:: with SMTP id
 w140mr12288488oiw.237.1548845918327; 
 Wed, 30 Jan 2019 02:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20190130091953.20131-1-ccaione@baylibre.com>
In-Reply-To: <20190130091953.20131-1-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 Jan 2019 08:58:32 -0200
Message-ID: <CAOMZO5DnJxgx1k3q4BxXJWV6rD9f3KUVfrK8uJmvD90BfB2NdA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mq: Add QuadSPI controller
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_025839_697435_928751EA 
X-CRM114-Status: GOOD (  14.05  )
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
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Carlo,

On Wed, Jan 30, 2019 at 7:19 AM Carlo Caione <ccaione@baylibre.com> wrote:
>
> Add a node for the Freescale/NXP QuadSPI controller with a proper
> pinctrl set and enable it for the i.MX8MQ EVK board.
> Extend also the AIPS3 memory range to accommodate the QuadSPI-memory
> region.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 27 ++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 16 +++++++++++-

Please split this in two patches: one for the imx8mq.dtsi and other
for the board dts.

> +&spi0 {

I have recently sent a patch adding eCSPI support. Please call this
qspi0 to avoid confusion with the eCSPI name instances.

> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_qspi>;
> +       status = "okay";
> +
> +       flash0: n25q256a@0 {

Node names should be generic and label names specific, so:

n25q256a: flash@0

> +               reg = <0>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "micron,n25q256a", "jedec,spi-nor";
> +               spi-max-frequency = <29000000>;
> +               spi-nor,ddr-quad-read-dummy = <6>;

This property does not exist in mainline.

>
> +                       spi0: spi@30bb0000 {

qspi0: spi@30bb0000 {

> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               compatible = "fsl,imx8mq-qspi", "fsl,imx7d-qspi";

Please send a separate patch documenting fsl,imx8mq-qspi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
