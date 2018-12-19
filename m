Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848E6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:16:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E02421871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aTkzIisA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="crsfA7Ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E02421871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Eh5Y28RzvjtDIM+IwbMvGnIhAE6RsxH6U3cPQ6BayGc=; b=aTkzIisAll6wHa
	/cfP8fyI+MPi69Bqw9udtb6D5aMsy1J5TNok/g1A7hXKVGaB+CVGu5DCPW//LY/jAL+iB4YsUBEUw
	QkmPopzr8rHXfNKSdfGvvWVLJ8j4hxmLVtzisozqAz+XC6bYnCJrNkz8hlWUmSORxHg/x1/BzPAsX
	D6Qdc62v0S+h+Vs3iBk3iN1EOFnuzcusABuVPiUstX7QeX2hnKHSdb5XFW4t86XsZDDncOPePxk1b
	ildSu6yoc62xeC8Qwr8k8UtIxyKl0vryvf58BT/PT4B3PcKeZfAY26TRJZgNeKKv7xdmW1NQ9RrEe
	GwrXOOPO7HXn4CzQh96g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZTHc-0002ZR-3P; Wed, 19 Dec 2018 04:16:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZTHV-0002YI-OC
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 04:16:27 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B239321871;
 Wed, 19 Dec 2018 04:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545192975;
 bh=R0kapBUVEXDskMBHCfvV47sJMxZ3TQFwmCs9rS2TfOg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=crsfA7Ev7Kik8HnxjEinl9OYR85UbVb6kMQsTYOGDNP8sle2vuGVeSCmJTy6q/x/N
 pNhUv1BpMmDFNQZt/gtkCfOxqQeWZZHcAZGtJVqfXnOK/sA1g9uE7+X/NCvQUTl4QH
 wpOvPRez4LkRLzskOjbQR9TBh5HbGJiCqlt+zJ7E=
Date: Wed, 19 Dec 2018 12:15:04 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] MAINTAINERS: add all files matching "imx" and "mxs" to
 the IMX entry
Message-ID: <20181219041502.GB13728@dragon>
References: <20181122075742.31966-1-u.kleine-koenig@pengutronix.de>
 <20181122081704.pk6oqw664ewpkenm@pengutronix.de>
 <20181122083558.utya62w3hlcyukdw@pengutronix.de>
 <20181212090213.muqk53yr73h7qcup@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212090213.muqk53yr73h7qcup@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_201625_809329_0090F1EB 
X-CRM114-Status: GOOD (  13.63  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 10:02:13AM +0100, Uwe Kleine-K=F6nig wrote:
...
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index b755a89fa325..cb9cbaa1ba19 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -1517,15 +1517,8 @@ R:	NXP Linux Team <linux-imx@nxp.com>
> > > >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscri=
bers)
> > > >  S:	Maintained
> > > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linu=
x.git
> > > > -F:	arch/arm/mach-imx/
> > > > -F:	arch/arm/mach-mxs/
> > > > -F:	arch/arm/boot/dts/imx*
> > > > -F:	arch/arm/configs/imx*_defconfig
> > > > -F:	drivers/clk/imx/
> > > > -F:	drivers/firmware/imx/
> > > > -F:	drivers/soc/imx/
> > > > -F:	include/linux/firmware/imx/
> > > > -F:	include/soc/imx/
> > > > +N:	imx
> > > > +N:	mxs
> > > =

> > > This probably also matches drivers/media/i2c/*imx*, no?
> > =

> > Right, I didn't identify these as Sony stuff. Maybe NXP could sue them
> > to rename their products? :-)
> > =

> > So we need instead of
> > =

> > 	N: imx
> > =

> > better:
> > =

> > 	N: (?<!drivers/media/i2c/)imx
> > =

> > Or we add X: drivers/media/i2c/ ?
> =

> I didn't receive any feedback from you. Are you positive in general to
> let the IMX entry match all relevant drivers?

Yes.

> If yes, I'd respin this
> patch, probably using the more conservative "X: drivers/media/i2c"
> approach in stead of the negative look-behind trick.

We have some conflicting changes queued for merge window, so you may
want to rebase on 4.21-rc1.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
