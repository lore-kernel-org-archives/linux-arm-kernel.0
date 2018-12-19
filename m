Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA01DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:35:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FA120873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QucDJuYi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up8owSfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FA120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uCZNZMEl8NjCER2UWHhISJkX3yyfxHZ3rnVotf3EJkI=; b=QucDJuYi1KLmm8
	AxRGHsZAkS3CbrCQP9PkD6Gely/rqmKbJxPyGPCd6M2q74U54eg3boepQFwEDtqKgnLVaSPziswE4
	G+lE0hR7vrA5Y79ANGWKIFS03wXR5UP6UTIXksCOm9rg57FQ3rwd/eIenCOZc+8IOy2mG9lAVXzue
	52runiILapvvMh3uQkWStMWrRd5fY2LzKeeUQMA8EQ1+XSw1800Tp+sTMWJWo2Y+BSZW0e7Qmk5e1
	kuMgzIp0byFByy39t6OFxl0YzSkva95g56skDmf/OIPwfNs+HmW8ZBegU456DLrko3Nx8Oi7sb+fZ
	dNC3hU+11S5tjA1B/55A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZkQb-0006lb-6E; Wed, 19 Dec 2018 22:34:57 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZkQX-0006l1-UC
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 22:34:55 +0000
Received: by mail-ed1-x542.google.com with SMTP id b3so79841ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 14:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jKP2px27KTzzQrWhR+f/O0lmfHo7sDHuQhoWWp6cUhU=;
 b=Up8owSfoD5Ge7R2dE2jQHEALphgGJGPboAZrSiWAi3QkQPRcuEQJjZWIHEKYzmCC+t
 2NMcOApwPCUVHrAfP08h4ZDze2hKsZ3XDI3tGK3dhbu005nfXXFkIFQxn2BxsVBTV40o
 +3jke85unc3vD1PAEErvdIsI08umwNH2rE1pXZl7qu05vGmT7OPavkzkfIJDStHsPEyP
 zF9xOSz5BnXfVfai8hpmR5pjcoMPQc4cC66JtoS35Af/tzMCA7TVTOTXhJscHr8RC162
 tZnqQTun7gURVJIFW14PZonCBFGNQrVi797qsUh2FgwlZljx0RqtXSOLrLAY+I1upBTe
 ixFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jKP2px27KTzzQrWhR+f/O0lmfHo7sDHuQhoWWp6cUhU=;
 b=BAvXkOzUBfcojAv4EVMu9eLZji1xmHAj5RP+lfjyTdhdc8EOcyb2SfyPqN93Z/sN5e
 2EQ2DVbBh0APuTd561XxS8NLwG5IJ1gwC7tepMpuRheTg+x+i9eD9cKURZV8m1oiQYN6
 ooOm+yMxs0yAuqhVbMFud/kLSFWL8hc4J7is2gSKql7Rzw4RAbHb1QGke8JQ0fFvl0go
 ChLUhaPPCrGjQ3kCii5h2n8183iE8cpNEsB2SWGHkL84UVureQI+wfcCCXP40LNmiZPS
 EZ6/OzLOcbUvULEBpXR94M0WdSRYGFmddTYx/ntHX69QThYnDvXAWDLEIpU3zxu0p5WZ
 taLQ==
X-Gm-Message-State: AA+aEWZR1ViAnGRG9EremRIJ7FRujLDQQ3YseMRIqcSzo7qkp5fa3mNa
 MKBayIJ2KluseAILGyj5yksEOkjuXzn7P/Z9Cwk=
X-Google-Smtp-Source: AFSGD/XGOnQfbRbGeM8vgvUVuhlrlt9Sjthb/Vu2DvwMh/+geTxKGMKLuqGhmAf87aTz+OdEOSTN7s/XAyWcvlJV8bk=
X-Received: by 2002:a17:906:753:: with SMTP id
 z19-v6mr17450015ejb.175.1545258882014; 
 Wed, 19 Dec 2018 14:34:42 -0800 (PST)
MIME-Version: 1.0
References: <1545232888-9302-1-git-send-email-aisheng.dong@nxp.com>
 <1545232888-9302-5-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5DzMpMp-Tf74iM3SuHoFpji8z-dxM-UsC13GeDx2bZYgA@mail.gmail.com>
In-Reply-To: <CAOMZO5DzMpMp-Tf74iM3SuHoFpji8z-dxM-UsC13GeDx2bZYgA@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 20 Dec 2018 00:34:30 +0200
Message-ID: <CAEnQRZDiUcV5svjmQ=ofUsxy5y+YBgOwgbca+ExkvHv9AzJSEQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: imx8qxp: make the name of clock ID generic
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_143453_969580_F74B1E0A 
X-CRM114-Status: GOOD (  16.89  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 7:08 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Aisheng,
>
> On Wed, Dec 19, 2018 at 1:29 PM Aisheng Dong <aisheng.dong@nxp.com> wrote:
> >
> > SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
> > Let's make the name of clock ID generic to allow other SoCs to reuse
> > the common part.
> >
> > This patch only changes the clock id name and file name, so no
> > functional change.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx8qxp-lpcg.c        | 146 +++++++--------
> >  drivers/clk/imx/clk-imx8qxp.c             | 152 ++++++++--------
> >  include/dt-bindings/clock/imx8-clock.h    | 289 ++++++++++++++++++++++++++++++
> >  include/dt-bindings/clock/imx8qxp-clock.h | 289 ------------------------------
> >  4 files changed, 438 insertions(+), 438 deletions(-)
>
> This seems like unneeded churn. Just keep the existing naming and
> other SoCs can reuse it without problem.

Thanks for review Fabio.

I get your point with churn and touching git file history. Anyhow, I feel that
the code is more clear this way.

Anyhow, it is not me to decide.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
