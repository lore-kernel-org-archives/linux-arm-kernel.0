Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA40CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:52:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD2A21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tDUMKOoW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QsJBauhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD2A21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YmPWG4a7B5kCXM48Ne6RQ3um2Sr1KOEZYysBpjppg2I=; b=tDUMKOoW0FBtWz
	QGJ/EkW8zXY8DaGbfX4yxUgSz05uYnm7xF/G4K0pXybPcbfTnMuihNXEJBh6CcliYOoOFJtalNopc
	sGHuFq9RdoqNPE5NFqG5LzC0WER7NL4FHB9pSvLONFbPs/9A71Vq+QkGE0OyPIHL1O3X2qVLweoVA
	WyywfWhY9UkqHURRj3JgX/+RTj9wF1OtuMeEEbeLuelE4sQoet2riNqROWtrFJ2uu7s6XGOb43pnq
	qwcRCbpcFhT0LP9xLpNlc/slXOkElbCoUFtM3boreE+Qd3KBzeBpqrCHTN8nN0M+0RXcCpsEUjHt3
	Iw8ycAEvWKGXoy7p1CNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goXYc-0003tZ-CU; Tue, 29 Jan 2019 17:52:22 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goXYY-0003t6-CR
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:52:19 +0000
Received: by mail-pl1-x641.google.com with SMTP id a14so9652790plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 09:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/tBJEqMWNjDrJbK7vLSjt12W3B5Rc+tYahKPemMtANI=;
 b=QsJBauhg4eUekdMhtLnxRl62aPdx2TMYBB8tV2MxqlsN3jtBnddYi44PvvrYG38ur1
 RtH4FdFx6B6W18ousVB8IzVANCNwqqhF51FVOxaUOU0upOTLjSkzKWdGbl0fuF8tDv1I
 Mp285vTUpHfN1pBJTiJEvKS+FH54zQB4oPYxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/tBJEqMWNjDrJbK7vLSjt12W3B5Rc+tYahKPemMtANI=;
 b=P++iYoJfU9eY1Bq/4fR5YilZTzFByiSnTAmvsgJoNLeU9V0nzJoye78RAkR9D9NZOp
 G3kEiQyeuemSO/dExwzDfwcj7DMx/5atdZL7Y1Uq4kg4w1YJlsMP/UBVqaZbXDJXT8Nz
 DaxPM7wH4XcNv1QyX+BbGi/uOxr/TB/s6DIwK5Ku0hXGfJGeSjP9BkTyZRJHK/NcRk8h
 dcigGNadDeux8hVbwB6QmzslxhpHs2yqA9Js0xuxG21d/vw/ngF/siA+q1B8Lwuqp9zG
 zCVm8MqCMfGhg0vX5i5zRB19CaBC8DPIeh6v1HTU+hB9YsZVat3VNE8M6UQde4jV6s7a
 HyJw==
X-Gm-Message-State: AJcUukeQbVha2YLTMo1byBP0adU2ilqi7ignAtmzucdPDLvoFjAuEWSn
 UYAp27sbYZJRGcRVPKV0iKblVg==
X-Google-Smtp-Source: ALg8bN7j5UhBKQlvkZLZOXYipaHjr9dC+/pB5TbPyABoNkl4cpYONYQGcG5JZEXuE9HffEFUGEM/rQ==
X-Received: by 2002:a17:902:50e:: with SMTP id
 14mr26655081plf.141.1548784337163; 
 Tue, 29 Jan 2019 09:52:17 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id j6sm64534816pfg.126.2019.01.29.09.52.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 09:52:16 -0800 (PST)
Date: Tue, 29 Jan 2019 09:52:15 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Message-ID: <20190129175215.GK81583@google.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
 <20190128190251.GH81583@google.com>
 <20190129090331.fgygq3dsaoqvegsl@queper01-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129090331.fgygq3dsaoqvegsl@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_095218_443612_60B4D4EA 
X-CRM114-Status: GOOD (  20.81  )
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
Cc: mark.rutland@arm.com, rjw@rjwysocki.net, nm@ti.com,
 lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, liviu.dudau@arm.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Quentin,

On Tue, Jan 29, 2019 at 09:03:34AM +0000, Quentin Perret wrote:
> Hi Matthias,
> 
> On Monday 28 Jan 2019 at 11:02:51 (-0800), Matthias Kaehlcke wrote:
> > > +/**
> > > + * of_dev_pm_opp_get_cpu_power() - Estimates the power of a CPU
> > > + * @mW:		pointer to the power estimate in milli-watts
> > > + * @KHz:	pointer to the OPP's frequency, in kilo-hertz
> > 
> > nit: should be kHz
> 
> Right, I can change that :-)
> 
> > 
> > > + * @cpu:	CPU for which power needs to be estimated
> > > + *
> > > + * Computes the power estimated by @CPU at the first OPP above @KHz (ceil),
> > > + * and updates @KHz and @mW accordingly.
> > > + *
> > > + * The power is estimated as P = C * V^2 * f, with C the CPU's capacitance
> > > + * (read from the 'dynamic-power-coefficient' devicetree binding) and V and f
> > > + * respectively the voltage and frequency of the OPP.
> > > + *
> > > + * Return: -ENODEV if the CPU device cannot be found, -EINVAL if the power
> > > + * calculation failed because of missing parameters, 0 otherwise.
> > > + */
> > > +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> > 
> > I think it is more common to put the input parameters first, then the
> > output ones, i.e. cpu, kHz, mW.
> 
> Hmm, the issue is this must match the expectations of the EM framework:
> 
> https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L62
> 
> So, I don't really have a choice. Or we can change the core code if this
> _really_ is a problem -- we don't have users yet so now is the best time
> to do so I guess ...

I see.

I think it would be preferable to follow the common scheme, but it's
also not a major issue, up to you whether you want to change the
definition of the callback. It's certainly true that now would be the
best time for a change.

Cheers

Matthias

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
