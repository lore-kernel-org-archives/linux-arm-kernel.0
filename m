Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB90C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:51:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF252084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jHS6YLvQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6gRoITN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF252084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7UMFaeDypvFP5Z37JHE65tHD26pWOLw0HiPZiqyVWzY=; b=jHS6YLvQ2hLhe8
	AJ11sNslMjXdaISkFK529pp0iw1Oi3eY7RhFstgfsqvsqt/NDeiIDkXrp23W9cUHp9boO4lPILOQf
	WX8tVeFKTFKLkIpkB7hW60E6HEryjMkeMq23K4h5QY/YCtOZRlL0HXlYIqAnQtS9YyGBykk/4Mjfn
	Aslszf7R6BHKVC4mL9lOg145ALO+XIAzYAf3bj9jvwSJqDLlIeOX0XEYn5LCeYOISBrXtIo1hljeX
	VcQBNgcfyVspkAcVOCxs9m4Yqd5z8KbqQL07IFN1SEuHfWhjBi02RojDvZXVIDY/ugW0H1+YHuiQp
	4VCnk45IbJ10NncYiIUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYocD-0001lN-Ce; Mon, 17 Dec 2018 08:51:05 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYoc9-0001jy-M2; Mon, 17 Dec 2018 08:51:03 +0000
Received: by mail-lf1-x144.google.com with SMTP id b20so8794259lfa.12;
 Mon, 17 Dec 2018 00:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dvxAbEnQmhD6O7pfOq+xyox5zauNKn8x4r7NjMwfiTk=;
 b=X6gRoITNt3/Nno5QnkTE2609YHgWgr/GaIr6anzjMKKru+EfKCSH875qzlcrqDDBFb
 ZmJKlbJ8IxDi83dWQAq1hwQj4g6PtH8XUAkWN8X7r03iraYezHwpjV7P899V9yYyGyQ9
 H/t0/hB+aIl675WQ/u+N2KCRDq7HM9SnCxobedje5yccy9t7M8C5bKfZIJzrkFABMrfL
 pULI6z4LGewz3rUQ0c240v3WdklvtezXCFeqzwb3U5Cb3lMLCnPsNVC474zaVCXxIAWL
 tI5zjKZ8YQsLiwJV/qZQE8ovunMqPsXVd613wc0feFpuUH4eRgxNFo9AZZtz+K3SD3PR
 XFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dvxAbEnQmhD6O7pfOq+xyox5zauNKn8x4r7NjMwfiTk=;
 b=ir6kWQMItZheuGksgnmDji5eGxtmL52W9IA8KnU5yS2bt86BPiUN/g7MdJp848d5NA
 hsj0yqRMiBeme61Ki6JxxdnSi44uCUrxiOnMCGKPaa8B7vCpQywk5IqmF+ZwAC9TmlsV
 ID1QxuYS+ZxueBcgz1wIYFAOlaqKAgu3g2qh1BMGjUIytW69BfE+reAXZrq8cZvKYluh
 qOY1DV16h2G72ZQ+cMLhCrGYrygLhGq6fgqY1rYRki/Jy03/EThlbQ3Nt5NFkopKe/gC
 lmRu5Kv2nfRhvFW31sm+PiBz/+UWBDtVFacHZc67Y415rCcFk61YRcI2GDmAo8ETJs1E
 l4Aw==
X-Gm-Message-State: AA+aEWaL3L4Ze9PVrezKgKG3hVbKnU2UeiaX4hZjSKY/Q0wMMWzUITw6
 h4tH9axDoKQ3qsmcZxlGyyBUPOLD5w3hBT0aqEE=
X-Google-Smtp-Source: AFSGD/V+fPXlggixcBqnnAzgxmII8ihsMB8RiuIaasAKyzTTg7GoXWQ2+qyoqeZgvki253HB0cTa10YnjkXavgLtrD0=
X-Received: by 2002:a19:8096:: with SMTP id b144mr7317813lfd.8.1545036649586; 
 Mon, 17 Dec 2018 00:50:49 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
In-Reply-To: <20181216101858.9585-7-starnight@g.ncu.edu.tw>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Mon, 17 Dec 2018 09:50:13 +0100
Message-ID: <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_005101_724854_5635F5C4 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 linux-lpwan@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan - ML <linux-wpan@vger.kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Jian-Hong,

Thanks for your work in LoRaWAN.
I have a question about the architecture of your module. AFAIK LoRaWAN
is already the MAC Layer above the LoRa technology. Why do you want to
make a new layer called "maclorawan" ?

Regards,

Xue Liu


On Sun, 16 Dec 2018 at 11:20, Jian-Hong Pan <starnight@g.ncu.edu.tw> wrote:
>
> List LORAWAN and MACLORAWAN in menuconfig and make they can be built.
>
> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> ---
> V2:
> - Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
>   LoRaWAN Soft MAC modules
>
>  net/Kconfig  | 2 ++
>  net/Makefile | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/net/Kconfig b/net/Kconfig
> index cf2e651ee31d..03b3ff306778 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -224,6 +224,8 @@ source "net/6lowpan/Kconfig"
>  source "net/ieee802154/Kconfig"
>  source "net/mac802154/Kconfig"
>  source "net/lora/Kconfig"
> +source "net/lorawan/Kconfig"
> +source "net/maclorawan/Kconfig"
>  source "net/sched/Kconfig"
>  source "net/dcb/Kconfig"
>  source "net/dns_resolver/Kconfig"
> diff --git a/net/Makefile b/net/Makefile
> index e80b84313851..9d5515965a8f 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -63,6 +63,8 @@ obj-$(CONFIG_6LOWPAN)         += 6lowpan/
>  obj-$(CONFIG_IEEE802154)       += ieee802154/
>  obj-$(CONFIG_MAC802154)                += mac802154/
>  obj-$(CONFIG_LORA)             += lora/
> +obj-$(CONFIG_LORAWAN)          += lorawan/
> +obj-$(CONFIG_MACLORAWAN)       += maclorawan/
>
>  ifeq ($(CONFIG_NET),y)
>  obj-$(CONFIG_SYSCTL)           += sysctl_net.o
> --
> 2.20.0
>


--

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
