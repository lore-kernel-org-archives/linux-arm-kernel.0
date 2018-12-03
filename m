Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:09:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DE520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cn7RQJQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DE520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w8C912Hp5uAS7fGnlyqSVyl+U8YeuohzoUBTqITzBGc=; b=cn7RQJQ7IRCmwP
	IDemYgEMXs3Em2a+FHhSBslo2bVEAG9+Buk9zPjvx83d2RQLbHpZlbnEoZgthv8crbVOn/SkwL+Vd
	JtW1rGOad37L7UL16Z4QObOQIl+PNctPw8zN8PQURD/Qbtl6eslub2lVbGmHTWZkF7Q03virMNM+p
	05jZP3vsJBMMMonv0RK0Yi6k7raB0t3r/GqnjCQokTKEvAGLVNwq6b2ViJc+fmm4jO8IL6p5zg7v+
	GvDAp8tjI4uh0gH0xnTL5wQYPJL60G3R7nNIeNMw2njcV+j223Q4sHP00v/47UgMCnvgPPkGBRAU6
	gDajP0NuHKqoQfck5GzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTn2R-000269-PQ; Mon, 03 Dec 2018 12:09:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTn2O-00025E-IJ
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:09:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 871E7165C;
 Mon,  3 Dec 2018 04:09:07 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 563F73F59C;
 Mon,  3 Dec 2018 04:09:07 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 44D981AE1062; Mon,  3 Dec 2018 12:09:27 +0000 (GMT)
Date: Mon, 3 Dec 2018 12:09:27 +0000
From: Will Deacon <will.deacon@arm.com>
To: "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>
Subject: Re: [PATCH v8 1/2] perf, uncore: Adding documentation for ThunderX2
 pmu uncore driver
Message-ID: <20181203120926.GB24824@arm.com>
References: <20181122030354.13570-1-ganapatrao.kulkarni@cavium.com>
 <20181122030354.13570-2-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181122030354.13570-2-ganapatrao.kulkarni@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_040920_617986_AD7B9BD2 
