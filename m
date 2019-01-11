Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B106C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:57:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB4620872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="osDl1RHr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgSAZmqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB4620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xhkYbePuVrLvS3cyeLn3ss8hRofaeK0cwBdWtdhGJ1w=; b=osDl1RHrTamJTC
	IF3Achz9VY9Qx3cakRfQILNoJG8zYX0hsxINzNzqObn2tzCCiBDQm7wk0GcDSNJCivH8aYxE0Vwvi
	mvT0aNCZN7JmnRdP99EYJUj+u+WWwY6Os+iBOQFq5WYebje8V++ibAOC0ICCVYyod3yS0h2Otjolx
	JWTYBtt0k57wF/llyM4g/cRBFu5G32k5xO7vcMLnushtpAnfBTGpcp3ryKrNHLC2xsQl3qbjIktJx
	5W44w9Xs2MPgPL2kQ4cU1uYSVXiL4q3hMkgasHhJdTJGWBdJiFddYjTdyxK5R3QPE21JqNKSABd42
	4A2EqQL2BAlMzhtRgHNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtYz-0003Fz-HS; Fri, 11 Jan 2019 09:57:17 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtYu-0003FY-My
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:57:15 +0000
Received: by mail-vs1-xe41.google.com with SMTP id v205so8855158vsc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hdxivZjww+kdiSrhuzC1PWn78pP7JY13s0K0FNua8kQ=;
 b=QgSAZmqy+LoU5cca445Mn/9Qjb4V+2eRA4M90GScviuRacw1X5qVNSdDk12BEX48jj
 w97mbncn2bJOmB2FO/HI82hxjJ0sNIYDyqGD98Nu5lXttJNP1HO2MxAwAseEIYcePsWZ
 et/UJL8NdNyjaDaOWruepTft55hi/eDaF38PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hdxivZjww+kdiSrhuzC1PWn78pP7JY13s0K0FNua8kQ=;
 b=RLGfRPzW5NCvbutQsehn4RyKT1htqSsn7aElN2r0uDZ4RhauY4rdhbTXUKcEziGbE2
 UrUBXIU78pQOM4yWcRzuXFVvdvb7hLTn1Gd6Szwthl3AVDOFlQoifSiDF/zHoLMCPCPy
 kF0wfKUOveLZax3poUrYKslKl4ICrGCPHKiODtzH5bGgc3kLsaJfdh2JV7nxPOBbCljS
 If/TUxjOUVt1ORyyd7qGHj6qoxv8LzvMEa6QZdFAmw/u/dkJAb2C8c3HdR0WOYXR9fu4
 DvtPMdyy75iHhNml6bd8UZ4sqfB4afd8aNxvMSBkHHokdI6hTXfWJ2LqkrtpLadsQ4zg
 sPEg==
X-Gm-Message-State: AJcUukdoX9hySWJXbaBK22RJJ/3E8vSAn2T3UYyzqv1TQOgVbFMs+JRW
 Y+DPR6dl/opmGjeWMxMuRvXzND8zo800a6kkhdhs8g==
X-Google-Smtp-Source: ALg8bN7gBLpnCYKzcoKbQM+Py6BQ9g4M4vk28CNSgFNbS2ONxp7bUleFVwMZ1lWpqEpu1bWOJ0Jw1ZB6656JfxVec8M=
X-Received: by 2002:a67:8cc2:: with SMTP id o185mr5575802vsd.55.1547200631444; 
 Fri, 11 Jan 2019 01:57:11 -0800 (PST)
MIME-Version: 1.0
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-4-git-send-email-sumit.garg@linaro.org>
 <20190110142355.bcgw62w2qk2mlzj6@holly.lan>
 <CAFA6WYPzA+rKMq58xVPghSe-mLa6fDi4t=1DYxakEaeG+ayQug@mail.gmail.com>
 <20190111095414.nbnzbocdn32zypdc@holly.lan>
In-Reply-To: <20190111095414.nbnzbocdn32zypdc@holly.lan>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 11 Jan 2019 15:27:00 +0530
Message-ID: <CAFA6WYM7JpE+h+6FC-YmqjyLo-xopeMg=d0BhOLx1C+N-tsZvA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] tee: add supp_nowait flag in tee_context struct
To: Daniel Thompson <daniel.thompson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_015714_573887_BF894329 
X-CRM114-Status: GOOD (  14.39  )
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
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bhupesh Sharma <bhsharma@redhat.com>, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 11 Jan 2019 at 15:24, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jan 11, 2019 at 01:00:49PM +0530, Sumit Garg wrote:
> > On Thu, 10 Jan 2019 at 19:53, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > > > index 9ddb89e..5d6c317 100644
> > > > --- a/drivers/tee/tee_core.c
> > > > +++ b/drivers/tee/tee_core.c
> > > > @@ -105,6 +105,7 @@ static int tee_open(struct inode *inode, struct file *filp)
> > > >       if (IS_ERR(ctx))
> > > >               return PTR_ERR(ctx);
> > > >
> > > > +     ctx->supp_nowait = false;
> > > >       filp->private_data = ctx;
> > > >       return 0;
> > > >  }
> > > > @@ -981,6 +982,7 @@ tee_client_open_context(struct tee_context *start,
> > > >       } while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
> > > >
> > > >       put_device(put_dev);
> > > > +     ctx->supp_nowait = true;
> > >
> > > Why automatically set supp_nowait inside open_context() ?
> > >
> >
> > I think this is the default behaviour (non-blocking request) that any
> > in kernel client would expect. Also this flag could be configured
> > again before call to open_session() if any in kernel client requires
> > different behaviour.
>
> Makes sense. I think this is a deep enough behaviour to warrant proper
> commenting though.
>

Sure, will add comments.

-Sumit

>
> Daniel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
