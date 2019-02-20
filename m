Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6FEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:22:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683B52086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UNnTLYze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683B52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uP9ZtudTahd9q/GktQuE4ypoX84Cb5kmEgVlrBDbcQU=; b=UNnTLYzeuMHkV9
	jOlRqTxvWlBgidpdEbjb8VXgdKdCEXqE6R3T7qUBFXo70fjq/jg72/I/eck1AyrbLORvRxClWnEVb
	Xp//zw0fqxNn6SXYul99we11SPTFj7RRGmXlsNhaSZj27oreIpUF8xKJ72vwWXbxpxJI3vH35vvKd
	8cITCxues0I4ny/c8Eo2qY8Uu0k8OZBFdvM/ALc7jfw/+2eetHJtP4YkyHvSmg4UzsVGjY7ALSnvR
	fOVJGHAIQarS2zlL0WFpcxpIl93g7rK33uyqDfCoHtqWwjctlgOwEmfNkqC1augawSHqcAcjnd2h0
	ZwbNxvavzA72syWYo1tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTh7-0005Zi-OR; Wed, 20 Feb 2019 15:21:57 +0000
Received: from mail-qt1-f175.google.com ([209.85.160.175])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTh4-0005ZL-Lb
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:21:56 +0000
Received: by mail-qt1-f175.google.com with SMTP id a48so27583191qtb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 07:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qo5tmYpcRxaLzliSeItuYmvcJ6g/Yi16tnpwz+dGPZs=;
 b=TOtB98gNLFWV5dpMTf2BZkHn+iRKsInv42mgIihdxM+b5i/rO8uYny3B9OtNTzJ3pq
 /EQzmH+HozczmwJO71Q3blmC47KvRsqVhA3lnGC9AcUxDyHzpiZni50iiwUrvDzcXHX9
 rz/rgwdfWfUAhxc2hMJkmUrFKFNQeXSRq53d9U1dvK2i11+dHve44DJJ6AijBTeihPbv
 3xJzlaBzQPTfX0ZNkYDBkVTedqxmnQCAZPKZ67meDmjPjzsnWwIJGKN6JJOg+I7gPmTh
 xty8sNnlM5D5uCLNuV7lpZU2jKzri9AgoJ1HCfhFVNoCdbM2SzUsAiqK7/B9frkMsHHl
 vFNA==
X-Gm-Message-State: AHQUAubf0b6/ZOhW6HI/DyAZFocEA3e5+4YhZ/zGG32WrCFEdjXBuMsc
 c8GjjTsGUZUHAL8EFdIvAZ8x0f5LnTlPr/4YlZM=
X-Google-Smtp-Source: AHgI3IZ3prvpuft6TvVX8v1GEymLmLhroW/Pf0TzgHjERPuP98OUlUpKHAKHXJGdVzVibrRJTnFoALsOAqHEPTlqK6E=
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr26637821qvd.161.1550676113064; 
 Wed, 20 Feb 2019 07:21:53 -0800 (PST)
MIME-Version: 1.0
References: <26892a0a-c6c4-6409-44cf-1f407ac21482@ti.com>
 <455ad8de-ad81-c716-679f-1e71e24ca642@ti.com>
In-Reply-To: <455ad8de-ad81-c716-679f-1e71e24ca642@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Feb 2019 16:21:36 +0100
Message-ID: <CAK8P3a2id=JXe1xQ4=UwXuqJL+E+fD8p7mu=pzJFUi8n46SkWw@mail.gmail.com>
Subject: Re: [GIT PULL] DaVinci SoC updates for v5.1 (part 3)
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_072154_707814_78E41D0D 
X-CRM114-Status: GOOD (  15.23  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 ARM-SoC Maintainers <arm@kernel.org>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 12:08 PM Sekhar Nori <nsekhar@ti.com> wrote:
>
> On 19/02/19 9:05 PM, Sekhar Nori wrote:
> > Hi Arnd, Olof,
> >
> > This is a late request to pull some further SoC updates for DaVinci.
> > The patches have been in the works for a while, but we received the
> > final maintainer acks only yesterday.
> >
> > I hope we can merge this for v5.1. We have further clean-ups for
> > mach-davinci planned, and it will be good to get this out of the
> > way.
> >
> > I have run randconfig builds with a previous version of this series.
> > I am running afresh with this branch too. The branch merges without
>
> This is done and no new randconfig issues were found with this series
> (10 random + 1 allnoconfig builds)

I've pulled the branch into arm/late for now. All the patches look
really nice, so agree we should have them in v5.1, but given
the timing I wasn't quite comfortable enough with having them
in arm/soc right away, in case something does come up.

If all goes well, we might end up merging it into arm/soc before
sendinng out the pull requests, but it depends a bit on the timing
of the merge window and how much more testing I can get done.

If it's not part of the initial pull requests, we can aim for sending
this in the second half of the merge window.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
