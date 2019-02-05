Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3292C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:40:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7361D20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ob/YoGpe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPrLLSJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7361D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h4vIw/I+/rR9ALeUqdOFF7PHDZ/CiP4RoyvRbJt4f3I=; b=ob/YoGpeMZeDDs
	3X59FIhfKrQgcOF+uTOEC5ZJRZhQr1J0cV4a81B4tBiOOU3NaYhkbptfoDb/eaSaGhGTizTcOK4QC
	E63/Bs8qUuQFhtiZJsP+MwRsC6ZYZCs3JaeQcaaQbrgdcTk+vyUIDDE7Lghm/Z+kR8HfGBx7WQAta
	iW+MZw+GPL12r3ydUcqtPSpSHQxI1R98TBLTIA+PQsSVxdOzBvdDmwDbJT6h2UayJAgAL4sy7+BMF
	b6+aIPzhca/z7Yzun009XcazNYBKMyptv2HWnSITmsgZSHQXX/qxpfZRAjgH/eynoUcZgQf91Q/Ab
	JPoCsMpPJSs1WRtEA5rA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxDQ-0005R6-LE; Tue, 05 Feb 2019 09:40:28 +0000
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxDN-0005Qh-Ev
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 09:40:27 +0000
Received: by mail-vk1-xa41.google.com with SMTP id 197so640599vkf.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 01:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PUbbD68Dm2rbFTrJ1ZJ+R3uLQKALFkdWbqo3heo6Xzw=;
 b=EPrLLSJFKOg7JaGRhtkSyBHeo/acfa3gyel5KjAsGlerXfXz8OVU5IcTzCm3+I2duc
 yPrw1wQavGMpdwR68etgw71JOoYoWzpUqcUcva41/0dBOhDML4NBJOqWNVCCOsqwphFQ
 src8rmWtvKZGoBsMZBfpMjZlr6ZGMSBue5lhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PUbbD68Dm2rbFTrJ1ZJ+R3uLQKALFkdWbqo3heo6Xzw=;
 b=IBiBvmJJdp1Tu0SQWrkS2nNmtmJIX5CvGz4ZfaMB1kQsBzda08pPWTHdmqwjyhhuR/
 h1w0PPXaS9W7LqPtAx0eQ9msyBeeSpgU/6TMQf4Fm1LrVbQqQAQ/8esi8Z1KYoRnLrwG
 wbcTgo5MQ+WZgFXWYq4kdoJQZIEo9ktyBXWU9h1nnYaZoPpTiYASQN9KqlFvNBWRHZiJ
 q4nMZWa99Y/3tlEh7cauuGt21ObW2GgDUW8KYJA2GtIifmzDNqlMnzCtSp6k2hcnnrb6
 zqJO1wgmbI1iJW+2LF2lOiS4MUz+uxS+5Q6dvsoSytrWYRjhf6vQ6/y19iyFy2C4Ze4X
 +0Fg==
X-Gm-Message-State: AHQUAuYMC2kay+wsAqEYXdc1BtKKL9+Ibxafq2LgrD201ZQoGK74efTq
 OvQX0S9Y+pfXA3RHigJfOThn6HbZLNuvsFZC3TDm+A==
X-Google-Smtp-Source: AHgI3IbHO3PSU3qDgTSJnVVoEKJNT5+Pu8j1uNBG0k2Z2IBxFOUzci+lNCtTgLYnqoGJfKipauibUz+/JooOouyYfrI=
X-Received: by 2002:a1f:1408:: with SMTP id 8mr361031vku.36.1549359623932;
 Tue, 05 Feb 2019 01:40:23 -0800 (PST)
MIME-Version: 1.0
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
 <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com>
 <AM0PR04MB421124AE755C01CEEC0CF31D808C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFodySv0A9ESDWwpJU=FQeyZ3FpOG0BMVBPxfgxd3oLWDw@mail.gmail.com>
 <AM0PR04MB4211C13768DD0D9543B6A59F808E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211C13768DD0D9543B6A59F808E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Feb 2019 10:39:47 +0100
Message-ID: <CAPDyKFrnUK1_=0okEPTxCjACbOpYuOF9h3oK6pBTXrR9OYje+A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
To: Aisheng Dong <aisheng.dong@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_014025_508720_83D43FE6 
X-CRM114-Status: GOOD (  23.59  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[...]

> > > Then attach_dev() can parse the correct "resource id" (e.g.
> > > IMX_SC_R_SDHC_1) from device tree And store it in per-device struct
> > generic_pm_domain_data for later start()/stop() using.
> >
> > I see, thanks for clarifying.
> >
> > Seem like, we have two options to make this work.
> >
> > 1. Let genpd pre-store the index in a the per device generic_pm_domain_data
> > while doing the attach and before calling the
> > ->attach_dev() callback. This would make sense, if we consider this to
> > be a common thing.
> >
> > 2. Provide the index as an additional new in-parameter to the
> > ->attach_dev() callback. This requires a tree wide change as it means
> > we need to update existing code using the ->attach_dev() callback.
> >
> > I would probably try 1) first to see how the code would look like and then fall
> > back to 2). What do you think?
> >
>
> Yes, I agree with you.
> This patch is exactly doing 1.
>
> For your former suggestion:
> " Just assign virt_dev->of_node = of_node_get(dev->of_node), somewhere in
> genpd_dev_pm_attach_by_id() and before calling __genpd_dev_pm_attach().
> Doing that, would mean the genpd provider's ->attach_dev() callback,
> don't have to distinguish between virtual and non-virtual devices"
>
> As this can only solve passing the real device node issue and we still need
> pre-store the index in a the per device generic_pm_domain_data and then
> distinguish if it's multi power domain virtual devices in attach_dev(), so
> I'm not sure if it's still quite necessary to do that way by assigning
> "virt_dev->of_node = of_node_get(dev->of_node) before attach".
> Probably after fully switch to option 2, then we can do it to fully drop the using
> of per device generic_pm_domain_data to make it transparent to attach_dev()
> users.
>
> So now the options may be:
> 1. Pre-store both device node and domain index in generic_pm_domain_data before
>   Calling attach_dev(). This is exactly this patch does.
> 2. Pre-store only domain index in generic_pm_domain_data. For device node, assigning
>   "virt_dev->of_node = of_node_get(dev->of_node) before attach.
> 3. Change attach_dev() to passing domain index and assigning
>   "virt_dev->of_node = of_node_get(dev->of_node) before attach.
>
> Can you please tell what's your prefer?

Apologize for the delay, just realized that you were expecting a reply from me.

To me is sounds like option 2) is the most feasible. Perhaps it's even
a good idea to store the domain index in the struct
generic_pm_domain_data, as it allows it then to be used at any point
later in time, this not only from the ->attach_dev() callback as
option 3) would mean.

So according to my understandings, then your genpd backend driver's
->attach_dev() callback, would use dev_gpd_data() to find out the
domain index for the device in question. Is that sufficient, or is
there anything else that is needed?

[...]

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
