Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FF6C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:03:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF39F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QGblEWTx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNgoTWCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF39F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qyXxpfki1AWhjv08gExndZ5H3qgq3/TqtgG8d/NOibg=; b=QGblEWTx5gOECx
	kS+ZB4PkFuVCSFI9ue4+VoyL52amWDp5Nz+aSNY3FnJg/8GThi6JR2USpYrttIy7s5GDJpyQoclbc
	sfJjpzf91pxI6OZB4w6kIkfg6ESRX7cIO+CV+hpieH3QYBExdbq5zg270RO3QXbaW0PmJ0b6XqSuB
	zCsI+sw5PfTqiHh3IVNhTv1YIl0N9adzdAL5oZf8pxl9orRIFvBFABlwlEkfflnpf4wupFUUZSSnK
	GHgsR54HzslUT2xCY+uUeKEf/LTtc4Jkon2M7HOBsQW6kN0eEWKlA1vTRuGPnpAAU4yq0rScQnnsg
	k8h+XkZamkJ6+9ZIez0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmwt-0000SO-Lx; Mon, 03 Dec 2018 12:03:39 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmwq-0000RL-OU
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:03:38 +0000
Received: by mail-ot1-x344.google.com with SMTP id k98so11329574otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WJJ7kyEb2x520IJKCmGS8rH+PEUleJgcDK2KlveNzQU=;
 b=cNgoTWCLTyYHuvnlGKn46wsoxDy0YoLbzbo8wHqj9+rk7v0kDCT8lk5O7RBlcri1Kl
 WL7kWXAn5dkY5qoFB0/oW2vcDRxdVERc3dXyOjuaSkPrJ98EwfVGpvEezfGcF+lDyvcY
 BSKrcMxydy9EV0+n9rGoJMDoo7mM122vE1aPk2kKfDXhyWY+0n8r/Or1LrN9m4pQ5bIH
 Tjfb5xNy1j53ZFMChlKAnSgKxNg7SipRKWwbaOHZV3LeZn2rSxeqU6dRNpuXD4VE/K+G
 WuOlnccOINCq889iLuvdRQc4Uqh4UJwViYQbuQCZ7KM2eza/M1pfV9bqo4xNvqzaHGTx
 +S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WJJ7kyEb2x520IJKCmGS8rH+PEUleJgcDK2KlveNzQU=;
 b=r/jrOAVROqSHYX4X9RXs6OkSkcLWy0jU4UqByT2zI9np3OjD1T4ZSvyUzq5cPst861
 OBMyGSbZDNCIDxlwuovSh52LCCfmVm+VbzaK9TNfYwRLpT0h1KKEFiyTg2SIO9TFQTtp
 JCUhYecdKqG3zUYDywHw0hh4zF8bAoAPF0WpT2fvVJbbVEQMuEJgXywfp5PUub4gzyki
 QgbcqHN16LfRTGMeh2uaVEsj4oZJHUHNuUfJx1CITUiEkw+XwnNwm79VYS4a1wiR5ftM
 LZRvKqogjImkFuT+Zy650r5yMOw/q0AuPIB3HL91B9rU1yrFKRErd/hOc2BVrH3BrJji
 skSA==
X-Gm-Message-State: AA+aEWYcJqo1my0uGKVgG8+PCK75N6asfgrnK9ZwPar3X8qgG5lM8Oxd
 8fVx/VdvIhelnl20xEDdQ9WjpJecVCOVt/hvZBs=
X-Google-Smtp-Source: AFSGD/V6QHU82I81dyrP3+vbJRLwiObWmnUwAVhaPmbDlZza2VFglekSqlDA9M1S8Gvdcpf1Qdy1mmgcv7vbAw7ujd4=
X-Received: by 2002:a9d:84e:: with SMTP id 72mr10382004oty.203.1543838605612; 
 Mon, 03 Dec 2018 04:03:25 -0800 (PST)
MIME-Version: 1.0
References: <1543804767-17650-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Bc2z9mtWN5HDDbLggryEaxF6eay2Wnu8AdBSBNFZSmXw@mail.gmail.com>
In-Reply-To: <CAOMZO5Bc2z9mtWN5HDDbLggryEaxF6eay2Wnu8AdBSBNFZSmXw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Dec 2018 10:03:26 -0200
Message-ID: <CAOMZO5CvjtVfQGT2+0k5eGT2=r_7=qDVe7KvFMcPvUythX8m5Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: update the cpu power up timing setting
To: Yongcai Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_040336_797937_D502D28D 
X-CRM114-Status: GOOD (  14.56  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 9:42 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Mon, Dec 3, 2018 at 12:45 AM Anson Huang <anson.huang@nxp.com> wrote:
> >
> > The sw2iso count should cover ARM LDO ramp-up time,
> > the MAX ARM LDO ramp-up time may be up to more than
> > 100us on some boards, this patch sets sw2iso to 0xf
> > (~384us) which is the reset value, and it is much
> > more safe to cover different boards, since we have
> > observed that some customer boards failed with current
> > setting of 0x2.
> >
> > Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for i.mx6sx")
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Minor nit that maybe Shawn can fix while applying it: Subject should
contain imx6sx as this change only affect this SoC.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
