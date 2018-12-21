Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D71C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:57:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B6921908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oo2D74z6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWPzdsjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B6921908
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E8z3/IY985CLwX84Puq/1h22lblQofG/LZlM4GBguM0=; b=oo2D74z6j/Pxa+
	2LJ7OttL+hbq55V1zLMVFGEC3G1gw3jvGvQ+e7UER1HbZJAeFOB+hJ56dJfTRjJ50V9OobmdONV5g
	NYuy/Zc4l6/dNJP4Guhb9Dxn6GFSfC0dJiWC9HlUs3PNVK5kWd6W/pmkMrIy3vkSqonK2BmEVXpc4
	Yj5djW2phjaWVNZo15z8+vd1OhmjbYzRv778WpARJlEMg0gIAzjol0YYMxlOxx8DmrFd+OoPCuC3j
	HAZ4p0C/P8YH5oEvnGFACzx5iz5h1kpKzP3teBlvOde00vOmwmHxrG4T/tbMNiIoYoT4ZVlNfOX1d
	Z8spi497/qCqaEiCncDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaHYg-0005Re-Lt; Fri, 21 Dec 2018 09:57:30 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaHYd-0005Qs-J6
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 09:57:28 +0000
Received: by mail-lj1-x244.google.com with SMTP id u89-v6so4196779lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 01:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i7YKGAkjxUIo6TZyT8S5jO0gVM/z67R7qDqWLXKFnOM=;
 b=fWPzdsjz/d2mgU4kuLHefDE53G7AfoUyzM5X+ZX2hzCzDVzKtEffKJI4rCHcCO0R0n
 UdadU6wtqP5VWw/hPnLTWzJg/BIG5Q6IFEbmii9XBaxzaYYN46C0lzVSPYdwtTmR7WKF
 He4P136CL8WTKoj+K3/Z4FEe6oYgpqZL1FWII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i7YKGAkjxUIo6TZyT8S5jO0gVM/z67R7qDqWLXKFnOM=;
 b=S/iyy4HxXCZ3Vv09nMMHVj9xN3Ut5OK+ZtQKhUOBmua3XESJSgCUr59srzD0Gozw3b
 2l4FbcXznkR4khYzFJ2j01bPrczZhweqixaAwKztNbIGHbwuSstaBn0SO1etDrP95TIC
 dxJsHUXSkYq7qYlyNuRh1eIag7GaS5+Eb9sImQHfnnOAFzGDdmL1SBpqWCI+c0sW3qkl
 oIGKCLGxwKNpo+rk0gJU0NJsdljn2FoAouyNnoSJUwxd0j6SNn9k90aqcgSCR/A83rpk
 +LUXanKQmhz3AqautCl9aO6YMXO4TtIBhtg8LhFYg9/O3QI9g0LjZVHd4EZCF55sA3Cr
 rTFA==
X-Gm-Message-State: AJcUukdK4ExEfwakRkAfu1WvvAA63QVAalRp58GlmPYDmj+2KNr3a+bl
 +5nwY/j30nciqv+oMDtDgZKn/THpl8/gxhRHoOT5Ag==
X-Google-Smtp-Source: ALg8bN6qFxjhl1txPozLGekSIBi4HLDvdAl89Hoi49dt0XAW3v0tSxgBaxLpCSNI6/wYOKJbc29FhIE3f88TY4l28n0=
X-Received: by 2002:a2e:710a:: with SMTP id
 m10-v6mr1157048ljc.66.1545386235773; 
 Fri, 21 Dec 2018 01:57:15 -0800 (PST)
MIME-Version: 1.0
References: <1544615784-29331-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544615784-29331-3-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544615784-29331-3-git-send-email-andrei.stefanescu@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 10:57:03 +0100
Message-ID: <CACRpkdaeyHOhGDR4HAJR6sSVFA-fGXNwY63rzicER-GFoBQtPA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: add driver for SAMA5D2 PIOBU pins
To: Andrei.Stefanescu@microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_015727_628725_612795C3 
X-CRM114-Status: GOOD (  11.91  )
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
 <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Ludovic Desroches <Ludovic.Desroches@microchip.com>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Cristian.Birsan@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 12:57 PM <Andrei.Stefanescu@microchip.com> wrote:

> PIOBU pins do not lose their voltage during Backup/Self-refresh.
> This patch adds a simple GPIO controller for them and a
> maintainer for the driver.
>
> This driver adds support for using the pins as GPIO
> offering the possibility to read/set the voltage.
>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>

Patch applied for v4.21, sorry for taking so long to reply!

Good work on this driver Andrei, it looks really nice now.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
