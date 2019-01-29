Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16283C282D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:05:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96FA2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cd8iSoq7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cirpHcDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96FA2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+3upnfqHwO5D12l1rT4Cq0ZcBysv32pxvHtH7n4REv0=; b=cd8iSoq7X5XZ3k
	HNiQzedt4qVtuTCoCYz/0kStgIGuP7btI30Y8QKCKiilB/y9veDJ/NykosoVF1qPcXrDLFG6X29qL
	w2HfpfmkKhBmzepAqZawk/SQlkQGXSId8D2IrXQbyCaLeG0sdBnN8CfKEDp7hR9lkpkLfBeTW1PZK
	LsQbRyOEc84Lq8g5Up0eWxhNWfDae2c2qibEPfCdC8vArl+qcmOI2w8de+oBvuNNboFOTkbic4EXq
	Ryj4IdMowwQ7Zv6u/kfLYMZUYGQdeLFKFQU5k3Oc7ZMS112oA8S+yQxfR/p3f4UTaNfm/DAAy5BL0
	Joojws98BL1+T6dLzI8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWou-0002Ed-Og; Tue, 29 Jan 2019 17:05:08 +0000
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWoq-0001gD-PO
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:05:06 +0000
Received: by mail-vk1-xa42.google.com with SMTP id s184so4647235vkd.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 09:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hvr50WOe5YAp+ZfNWlbBzbHKySkVFiVrgRzeI4jrxMY=;
 b=cirpHcDvmVexDxUSFxEOMfTqD9LddehQ6agRWW1r/TYMjffUW4bEbw7rEs+b/eBIfm
 rQkPjrQXfZnB9c63yzODT1AdFY9zX86Zwyns2lSICzrfoppBiDthnWVeS0wTejgvefo2
 1VGJHhTfUz+20nu0NMDQ1ENbO3SwB2U9gwxBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hvr50WOe5YAp+ZfNWlbBzbHKySkVFiVrgRzeI4jrxMY=;
 b=BQfnX+FXPsBIsMz6a9rPSIKIEO0DGJNz/FmWKYpfJOLvmmgd1/oydSuYi+H/bxwvsh
 0abixyXY3XESpk15UzJrenycV9oH/OYMcnRWN7bdod9ox9RlIp2NpnAmmikYopZT/xRn
 9UV64+71rxT8JGtLzk6Px6owOi9wBGmSADX5ckB3pqg53QQGT1TRExyuFDBZ39ajsheg
 6RoI57m8MuvFIOvHJerdMMbEMV/lXN3n/tB6aiaYlZOcR5MZ4UGtiL5YQsbNS7DEmERZ
 EizBjh6nJ7HiuSB2CVhWQhZZYz/HF1UV4UrynIOurnozfNO1kXVylIVhEjNtnepQeaa5
 dx9w==
X-Gm-Message-State: AJcUukcm9MrxtRNX9K0bzcI3dyRxATvUZCtMknDl2o0HTAik1Tv2iWoQ
 RCuRJmIr/HCiReph3bvQ1GsRcmsKCOA=
X-Google-Smtp-Source: ALg8bN4U253j9TwtaWT6H5OA5aS39zH3Fkbhy6mUmcBdaXm42ZHB3LaC8a87WgO2+KPp7ekmMiSc5w==
X-Received: by 2002:a1f:e807:: with SMTP id f7mr10636592vkh.16.1548781497750; 
 Tue, 29 Jan 2019 09:04:57 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com.
 [209.85.221.177])
 by smtp.gmail.com with ESMTPSA id 30sm30988252vkq.49.2019.01.29.09.04.56
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 09:04:57 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id b18so4658633vke.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 09:04:56 -0800 (PST)
X-Received: by 2002:a1f:bfd6:: with SMTP id p205mr11125087vkf.70.1548781496482; 
 Tue, 29 Jan 2019 09:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20190129164813.GA5720@atomide.com>
In-Reply-To: <20190129164813.GA5720@atomide.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 Jan 2019 09:04:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
Message-ID: <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_090504_834734_AE8BA880 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sre@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Jan 29, 2019 at 8:48 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> Looks like commit 5451781dadf8 ("regulator: core: Only count load for
> enabled consumers") started showing new warnings with v5.0-rc cycle:
>
> regulator-dummy: Underflow of regulator enable count
>
> I'm seeing this at least with my pwm-vibra test case:
>
> # rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
> pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulator
> input: pwm-vibrator as /devices/platform/vibrator/input/input4
> regulator-dummy: Underflow of regulator enable count
> Upload rumble effect... id=0
> regulator-dummy: Underflow of regulator enable count
>
> Are these bogus warnings for dummy regulator or do we have
> real unpaired regulator calls or somewhere?

My first guess is that there's a real unpaired regulator call somewhere.

I actually meant to include this in the commit message, but I'm an
idiot and I used "--" to break up the parts of the commit message
which confused git when Mark applied it.  Sigh.  For the full commit
message, see:

https://lkml.kernel.org/r/20181120175255.227783-1-dianders@chromium.org

In that message I said:

> - We can (and will) spit errors out for code that used to be invalid
>   but was never caught before.  Specifically if someone leaves a
>   regulator enabled and calls regulator_put() we'll yell.  We'll also
>   yell if a single consumer calls more disables than enables.

Looking quickly at 'pwm-vibra.c' it wouldn't surprise me at all if you
call regulator_disable() more times than regulator_enable().  If
that's true it should be fixed.

-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
