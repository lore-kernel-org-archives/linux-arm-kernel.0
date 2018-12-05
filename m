Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F20EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF0E2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CksNl1OD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDHhg2QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF0E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kxa1Y0piWIks0DlNgsjmBS8fm6IdJT4n8UGGAYj8Nro=; b=CksNl1ODu9CEP8
	wT0pm+a1CRpsktjOlyGVbOFUz3BbwJikV9KZiKdp1r3gd4N8tF4UWG88GoWuFsa6B02wk15bjCWPV
	hQlySX6cPm9FCEJ4W6rvjtoRqkDIoipuktbRvu6gqEuo34hLJsXI0p+vrH5mBXCEerRRjvbJsfufG
	UyFwLFnGfmo6IaNoNQTQOU4Vm3hog/5fOB5m5+BJHZf7hBPofHhXIlKDZ8T5x/XpSRS7Sq+HxR3Nl
	k9WBK4KuSSBhmiiwDy5KxZNFEl1+7zqXTuEzPyeosxZcztyurPkhERGe4uP+GFEtg065UW1o7iKH5
	rxJQTyZpJxsno1S45gyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUOWh-0006sz-Gh; Wed, 05 Dec 2018 04:11:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUOWe-0006sW-Nk
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 04:11:06 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 955512081C;
 Wed,  5 Dec 2018 04:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543983053;
 bh=z0KwHo+j10fXkhc1DELP+e8m8XQbNAvOZoxoDHV2x9g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rDHhg2QYzWXiIRLx6tqpVofsYUpPvRrHAZC+nOs49mtEcCx8MtT3qygFqdvlBQghw
 35WrS03XmLVs2S47yhKMT8aZmJHbW/2gCa72odsXE7pjdq4/1i8ufRJiNwU4UmMn8K
 OyVcJlfSyBc/KxdWtVYuf3E8M23GuMh+QgPwK+3w=
Date: Wed, 5 Dec 2018 12:10:15 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-nitrogen7: Fix the description of the
 Wifi clock
Message-ID: <20181205041014.GL3987@dragon>
References: <1543542470-4813-1-git-send-email-festevam@gmail.com>
 <CAAMH-ysdpxBpGLpqNo9vhoMtkvtJsu440dRw2HvGfvwYW=36Rg@mail.gmail.com>
 <CAOMZO5DEboD6myFuMUCRgFLsgdFAz+9SwK874SsqbmwcQnQaFg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMZO5DEboD6myFuMUCRgFLsgdFAz+9SwK874SsqbmwcQnQaFg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_201104_889994_6ABC2D5E 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: Gary Bisson <gary.bisson@boundarydevices.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 02, 2018 at 06:42:08PM -0200, Fabio Estevam wrote:
> Hi Gary,
> 
> On Sun, Dec 2, 2018 at 5:09 PM Gary Bisson
> <gary.bisson@boundarydevices.com> wrote:
> 
> > Actually the whole regulator should be changed into a pwrseq as it is
> > really a WL_EN signal.
> 
> Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt only lists
> a 'reset-gpios' entry, so it seems this should stays as regulator.
> 
> > > +
> > > +       usdhc2_pwrseq: usdhc2_pwrseq {
> > > +               compatible = "mmc-pwrseq-simple";
> > > +               clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
> > > +               clock-names = "slow";
> >
> > Shouldn't the name be "ext_clock"?
> 
> Yes, you are correct.
> 
> If you agree that we should keep the regulator as is, then I can send a v2.

Okay, dropped RFC patch and waiting for new version.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
