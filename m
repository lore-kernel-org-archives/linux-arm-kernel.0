Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3809EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:05:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFCB2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tMM7uuoP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOdxANA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFCB2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fRN4vGEkWIvxTuz4QGBUXmRa7kxk+lCHzbiNA+SeRJo=; b=tMM7uuoPWoIG38
	LkxzgdChDZPaY3+eki8gq4ApJasMOfBda+9lm5EhQnIxKo6Sk2oJOZ5RqQHDQBfFiLWgMFHRPv+aB
	ExvriRkhzdf4EWrarFbv+p3kkELYqeppAdfkBt5isr7HlCAgQ8BStgo7zVlIVuQS2iS3vA+Bi/odG
	cwxTxKkNcc7YjhsFoN/oQbAOf/dcZUAKb2mLjQNupKqa7kCwUlqkBMTSzXqNVf0EAD21s8a5E/RBS
	dbU0KplDGTbhkL2NDtWYm2bTBv/DeknFj6zqy1y2mzr+ifAGK8Ta5QsCPEL6NWFb8bWoJKPZGIzlc
	/pNovKNI9t11Raw4m2aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUacO-0004ne-Tc; Wed, 05 Dec 2018 17:05:48 +0000
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUacL-0004my-IN
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:05:46 +0000
Received: by mail-ot1-x333.google.com with SMTP id 81so19321154otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NG+79QKl12XfRiwyuSo8WMhGskMC/I9naYFfmYEUZzo=;
 b=DOdxANA//I3QOxYf6RbgvtMqUVuSz/jKkUfeAVXbVuQmSsVqH8h4nLht21kn6dfqmt
 wrUDC/7fNXNHngeY1oOtkGGHDPxos+NEg1wGuVimiLEqaXVGbWMNqt5iX/iL8jOz94ag
 Yyd40qBv+kErwNwHO11Kfcq068fBIG6GVugyt1geBxScaFanXKOvpCwn8hk6yBkZnNGL
 usSUg7Rvvqse4WthzjJmzQ5nOQC2O/nxuCSqWrOk+px7JRUySV1TF6hDYIsqPzPK1+yX
 8gnnh1xer9PBH9SJc95xiemCGg1++4E+U8Rx/ivuvcmZJvliPRHxSW3JupBA/fv9hyW7
 UVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NG+79QKl12XfRiwyuSo8WMhGskMC/I9naYFfmYEUZzo=;
 b=uMRi789CT6/LDeTk0hU0rrclZyTrqmOCXi0GSjFW8TJzdP2cW0oweq7SsRHWWNtu3y
 EHaqsx+eA2Uxrv2FsWJjT6COe0oiDNztewH5chtO+k4wZxOpkuAz/mOZ81Ttwy46+ull
 gsnwQZnYVyLgu/fWfyRMXSRkfrs/zhaQw4datfCOgQGgZN/yC9A/oYXiFPT1PjpWsz+6
 0RtU1xuHBTzetcfDRa/onjSc3my13eIUcWQAUph0Wxh5zLSF9BS9dCg2Qrckc4cn8uVQ
 ZBowPAX0RH3wtwRXPiCy/7FoS7fcw4dbge6hHtfGIc/tnM6uGGXe110cDe2XpAefpE8J
 L0aA==
X-Gm-Message-State: AA+aEWYGa4QsM8m0sfzFGsNeyICVYfVdNMe2mGGnzFmR3UdZdMS8y5w6
 HtM1Bp+rQAaSoOSEgI+OT49EJhd6B6P5SN3asmI=
X-Google-Smtp-Source: AFSGD/XECn99riVsTPyNKTAmgmePIgf1J8F2zNICvJqwfOLHzpnI1NJQVL/7xLMyZ80pd04EClnl+fopBzFmdoi9z18=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr17244806otp.225.1544029534272; 
 Wed, 05 Dec 2018 09:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20181205164704.21649-1-marcofrk@gmail.com>
In-Reply-To: <20181205164704.21649-1-marcofrk@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Dec 2018 15:05:38 -0200
Message-ID: <CAOMZO5DWoKRiqwcSvDW0nunV1nMTVijHeuuHzpQWdMXDQNJwgQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Fix memory node duplication
To: Marco Antonio Franchi <marcofrk@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_090545_605406_F4FFFF26 
X-CRM114-Status: GOOD (  11.23  )
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
Cc: Rob Herring <robh@kernel.org>, Marco Franchi <marco.franchi@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marco,

Thanks for your help on this!

It looks good to me. Just a minor nit:

On Wed, Dec 5, 2018 at 2:47 PM <marcofrk@gmail.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 6d827b69ead0..84afc555606f 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -16,7 +16,6 @@
>          * Also for U-Boot there must be a pre-existing /memory node.

Please remove this comment line.

I also fixed the two occurrences that your script captured where we
have incorrect or missing memory nodes.

I have just sent them to you. Please include them on your v2.

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
