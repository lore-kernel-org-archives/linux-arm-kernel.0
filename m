Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:20:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89C5214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CEkheXiX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T53Yq8pX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89C5214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3zVCUJd+3rmZvEiToLdePeoM32Gf9BTWvFYierAEG0A=; b=CEkheXiX2JeW41
	L1gpxYGOc88l0E8YECLpPICYSnCVFQhEJtXsO+wosyxahrHJbN0mtN+veCdEwFRfdi81Sg9YK6hA+
	9bWQvpRwdA7hv3WWQeSxcHYbHXtrhDUWyq69d56Y/f0hSzpeVWzDp4fnDJOv9fWgtHJ1Il1dw0dOF
	EK5Ev9mYozuWyUnwks/Q2Et+KqX6rzN2QnCb7ZcdrLKQpAm/vcVShqe6mnLt4EEBJPlan97Xgkj4k
	4kWhQcmyNtbJ9jWBGgX2J5UwAnAkIEf7qz40vBMVgCFDluthyFYpa6mpoklOqlOKZihdbWeCg6+oz
	piLul8R0wBiVwddznpXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghc8a-0005EL-IT; Thu, 10 Jan 2019 15:20:52 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghc8X-0005E3-KV
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 15:20:50 +0000
Received: by mail-lj1-x242.google.com with SMTP id t18-v6so10049061ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 07:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wuv+ErdZeIPOmUMsRDVMGvhZI48dR8gLNMeJlEMPlUE=;
 b=T53Yq8pX5muDD8Ul/8zMODkCDCB0eHnH7hkmagCBomBnIVRuUcGj1CAocgK/0970br
 s4Exx/+FTtmP3UV3g3MkhaFYjsMt4xr0RvIefaGtDuKv8RJNvQ+ZuJ+9eMnvmHxj3/zp
 hv3zQJ25XanzIu48Iz6ZyCJUUhdndxUcTqyWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wuv+ErdZeIPOmUMsRDVMGvhZI48dR8gLNMeJlEMPlUE=;
 b=LQ3BDdxIsJ42iRhXF9LXZvqFA/JWGxGwS2qdbo6q9QyiJTzLFiANsWybdzMcIDUpeC
 x2ReIdXdUcB1OZV1gB65/LKL0RON5soMmz+FNtgsRkNtywmzONI9EpSEXkUEhMty9eRF
 38tvkW/mEIxBVU8oARzC6oth3PyY2H0F1vKIgKkM2gSuG4gVpgHISiMh8q68lE/CyQ7f
 ga1Ljnz4Hx6BKqSTJKyDZx9rbKO+UVQzIg91UOXV6pjGnRRcQF20Dyj2VYD8CxzIVFxg
 Ql4LOQQhVTdey4S8YKjsgSbtVVl6QVkNS6b+wQiYSDn5w0FhP/C543//rRANSC+4bME5
 hGvg==
X-Gm-Message-State: AJcUukd8N068M0NmPL7HESbD61EisH5TUysHSZo/Da/qrtNVuuU+0Fvc
 6O8LTpvlQm9Rh7rXuyBowplZSUh7siwhDcUbeF5s5w==
X-Google-Smtp-Source: ALg8bN7gkhYVUz5T/kLz9HGBPgGRlWesnuS3xp3z13omcSKb777TZ+mtBdW1x+aVD9o4v0yaZin6uBaea6aOJBwf/r0=
X-Received: by 2002:a2e:29d7:: with SMTP id
 p84-v6mr6204789ljp.12.1547133647748; 
 Thu, 10 Jan 2019 07:20:47 -0800 (PST)
MIME-Version: 1.0
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
In-Reply-To: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Jan 2019 16:20:35 +0100
Message-ID: <CACRpkdY3Uphb13rAcnWvnd=cirHYeqkWk3sb3yWSNL=jzA1cHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mvebu: implement get_direction
To: Baruch Siach <baruch@tkos.co.il>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_072049_679045_D62AB9F9 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-pwm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thierry Reding <thierry.reding@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 1:27 PM Baruch Siach <baruch@tkos.co.il> wrote:

> struct gpio_chip documentation recommends to always implement this
> callback function.
>
> A more concrete motivation is to be able (in combination with
> GPIOD_ASIS) to detect whether the bootloader has changed the state of a
> GPIO signal.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

This is strongly recommended for all drivers to implment so patch
applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
