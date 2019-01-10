Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05430C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:50:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45C620685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UVQ/F0l7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7OrjCFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45C620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/+opZ/ueX9z2R8Ksjg3iKwYz8bzxjR2aBxFBoqBZeEQ=; b=UVQ/F0l77L6/xu
	4NRgEKip1L1rbxFoeVR1GrOyGecCq9qyBhCSGpyBoIV8YcPNBcNbiaUVpxnmLMSZny8xUiK4oBRKJ
	I7M/g2TBDTPREWaiNh2YuiAXUvPMIIv4hfOI3K7USXieZFxQcDCY9TDEu5DKk48Ag+TTw0rrYMX4l
	0NfVOjQn1VMWrYmeCry7WsAigHt1tnA/63LtBOGlxhM23IOXdNuR9IHIKwVKFtUUKsHOQSqpMqggb
	19OBCKaJjDHfQkmn7z7T0QqJ4W2RuzFUBZERJi+P85ZHQ/fLcvinTyYk390eDnVoEA7lemDR/B1N3
	bXMSq81Iv5P+tiCiIq8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghV6k-0002sc-CL; Thu, 10 Jan 2019 07:50:30 +0000
Received: from mail-it1-x136.google.com ([2607:f8b0:4864:20::136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghV6h-0002rq-AG
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:50:28 +0000
Received: by mail-it1-x136.google.com with SMTP id g85so15949132ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 23:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=INsuntaXfrMFs/lZatoLWmlxRSavmXUczoK2TVglobY=;
 b=E7OrjCFEJq8T8axZB71vgTBwGx0iXgPBDIbVSDnOEicYpGCoHnRxB2GkQlHfgmAgTf
 Bf3SME3JPZiSPVMtnzCHUCFFuBYDep6oVLjBfFEnLcTQPKG0JUlqc66nyleBmkoeHfBF
 h9GztOacO/FKr35cLTQyEZwv0zbGafTDRnjJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=INsuntaXfrMFs/lZatoLWmlxRSavmXUczoK2TVglobY=;
 b=llG7VxRlTWKm8tZWGoesaucxT4RkVOy9YzEnoP64WOJaCneAzvlfjPMfA1ezWPbcR+
 RnVDOS7Aa6yQDlueX08yWmz+GAIt5f1mVV+BKA0eo/qZt+oHHt/UX/iqNY/pkaQdVz48
 V521+hWZVU//T8fBDVBd1d9bjqspn4EI5B2/WvKniicGLk+QZvLt2dfTUXAHRiitpIib
 ysugJFfQpzy7m57qRTb7a8GLxDEl7xj+nr5smjd/ima0osOPJQ1kwHCt4RUym3FFOni3
 uFXzV5OgaosWEHBmg1Icp38z67Ns/wyMOz4mXIIyV0yARIq3gbmo74AfJNAbLJtAeqzP
 LOvA==
X-Gm-Message-State: AJcUukevcjYUBUtcvamAbOEUIw9PW+MxRyPbjI/8+VxbJHDXXpzFkxWq
 XGYdJzHg5W9erV2HtcJUDlARB9p5h8rrDiNUmAYsvA==
X-Google-Smtp-Source: ALg8bN4TcGwpGoI5T7NASo4ym68M5QmJe5bQFZZ+whlwbCspbnHFBlpTJ/9YnPxnoJyriFVS23hu4/KDApVQp0zfYC8=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr6582694itf.14.1547106625983; 
 Wed, 09 Jan 2019 23:50:25 -0800 (PST)
MIME-Version: 1.0
References: <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
 <20190109115824.GA1353@lenoch>
 <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
 <20190109133337.GA13579@lenoch>
 <CAKfTPtAsENRKh_wTFXCLW2_MdMBug+tV2KtjC7x6RigN7hgPmw@mail.gmail.com>
 <20190109160736.GA7416@lenoch>
 <CAKfTPtBnNA6knrsHsZXeaotBSn5mS12xNWNUKdSwZ1EUvueQkA@mail.gmail.com>
 <20190109172623.GB1711@lenoch>
 <CAKfTPtBGh+ShbNCZLiYr4PZJooun7uctuQaomc40czvAk5Yizg@mail.gmail.com>
 <CAJZ5v0jPJYyszAs4qJhqX+5RGwzJoo=+reTS__buoCrfTeYY8Q@mail.gmail.com>
 <20190110074558.GA26167@lenoch>
In-Reply-To: <20190110074558.GA26167@lenoch>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 10 Jan 2019 08:50:14 +0100
Message-ID: <CAKfTPtA53BS0MTW7SaiC7B+KsGmWCiUJW+PzT57CUN5YpGN5vA@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To: Ladislav Michl <ladis@linux-mips.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_235027_360731_5434FC41 
X-CRM114-Status: GOOD (  18.60  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 at 08:46, Ladislav Michl <ladis@linux-mips.org> wrote:
>
> On Wed, Jan 09, 2019 at 11:06:34PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 9, 2019 at 7:05 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 9 Jan 2019 at 18:26, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > >
> > > > On Wed, Jan 09, 2019 at 05:32:31PM +0100, Vincent Guittot wrote:
> > > > > On Wed, 9 Jan 2019 at 17:07, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > > >
> > > > > > On Wed, Jan 09, 2019 at 03:12:25PM +0100, Vincent Guittot wrote:
> > > > > > > Please keep all thread list when replying :-)
> > > > > >
> > > > > > Ahh, sorry for that...
> > > > > > [snip]
> > > > > > > On Wed, 9 Jan 2019 at 14:33, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > > > > > I agree, but it doea all the magic correctly, so you won't need
> > > > > > > > to touch that code is ktime_t changes (I know, unlikely..)
> > > > > > >
> > > > > > > But the current implementation doesn't care of any changes in ktime_t
> > > > > > > as it uses raw ns
> > > > > >
> > > > > > Fair enough, so let's go back to:
> > > > >
> > > > > This one looks good for me
> > > >
> > > > Lets split is for 'comments fix' patch, which was just send and 'the rest'.
> > > > Now, 'the rest' can either be v2 of your "PM/runtime: Fix autosuspend_delay on
> > > > 32bits arch" or will wait for 5.1. You decide :)
> > >
> > > I don't really mind.
> > >
> > > Rafael,
> > > Do you prefer to only take the fix for u64 casting problem or do you
> > > prefer to also take the optimization below in one single patch ?
> >
> > The casting problem is a bug and the optimization is next release
> > material in my view.  Please send the optimization separately.
>
> Ok, will send that separately in a few moments...
> Btw, u64 casting problem seems to be still present in rpm_suspend while
> computing slack for autosuspend delay greater than 25% of 2^31 (2^33) ns.

Good point. I will add it to the fix as well

> Not sure if that triggers any real bug.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
