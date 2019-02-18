Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1436EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:17:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D140920855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X8yIuPky";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVihKabK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D140920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J34n/hlB1SWCxI2C9o7ULJYpHq8r2nxSWzQhuFSFtDk=; b=X8yIuPkyAhSNVM
	EExV28XDf0xUl/lhuLCFJn/D1ncxPlsrroQp4ej+uwKn9T4RhY2XKkumTf6KOYGI+GYVvzaVoSWiu
	QKg87DjSuXkDMHA5lpsTlWh6mlP48fENM30lYJuFzVVe42f/fJIyPYFKrSx0T6sq0Efvop4CZYA7C
	HYeE2lCMxpaOKYsPSdtMFJ0D1zYcwSuICsoNwdLEdxSrFvVASumhJULiAohKPaFifTPFSNvyvTigg
	jvqKF4lp/IYioIFVo0VxmkCt7nB2i7FUuR21o4ZaVpmCZg4+G5REv+TSqj7fXFT+fPV9CLlhwkSIg
	CzZK+l/NboMQt+nzeYqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvXYJ-0004oW-9G; Mon, 18 Feb 2019 01:16:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvXYF-0004o2-S5
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 01:16:57 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5E3CC20855;
 Mon, 18 Feb 2019 01:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550452613;
 bh=PizUtOXMPqSIkUGQuJtZV9wsWV9xdqHr2hu6rEoAArE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TVihKabKDazPmwHMLKfjM4W71tyjDIW+EwP4DD/duLEpAnePFAo3wSc8vt7ek/61s
 sVKNFNjzeJGgvEbwJr3ZVytYWTj1q3/EdomoOBJoicY4KWNgJf35rhfa2USMukwnHj
 Gm9m7BCSTdRBsJmtBHL31LrH+r84jqY2U6Bh+feE=
Date: Mon, 18 Feb 2019 09:16:26 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 3/7] i.MX DT bindings update for 5.1
Message-ID: <20190218011624.GA6262@dragon>
References: <20190212112126.572-1-shawnguo@kernel.org>
 <20190212112126.572-3-shawnguo@kernel.org>
 <CAK8P3a1jj21UDq92L-gW0DeXZwyz55Ui8jdTpbi-K7Jy4mpO4w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a1jj21UDq92L-gW0DeXZwyz55Ui8jdTpbi-K7Jy4mpO4w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_171655_927300_7962C3F5 
X-CRM114-Status: GOOD (  14.16  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 04:08:41PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 12, 2019 at 12:21 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > Hi Arnd, Olof,
> >
> > In the past, I was simply using imx/dt branch to collect i.MX platform
> > related DT bindings changes, together with arm32 dts ones.  Now with the
> > move to json-schema, we are using a single fsl.yaml file to accommodate
> > both arm32 and arm64 platform bindings, while we have separate branches
> > for dts changes - imx/dt and imx/dt64.  To avoid conflicts, I chose to
> > create a new branch imx/bindings for i.MX platform bindings change for
> > this cycle.  That's why we get this pull request, which you will pull
> > into arm-soc next/dt branch, I guess.
> >
> > For future cycles, I would like to hear your thoughts on if we can use
> > a single branch for both arm32 and arm64 dts changes, so that the
> > bindings changes can go in there too.  Thanks.
> 
> I'd say you could combine them if you have only a couple of changesets
> in total, but given the current size of the branches, I prefer having three
> or even more separate branches for the DT changes.

Got it.  Thanks for the comment, Arnd.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
