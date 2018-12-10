Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02427C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:04:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F102082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VUq56K9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F102082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6+RCFaFdSUNFHG4DwsbpKDp1UhHlA0vigb92Jr6Sitw=; b=VUq56K9P3u7zD3
	o2qmXTSazg1+RfevJtkYbrSe+blyuiV98EJor8pSUTaq7lmEy2K+Y94bMOlzm9crbILi/Ycn03x55
	nHkjxrCclBFFjtz6wpFmVetk+n28fqNFac1CeBsOEGFeAF4Ks045O9xtTVEKhefg5xOn/P4PSpM2c
	ylLrumk7RrfbqYuWvsSNnO0dwwLPEN6BiwFlhKAiFo2iC7XuLcMn+nCszSt3nfjnyhiO1yXw5NUkj
	7hLVg13Ms1rjurQJSt3CzOlPIXjQM0IAnWr5r2pTwGzkay8pimQrY8fesKhcKefeJC3Pa9OFxHeGk
	2jihDWPnCfNDnX/ttSJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHUX-0006Yn-7R; Mon, 10 Dec 2018 09:04:41 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHUU-0006Y0-17
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:04:39 +0000
Received: by mail-ot1-f66.google.com with SMTP id n8so9682224otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 01:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OZGCtl0s42CEQU4yKwqXBNJBWb6cemdDrQzpSV1gBDA=;
 b=LG+LHds5NknXBbNQIGkZC2IYbD4AKhpil2/WEdHid+dzwOkN1ARlvjQ2sIgM6mmPFZ
 NbJFflVHkZL4bcZ7yOfczJJrzf9jykNBg3ERA5J9AIJ8DGT2Gtpvb3Ox03imyrDyzHZZ
 f5Xx1C0H486ptHapx6xjzc5V1tLGjHtFuv1cNnoejFBkjukbZmeLn8wSMvB5UKG0nbwn
 F2bwHZ/02/BV+5O2VPLkCyCp42i43W8yOMRo97CX6iBFVz9mcxH7/8fxZHOIuJFcMW2V
 BgmTgL1isJXCRxB/zEuvsK35Dviqq6UUWA31OXnlQFR9NwnotPiuCYgiCzyn5HxmmruA
 /AdA==
X-Gm-Message-State: AA+aEWZziW3jVlADYoqMdbFJHsMBIsXIES+WlCRIFa3VBAxdRRYaGqKK
 e0z/Z7BvPYkRRPUrp7NiRL3izdwX6SeCJe2mzZQ=
X-Google-Smtp-Source: AFSGD/XMrN+ZNiu+5/9BaKlMFVsJ9gKo2Ptl5fpkQsAXDBdepuHeiZLtqINJ9PaLN6JxPFwHqtON3h2IbPPafGDBaMk=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr7720286otn.200.1544432665576;
 Mon, 10 Dec 2018 01:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
 <20181206145547.GA7884@kroah.com>
In-Reply-To: <20181206145547.GA7884@kroah.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Dec 2018 10:04:14 +0100
Message-ID: <CAJZ5v0gP50tmq4ZzB7LLSaWGWjGjK31y=qFg5PS9B7c2XQ+DyQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_010438_074321_3E704B32 
X-CRM114-Status: GOOD (  27.75  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>,
 sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
 bjorn.andersson@linaro.org, Saravana Kannan <skannan@codeaurora.org>,
 abailon@baylibre.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 Kevin Hilman <khilman@baylibre.com>, evgreen@chromium.org,
 ksitaraman@nvidia.com,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Linux PM <linux-pm@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Georgi Djakov <georgi.djakov@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 3:55 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 05, 2018 at 12:41:35PM -0800, Evan Green wrote:
> > On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> > >
> > > Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> > > graphics, modem). These cores are talking to each other and can generate a
> > > lot of data flowing through the on-chip interconnects. These interconnect
> > > buses could form different topologies such as crossbar, point to point buses,
> > > hierarchical buses or use the network-on-chip concept.
> > >
> > > These buses have been sized usually to handle use cases with high data
> > > throughput but it is not necessary all the time and consume a lot of power.
> > > Furthermore, the priority between masters can vary depending on the running
> > > use case like video playback or CPU intensive tasks.
> > >
> > > Having an API to control the requirement of the system in terms of bandwidth
> > > and QoS, so we can adapt the interconnect configuration to match those by
> > > scaling the frequencies, setting link priority and tuning QoS parameters.
> > > This configuration can be a static, one-time operation done at boot for some
> > > platforms or a dynamic set of operations that happen at run-time.
> > >
> > > This patchset introduce a new API to get the requirement and configure the
> > > interconnect buses across the entire chipset to fit with the current demand.
> > > The API is NOT for changing the performance of the endpoint devices, but only
> > > the interconnect path in between them.
> >
> > For what it's worth, we are ready to land this in Chrome OS. I think
> > this series has been very well discussed and reviewed, hasn't changed
> > much in the last few spins, and is in good enough shape to use as a
> > base for future patches. Georgi's also done a great job reaching out
> > to other SoC vendors, and there appears to be enough consensus that
> > this framework will be usable by more than just Qualcomm. There are
> > also several drivers out on the list trying to add patches to use this
> > framework, with more to come, so it made sense (to us) to get this
> > base framework nailed down. In my experiments this is an important
> > piece of the overall power management story, especially on systems
> > that are mostly idle.
> >
> > I'll continue to track changes to this series and we will ultimately
> > reconcile with whatever happens upstream, but I thought it was worth
> > sending this note to express our "thumbs up" towards this framework.
>
> Looks like a v11 will be forthcoming, so I'll wait for that one to apply
> it to the tree if all looks good.

I'm honestly not sure if it is ready yet.

New versions are coming on and on, which may make such an impression,
but we had some discussion on it at the LPC and some serious questions
were asked during it, for instance regarding the DT binding introduced
here.  I'm not sure how this particular issue has been addressed here,
for example.

Thanks,
Rafael

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