X-CRM114-Status: GOOD (  29.85  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "Nair,
 Jayachandran" <Jayachandran.Nair@cavium.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "gklkml16@gmail.com" <gklkml16@gmail.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Richter,
 Robert" <Robert.Richter@cavium.com>, "Lomovtsev,
 Vadim" <Vadim.Lomovtsev@cavium.com>, Jan Glauber <Jan.Glauber@cavium.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 22, 2018 at 03:04:31AM +0000, Kulkarni, Ganapatrao wrote:
> The SoC has PMU support in its L3 cache controller (L3C) and in the
> DDR4 Memory Controller (DMC).
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  Documentation/perf/thunderx2-pmu.txt | 106 +++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/perf/thunderx2-pmu.txt

Thanks for writing the documentation, although I think it needs a bit of
help before we can merge it.

> diff --git a/Documentation/perf/thunderx2-pmu.txt b/Documentation/perf/thunderx2-pmu.txt
> new file mode 100644
> index 000000000000..9f5dd7459e68
> --- /dev/null
> +++ b/Documentation/perf/thunderx2-pmu.txt
> @@ -0,0 +1,106 @@
> +
> +Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
> +==========================================================================
> +
> +ThunderX2 SoC PMU consists of independent system wide per Socket PMUs such
> +as Level 3 Cache(L3C) and DDR4 Memory Controller(DMC).

Please add some punctuation here.

> +
> +DMC has 8 interleave channels and L3C has 16 interleave tiles. Events are

*The* DMC and *the* L3C


> +sampled for default channel(i.e channel 0) and prorated to total number of

I'm not sure I understand this; are you saying it's not possible to sample
channels other than channel 0?

> +channels/tiles.
> +
> +DMC and L3C, Each PMU supports up to 4 counters. Counters are independently

The start of this sentence makes no sense and you've got a capital "Each".

> +programmable and can be started and stopped individually. Each counter can
> +be set to sample specific perf events. Counters are 32 bit and do not support
> +overflow interrupt; they are sampled at every 2 seconds.

I think this is unfortunate wording, because actually you don't support what
perf calls "sampling" at all.

> +
> +PMU UNCORE (perf) driver:
> +
> +The thunderx2-pmu driver registers several perf PMUs for DMC and L3C devices.

I think the driver name uses an underscore instead of a hyphen.

> +Each of the PMUs provides description of its available events
> +and configuration options in sysfs.
> +	see /sys/devices/uncore_<l3c_S/dmc_S/>
> +
> +S is socket id.

*the* socket id

> +Each PMU can be used to sample up to 4 events simultaneously.
> +
> +The "format" directory describes format of the config (event ID).
> +The "events" directory provides configuration templates for all
> +supported event types that can be used with perf tool.

You can drop this bit, since it's not specific to your PMU and is actually
describing the perf ABI via sysfs. If we want to document that someplace, it
should be in a separate file.

> +
> +For example, "uncore_dmc_0/cnt_cycles/" is an
> +equivalent of "uncore_dmc_0/config=0x1/".

Why is this helpful?

> +
> +Each perf driver also provides a "cpumask" sysfs attribute, which contains a
> +single CPU ID of the processor which is likely to be used to handle all the
> +PMU events. It will be the first online CPU from the NUMA node of the PMU device.

Again, I don't think this really belongs in here.

> +
> +Example for perf tool use:
> +
> +perf stat -a -e uncore_dmc_0/cnt_cycles/ sleep 1
> +
> +perf stat -a -e \
> +uncore_dmc_0/cnt_cycles/,\
> +uncore_dmc_0/data_transfers/,\
> +uncore_dmc_0/read_txns/,\
> +uncore_dmc_0/write_txns/ sleep 1
> +
> +perf stat -a -e \
> +uncore_l3c_0/read_request/,\
> +uncore_l3c_0/read_hit/,\
> +uncore_l3c_0/inv_request/,\
> +uncore_l3c_0/inv_hit/ sleep 1
> +
> +The driver does not support sampling, therefore "perf record" will
> +not work. Per-task (without "-a") perf sessions are not supported.

What do you mean by "not supported"? If I invoke perf as:

# ./perf stat -e uncore_dmc_0/cnt_cycles/ -- ls

then I get results back.

> +
> +L3C events:
> +============
> +
> +read_request:
> +	Number of Read requests received by the L3 Cache.
> +	This include Read as well as Read Exclusives.
> +
> +read_hit:
> +	Number of Read requests received by the L3 cache that were hit
> +	in the L3 (Data provided form the L3)
> +
> +writeback_request:
> +	Number of Write Backs received by the L3 Cache. These are basically
> +	the L2 Evicts and writes from the PCIe Write Cache.
> +
> +inv_nwrite_request:
> +	This is the Number of Invalidate and Write received by the L3 Cache.
> +	Also Writes from IO that did not go through the PCIe Write Cache.
> +
> +inv_nwrite_hit
> +	This is the Number of Invalidate and Write received by the L3 Cache
> +	That were a hit in the L3 Cache.
> +
> +inv_request:
> +	Number of Invalidate request received by the L3 Cache.
> +
> +inv_hit:
> +	Number of Invalidate request received by the L3 Cache that were a
> +	hit in L3.
> +
> +evict_request:
> +	Number of Evicts that the L3 generated.

Wouldn't this be better off in the perf tools sources, as part of the JSON
events file for your PMU?

> +
> +NOTE:
> +1. Granularity of all these events counter value is cache line length(64 Bytes).
> +2. L3C cache Hit Ratio = (read_hit + inv_nwrite_hit + inv_hit) / (read_request + inv_nwrite_request + inv_request)
> +
> +DMC events:
> +============
> +cnt_cycles:
> +	Count cycles (Clocks at the DMC clock rate)
> +
> +write_txns:
> +	Number of 64 Bytes write transactions received by the DMC(s)
> +
> +read_txns:
> +	Number of 64 Bytes Read transactions received by the DMC(s)
> +
> +data_transfers:
> +	Number of 64 Bytes data transferred to or from DRAM.

Same here.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
