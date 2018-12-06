Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D20C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FC720700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tyZco5Pz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz/fJM7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FC720700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S5d+SfFAEC22Iucbq0RAZwhC3jkmB5L5TkllQETfbuY=; b=tyZco5Pz8bcGzY
	AvQJ4C3gKVDwcyg0d2XUC1VdaQKzlOnLVYHEEwOt00g29q0wZ+rcaF5U6DS+PUFGXUAskqlpjndnF
	P/mqgBn7uyBkELlPDBkRLbOZZVNJskPYW2pnSJeBGIgueH9IOwOpTAgJjNbtsOauExGL6tAyvBl35
	hZKrdEN+GRpB5KxYmGmiVwh2GDQWjNjnlFIncOt7vmlc2YAY+wE+IcF8OL9LJYwxV/cjuNwsHdnZC
	nCEGQaBQ9Gusc63clCY5vyVxczvXOczPLTyFXxygkt6vKV38E8/RpRZRJEQrl/oPt7vpSFlenR+O7
	OK6sIr7/6Bkmff7ENTfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUv4W-0006EP-J7; Thu, 06 Dec 2018 14:56:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUv4I-00063b-DO
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:56:02 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4F2CE20850;
 Thu,  6 Dec 2018 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544108149;
 bh=KhuHcI54qejZzgMJEA/PeUcsTUuPrybT0KJnwKINenI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vz/fJM7LCn16OuyLD8ZRCP5nbDjwcVOD6TYrKuqudnKPDQgDhKhjw91HDknvYdmSY
 k2TEFHPb4VGhFS1Wa8D8dDtN1VipJLXz6bAbDMb+71Rqjat7zFCTl+lRo3oKNIVj/r
 8TtGNPx6opuT06JVtCKt1S4ZHBZW2B7iHb4boVE8=
Date: Thu, 6 Dec 2018 15:55:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
Message-ID: <20181206145547.GA7884@kroah.com>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_065558_603045_FB0824A5 
X-CRM114-Status: GOOD (  21.16  )
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
Cc: mark.rutland@arm.com, Doug Anderson <dianders@chromium.org>,
 sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>, lorenzo.pieralisi@arm.com,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 khilman@baylibre.com, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 Thierry Reding <thierry.reding@gmail.com>, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 12:41:35PM -0800, Evan Green wrote:
> On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >
> > Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> > graphics, modem). These cores are talking to each other and can generate a
> > lot of data flowing through the on-chip interconnects. These interconnect
> > buses could form different topologies such as crossbar, point to point buses,
> > hierarchical buses or use the network-on-chip concept.
> >
> > These buses have been sized usually to handle use cases with high data
> > throughput but it is not necessary all the time and consume a lot of power.
> > Furthermore, the priority between masters can vary depending on the running
> > use case like video playback or CPU intensive tasks.
> >
> > Having an API to control the requirement of the system in terms of bandwidth
> > and QoS, so we can adapt the interconnect configuration to match those by
> > scaling the frequencies, setting link priority and tuning QoS parameters.
> > This configuration can be a static, one-time operation done at boot for some
> > platforms or a dynamic set of operations that happen at run-time.
> >
> > This patchset introduce a new API to get the requirement and configure the
> > interconnect buses across the entire chipset to fit with the current demand.
> > The API is NOT for changing the performance of the endpoint devices, but only
> > the interconnect path in between them.
> 
> For what it's worth, we are ready to land this in Chrome OS. I think
> this series has been very well discussed and reviewed, hasn't changed
> much in the last few spins, and is in good enough shape to use as a
> base for future patches. Georgi's also done a great job reaching out
> to other SoC vendors, and there appears to be enough consensus that
> this framework will be usable by more than just Qualcomm. There are
> also several drivers out on the list trying to add patches to use this
> framework, with more to come, so it made sense (to us) to get this
> base framework nailed down. In my experiments this is an important
> piece of the overall power management story, especially on systems
> that are mostly idle.
> 
> I'll continue to track changes to this series and we will ultimately
> reconcile with whatever happens upstream, but I thought it was worth
> sending this note to express our "thumbs up" towards this framework.

Looks like a v11 will be forthcoming, so I'll wait for that one to apply
it to the tree if all looks good.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
