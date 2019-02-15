Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0105C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE14921924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hi1TykOA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZ8K3LSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE14921924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=auvcVhO7nnlfYc2v7URaak8CbtqWyf9kJ+TYwV5KstY=; b=Hi1TykOAExsPeh
	PAEPQbAlTxmDHQzwaTYwYIkGKZu2H71jBGjsOj2XduS+0k1ye8H/q5sx0E/fy6dmcjPWUs3983zki
	UYeVA72LnJymOlWlMIKdPqCe9BbGfVrgDz8vv8w04Dm2zW+k+xWfYHhgzCAunB7GkFOw75jnvA6GF
	KW6Ck68++sloEMPTV+zzOLaPXF1fxhpaNWOb9GUbpCJze+Z3chA6Vj0NdrNAkavuBdhv36PkX7Vho
	egzkPpyjYX5HtsqOF7NXouAfku8rf0RaOh3b3gx9otf9jP5O0qfaJU1n1DCd2LSzOVtNc4AjhVBTk
	R6kzOSGlSy2R91P4HV1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufWQ-0004NX-B7; Fri, 15 Feb 2019 15:35:26 +0000
Received: from mail-it1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufWJ-0004Ih-Fa
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:35:21 +0000
Received: by mail-it1-x12a.google.com with SMTP id l66so14152521itg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9OMXfTecjnMTcRmrRQJcFu8mpWNxQK6DFzlJ2wdDnqc=;
 b=vZ8K3LSUUzkuGEiplfz8mEDElieQwcpFMi49Rokq5+o1xTGtVrYJfpO34miWQ+Qk9n
 9R9K+D9zvd359dlW3pU1wth2U41b2FuMA9rt5MGSc+t85JeJJdwGWBWB0I29AvxCUxCj
 xNbWadE86WSfTBTAp10Y47pevWDO6izDlZrQYOkwJGeyvlb0GdvLfoXhdi9/9xA5VSov
 gZrS+Ix+D6ey9s8CN39zZKWt78jvYXqGeVqfgRZhauK7bnbTM+qVcuLK00KqcHVGtpIz
 M6HjjzC2JxrYdQqWZfIYQt9Wp92fydk96neK4aGoH6xOjHp0ZSq0UdutuDGgl283vw65
 KZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9OMXfTecjnMTcRmrRQJcFu8mpWNxQK6DFzlJ2wdDnqc=;
 b=udx6C7aPYH8VJ/yf3CbQ/Mi33cMA7mij10N5Z7vNtKdZadOSENsWqGqFnLe3lor/AV
 SB6bPHWDhX3ytLxLGWf88GE3skWmnwdGf5y8u3vpvVKEzX7/bO8hwKEJePJIOE4eDhEN
 kn6cCM15lwxc5qBzkOQl5XKgMW/IhmYyb7IDt7r99frQIiQ+eN3fJwvXxEVCucJs8Lxx
 H6Jo2Pfn4/CTTSg5TVXnGWKYt/vzt+i0vIzTCNDXrxN3AxfmWMEu5YO/OPkwEOw6WZ0N
 B1QyoqV4xrKgvWg09uT9mRYYNarwLSg02cpgqvbH+krc2zEFM7+nso1yLfTuGVHWTvQA
 NYdA==
X-Gm-Message-State: AHQUAubVXIohoP+qiAhNfGiBF+B4ZUmmtTMihdqynGgqKL4yMRq5tSSh
 XpAMWmydv3as14Dw0RP03FV3BcOjtChtIo/i4l8=
X-Google-Smtp-Source: AHgI3IbCcHTsrN5N2AoyPWm6fAz1oBG0ELVAG7pJm7PvQPQYYfgCHwcLvVrJNRbum/pa1O29+ct3/0dZrDbE/Jv1Fus=
X-Received: by 2002:a6b:c545:: with SMTP id v66mr5826554iof.40.1550244918198; 
 Fri, 15 Feb 2019 07:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
 <20190215151357.noovkx3r6ia4boag@flea>
In-Reply-To: <20190215151357.noovkx3r6ia4boag@flea>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Fri, 15 Feb 2019 23:35:20 +0800
Message-ID: <CAEExFWs2VuOpZu=Mw221Gp3RDbw=Q24eh8Y=pWdfh-c+mPvwuw@mail.gmail.com>
Subject: Re: [PATVH v2 0/4] arm64: dts: allwinner: h6: Enable CPU
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_073519_544304_3FADDDF4 
X-CRM114-Status: GOOD (  13.04  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 11:13 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Fri, Feb 15, 2019 at 08:49:33AM -0500, Yangtao Li wrote:
> > Add the cpufreq support of h6, source of information is as follows.
> >
> > h6 cpu opp info:
> > https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi
> >
> > axp805 spec:
> > http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf
>
> Was that tested on the two H6 boards this time?
I tested two boards for about two hours.
>
> Adding a changelog between version is nice as well so that we can see
> what you changed.
Yes, sorry, I forgot.

Yours,
Yangtao
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
