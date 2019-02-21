Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B76C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:43:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD6420855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a3Eox7la";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWTLE8h/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD6420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mqp+LPiCrdxWf7SEydMAekwD39WusrLqQvmG/VG/R4w=; b=a3Eox7laAxeLsw
	djxJmmrJ6Ef1I7+IiJg+C3aA6aps+tX55Y8Nqd/M0wShTCw3BiZPCU0rhljhZE2ou1lbHcZZZMJUu
	+o5OmWgBgzMoS+26xIOxos4pJ289Mlvueq2JMkclk86IntkvhK4CXqA72isJn2FSq8Z4PpoEeP8tt
	FWIQDUat3yc93BIoFs7qmY4RCo2pQvq8bhMr9oAcXcN9LGhWP6oUuhAKgLX+bC27XXHO3AWuaum3N
	vOmk4AfirCKNLxS8Tgjyukqd5M79HAM9WIN94BjXYzZ2R/DTacPQ1N4DG/XUQ8PhnQSS+6LNZdV56
	pS4NeXVI+DZMF7900CHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmlX-0000wy-23; Thu, 21 Feb 2019 11:43:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmlU-0000wd-B3
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 11:43:45 +0000
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 64CB321841
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550749423;
 bh=uxodDM8DcIH3DFJRf934Ta55iD7dtEytKxV92UjmqeI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mWTLE8h/Lv6/fQgKksVECU0Esfe1cnrxar+Gpek8lGgTSmKdyrY+VCf1W58l2Bm2i
 b3Oke1FdCzh9MU7Z703X0PuIpHVogTMCjhGq47J2ULY5BjqymLAvNKg8LW9Vu5KQ9s
 hTLD6PasBETPnup5ZcQwIbLFVtqbWl0oWDrKPK6E=
Received: by mail-lj1-f180.google.com with SMTP id j13-v6so23751838ljc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 03:43:43 -0800 (PST)
X-Gm-Message-State: AHQUAuY1VxOSSgd5JdfefzvE2EY4rkToiogr2Xp5p1w4qKD03OQJPTPq
 T1rY9/kBRqccY+zlhrabAitS0NmIYxyCIAp3Vw8=
X-Google-Smtp-Source: AHgI3IZNZsanInxkXFUrNJne8zWhKWZSRpL4jzRErZ+/B+6LAWL7rvdLBlsvjSdwbsFS7QIgo54g0gcKMPfX700vRDQ=
X-Received: by 2002:a2e:3c10:: with SMTP id j16mr1213830lja.113.1550749421489; 
 Thu, 21 Feb 2019 03:43:41 -0800 (PST)
MIME-Version: 1.0
References: <1550484960-2392-1-git-send-email-krzk@kernel.org>
 <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
 <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com>
 <155070010208.77512.17397936280518534534@swboyd.mtv.corp.google.com>
In-Reply-To: <155070010208.77512.17397936280518534534@swboyd.mtv.corp.google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 21 Feb 2019 12:43:29 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc=mKrNuw65qf=vPtRD7b7=5FZWdNcncvwhpDN+tqp0Bw@mail.gmail.com>
Message-ID: <CAJKOXPc=mKrNuw65qf=vPtRD7b7=5FZWdNcncvwhpDN+tqp0Bw@mail.gmail.com>
Subject: Re: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on
 setting driver_override
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_034344_419931_A7EA85D7 
X-CRM114-Status: GOOD (  22.89  )
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
Cc: David Brown <david.brown@linaro.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Russell King <linux@armlinux.org.uk>, linux-spi <linux-spi@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-msm@vger.kernel.org,
 Andy Gross <andy.gross@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Tomasz Figa <tomasz.figa@gmail.com>, linux-clk <linux-clk@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 20 Feb 2019 at 23:01, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Krzysztof Kozlowski (2019-02-18 03:14:29)
> > On Mon, 18 Feb 2019 at 11:40, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Krzysztof,
> > >
> > > On Mon, Feb 18, 2019 at 11:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > The problem
> > > > ===========
> > > > Several device types (platform, amba, spi etc.) provide a driver_override
> > > > field.  On sysfs store or during device removal, they kfree() the
> > > > existing value.
> > > >
> > > > However the users are unaware of this and set the driver_override like:
> > > >
> > > >         pdev->driver_override = "exynos5-subcmu";
> > > >
> > > > which obviously leads to error.
> > >
> > > IMHO driver_override is not meant to be set by a driver, only from userspace,
> > > for binding the device to vfio (is there another use case?).
> > >
> > > >   clk: samsung: exynos5: Fix kfree() of const memory on setting
> > > >     driver_override
> > > >   slimbus: ngd: Fix kfree() of const memory on setting driver_override
> > >
> > > I see all users set override immediately after allocating a platform device.
> > > Can't they just allocate a platform device using the override name instead?
> > > What am I missing?
> >
> > For the clk-exynos5-subcmu.c case, driver registers several
> > sub-devices. Each sub-devices is a clock controller associated with
> > power domain. I guess the author wanted to have meaningful names of
> > these sub-devices (DISP, CAM etc. like names of power domains),
> > instead of just exynos5-subcmu.1, exynos5-subcmu.2 ...
> >
> > If driver_override should not be used for such case, then I could
> > replace it with what you said.
>
> Looking at the introduction of the code into the platform bus makes it
> sound like it was all for vfio devices. If the clk driver doesn't need
> it for that purpose and can get by with more generic names then it seems
> best to avoid using it entirely. So can you do that and resend the first
> patch in this series too? Effectively splitting the clk parts from the
> larger issue of kfree()ing of const memory.

Sure, let me send just the clk parts.

BR,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
