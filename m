Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72E4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:16:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E2520892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bb+qHfpm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgKVnjHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E2520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=75455Rzq/vMPRoJxTdb6+wjYSFGgKH4ol2Bh5pIA0/4=; b=bb+qHfpmiHFbxp
	0BKkbFtGCZqCtRtmt0WIC/btbVMDuU3+2miskC1FYOsBqnYEW7b6zFFrydk/JDJoi43XZnBGOAlQ7
	9CXAZdOV4YYadVFMDRPEckgCy4jaDNhBBrp7i4+PKXUqQ7dg339JuhexzsodpfAocce+LXHbnxAZZ
	1MeMFmGimVkaJIIXeQqtsfQuV1JmIihc/ai4v7Ko8S4s7shrHFdn9SVHiXybhJNUqWiggnnkfd1qL
	iVJ4Nb4JmV8gQJPzJNRBkQuCWPoQ45fz2RTPo0HY27UNRaw9eC+J6xKkYoiethCoe/2wHieRBzpCn
	6iD2zFGhCrF3F3EDcKYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZqy-0003r4-Ef; Wed, 05 Dec 2018 16:16:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZqu-0003qI-3w
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:16:45 +0000
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D9892151B
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544026593;
 bh=+gwzwDnPJNvLtZKEcJq1sOD+YlIQ9jtCtlNxDquqasA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HgKVnjHdkCcyggeq7BjdbCl7BxcHvgPf7S/DHpWyahmTZ4lLqTK5pZFLBIiUO9OcU
 NRMpTnap7OOMroC5aC+ikTZ9aOsLb3hDUZktI5SL1HNqXFX6A6GF1mxAtwfQ+tLxrc
 U+KcYKEEF9B9CCrd+RqhQQ/7RzYVyHMHt2OEk5pI=
Received: by mail-qt1-f169.google.com with SMTP id r14so22920077qtp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:16:33 -0800 (PST)
X-Gm-Message-State: AA+aEWZBHmNlhA3J3NO0+jwUUSva+GBcIHKqDsDXvJrVXDch8E/lXD19
 F6WUlzMEHpr0MvQ9YXsdmvi/qX1NmInbekrN3g==
X-Google-Smtp-Source: AFSGD/VShLBbgbwIJla3YZAI37uxkZHbIfEdulh/nkj92GC+EcdvCUwd6cqZQ+wGNlis0HADZyDVJlIYj4NIdiZfQ0I=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr24356925qts.144.1544026592489; 
 Wed, 05 Dec 2018 08:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-2-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-2-georgi.djakov@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 5 Dec 2018 10:16:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJyPH9WVw2VqGTjUvhxoq3+KGpfqtAMf9iH07N7m3P4yw@mail.gmail.com>
Message-ID: <CAL_JsqJyPH9WVw2VqGTjUvhxoq3+KGpfqtAMf9iH07N7m3P4yw@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] interconnect: Add generic on-chip interconnect API
To: Georgi Djakov <georgi.djakov@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_081644_191193_FF4CC027 
X-CRM114-Status: GOOD (  16.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, sanjayc@nvidia.com,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 Kevin Hilman <khilman@baylibre.com>, Evan Green <evgreen@chromium.org>,
 ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-tegra@vger.kernel.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 12:03 PM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> This patch introduces a new API to get requirements and configure the
> interconnect buses across the entire chipset to fit with the current
> demand.
>
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) between endpoints and
> set the desired constraints on this data flow path. The providers receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>

[...]

> +struct icc_path *icc_get(struct device *dev, const int src_id,
> +                        const int dst_id);
> +void icc_put(struct icc_path *path);
> +int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);

icc_set() is very generic, but this function isn't easily extended to
other parameters than bandwidth. Perhaps icc_set_bandwidth() instead.
Then when you add some other setting, you just add a new function. Of
course, if you wind up with a bunch of different parameters, then
you'll probably need an atomic type interface where you test all the
settings together and then commit them separately in one call. But
from a DT perspective, I certainly hope there are not lots of new
settings folks want to add. :)

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
