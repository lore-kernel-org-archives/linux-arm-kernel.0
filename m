Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB787C5ACD3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:14:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC022086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DlBNPEXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC022086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W8rG52nA5fU2Nv6DjAKUaoNRlIp3TiHIT3Ygr6oLM8M=; b=DlBNPEXFjTZnVG
	kchFHC1tB6AmqQVVK/n4qLJuYJytMpGxlcAUcF+85UHXLMF1Ix9tpnr0qtvX8iJshqi3HIdte5U9T
	Bsq+9AxZht8Tin6xIpYUUquuzEvPwvHzhKWMdt4jKgHOfBJw0/vRhFmyN3XmmMhpbN999SJu5PJIO
	3lMtHnkvYwJ4GrLXqzfwAvhyh9og63qAcMbHYgwh5yVUWTiFNKICGM/WAF8qDPeRwJqi7YvHNb0e4
	LURzbj2dqGUjMOjdEtbvFZp0cfREULodpP6feBaQCgyRcA5bd97a2inWYo2MENT97v6q/AD57SYfH
	W/rpwqf3YcKLdzU/3P9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXie-0007OE-JO; Fri, 18 Jan 2019 17:14:12 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXib-0007Nk-DT
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:14:10 +0000
Received: by mail-ed1-f67.google.com with SMTP id h15so11719185edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ktKsigAQx+weGoNj6gtSnvxHTDmILfP/OH8CmOk6WZQ=;
 b=DneMrSIyqPDvqqyqqt/aYvYYJq76yn3hX3DsRNlimNHgWlR3cxynXbiRtMYNocfJtE
 e4bHQE1gBDsson/ZjD3j8xvD8fR1/lyB/5MLJA2JeL6+cnsiYyHZWYyIjcye/dgEjuwH
 2jayXmTJlV/sqXW4/51A6QRFRvhib4MyLaCXwHUR0GLKi9L+nJr+msF6uUELi7J7vszM
 Is86VJ5xTmxF8/JsGP2dg4qb2IJGqZb+w7xy+f44NCpCwUFb+BreB6gg+zWMCMYojxZ4
 VvE0U5/gpJ5J8gxwYqP2ibbs61QCNqbAK0DcfdAv2BDQCgmoPgsOqI3PyAkBSkwHBpkH
 h3tg==
X-Gm-Message-State: AJcUukcGvoLWspuSVp8PKAYuSnTVr5c46JYeSEAYjNjj9URITYzgLYu9
 oGw1ApNnbVsWK4c7LWpLlXQcriE8rLE=
X-Google-Smtp-Source: ALg8bN4fAWE0db0tJKFVA18FK2m9qvS+aehhj8SR5cu2UKmzOodb0Fm0hgVfs9ZgdTkxaBYW7Z7Vgw==
X-Received: by 2002:a05:6402:3d1:: with SMTP id
 t17mr17118594edw.21.1547831646488; 
 Fri, 18 Jan 2019 09:14:06 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com.
 [209.85.128.41])
 by smtp.gmail.com with ESMTPSA id d2sm7226681eda.92.2019.01.18.09.14.05
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 09:14:06 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id b11so5204280wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:14:05 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr16981898wmc.116.1547831645652; 
 Fri, 18 Jan 2019 09:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-3-anarsoul@gmail.com>
In-Reply-To: <20190118170232.16142-3-anarsoul@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 19 Jan 2019 01:13:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v665Wsu5dhNi1=-bMmPYP-5nfTamtu0uXVYym+RxzNeN=A@mail.gmail.com>
Message-ID: <CAGb2v665Wsu5dhNi1=-bMmPYP-5nfTamtu0uXVYym+RxzNeN=A@mail.gmail.com>
Subject: Re: [PATCH 2/8] Bluetooth: hci_h5: Add support for reset GPIO
To: Vasily Khoruzhick <anarsoul@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_091409_450317_639988AE 
X-CRM114-Status: GOOD (  17.60  )
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
 devicetree <devicetree@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 19, 2019 at 1:02 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> Some boards (e.g. Pine64 and Pinebook) wire a GPIO to reset pin of
> RTL8723BS

Pine64 / Pinebook don't have the enable pin. One could say that the
enable pin and the reset pin you add here are actually the same thing.

ChenYu

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/bluetooth/hci_h5.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 069d1c8fde73..7ead8c3d8657 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -107,6 +107,7 @@ struct h5 {
>         const struct h5_vnd *vnd;
>         const char *id;
>
> +       struct gpio_desc *reset_gpio;
>         struct gpio_desc *enable_gpio;
>         struct gpio_desc *device_wake_gpio;
>  };
> @@ -833,6 +834,10 @@ static int h5_serdev_probe(struct serdev_device *serdev)
>         if (IS_ERR(h5->device_wake_gpio))
>                 return PTR_ERR(h5->device_wake_gpio);
>
> +       h5->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(h5->reset_gpio))
> +               return PTR_ERR(h5->reset_gpio);
> +
>         return hci_uart_register_device(&h5->serdev_hu, &h5p);
>  }
>
> @@ -921,6 +926,9 @@ static void h5_btrtl_open(struct h5 *h5)
>
>         /* The controller needs up to 500ms to wakeup */
>         gpiod_set_value_cansleep(h5->enable_gpio, 1);
> +       /* Take it out of reset */
> +       gpiod_set_value_cansleep(h5->reset_gpio, 0);
> +       msleep(100);
>         gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
>         msleep(500);
>  }
> @@ -928,6 +936,7 @@ static void h5_btrtl_open(struct h5 *h5)
>  static void h5_btrtl_close(struct h5 *h5)
>  {
>         gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
> +       gpiod_set_value_cansleep(h5->reset_gpio, 1);
>         gpiod_set_value_cansleep(h5->enable_gpio, 0);
>  }
>
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
