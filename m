Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E8CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:15:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B162082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uMekgU4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B162082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uAmWdbkucUtzIvKxCeD4/92bQduBG9E8l2d7y5G8jys=; b=uMekgU4m52z1Nu
	f8XK9Xpe2kH39S8cv50CvYRWpqefhUymRCA3vjcq02nGDthQBg2C2X/fx9prpUgCp0QrhfAQMaCF2
	emp8wo+sNrmlG5ogPJgAYl+jJ5QX2+ENq2xdo760Bb61gYyJ0rrGoxawkKfV1C0yLbY3f6nwWJx01
	CvEbdEWhPVmXlUMV1wBI71Wcbh71RKu4iNYxgBy+mSUg7nxQp2HxUmKegtPfVfFOgkdn55l0XE6nA
	pHkyyxQ94d/U/j6bWoOEWNHmIxq8MShnKD8PxvZ+oztbtsqab5vWxRAxOBhyMqmwEkmEOjo+w/ELP
	1PcUAqH0LY8R5egQ3KVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJiT-0001NR-3C; Fri, 07 Dec 2018 17:15:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJiO-0001F9-FK
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:15:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D03715AB;
 Fri,  7 Dec 2018 09:14:50 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D7933F5AF;
 Fri,  7 Dec 2018 09:14:45 -0800 (PST)
Date: Fri, 7 Dec 2018 17:14:40 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v11 8/8] interconnect: sdm845: Fix build failure after
 cmd_db API change
Message-ID: <20181207171437.qmtacurmqg53zzkl@queper01-lin>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-9-georgi.djakov@linaro.org>
 <20181207162733.pdd62qvqzd6xk4nr@queper01-lin>
 <fb5d11cd-6729-5521-c828-9bfeedba9ce0@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fb5d11cd-6729-5521-c828-9bfeedba9ce0@linaro.org>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_091500_533668_0A98C0D2 
X-CRM114-Status: GOOD (  17.33  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 mturquette@baylibre.com, daidavid1@codeaurora.org, bjorn.andersson@linaro.org,
 skannan@codeaurora.org, abailon@baylibre.com, lorenzo.pieralisi@arm.com,
 vincent.guittot@linaro.org, seansw@qti.qualcomm.com, khilman@baylibre.com,
 evgreen@chromium.org, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 arnd@arndb.de, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Friday 07 Dec 2018 at 18:47:22 (+0200), Georgi Djakov wrote:
> Hi Quentin,
> 
> On 12/7/18 18:27, Quentin Perret wrote:
> > Hi Georgi,
> > 
> > On Friday 07 Dec 2018 at 17:29:17 (+0200), Georgi Djakov wrote:
> >> Recently the cmd_db_read_aux_data() function was changed to avoid using
> >> memcpy and return a pointer instead. Update the code to the new API and
> >> fix the build failure.
> >>
> >> Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>  drivers/interconnect/qcom/sdm845.c | 26 ++++++++++++++------------
> > 
> > IIUC this file is introduced by patch 5. Should the fix be squashed
> > into patch 5 directly ? Just to keep things bisectable.
> 
> The reason why i have split it as a separate change is because as a
> separate change it would be easier to review & test for the people who
> are already familiar with the rest of the series.
> 
> Another minor reason is that a separate patch will also make the life a
> bit easier for some people who are back-porting this to kernels using
> the older version of the cmd_db API.
> 
> The commit that changed the cmd_db API is not yet in mainline, but in
> linux-next. I am not sure what is preferred in this case?

Not sure either but I guess that will depend who gets merged first ...
If that's the cmd_db change, then you'll need to squash your fix in
patch 5. If your series goes first, then the fix needs to be applied to
the cmb_db change.

I personally don't mind either way as long as we don't break bisection :-)

Thanks,
Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
