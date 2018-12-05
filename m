Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2F5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:12:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0140520850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UcjGnUd+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwYwfESS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0140520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=86f2hdc/69nQiKqewTSxzm9fjtTcLjJiKAdSwKwyF30=; b=UcjGnUd+pZFcNJ
	HMK2RuI9LECAefmSVPdrWgd9B2CeRiKfFexLYzrEuW2OXINlNp/v8ZkCUU31k1zC33FR1muErbpOb
	VFQx18M9/kWKnvq4jOwdkNr5aI5HoiFqIHB6lDqQJHDUMJhE4oIk9c1atv8pF2mwZpe2t0xCkuApn
	3bVZ6DllQGMHz3HaJW0/o0+E62x6wxgDqZubPeHKbdERG9XbkTGrm+ON3LV8Hub0JDW9CeqlEsbII
	+++fMh+8xVVWC05DNyZNvrrdw9BAF7mFcp2YeiHmRuQ0d+8DpJ61UyRPWu8qVx2TRYUT9hHIcXB1F
	N80rPnJfb2JSvUfD2gMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUgLh-0003uF-16; Wed, 05 Dec 2018 23:12:57 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUgLd-0003sw-LB
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 23:12:55 +0000
Received: by mail-oi1-x242.google.com with SMTP id x202so19077134oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 15:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EkizHcBY6p+rcRAqBQZOi//Lbe0QzeeHQoMKr+sJteE=;
 b=qwYwfESSnjbgrzRSar3FJo+WqSbFWRJD8jktRTWBLtORkCNLdsYCu5h2WzCb+34Fy4
 1/YzvCo7VF6QhIrJTSMHcj4CNmK+hnjoP5rYaqU9JJFriiMqkCVUAQZBvVTBtgAXWHwB
 ufnqVO2QWYji4mP31UlJIczjOZgkO8qCRwnXNG7Cud7M2XZnp8FadFFBzHAibxUimUGG
 jGhIC9pjs2psgDJan1h58p3pFYoHPo+FnCTrrUNIt6qdSysJeYVORGc3FEoDmNf5KHG8
 DibQm2TzbiPmzcXyIqxu7QLS/kX3P3EE7nMOFhiX3B0S9okOv7qjHoxQJyxseG+4UQW7
 a4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EkizHcBY6p+rcRAqBQZOi//Lbe0QzeeHQoMKr+sJteE=;
 b=lME+n35ai8kzIVRxYT6VmB6nyEEQVhPAxU/2fDc3WKfZSXbw3Cnsy44cOQWaZ7Ol54
 8ciTbywLp3vKC/46EwbRIvRFmRKn4KDbQ2X/S9fB8OQvykSohlRO8bYLNoTCjKBJAFOc
 3CiHkNTs8bBueXe/8WlkoRw+Eb+mOrTgI/Ak4P3LQuoyvlqDPBResqOrzK2yFoHCMlcL
 GFDdufb8tAjXKSJDIe06XXT/drOJuKYYnkTjf7DSYzY0pnY3nl3QEwMsZ1rCmqyBWR4z
 kNRTuQOUl6t6a7Jhx0jJk4qJleU/cdIPVmvXu1oRO0s+OnzAw6gKdpUAh2Qegm2wD6kd
 zaew==
X-Gm-Message-State: AA+aEWaK6WNAwWQf42Pt1vWMp+X00/JM/Zn7KojyAwiW2Wsp8ybvSlBQ
 zu5atGHGkGXkVk2hKPOExsj+3hdYXoOEGBZUhi4=
X-Google-Smtp-Source: AFSGD/XNWHNO35u7npYzx2TaJUjo9t7cFy3iAuhvfArtyDL09u7BdAkcKi7Kq89bNh5nWMUMGYSPAxKvBUVofm1y8jU=
X-Received: by 2002:aca:3092:: with SMTP id
 w140mr16652500oiw.237.1544051562355; 
 Wed, 05 Dec 2018 15:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20180921152726.31742-1-lukma@denx.de>
 <20181009105028.17971-1-lukma@denx.de>
In-Reply-To: <20181009105028.17971-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Dec 2018 21:12:46 -0200
Message-ID: <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device (vf610
 based)
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh+dt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_151253_701759_C7BD3DF2 
X-CRM114-Status: GOOD (  12.66  )
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
 linux-kernel <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lukasz/Rob,

On Tue, Oct 9, 2018 at 7:50 AM Lukasz Majewski <lukma@denx.de> wrote:

> +&dspi3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_dspi3>;
> +       bus-num = <3>;
> +       status = "okay";
> +       spi-slave;
> +
> +       slave@0 {
> +               compatible = "lwn,bk4";
> +               spi-max-frequency = <30000000>;
> +               reg = <0>;
> +       };
> +};

This is causing the following dtc warning in linux-next:

  DTC     arch/arm/boot/dts/vf610-bk4.dtb
arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning (spi_bus_bridge):
/soc/aips-bus@40080000/spi@400ad000: incorrect #address-cells for SPI
bus
  also defined at arch/arm/boot/dts/vf610-bk4.dts:106.8-118.3
arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
prerequisite 'spi_bus_bridge'

If spi-slave property is removed the warning is gone.

Looking at drivers/spi/spi-fsl-dspi.c I don't see the "spi-slave"
property being handled there.

Any ideas on how to fix this?

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
