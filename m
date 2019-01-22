Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B6C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:42:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCD421019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V/13mfCT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v06nkiHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCD421019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0mOyRYQaf3k7Oj4DBI/viosRJfRn5h3DTejLCpd5sp4=; b=V/13mfCTwqugsW
	VYq62Ac13a6jA7GBrw5Zg2+ejV8VQLQK7u3ppd/PZF73W572FcKazVbpJG+qEwVqjlTVnxk4j/CZo
	LHooPe01PVotAOkOg4XLcW55DlQ3nEPSPUTSVIDVTlQJtzVoXJbw6teNoG/Shsdt5WNeXa4tdkyMD
	t9ExgbT9cxHs882zWMdhG2PhTFcRtLZzFYb7o4jpt2HBk8YBE6SyrU0ABwREiesWTyfhGYY2NARb+
	rJZ1LywcFPXCVANUSNQIAXT/iUHPDIttzSeXfHCEZ7meZkkTpolTQU5yIdRu/+I/zoqeHGttGBiiI
	N8KsyOkpPGcDtYDfk/+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glvNo-0008Ju-OX; Tue, 22 Jan 2019 12:42:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glvNc-00086e-Sr; Tue, 22 Jan 2019 12:42:19 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C3AD420855;
 Tue, 22 Jan 2019 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548160932;
 bh=dp15uKwqwdlEj1uUFXimVhvyYY5t4Ul7E+PFaOKJkoA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=v06nkiHyaPeoIMyTCPKrOe0E3suQWdz5XaVnRvgqHQqejAIhdf1LusImEJb/HeY7r
 dEIcS4FE27SVcYh5S78YKMW6b0xUIrzkB8W6uFtCT7wpldEVi5WDF7c6LcWKgKKtQm
 HrV03GJ4xaJ4AYHMoirEP7Y/w7o5tYO/Lwsczmas=
Date: Tue, 22 Jan 2019 13:42:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v13 0/8] Introduce on-chip interconnect API
Message-ID: <20190122124204.GA26969@kroah.com>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_044213_594476_FF5C3081 
X-CRM114-Status: GOOD (  19.48  )
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
Cc: sanjayc@nvidia.com, maxime.ripard@bootlin.com, mturquette@baylibre.com,
 daidavid1@codeaurora.org, bjorn.andersson@linaro.org, skannan@codeaurora.org,
 abailon@baylibre.com, vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
 khilman@baylibre.com, evgreen@chromium.org, ksitaraman@nvidia.com,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, henryc.chen@mediatek.com, andy.gross@linaro.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com, olof@lixom.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 06:10:55PM +0200, Georgi Djakov wrote:
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
> 
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
> 
> Below is a simplified diagram of a real-world SoC topology. The interconnect
> providers are the NoCs.
> 
> +----------------+    +----------------+
> | HW Accelerator |--->|      M NoC     |<---------------+
> +----------------+    +----------------+                |
>                         |      |                    +------------+
>  +-----+  +-------------+      V       +------+     |            |
>  | DDR |  |                +--------+  | PCIe |     |            |
>  +-----+  |                | Slaves |  +------+     |            |
>    ^ ^    |                +--------+     |         |   C NoC    |
>    | |    V                               V         |            |
> +------------------+   +------------------------+   |            |   +-----+
> |                  |-->|                        |-->|            |-->| CPU |
> |                  |-->|                        |<--|            |   +-----+
> |     Mem NoC      |   |         S NoC          |   +------------+
> |                  |<--|                        |---------+    |
> |                  |<--|                        |<------+ |    |   +--------+
> +------------------+   +------------------------+       | |    +-->| Slaves |
>   ^  ^    ^    ^          ^                             | |        +--------+
>   |  |    |    |          |                             | V
> +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
> | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
> +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
>           |
>       +-------+
>       | Modem |
>       +-------+
> 
> It's important to note that the interconnect API, in contrast with devfreq,
> is allowing drivers to express their needs in advance and be proactive.
> Devfreq is using a reactive approach (e.g. monitor performance counters and
> reconfigure bandwidth when the bottleneck had already occurred), which is
> suboptimal and might not work well. The interconnect API is designed to
> deal with multi-tiered bus topologies and aggregating constraints provided
> by drivers, while the devfreq is more oriented towards a device like GPU
> or CPU, that controls the power/performance of itself and not other devices.
> 
> Some examples of how interconnect API is used by consumers:
> https://lkml.org/lkml/2018/12/20/811
> https://lkml.org/lkml/2019/1/9/740
> https://lkml.org/lkml/2018/10/11/499
> https://lkml.org/lkml/2018/9/20/986
> 
> Platform drivers for different SoCs are available:
> https://lkml.org/lkml/2018/11/17/368
> https://lkml.org/lkml/2018/8/10/380

All now queued up, thanks.

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
