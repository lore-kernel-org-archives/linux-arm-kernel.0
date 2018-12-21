Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5816C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:15:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67BC218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NQ0x31rv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5I2IPL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67BC218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6sQ9JRpTXP1lGYEGWq08XWEdyaRGrxLf0H0eenIWdkc=; b=NQ0x31rv9yBfaE
	IADARxv4d1Q+PcPAE7WubVSIj0sUelCrvn11d1qtgWJjzfCP2vMo/2yksCF7dKEAxA8IEobTjPOTz
	5adiPaKRLweSXCBN/hyyuL+Km0wneei/FfTHMdfHW3TgyywfjCM2Ink/L+WkONOACiE6MO4Ye7tbf
	BsX75fHfxyTKqWmUQdnR7Mjy19BxI4LulzONUYSB9AeJ2FLCOmnnyZ/NFtvmcOp8wnCMEwLEUpYbX
	yYgX86BTEdGTLo2Djiz570XbfGTBusE5X45EJ6fabWEqluqusFQ7wpnBwzMY77IP5R23hvu5zdfAk
	OG0V1Sv6pHtwmc1InzRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaHpr-0004wx-Sy; Fri, 21 Dec 2018 10:15:15 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaHpo-0003fH-Uu
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:15:14 +0000
Received: by mail-lj1-x244.google.com with SMTP id g11-v6so4237856ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DGstlgzAhYekvSI+PJ9By92VAGAoLLwYkDeZkhyu6X0=;
 b=c5I2IPL2v2/au8jFT5du0k+RJP1kCtptQ6y4dH+1/Bit8xmzEJc4/12YMmnPUnpUh2
 ojVRNIlnxl/nKp7jqAplsaizrmh3z38cOghW302OAWFagOg4SG8pZ9J5t5RpWCJlYRsc
 8wDphWPt32yfcmnPlelX7NX9Mw+fGekaPCElM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DGstlgzAhYekvSI+PJ9By92VAGAoLLwYkDeZkhyu6X0=;
 b=oIlv0+fW8XUa409oL5gwwdiXzBAmgAUAa+/3ZD8cGVDqXRODGmo6JWVXCO6K12Jrgh
 5XK6Q+G5yc7ziKW8pFLiXIQDEyIc2VdO21AaVvhF1QUM6JLwz4XuAxDt0UyU0fdNAwzH
 x+SFyYP3eTVb824aIe5JxEqqsIDjheb0+HbpgaJ5HdO8LB0vJNyiPk/vzWNZaLqrEilW
 IkNsXAjARmJIbqY50IAO/a6Yvcuz9qSOhwFCz/h1kYxsWSQajPS75mQmRF5JSQB+9bHa
 lWAckCeI+VaOmuOYcBEw/1hUJgfYHpLLskLk/gLLaLqwHGKOpexvXZ6lWNKnWrvgPZMN
 8rnw==
X-Gm-Message-State: AJcUukerAnKqcZjNRiKOto/Uijav6Kju2Db39dv4b68+8YfcOhs1ITAz
 Ts5ExqR4DY6WHrGXkJLXaINT5XLm9tCB/gybrOR+Rw==
X-Google-Smtp-Source: ALg8bN7AopW4FfqmbqbcDvGxfNYRDMgbPHW18qr/+SeYk+5GjNXRgJbQgLxxSX/kfbkrDMjq5hpbL14VpZIRL4d2eK8=
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr1190314ljk.4.1545387301141; 
 Fri, 21 Dec 2018 02:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20181212215305.3852170-1-taoren@fb.com>
In-Reply-To: <20181212215305.3852170-1-taoren@fb.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 11:14:48 +0100
Message-ID: <CACRpkdZr7zX2cvk-T93Ahj3Q2cE7-ey+T4Kr0n_==jae3KGr0Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: remove duplicated statement
To: Tao Ren <taoren@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_021513_022938_038DD5FA 
X-CRM114-Status: UNSURE (   6.97  )
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
Cc: linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Joel Stanley <joel@jms.id.au>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 10:53 PM Tao Ren <taoren@fb.com> wrote:

> Remove duplicated assignment statement from aspeed_gpio_probe() function.
>
> Signed-off-by: Tao Ren <taoren@fb.com>

Patch applied with Joel's ACK.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
