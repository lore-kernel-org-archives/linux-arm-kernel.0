Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5620BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:31:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276CB21901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FP/r9Kbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276CB21901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IylEFZcVKS1rdwU4J2UCs4GMoxZpnmAWuVsx5qDWk0M=; b=FP/r9KbuzHrfzU
	EXTeQmP1BzpLATX3YE+MKQ5aQdJrDUITw5G8a7X9xyk7BSg5gg70uAAtJb6w/O8L99nCgcWV2mriI
	JgmNsnZdIz+h1mXU5v9fFufKu3JAdUQrbccqHUrKmA+BWt+ryXfYN5VJSzMgMxEGkLpA6RcHeUA/U
	GSmk17pfwHB5ReGdi2PaWsFZEznJIE9Jvlj6/7oCfHXXb2PdgArwF1fq2kJmyR/XF6mGjNAp+L5LB
	GunPz1H+SBgbQ7GfaiLgepOfNg3jnx4KEB4f62NLoOu/Py7pJpVLOeY7MjFGeqRnn2A3vGIsczLJf
	qGu6Qs3v2ZPEA8V37izA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqtC-000876-Th; Wed, 13 Feb 2019 09:31:34 +0000
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqt8-00085B-GS; Wed, 13 Feb 2019 09:31:31 +0000
Received: by mail-lf1-f67.google.com with SMTP id u21so1253032lfu.1;
 Wed, 13 Feb 2019 01:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=c+iFjGEOpJX/4J59kOCjMN5B4RIy1M2e/xU0fsMpcDg=;
 b=ZtAVz2W9wM5O2oI/0nOydHzbEOvgrOJ0QuNQjXEUT5BBgpf3F/n6ytDohN4tyS/G5q
 HI/NkFeSauBBCUez5OloAt4h3YepNoxPk8qaUf1eeofZZ8LflfdZrNmBaFUUjQ3M2X/T
 D7Gk+1V2Ge1VM2zn985/EwmGvhkCUhJGDjBS8v3YP0hp1AtFhizo+eG1MYDJmvegxWxN
 nFW78/YebHrzxN4O95TZlwbNrrGDc4YG3lDm1ZwKXuqGH+AULCvMrWvjm/kuTPZzmPwk
 eVb2kNkXic+LY6asJv0iA5002WEooruHllMtv6dSvvG0jRyZ03etO7pOXxjo0qrvAzIL
 0o3A==
X-Gm-Message-State: AHQUAuZBQ41hnNXQf3WwsEft/4zet5cL8w5X7yeVK+b+SHdRLxhYkFDv
 4wChBSosZAdPXZx85WjNND9KTZxw
X-Google-Smtp-Source: AHgI3IYdDfwOBMB6kntmuxcjS1c3Mj/Iga23L5r99s7UHsstnAmeyLNY/KB0Fe+7KlwsYdOt+2cTWA==
X-Received: by 2002:ac2:53b7:: with SMTP id j23mr5078139lfh.109.1550050288363; 
 Wed, 13 Feb 2019 01:31:28 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
 [85.230.190.116])
 by smtp.gmail.com with ESMTPSA id z2-v6sm3326542ljk.50.2019.02.13.01.31.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 01:31:27 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1gtqsz-0007i1-3y; Wed, 13 Feb 2019 10:31:21 +0100
Date: Wed, 13 Feb 2019 10:31:21 +0100
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190213093121.GG28278@localhost>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
 <20190130155016.GA26536@bogus> <20190211092251.GV4686@localhost>
 <CAL_JsqJPhuDDsEMvpVizewTuehOZTc84d+8Hq7o8C+O4UrBjYw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqJPhuDDsEMvpVizewTuehOZTc84d+8Hq7o8C+O4UrBjYw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_013130_542309_3869BA36 
X-CRM114-Status: GOOD (  18.80  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 Johan Hovold <johan@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 linux-amlogic@lists.infradead.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 03:18:46PM -0600, Rob Herring wrote:
> On Mon, Feb 11, 2019 at 3:23 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Wed, Jan 30, 2019 at 09:50:16AM -0600, Rob Herring wrote:
> > > On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
> > > > Add binding for Mediatek-based GNSS receivers.
> > > >
> > > > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

> > > > +- gtop,fix-gpios   : GPIO used to determine device position fix state
> > > > +                     (pin name: FIX, 3D_FIX)
> >
> > I'm thinking we might need a standard name for fix-gpios as well. This
> > isn't a feature that is globaltop (or mediatek) specific, and other
> > manufacturers provide similar functionality through pins named UI_FIX,
> > or even LCKIND (lock indicator).
> >
> > The pin is typically used to drive an indicator LED AFAIU, but the
> > characteristics of the signal varies from device to device (fw to fw),
> > for example, pulse when no lock and low otherwise, or pulse when a 2d or
> > 3d-fix is acquired, etc.
> >
> > I'm not sure how useful the pulsing would be for software, but someone
> > might find a use for it in some form.
> >
> > Rob, is this something we want to keep in the binding, and if so, how
> > about using a generic name such as "gnss-fix-gpios"?
> 
> Sure. As long as details like being a pulse and when the pulse occurs
> are implied by compatible string. So we don't get an endless addition
> of properties to describe those.

Agreed, thanks.

Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
