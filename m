Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A330DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:23:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7019B20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bvjmuvtm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jdAsyQ90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7019B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pLjxCWu5joQdFE4f0h6mksZwJoXwkDgdItGuxNLcRO4=; b=BvjmuvtmhPzY/s
	S6n0ga37taiWu0wV5CWGCRS95jbqrpzd+9trUvXWeuNRAnEgaF8sUqnzOqQA+6SBVvVYy2BrPMbJ1
	mYA+tN7C10TpYQLeaV3Do8uIdPt67q59WOa5FaBYZBJBUkTT6lqxW6aAIzR3zo9sBCerDh3fb1yjX
	4zIk0YVjtDHI2kAyMfoQDbWD8F6le1GdX/3KPGlqIW1YMElVNTjlxG7PGAz+pFP03JIZkV2h+Fm9S
	w0aV09Ag9n9ZiP3kupJWpOCnOPkT8mke8cS5U2CKuJbRxXPfvuT+GaJxmL+vgouf8fpLVU0I89+4J
	Da5/K3y3sEZMRrZ1VrBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt6rg-0002vn-3A; Mon, 11 Feb 2019 08:22:56 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt6rc-0002v4-45
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 08:22:54 +0000
Received: by mail-it1-x142.google.com with SMTP id c9so24106474itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 00:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fvY2/yBGMwbngNDLa66cM3Z3OvAxuwsm6ud86Xu01mE=;
 b=jdAsyQ90mli/1X4feqFov2FjxbYBaMp8oZXHDFKZAWdO1k84n+XBqCwxjtSJ8VoJM9
 lFJCACs/k+wKAao0f9jIyuZozeIDbrBMETX3xuOOUCzseOUdxq3r8S3hsyqwQpGUgtNl
 ern03whpopTdNC/7JyKsxVGGZJZy2bZm6hI00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fvY2/yBGMwbngNDLa66cM3Z3OvAxuwsm6ud86Xu01mE=;
 b=qDRL3/qnw8IJ7ADUDi5o33DHesLNzvkww4TPzMFD0Y8pkPyQ45h5sThvvBTXV5kyIK
 D/zQNhcFTgI1HkdngBqzdmbdQ+7nSn/rUcUTM3EeCuW2apaRFucHjHyZBl/dScuKzanH
 sjfsrt+FB2O6bYNaXAY67OJi3GMwNHwbk9wimy+SV+O374PfIEeTy/CZ2/BU1vocxyRO
 eCq8ljRB8oKrstBtQxE97Cp+zG35tyL3KNf7TrLEpWpJoYplz0La9P94D9/igHNvUUed
 KBGBWe9r1ZyV6G9MC4qGvN2lmUIqTMBTCKQILmLFM2wZYENWBvbFtizgqgWXoaMfBY+C
 4r7A==
X-Gm-Message-State: AHQUAuYsZblC+OO0g2HX+zRocIsmZ8CZ0906fQ0JRnZYudKt7GKmyVqm
 JUWG3mOQ2olzF9pCYGqGnsaMi4FsQfQf/heVSEFsxQ==
X-Google-Smtp-Source: AHgI3IaFcZZL/2rH9QTpGunyScGyRTXN776wXOAZSs3378quUqLuNmzuocgC1Zo1SMOQDR5v96EwagPe0Xwc0kqbyPg=
X-Received: by 2002:a6b:b790:: with SMTP id
 h138mr14110911iof.114.1549873370645; 
 Mon, 11 Feb 2019 00:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20190128085847.7217-1-jagan@amarulasolutions.com>
In-Reply-To: <20190128085847.7217-1-jagan@amarulasolutions.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 11 Feb 2019 13:52:39 +0530
Message-ID: <CAMty3ZCdm_RoVxoHy9u2-Xhg4_tf7Mr0Gedcrz-jVhc5ceL0CQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] media/sun6i: Allwinner A64 CSI support
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, 
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_002252_635272_A0E6255D 
X-CRM114-Status: GOOD (  11.31  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Mauro and Maxime,

On Mon, Jan 28, 2019 at 2:29 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Add CSI support for Allwinner A64. Here is previous series[1]
>
> Changes for v8:
> - update proper enable and disable sequnce for clk_mod
> - fix warning for patch "media: sun6i: Add A64 CSI block support"
> - collect Maxime Acked-by
> Changes for v7:
> - Drop quirk change, and add as suggusted by Maxime
> - Use csi instead csi0 in pinctrl function
> Changes for v6:
> - set the mod rate in seett_power instead of probe
> Changes for v5:
> - Add mod_rate quirk for better handling clk_set code
> Changes for v4:
> - update the compatible string order
> - add proper commit message
> - included BPI-M64 patch
> - skipped amarula-a64 patch
> Changes for v3:
> - update dt-bindings for A64
> - set mod clock via csi driver
> - remove assign clocks from dtsi
> - remove i2c-gpio opendrian
> - fix avdd and dovdd supplies
> - remove vcc-csi pin group supply
>
> [1] https://patchwork.kernel.org/cover/10779831/
>
> Jagan Teki (5):
>   dt-bindings: media: sun6i: Add A64 CSI compatible
>   media: sun6i: Add A64 CSI block support
>   arm64: dts: allwinner: a64: Add A64 CSI controller
>   arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1

Any chance to apply this patches? dtsi patch is already been merged
and all been Acked as well.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
