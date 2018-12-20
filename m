Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08CAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:38:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DF4218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WtGKg8WO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCtp2BDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DF4218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bIABnIGK0XtxP7HucYLh8DDBgf0jhBrqQ4WRwlIpvpk=; b=WtGKg8WOOEl855
	4FxUPInG3ULUMXwKD3g2+zFIDk2pPWMa0WJYu8PkJE05QkSIvqQgs0fqK5x1P8vxUAeg0EWbq1KqZ
	y5aj5suEzyKPWpbrpU/DKkuGqLDCHSE/CCzsVlMaqhl+ZnQeZ7s6jKHv9177ck+RKzit/ecTucPuy
	peeSns6wwnw0IxL9qK8+lFyN8OQYSLnHo6fnGL2uow2ZE9onrP0KRGTFAqwtrX8ThUwsxWQP8cMhH
	IzQBSdiVSdZoPfuEQB+zB/SF4969pWL5LbDt+UmDQ3KwvKddQuxdnu2Ym/VfiO+ZuAgUFsL4sGgNA
	WOi8FzXp61LNKexLSaXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga61Z-0000St-Md; Thu, 20 Dec 2018 21:38:33 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga61W-0000Is-7x
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 21:38:31 +0000
Received: by mail-vs1-xe44.google.com with SMTP id g68so2008261vsd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hd1zjWHHpgD0qROv72UJYyj+0NjjOMgAjMEV9h/x22g=;
 b=jCtp2BDRUY2R3uheIzg4N7kRzaBByo93WohqCnuRnGazMNVAoEanS0NTcZQwnwMdPC
 G/9KMVmeZCIoOgWkZ+WydvJNC2bDXriMpkVWZ4QicCLiCR+wjLWacMj3Hogj0UQ6QxAW
 CRZzpvmQ6O3B3CCk9OmKydJWvqYoWPFMty+TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hd1zjWHHpgD0qROv72UJYyj+0NjjOMgAjMEV9h/x22g=;
 b=Grf4LCzB/3+l0skvc4sAzRZt+R5OAl3cX+s7AlACPMchpcq7AS1Il+1kZqtk4tWSEw
 wBpbq99ehSaP8Pl5uxRPhUe5TjV4o1heImF/iDdc4jq1dfKUY5yxac7Cl1e4gaihDhKt
 I74bXOLIvGjE05+kHNNquBwdCKCYSE1YNx70/CagRt0DqHHFrSQtascuu85L523Ot2C1
 +craoLFSZluGqAXkZQI0w5Fg6tfHDEoFaPH1FNUvMpF2cCuhMovcL9ruVz6fg1nrdDJL
 qVb5uoAvJQ4p6vLBtznzNj2Ol9zrQ+qckgVn9eM5jgT5eZJ2L0V3Y82lJHdQIepn7+pv
 r/rQ==
X-Gm-Message-State: AA+aEWb+MqMYNL1n9QOo/HgDC+9ixNoiLMrglUIco6EE77LEb9rHF/pV
 LWCOjZJDmxbz7YY8xdSqI+OXpTXgYPBEOpoinWLJ2g==
X-Google-Smtp-Source: AFSGD/Xl0U7e1C23eyYbgTfrCIamlXLYgoLV92380Pg21ZCoVrY6/dmKMqSjrYRckNmY6he2GQRFRNrAKrSY/2JXK3c=
X-Received: by 2002:a67:1a84:: with SMTP id
 a126mr12967616vsa.165.1545341899053; 
 Thu, 20 Dec 2018 13:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org>
 <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
 <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com>
 <c5587b35-734c-5c1d-a433-ce78c8583ef1@linaro.org>
In-Reply-To: <c5587b35-734c-5c1d-a433-ce78c8583ef1@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Dec 2018 22:37:43 +0100
Message-ID: <CAPDyKFqdeSm56hVB+9dwJekNhZU10DE+-WaWa4m=wdUmjAdAdw@mail.gmail.com>
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM
 domains
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_133830_310026_08906D19 
X-CRM114-Status: GOOD (  18.46  )
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
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 20 Dec 2018 at 19:06, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 20/12/2018 16:49, Ulf Hansson wrote:
>
> [ ... ]
>
> >>> +#ifdef CONFIG_CPU_IDLE
> >>
> >> It would be nicer if you can remove the CONFIG_CPU_IDLE by replacing it
> >> with a specific one (eg. CONFIG_PSCI_IDLE) and make it depend on
> >> CONFIG_CPU_IDLE, so the config options stay contained in their
> >> respective subsystems directory.
> >
> > I am all for simplifying the Kconfig options in here, as indeed it's
> > rather messy. However, I would rather avoid folding in additional
> > cleanup changes to this series, is already extensive enough.
> >
> > Would you be okay if we deal with that on top?
>
> IMO, there are patches in this series which can be grouped into a
> cleanup + set the scene patchset and merged immediately. An option
> similar to ARM_SCMI_POWER_DOMAIN can be part of it.

I certainly agree to that. The tricky is, to know what pieces people
are happy with to go in. :-)

Earlier, in v9 I tried your suggested approach (kind of), but then
Lorenzo stated that it's kind of all or nothing. Maybe we can bring up
that discussion again with him and see what we can figure out.

>
> However, if you swear you will do the change after and sign with your
> blood, I'm fine with that 0:)
>

Whatever it takes!

Anyway, as stated, the reason why I want to tackle that on top, is
that I don't want to make the series more extensive than it already
is.

Agree?

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
