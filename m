Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C55C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:54:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F5F20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ktnBr0rW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8uRTkxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F5F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=igTqLTEh0Co/f7b77ymgTHuOgzKPbsVARGAmgq7sYnY=; b=ktnBr0rWetImtW
	RZI0s52QiTJIcuo1A4woj0CrXXqDe+KFmO/HwaYgocImYZRihAwMVuX30WzDlAxxTG2+69LpSF8G4
	DiWqza68e1Obknn6NjsUsguTK+3I6XY2gK9PyM+MTJu5dq7T/5V/iMzSs10ZyDT6bDR3NUKwYxOGJ
	R0cdA499FokoFqnWWZf9bA4Hs+W6qCRkwl77HciCrQL4Amx00njztlRz/7sPwLWYwXHKxCikPabcR
	aE3rZRbcSujWZ4DcwboSJVd1EKha0hrwOo0mDA4WHFhYLRfwja5EjIX5SNUOPtsGzJcA8vHAtd6JR
	Fp0bztgs3ZGjFjtSQpTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxkre-0005QJ-Jo; Sun, 24 Feb 2019 03:54:06 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxkra-0005Pr-Ih
 for linux-arm-kernel@lists.infradead.org; Sun, 24 Feb 2019 03:54:04 +0000
Received: by mail-pf1-x444.google.com with SMTP id i19so2925341pfd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 19:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vEFJj8f8aJJKNog+h5E3CItg2WjBd6JxcRZBrrmKL3Q=;
 b=o8uRTkxYYxNxx9gCDsBgGLu9asQE2kEcKC3WWxLciu1WMLFHflUHM9FP2KUuoEntpq
 kJW/FLFZIkm2eVjHb+pjjn9pCd8piQXJWbi5UcrgITrUcjjKN07iTL4/yT7r1DLcYyFd
 uFIsoC1uEc351KV3I/AeT3itvL6Z1HLdee9KlG8SP6V/mm/u+fdgDPGcNV16ksuw9IQL
 Pwn/X1gFSRxFfSfoEwfasMjoiQ+fQf4+ankGV4W/AyuM6HPUskcFCs8bUqTljbjWd2u3
 6xuTrnG7gZE3dz7b/4ZpHsf1MOrWu9KP6TPQIrj6bSWawk378ffbkJlCM5QNkRuehCYG
 Tc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vEFJj8f8aJJKNog+h5E3CItg2WjBd6JxcRZBrrmKL3Q=;
 b=MWjgqVAX7afShs0oOzieeBO+E6HRfbczXJsvOBnyqiIJi3qqs+Y5bLKMXOS7RyRqV9
 dPxSwgNg6J+o4QqUCSnPJR6LB7dvu4y/AoUFGXTYZaTa4mGpnA9piVds9f1+ey9YnCqR
 calvzA6heuPnh8Ws8EEG4Ai1aGYxF3HWWzknYhlbEmoQhqMZJx6B7+S3Rou/aMpOTbN5
 Ee/uK9Zh2miDpTzfPDuS8eyFkIZZqt/IoeNPD2v5UODR70CbFQQkdOOTCGff2OwzO6/3
 o8BOxANbBtyDt8z8KAnbGBU1kdjL0KrKjmYhJFOQGiVpfB5KzDLRGpDej/3fbjcoiA2r
 4cVA==
X-Gm-Message-State: AHQUAuY5o2wmQ2VKlIEhiqHnnt/ZbfHPkDXNmltvftho0/mJK3d664Z7
 iixlq5A+a0/1WdKG+fqvs7wscA==
X-Google-Smtp-Source: AHgI3IbWcnfQyp5986NEkTynM+WgioIIX4ib7mtuHujZZp12UDUzhPBeTDUDcitVhs3hkSB3ci0VJw==
X-Received: by 2002:a62:e204:: with SMTP id a4mr11200228pfi.225.1550980439873; 
 Sat, 23 Feb 2019 19:53:59 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id v26sm7362953pgn.46.2019.02.23.19.53.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 23 Feb 2019 19:53:58 -0800 (PST)
Date: Sat, 23 Feb 2019 19:53:56 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
Message-ID: <20190224035356.GD572@tuxbook-pro>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
 <20190223181254.GC572@tuxbook-pro>
 <86zhqm8i6d.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86zhqm8i6d.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_195402_642191_B561DF0E 
X-CRM114-Status: GOOD (  23.92  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat 23 Feb 10:37 PST 2019, Marc Zyngier wrote:

> On Sat, 23 Feb 2019 18:12:54 +0000,
> Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> > 
> > On Mon 11 Feb 06:59 PST 2019, Marc Zyngier wrote:
> > 
> > > On 11/02/2019 14:29, AngeloGioacchino Del Regno wrote:
> > > 
> > > [...]
> > > 
> > > > Also, just one more thing: yes this thing is going ARM64-wide and
> > > > - from my findings - it's targeting certain Qualcomm SoCs, but...
> > > > I'm not sure that only QC is affected by that, others may as well
> > > > have the same stupid bug.
> > > > 
> > > 
> > > At the moment, only QC SoCs seem to be affected, probably because
> > > everyone else has debugged their hypervisor (or most likely doesn't
> > > bother with shipping one).
> > > 
> > > In all honesty, we need some information from QC here: which SoCs are
> > > affected, what is the exact nature of the bug, can it be triggered from
> > > EL0. Randomly papering over symptoms is not something I really like
> > > doing, and is likely to generate problems on unaffected systems.
> > > 
> > 
> > The bug at hand is that the XZR is not deemed a valid source in the
> > virtualization of the SMMU registers. It was identified and fixed for
> > all platforms that are shipping kernels based on v4.9 or later.
> 
> When you say "fixed": Do you mean fixed in the firmware? Or by adding
> a workaround in the shipped kernel?

I mean that it's fixed in the firmware.

> If the former, is this part of an official QC statement, with an
> associated erratum number?

I don't know, will get back to you on this one.

> Is this really limited to the SMMU accesses?
> 

Yes.

> > As such Angelo's list of affected platforms covers the high-profile
> > ones. In particular MSM8996 and MSM8998 is getting pretty good support
> > upstream, if we can figure out a way around this issue.
> 
> We'd need an exhaustive list of the affected SoCs, and work out if we
> can limit the hack to the SMMU driver (cc'ing Robin, who's the one
> who'd know about it).
> 

I will try to compose a list.

Regards,
Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
