Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:06:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113A82075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s8TFc41b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113A82075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KlSD21j1VOcwf3o1xInMNH3IvxGHEauMfNYG2bC7oAU=; b=s8TFc41bu0b0WY
	0CVqtGayHlmmtko+WUbNk32qLoMjQxeBTnq+Q/78LqISDPLbtsp4Ox7gw9/7m609pZXXBALBZAmvd
	lvRHoLYg0PrmsFH/DGtSzjGTKnF2PvSSp0Cbo8PRiOoS9wPmB/+u1AuEl+9mNfcfdlvgrwevzPzKu
	qqYV71BWhvdNrJVfYRwL0iv2qmQfFl+etDjgXjp7b1+PY+J4TGE3VuaGczvRCssNt+v1tTyX2EB2s
	xbAruDju5WiOUUbSVW4k277gBYgRQl8wrjJE1pMuypqiXIhmU34iDGJMnb8CgcDewDFP6J5zDkcr7
	irE7Sm2tFUr+wSY0Brng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghLzv-00019O-57; Wed, 09 Jan 2019 22:06:51 +0000
Received: from mail-oi1-f170.google.com ([209.85.167.170])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghLzr-00018w-Nk
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 22:06:49 +0000
Received: by mail-oi1-f170.google.com with SMTP id m6so7609292oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 14:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mbOrBzvxpr23c/lgxXfwTc8+8FBXMZjPC223hJfy8qo=;
 b=PcXw/jQOpTfOgbNy1geKv55yE2aLLa88+HnsIzyzfjfU7TFOiIfao0MpKLVOZYeIvr
 xHmJmvPpII2Uy45hUnTJWtHVBAymD3eUC1u78pv9jzOZOEU+POrjcwfc1YcArWGxbUvV
 a17rt7u442XeTfKUWxDWMdspyyi4wwKi4DLeIn35AvNZb5daafZ3dssuuAw/Il/1sJb0
 PubxV+i1fJtS6s42IyxtwntbdAht83JyXznKGzDdkWkJsr/sKD2ASZ4r92jWQp/0k1KV
 YT1AQeIekQG1K+pNJYFIb2jFFSgdR7RK/6v6kLc06UfTKbTHOH3lx8JAYYX1GL8j5Gg1
 pPtA==
X-Gm-Message-State: AJcUukf37PTTF4PtiN2vHyDPk35lDM36gilIHPyphk1XDnaj8Lyw8Y3I
 JFauQCW6fGgij8wvZ2YPVhNcqM8mYYwIGoawpw0=
X-Google-Smtp-Source: ALg8bN66+S1vlmhpTzUBfTCHQO0EWVpWO+n2QOjXmuTFCHBbBxmywXc3H+sQvYP9uc127clQclVRxVdQZFS0sytUjUU=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr5061008oic.33.1547071606398; 
 Wed, 09 Jan 2019 14:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20190108213743.GN5544@atomide.com>
 <20190109014218.GA8363@linaro.org> <20190109111703.GA28605@lenoch>
 <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
 <20190109115824.GA1353@lenoch>
 <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
 <20190109133337.GA13579@lenoch>
 <CAKfTPtAsENRKh_wTFXCLW2_MdMBug+tV2KtjC7x6RigN7hgPmw@mail.gmail.com>
 <20190109160736.GA7416@lenoch>
 <CAKfTPtBnNA6knrsHsZXeaotBSn5mS12xNWNUKdSwZ1EUvueQkA@mail.gmail.com>
 <20190109172623.GB1711@lenoch>
 <CAKfTPtBGh+ShbNCZLiYr4PZJooun7uctuQaomc40czvAk5Yizg@mail.gmail.com>
In-Reply-To: <CAKfTPtBGh+ShbNCZLiYr4PZJooun7uctuQaomc40czvAk5Yizg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jan 2019 23:06:34 +0100
Message-ID: <CAJZ5v0jPJYyszAs4qJhqX+5RGwzJoo=+reTS__buoCrfTeYY8Q@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To: Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_140647_767203_DB1BF3D2 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ladislav Michl <ladis@linux-mips.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 9, 2019 at 7:05 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 9 Jan 2019 at 18:26, Ladislav Michl <ladis@linux-mips.org> wrote:
> >
> > On Wed, Jan 09, 2019 at 05:32:31PM +0100, Vincent Guittot wrote:
> > > On Wed, 9 Jan 2019 at 17:07, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > >
> > > > On Wed, Jan 09, 2019 at 03:12:25PM +0100, Vincent Guittot wrote:
> > > > > Please keep all thread list when replying :-)
> > > >
> > > > Ahh, sorry for that...
> > > > [snip]
> > > > > On Wed, 9 Jan 2019 at 14:33, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > > > I agree, but it doea all the magic correctly, so you won't need
> > > > > > to touch that code is ktime_t changes (I know, unlikely..)
> > > > >
> > > > > But the current implementation doesn't care of any changes in ktime_t
> > > > > as it uses raw ns
> > > >
> > > > Fair enough, so let's go back to:
> > >
> > > This one looks good for me
> >
> > Lets split is for 'comments fix' patch, which was just send and 'the rest'.
> > Now, 'the rest' can either be v2 of your "PM/runtime: Fix autosuspend_delay on
> > 32bits arch" or will wait for 5.1. You decide :)
>
> I don't really mind.
>
> Rafael,
> Do you prefer to only take the fix for u64 casting problem or do you
> prefer to also take the optimization below in one single patch ?

The casting problem is a bug and the optimization is next release
material in my view.  Please send the optimization separately.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
