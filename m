Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAD8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:12:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D162175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SKtJiKJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D162175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4siaRp+O2dvp0Vvw0BydfE2vRhHBr9zewf0Ipf8kzDg=; b=SKtJiKJpu+mbwc
	TU746y7JtK/tNPEOB7Oj6/em3BbbG2a+dDxO4nDQ8Q8b4tjJfpe7V/x8URj+PULI6bXh3Rf3WZl2u
	sKRk9AOFHrUHjMJePPDxp2+/h5cuGOYf7ggZ18z+0VAefjoCgRLd8i9qrJfre4Pg4WzBA8bDBJxLc
	nnDirxZUC2owi+H0Y9hdEtFlwgnvQVOIszUjDE5QV4cF2Y7WtrH8VMLTVBdxm17aypk8aODjstYZE
	vFEBtrSegQ8tMvOpU+l8icIsr2EKy+HPBw7dv0Zw3F+ElgoG15BOeIl4qjlnwStqnp6crz4WzBKpV
	UTmWNDMkKaDS3VPiFimA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWvW-0005BE-VZ; Tue, 29 Jan 2019 17:11:58 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWvT-0005Ap-AC
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:11:57 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 0AD1C8140;
 Tue, 29 Jan 2019 17:12:02 +0000 (UTC)
Date: Tue, 29 Jan 2019 09:11:51 -0800
From: Tony Lindgren <tony@atomide.com>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129171151.GC5720@atomide.com>
References: <20190129164813.GA5720@atomide.com>
 <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_091155_394217_5CCFCDFA 
X-CRM114-Status: GOOD (  15.08  )
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

* Doug Anderson <dianders@chromium.org> [190129 17:05]:
> Hi,
> 
> On Tue, Jan 29, 2019 at 8:48 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi,
> >
> > Looks like commit 5451781dadf8 ("regulator: core: Only count load for
> > enabled consumers") started showing new warnings with v5.0-rc cycle:
> >
> > regulator-dummy: Underflow of regulator enable count
> >
> > I'm seeing this at least with my pwm-vibra test case:
> >
> > # rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
> > pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulator
> > input: pwm-vibrator as /devices/platform/vibrator/input/input4
> > regulator-dummy: Underflow of regulator enable count
> > Upload rumble effect... id=0
> > regulator-dummy: Underflow of regulator enable count
> >
> > Are these bogus warnings for dummy regulator or do we have
> > real unpaired regulator calls or somewhere?
> 
> My first guess is that there's a real unpaired regulator call somewhere.
> 
> I actually meant to include this in the commit message, but I'm an
> idiot and I used "--" to break up the parts of the commit message
> which confused git when Mark applied it.  Sigh.  For the full commit
> message, see:
> 
> https://lkml.kernel.org/r/20181120175255.227783-1-dianders@chromium.org

Oh I see, thanks for the link :)

> In that message I said:
> 
> > - We can (and will) spit errors out for code that used to be invalid
> >   but was never caught before.  Specifically if someone leaves a
> >   regulator enabled and calls regulator_put() we'll yell.  We'll also
> >   yell if a single consumer calls more disables than enables.
> 
> Looking quickly at 'pwm-vibra.c' it wouldn't surprise me at all if you
> call regulator_disable() more times than regulator_enable().  If
> that's true it should be fixed.

OK. Let's see if Sebastian spots where pwm_vibrator_start()
and pwm_vibrator_stop() might get called multiple times
or something similar.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
