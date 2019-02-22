Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2F8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:09:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35AFA206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kCobURib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AFA206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v1m0KHOx+9Zr5CsBHhRFaLyL1yplXAyfqYpnijZEC9g=; b=kCobURibq7M0j6
	pUsmg+E+fJeiZXnEN852xyYi6x40N3+mMOvgeB5Io/VT0z598HM2i2iNo8NICY9+Kc76hm0Q6nqNQ
	wUyF/lrAuINE8K3iFCR3KKHkIUYd8hz+hkwqNXbE7H8lOtaAVNYevRnPd4X2VGg9J5HsEE1f6unDT
	TnI8W2cwyOIXTu7UM0j9L9pG92W9gyX7UWAKuGcS5258glUSrK95u5Z/MCWhb1MLyl1acSKcHJZEC
	faXlQoCSb17GdwI7Q7gDO4YwLYtpGQBm3O2jGdlJz7WE6RrChmRVUF5jd4sql5v08sKEEMXgIBOu0
	GzlR6FPtLzyfdMg51u7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxI46-0005jX-Po; Fri, 22 Feb 2019 21:09:02 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxI44-0005j8-0S
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 21:09:01 +0000
Received: by mail-qt1-f193.google.com with SMTP id s1so4153899qte.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 13:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OF2nz6JFzMpbG9u4cw0eJbSFtA7QAYx8oTPH49BlqJU=;
 b=rBCEiyuTs2Sb8aL5/C3+Nwwr43BtjZsntUL8koyumfDPzGZcP0QDWKTHbjky24TqRJ
 bqG61qFtYP9W/+ZP50QQ2U3cMQ8Or6nIbq+tZsiNaB615LZVTRT6vYm0k3BF+gecqTGT
 4Hs5SULw5XVbALB7plac1phKw5kLvbGCSguO1i3qnGNAoZ43iJxNLei5jjbuqKIzqsiR
 uXwH6ijUloeyWlBiLLM/gLLAFp2wRuv8A95c/caF+s80INcJTBF8TsiHzeD8rKFKn1Ba
 pfvgS+nqWQVHaliKhOcBQmQ5dy0uWcqdGnW5+x2AonJoIVQumHH90E95fDHS3FRQ3GJG
 6OZg==
X-Gm-Message-State: AHQUAuajmXihz/YUH3TebZkljNrQFrnHX8n3dNnPJfSUKbMAcptEummM
 4HAhhnjuA5G5MzCNaJyMLZu7ME0Kcni7APYrsGo=
X-Google-Smtp-Source: AHgI3Iap9c9pTGBibR82WMR77Hx0sWJzEo7ZvyKko4dh5OdsgYJvP2c4TltCGojzSpkuMgU+0+2Gs35LWcaaAkM/mt8=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr4704623qtb.343.1550869738537; 
 Fri, 22 Feb 2019 13:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20190222150931.12317-1-linus.walleij@linaro.org>
In-Reply-To: <20190222150931.12317-1-linus.walleij@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 22:08:41 +0100
Message-ID: <CAK8P3a21qN6L+jt9edG9HZkYYzEk6K1NbOvLf9XTcreZU_v5Rg@mail.gmail.com>
Subject: Re: [PATCH] ARM: defconfig: integrator: Switch to DRM
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_130900_053269_F7ED7BB9 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 4:09 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This switches the ARM Integrator to use the new PL11x DRM
> driver. We need CMA enabled to get coherent allocations
> at all times. The dumb VGA DAC bridge is needed for
> the VGA output on the reference designs, and backlight
> is needed when using an external display.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please queue this for v5.1 so that
> we can delete the old driver for v5.2.

Applied to arm/defconfigs, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
