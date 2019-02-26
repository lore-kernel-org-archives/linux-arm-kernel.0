Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED3EC10F16
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:34:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DD1218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N1uoziha";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0WrUlOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DD1218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+GGQDtUaia7I/U/rAjEPLiDjre5Tf8hbzwSveYnGYto=; b=N1uozihaZtMtlV
	YRg5eVkjNPyyZx7xlvb9TW1mLUd4vvL1Z9Wtt1Fgh8UAaQogO7wKtCJI5MblOrkEgQH4GjKie2bYc
	unE9bOP3QaoYC/wCFjjtqli8F915G9cLpRD+tgd/z+A01j3n2BAqCGH0/84mekrmQvn37H0qKxxvy
	es2N8IMV/PVV3AtOyuvNUxGRiNuIDE8y2IlpQedjCpK+4IWd0Ci3AsD23A2aNjRfOLbWU5ccbtOTJ
	tytzXm4qUbYekOYlT6j98Z3IlACR7IDHvj5Z/Jrv+Y/6FwmcR5Lm60SGrAqB5n6YTlCRcOP7DzjAK
	2984ZNj1Vm9AD8OcyWXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gymEv-0006Zt-4S; Tue, 26 Feb 2019 23:34:21 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gymEs-0006ZI-6c
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 23:34:19 +0000
Received: by mail-pg1-x544.google.com with SMTP id r124so6967777pgr.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 15:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=n8P1R9OyXHB7VHmonbdf5o5d5UZLIcR5uQjnpwS7Rxs=;
 b=R0WrUlOibSuPQgcyO2hHr4f/HTwGABPIQ/KdpA9Xvgmjfc5nJyHn7/W27Uzqynszmi
 eIokDHbySLPsLO7ocFqxfuD1xf7fhUDQkMD58mXscM/BnWgxpCPalmFTqM0UcWVXm3Js
 zcurYfA8ql9oiKS5la61WSzQcVNmdAGwL0Hvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=n8P1R9OyXHB7VHmonbdf5o5d5UZLIcR5uQjnpwS7Rxs=;
 b=VHzao/JmASIH+YRROCHU/2kPodG2yYxtQ0lru9DekhQueygZplaEd0Npg5YxCPXgXR
 g/w+/6aZ6hHGHCr0ka9bweQwOxVbIZu5eFXOLwUo6Fk55arMS3+GOtxnQehGrLZqtZLf
 GxWguw22wh6n1iE4ncoFH2gtJtWl3PlkXA4hojCH6+YQZPtQiAfsbjIVRn/x6le/atkg
 7D9lc6SmiaFpLMtZmulJPRRLsxIR69+Byl1lyy0oLEekDuK+/n8XxgDMT3uQEvG4kqhF
 XJYqXJt1vx5T50TzwmTehzft2K5c2kaq0II79vpSzi+9rk85wySoDgK8rpKs11jT2Ba3
 O/Eg==
X-Gm-Message-State: AHQUAua9JQHw2jDAv21UNLNadXNjsZa3AYxaYXA/PFbX7gVT4+8C9egC
 r90JyKJ9D4+4k/SrwWw1k0XgeQ==
X-Google-Smtp-Source: AHgI3IZx/l9x7PyCNpPE3Gv0+b01BmZTP6CBrJzUZgTSbtd/AkFWEJ9sOsJtS774d9kZWUOj57TVcg==
X-Received: by 2002:aa7:8150:: with SMTP id d16mr28898496pfn.172.1551224057414; 
 Tue, 26 Feb 2019 15:34:17 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id p34sm28840880pgb.18.2019.02.26.15.34.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 15:34:16 -0800 (PST)
Date: Tue, 26 Feb 2019 15:34:14 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 3/4] mwifiex: Flag wake-up interrupt as IRQ_NOAUTOEN
 rather than disabling it too late
Message-ID: <20190226233413.GC174696@google.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <20190224140426.3267-4-marc.zyngier@arm.com>
 <20190226233130.GB174696@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190226233130.GB174696@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_153418_267728_8E9A6990 
X-CRM114-Status: GOOD (  22.63  )
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
Cc: Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, Xinming Hu <huxinming820@gmail.com>,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amitkumar Karwar <amitkarwar@gmail.com>,
 linux-rockchip@lists.infradead.org, Nishant Sarmukadam <nishants@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 03:31:31PM -0800, Brian Norris wrote:
> Hi Marc,
> 
> On Sun, Feb 24, 2019 at 02:04:25PM +0000, Marc Zyngier wrote:
> > The mwifiex driver makes unsafe assumptions about the state of the
> > wake-up interrupt. It requests it and only then disable it. Of
> > course, the interrupt may be screaming for whatever reason at that
> > time, and the handler will then be called without the interrupt
> > having been registered with the PM/wakeup subsystem. Oops.
> > 
> > The right way to handle this kind of situation is to flag the
> > interrupt with IRQ_NOAUTOEN before requesting it. It will then
> > stay disabled until someone (the wake-up subsystem) enables it.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> This could be:
> 
> Fixes: 853402a00823 ("mwifiex: Enable WoWLAN for both sdio and pcie")

Also, this comes after a different change (that's not quite as clearly a
backport-able bugfix). Perhaps it should go first in the series?

Brian

> although, that was just borrowing the existing antipattern from SDIO
> code..
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> Thanks.
> 
> > ---
> >  drivers/net/wireless/marvell/mwifiex/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> > index 2105c2b7c627..82cf35e50579 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/main.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> > @@ -1610,6 +1610,7 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
> >  			 "wake-up interrupt outside 'wake-up' subnode of %pOF\n",
> >  			 adapter->dt_node);
> >  
> > +	irq_set_status_flags(adapter->irq_wakeup, IRQ_NOAUTOEN);
> >  	ret = devm_request_irq(dev, adapter->irq_wakeup,
> >  			       mwifiex_irq_wakeup_handler, IRQF_TRIGGER_LOW,
> >  			       "wifi_wake", adapter);
> > @@ -1619,7 +1620,6 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
> >  		goto err_exit;
> >  	}
> >  
> > -	disable_irq(adapter->irq_wakeup);
> >  	if (device_init_wakeup(dev, true)) {
> >  		dev_err(dev, "fail to init wakeup for mwifiex\n");
> >  		goto err_exit;
> > -- 
> > 2.20.1
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
