Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55A6C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:35:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABE820838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hmda1euV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP77AmPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABE820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x6MczycpBIW0IKbqIaC+b9aH3cFwkAlqEUe30DiThw0=; b=hmda1euV5mIGlC
	4hXi7aNG0XqWy9Sz4fqBXwcK6jCvRbQkxLG9dGI0+6bKMzgt3CL0PiT7awWA+6rbsp85Abr83DiWr
	vabPF7w3WE8CWfe+2WWLpIZFYPtCLTygPeOtqsraQZDyDjhtLLMU2qv5s2oju2ye2ZusW9xAT55rH
	paeA2mkrag/JL6Aun6hKaiewiesKXguRBIFto9AwhPB7T1GUy2jrlXXYO3eTU3EmppuB1VFlRTP2T
	xbSOQSUmwaDPIxkEz5M59C7MpVeWsmsKYSOZ87lrM+4JvD1JdS26p/1p4eo3+hHw9wzq8XeYcNRLd
	10GNFNZw29aMXL3Db93g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9rs-0000Wu-AW; Mon, 11 Feb 2019 11:35:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9rl-0008E9-2c
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:35:18 +0000
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B47321874
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549884912;
 bh=tZHM7+rLTmXHl6qUUR3voaPwyqlFBHoe0W+qn/KqtoQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=KP77AmPTUs/uWr/de90sN79Pmt6EnSgp//FnSD9WotPrsN9u9UY3TUBDdZmsDgrRH
 Fq0bBsAJNzw+WzFXnptjWKXJJF2d1+sLcY+FHwzp7gfnpti+vHV/wxRJ/uO4BKYjFo
 kLz8SqYNvx7TMqpZ02eKb2fdq0IRCk50gRQIQlUQ=
Received: by mail-lj1-f171.google.com with SMTP id v14-v6so8485932ljv.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 03:35:12 -0800 (PST)
X-Gm-Message-State: AHQUAuadp8mJyFT4fkPcftK1pqY1gROxqsz7g20FnoOHzm51+gTAjnwv
 MuwgFkXLy+rnK3piXf9sBBH0iNCrTTLulAP/RKc=
X-Google-Smtp-Source: AHgI3IZPQjrXU7wN2m+yvfTQj0zh5T+3sH5Qvr8njEtSv/vNlRFUCD06dmsoLc2+2h9CBc+piE3KTCvx9JYmQP9jjJk=
X-Received: by 2002:a2e:890b:: with SMTP id
 d11-v6mr23037595lji.113.1549884910274; 
 Mon, 11 Feb 2019 03:35:10 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190210225147epcas3p4cedebfc5692274bc6135ceabbcf2642d@epcas3p4.samsung.com>
 <20190210225114.20110-1-stuart.menefy@mathembedded.com>
 <e22c175a-d88a-81a7-9faa-42bb4fe09a22@samsung.com>
 <e3637f0f-1e72-db3a-f744-ade0e878cfc5@linaro.org>
In-Reply-To: <e3637f0f-1e72-db3a-f744-ade0e878cfc5@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 11 Feb 2019 12:34:58 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfguCS5jFNhdfJ8poA1yC3JVb0jnra4af-EBXfwy2P8Gw@mail.gmail.com>
Message-ID: <CAJKOXPfguCS5jFNhdfJ8poA1yC3JVb0jnra4af-EBXfwy2P8Gw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Subject: [PATCH 0/2] clocksource: exynos_mct: Clear
 timer interrupt when shutting down
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_033513_543940_DF5AB47A 
X-CRM114-Status: GOOD (  18.52  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Stuart Menefy <stuart.menefy@mathembedded.com>, linux-kernel@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 11 Feb 2019 at 12:23, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 11/02/2019 08:14, Marek Szyprowski wrote:
> > Hi Stuart
> >
> > On 2019-02-10 23:51, Stuart Menefy wrote:
> >> When debugging suspend problems on Exynos 5260, I had a large number
> >> of debugging prints going to the serial port after interrupts
> >> had been disabled but before the timer interrupt was shutdown. This
> >> was long enough for a timer tick to occur, but as interrupts were
> >> disabled the ISR didn't run, and so the interrupt wasn't cleared.
> >> Later when the timer was shutdown the interrupt was left asserted and
> >> so the wfi at the heart of the suspend code didn't wait, causing
> >> the suspend to fail.
> >>
> >> Currently the code which stops the timer when it is on one-shot mode
> >> and the interrupt occurs is in exynos4_mct_tick_clear(), meaning if we
> >> called this from the shutdown code exynos4_mct_tick_stop() could be
> >> called twice. So first restructure the existing code, so the check for
> >> one-shot mode and stopping the timer is moved to the ISR, leaving
> >> exynos4_mct_tick_clear() just clearing the interrupt flag.
> >>
> >> Once this has been done simply call exynos4_mct_tick_clear() from
> >> set_state_shutdown().
> >
> > This also fixes mysterious suspend failures on Odroid XU3/XU4/HC1 :)
> >
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Applied. Shall I add the stable@ tag?

Makes sense - for the second patch, although first is a prerequisite.
It should be backported up to v4.3 (the code differ a lot on older
versions).

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
