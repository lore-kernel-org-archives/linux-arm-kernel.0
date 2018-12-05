Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E255CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:50:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A53213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MCtSpGg5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g3NN9mOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A53213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MBtWz/kmBgjOYVL1lmG8E54OQmV5yaGAXDWRkQlTfow=; b=MCtSpGg5vNZA08
	wwngX+Mpv5uzpJLggJPnWl2qUbkJwLlMCBohLJHj+PckaPBhzDiDiFCwDV/EDo6sELvVr3Fx21yaJ
	UXb4MXBlV64iaadRUPT+zGX89zqrIgokLxsemaLePvQDdTatzGOjz+57aBHJ8U4CjYwGviIv2Zy29
	bu62MVoNcr3/xNNkMiLGn6g+1N8bEq68BvtQu33HrVul0Fp6aMaZt7pW0qfoqmRNfunwcDD4SFsiw
	pO0gOSW74Xo//PQVC+13oEAdI9LURdfh1+ytTGTgWIAl+s8iDl4Kr7g1cRPA45V3m5omlUW9YI5B2
	u5ZwsgvjWNCwU0a7+Mvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUe7t-0000Nu-Nc; Wed, 05 Dec 2018 20:50:33 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUe7q-0000N1-Be
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 20:50:32 +0000
Received: by mail-lj1-x241.google.com with SMTP id v15-v6so19603962ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 12:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=chV5AMXa7wTX8GxqMhONGZ3HZuE3v6EMe6pHqOA45KM=;
 b=g3NN9mOUYwwsIgRo6hI3jVCwAjHlPRj0pGMnfXkdAmoMFw+gvRdHHNo4Cw9AqxBdgo
 uAJzrU3EjBCkGkYvl/sHbFqSH1eGvAAiKGLZ2k2AZyahVBsQfXlzwxjedyHxWnhKMPui
 EbvxNBUfQaXW+wbPhhT02f4nfywHoeMvQWmFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=chV5AMXa7wTX8GxqMhONGZ3HZuE3v6EMe6pHqOA45KM=;
 b=Cw8qSdgsi5qCJiVxTQvT4XfXePICW8q70/flHvABynbjcUp1O8pKA9lB0H93CrBlAW
 AHo37k6w+p9D0R1/RbiDKvUMGpzcSFCzubohzTa5/VWkmyqIVIBM0qO8MswflYLSmqmq
 GH6j2C5l3DcQeh2pVbHMvsVm5iJWZpBA49Irb8ohZVZ+vMU6SJHUC6MRigzKcF67mgiJ
 wHuaQYmnXnZzly76+LK4zoOz64wFBn6zrZDwd23fuj63rIag6nsgHhPJ10cRqi0+kSQE
 gCkI9K10gxdPMeIJlzRZh3Dx++b7TZhL8KCKsCv2Th+RpgoBZM0EbeVGgFR2KW5J+rrO
 k6gA==
X-Gm-Message-State: AA+aEWYhYjA32Bv3BEVgBzbMkW6ZIy3hZBHayGhuAtg5opq8N2qDQmE5
 FX+KQak4fN26skRyhretlq128sUj9UA=
X-Google-Smtp-Source: AFSGD/X3IsT05z+Z9T9BRNbZO78xBCnizjKWMXrE/53bGYuhPpuDgNkK2Y1Dak9Ae7Gz6ZzkPNur8w==
X-Received: by 2002:a2e:9f0b:: with SMTP id
 u11-v6mr14560597ljk.99.1544043017235; 
 Wed, 05 Dec 2018 12:50:17 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com.
 [209.85.208.175])
 by smtp.gmail.com with ESMTPSA id m10-v6sm3934066ljj.34.2018.12.05.12.50.17
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 12:50:17 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id v15-v6so19603928ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 12:50:17 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id
 x10-v6mr18064501ljh.174.1544042532343; 
 Wed, 05 Dec 2018 12:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-1-georgi.djakov@linaro.org>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 5 Dec 2018 12:41:35 -0800
X-Gmail-Original-Message-ID: <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
Message-ID: <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
To: georgi.djakov@linaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_125030_425943_B5C9FE32 
X-CRM114-Status: GOOD (  17.84  )
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
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> graphics, modem). These cores are talking to each other and can generate a
> lot of data flowing through the on-chip interconnects. These interconnect
> buses could form different topologies such as crossbar, point to point buses,
> hierarchical buses or use the network-on-chip concept.
>
> These buses have been sized usually to handle use cases with high data
> throughput but it is not necessary all the time and consume a lot of power.
> Furthermore, the priority between masters can vary depending on the running
> use case like video playback or CPU intensive tasks.
>
> Having an API to control the requirement of the system in terms of bandwidth
> and QoS, so we can adapt the interconnect configuration to match those by
> scaling the frequencies, setting link priority and tuning QoS parameters.
> This configuration can be a static, one-time operation done at boot for some
> platforms or a dynamic set of operations that happen at run-time.
>
> This patchset introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
> The API is NOT for changing the performance of the endpoint devices, but only
> the interconnect path in between them.

For what it's worth, we are ready to land this in Chrome OS. I think
this series has been very well discussed and reviewed, hasn't changed
much in the last few spins, and is in good enough shape to use as a
base for future patches. Georgi's also done a great job reaching out
to other SoC vendors, and there appears to be enough consensus that
this framework will be usable by more than just Qualcomm. There are
also several drivers out on the list trying to add patches to use this
framework, with more to come, so it made sense (to us) to get this
base framework nailed down. In my experiments this is an important
piece of the overall power management story, especially on systems
that are mostly idle.

I'll continue to track changes to this series and we will ultimately
reconcile with whatever happens upstream, but I thought it was worth
sending this note to express our "thumbs up" towards this framework.

-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
