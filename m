Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1EFC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D3D218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HxOkf9ZP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuwyJIPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D3D218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o143FBhvelpHXzwmk93EqwZvOqKqL024Db9uwxmxCYw=; b=HxOkf9ZPpOquKB
	P3nMb9P0YRElo3YsxUOlSQdkly1KtUaLIF5NXcWwdBGSP+Cc0TU1EMKAsgXbNZtMUancwfcTvoYPs
	oGuBeMlWyRHwcqqbq+rB4D6/1OZHQmQF+q/MLW6X1P0BErzodCm6pmsw5dz0+sUg2FoPo13IyCv0j
	SyhxKiBD86JSyMaXwHMUZm6oQh/W8bYu5pss/cl0ze1DB6/nPnZ60/AGVTd2w3mivBwRsm8PienX6
	WvflzKVlExbFHtub1a5QtGHndF5HycpL9mcErwuTfcYqvsMBcFFAtW1KI1tkZ7jBDa+GOVpk4Q0a2
	VzFH8di4cVOJrjG8E7PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn0XP-0007Sm-3t; Fri, 25 Jan 2019 12:24:47 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0XD-0007IT-2S
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:24:36 +0000
Received: by mail-ot1-x342.google.com with SMTP id g16so4326257otg.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 04:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HXwo8sIHaAOB1X0Q6WmrUJXEzNjji81TmxrAtTZnLX8=;
 b=iuwyJIPO2HFVlM2EQu8h4/MG/ey18khuqM3cgOZNY7RI/FJ7ZDKkj3ga4hF0lPdlu0
 0Ava4JNHaUCA50qkDJvywVsvIMiBF+T/LCx3DIRHgCCmHqFEdTBmiYqPvVyvhoxCapjU
 /McC/Nu1P0kVBAhS0t3oR8E9mfEdeAfiLQb6JuwmLLsA9eP66yETzl6ra+V3dcigAxfX
 iPtdUMqBn4zaDrEZLqTgP7rDXZQXl7Kw/wcJEJyK0MvCTortKnTAR3CqkaKVkzTHRS/p
 YENTnqAqubQ4238VtSxkbvBw7mPoUrKu31LLsO7mOlq1Zu8K533Mkr3gepS7h6XqlbUy
 n8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HXwo8sIHaAOB1X0Q6WmrUJXEzNjji81TmxrAtTZnLX8=;
 b=UEoUPj/gVY878ogKw/IS1Cxeu8NXaG9FxvkExmOq9kfjhaMIwOgqObixsuNbYvs35w
 rs8QbmkVFB1+xZsMv/pk/8Lkow5GUVQd2oFlXRJxUTI2h7ur98v9vqxhSeNKux+1qbJH
 /LtPSf4LJv1ZNE8vdwHnOoSpKNA6Vqx4pNVC30ZxL3b409PRmXZCVPk+4W3fpbSDuwt6
 WBJIDoWIXq3dd7x6FhLwTAGPM+FY69p38RCEbcO+zg1u/n2HvCb2Qw6b+CQQiAwTokUG
 czib+7xS0ZD5FsO4NnnBjQoV55DfhJoKMUMiMnaLDmt1e0y77ltKB6iQiKWeATCmMq8K
 o2Lg==
X-Gm-Message-State: AJcUukcsQQUIvRYJmr9uqoA6eIsp6zDoosbK7xh0yxPGw/SS2YkqZgXp
 /qaqEPWCAM+MYCmj8agsu/MAwMmqJbUW6IiEfFs=
X-Google-Smtp-Source: ALg8bN6kRB5YihtHrLb89/HPaoqo5pimwtzSe+JfxhAP0ofyuXArHstBPKq6eJ1LczUGA21rqy7o9FUsNd8vjgls2xg=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr8201782otp.225.1548419073452; 
 Fri, 25 Jan 2019 04:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20190125121257.7151-1-ccaione@baylibre.com>
In-Reply-To: <20190125121257.7151-1-ccaione@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Jan 2019 10:24:31 -0200
Message-ID: <CAOMZO5DKzOsVXp9TcDC3AGzrtTSNiDG7cUkkdPRvbu4VGHV9nw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: add missing MDIO / PHY nodes
To: Carlo Caione <ccaione@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_042435_132485_15AA6382 
X-CRM114-Status: GOOD (  13.37  )
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
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, abailon@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Carlo,

On Fri, Jan 25, 2019 at 10:13 AM Carlo Caione <ccaione@baylibre.com> wrote:
>
> Populate the fec1 node with the missing MDIO and PHY entries.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 64acccc4bfcb..02f6da92957f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -37,7 +37,19 @@
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_fec1>;
>         phy-mode = "rgmii-id";
> +       phy-handle = <&ethphy0>;
> +       fsl,magic-packet;

This looks like an unrelated change.

Otherwise it looks fine.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
