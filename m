Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45431C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:43:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB952148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IN4BpI7S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkRIhi1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB952148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Vb8bNegcWGd1zpEjjvrIygpFI5ennH2bKhqrHbOkTI=; b=IN4BpI7SME5dfX
	4OlSqGGDOcewZTP7iwC+hfA4Iw9AApaQNUiHN8nddAK8e6LO4O5xWDNZ0S8Ki7lvT9b7WHs0+JJXJ
	8zI3VJlihSqPu9UKNFq8au7abGy2Xqm9ZpiKoU8+IoTKb216aLaMNYBEM7fL+O/jtuRRswKBh1exH
	MbuTwTD8YOhQXoewwz/sdWrRl1o91+otQRx0FmPJ1uOnY6cgv8wjx8NK2JRhLL0psvuNuTTHLDz4/
	NtrVCG+kYe0WQr0nUU5PcYhn0azDbPUF10AOS6z90EYhpvSSGuOWEZ5nss+UU93shfRsZIBgCnmDQ
	qqjxDHHiCMY7dNlYrDPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcSC9-0001wQ-8v; Thu, 27 Dec 2018 09:43:13 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcSC4-0001vW-SW
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 09:43:11 +0000
Received: by mail-lj1-x244.google.com with SMTP id c19-v6so15794852lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 01:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TrXN9IlYj7H8BAW7Y6qeebMlCuULu58GprRtiAQCAuk=;
 b=GkRIhi1cyPYoktZaB5P/efqyG4MWuRp0g+85QesmBk7dGmMc/8YQtJGOyRZk0Oca+9
 K6maatuA+0/L3iR2/Ma3H8DOeOhzA4I067gWoFPMzfuGxE8VjmqnlB5vwqr6nks4K4TI
 ddS+pTzUbjohx12CxIPPgOee633HL8unS2UEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TrXN9IlYj7H8BAW7Y6qeebMlCuULu58GprRtiAQCAuk=;
 b=LGsl8xblqWw10WKEOK8iI3fkDclioXrVDY/cORi6AqjcktFF4097lIOE9PqvuqJXav
 WgDPuJ/T/Sgn1PafPW+xsjE/qzEeAk4Q1pBIKcWW8eXDhICqVwWyNbX0cHIQVPonkm3p
 DRTImw41vg2ZVG5npWC6h8L+W5xKMb1XStGHou9jRoQkdcvvOhyZnjjfK4zLcbT6l2X9
 S7MpwHOb29aaXobvuInSD9DvSLoQIlWImr6dC3AhJArBmKSsrf1/cFqSB9MfumsQVQsm
 9VcPLgR1cdkX7vxVjREF4Wi3+FgHXNzRBzknbYQe32SvqbaC0S71uwubsUyvGbXEeqyx
 xwBA==
X-Gm-Message-State: AJcUukfR1EUiCbWvGy7MMbm55KHUZ7fHHfqLx4j3IHjZgcUeQ2GuZmik
 QoK4YwIyqmT1UocRM4g5lqwqR5QGGobWaPlm47lfTA==
X-Google-Smtp-Source: ALg8bN6ySI15AzHlXaKbakPmKZWpViG0h/3hFOgB9t45dEutrl1ey3I7jqvZmJHkmdkttKEUdiNOj20qLPhfhu+I4R4=
X-Received: by 2002:a2e:29d7:: with SMTP id
 p84-v6mr13142358ljp.12.1545903776019; 
 Thu, 27 Dec 2018 01:42:56 -0800 (PST)
MIME-Version: 1.0
References: <1545146239-30993-1-git-send-email-aisheng.dong@nxp.com>
 <1545146239-30993-2-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545146239-30993-2-git-send-email-aisheng.dong@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Dec 2018 10:42:44 +0100
Message-ID: <CACRpkdZU7toMYYP3UGRorCW6WhqukeWXCZMpe=_f9EWcWsRw6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl-scu: add imx8qm pinctrl support
To: Aisheng Dong <aisheng.dong@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_014308_923254_69CB9282 
X-CRM114-Status: GOOD (  10.13  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 4:22 PM Aisheng Dong <aisheng.dong@nxp.com> wrote:

> Update binding doc to support imx8qm pinctrl.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
