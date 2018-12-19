Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFD0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:41:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B32321850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dbuIPR0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B32321850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=44xaZaZfC1hygfvR0f07JYHJW+bdInhOYkJVLLlFOZ0=; b=dbuIPR0pv+/iY5l0lIJRzFDaR
	AAIPIK3X+X2AASHCjzclFun3zW42+InKKGDPvseDhc25IN+K8BGDRUQS/UaEg+SyiP5zu1SAuTEPK
	JsmrESTtkWAGXdTBR47lj+XqCt+TfVYOeg5S5mTvA6o3l910MY58nfTDn32Jcb+fmRcmWMBG1FacA
	XPiud19mnggMtBdUmll7wAgyxsqViwUkVI4uV4Z9CikN0gSCtd04bMf14j+I3//3V61Sm14nFhcX0
	2mcSrcVYPReFGeSJQRJL1m82dMv++w+IzDkG0QvW5mUmL4nvGJwLzrlV3ThUuuS146F8pXGgxLax5
	3r1jQwicw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYLo-0003o7-OT; Wed, 19 Dec 2018 09:41:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYLb-0003dw-Vz
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 09:41:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53048A78;
 Wed, 19 Dec 2018 01:40:48 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35E793F575;
 Wed, 19 Dec 2018 01:40:45 -0800 (PST)
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
To: Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
 <CANLsYkyvq-K1M7jZ=rOEcGBySTktV_c7D4S2jBV_nS3cj8a8wg@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <bb313a2d-b5fc-9329-5db6-4bf661d278bb@arm.com>
Date: Wed, 19 Dec 2018 09:40:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkyvq-K1M7jZ=rOEcGBySTktV_c7D4S2jBV_nS3cj8a8wg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_014100_133701_79ED414D 
X-CRM114-Status: GOOD (  35.79  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 heiko.carstens@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, schwidefsky@de.ibm.com,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 suzuki.poulosi@arm.com, Jiri Olsa <jolsa@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 18/12/2018 17:34, Mathieu Poirier wrote:
> Good day Suzuki,
> 
> On Tue, 18 Dec 2018 at 07:14, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Hi Mathieu,
>>
>> On 17/12/2018 17:21, Mathieu Poirier wrote:
>>> This patch uses the PMU driver configuration held in event::hw::drv_config
>>> to select a sink for each event that is created (the old sysFS way of
>>> working is kept around for backward compatibility).
>>>
>>> By proceeding in this way a sink can be used by multiple sessions
>>> without having to play games with entries in sysFS.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>    drivers/hwtracing/coresight/coresight-etm-perf.c | 74 ++++++++++++++++++++----
>>>    1 file changed, 62 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>>> index f21eb28b6782..a7e1fdef07f2 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>>> @@ -4,6 +4,7 @@
>>>     * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>     */
>>>
>>> +#include <linux/amba/bus.h>
>>>    #include <linux/coresight.h>
>>>    #include <linux/coresight-pmu.h>
>>>    #include <linux/cpumask.h>
>>> @@ -11,6 +12,7 @@
>>>    #include <linux/list.h>
>>>    #include <linux/mm.h>
>>>    #include <linux/init.h>
>>> +#include <linux/ioport.h>
>>>    #include <linux/perf_event.h>
>>>    #include <linux/percpu-defs.h>
>>>    #include <linux/slab.h>
>>> @@ -177,6 +179,26 @@ static void etm_free_aux(void *data)
>>>        schedule_work(&event_data->work);
>>>    }
>>>
>>> +static struct coresight_device *etm_drv_config_sync(struct perf_event *event)
>>
>> minor nit: The name doesn't quite imply what we do here. Did you mean
>> s/sync/sink ?
>>
> 
> I chose "sync" with "synchronisation" in mind.  I tried to keep things
> generic since we could potentially use the same interface to convey
> complex PMU configuration.  Arguably we could go with "sink" for now
> and change it to "sync" in the future - I'm not strongly opinionated
> on that part.

Ok. I thought we were trying to grab the sink information from the event
drv_config, hence something that implies that would be slightly more
reader friendly. Again, I am not too keen on it.

> 
>>> +{
>>> +     struct coresight_device *sink = NULL;
>>> +     struct pmu_drv_config *drv_config = perf_event_get_drv_config(event);
>>> +
>>> +     /*
>>> +      * Make sure we don't race with perf_drv_config_replace() in
>>> +      * kernel/events/core.c.
>>> +      */
>>> +     raw_spin_lock(&drv_config->lock);
>>> +
>>> +     /* Copy what we got from user space if applicable. */
>>> +     if (drv_config->config)
>>> +             sink = drv_config->config;
>>> +
>>> +     raw_spin_unlock(&drv_config->lock);
>>> +
>>> +     return sink;
>>> +}
>>> +
>>>    static void *etm_setup_aux(struct perf_event *event, void **pages,
>>>                           int nr_pages, bool overwrite)
>>>    {
>>> @@ -190,18 +212,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>>>                return NULL;
>>>        INIT_WORK(&event_data->work, free_event_data);
>>>
>>> -     /*
>>> -      * In theory nothing prevent tracers in a trace session from being
>>> -      * associated with different sinks, nor having a sink per tracer.  But
>>> -      * until we have HW with this kind of topology we need to assume tracers
>>> -      * in a trace session are using the same sink.  Therefore go through
>>> -      * the coresight bus and pick the first enabled sink.
>>> -      *
>>> -      * When operated from sysFS users are responsible to enable the sink
>>> -      * while from perf, the perf tools will do it based on the choice made
>>> -      * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
>>> -      */
>>> -     sink = coresight_get_enabled_sink(true);
>>> +     /* First get the sink config from user space. */
>>> +     sink = etm_drv_config_sync(event);
>>> +     if (!sink)
>>> +             sink = coresight_get_enabled_sink(true);
>>> +
>>>        if (!sink || !sink_ops(sink)->alloc_buffer)
>>>                goto err;
>>>
>>> @@ -454,6 +469,40 @@ static void etm_addr_filters_sync(struct perf_event *event)
>>>        filters->nr_filters = i;
>>>    }
>>>
>>> +static int etm_drv_config_find_sink(struct device *dev, void *data)
>>> +{
>>> +     struct amba_device *adev = to_amba_device(dev->parent);
>>> +     struct resource *res = &adev->res;
>>> +     u64 value = *((u64 *)data);
>>> +
>>> +     /*
>>> +      * The HW mapping of a component is unique.  If the value we've been
>>> +      * given matches the component's start address, then we must have found
>>> +      * the device we are looking for.
>>> +      */
>>
>> To be frank, I don't quite like the idea of passing the base address of the
>> component as the key to locate a device, (even though that is unique and readily
>> available). I would rather prefer a programmable way to map the keys to the
>> "sink" devices, which works platform agnostic (e.g, ACPI support, where the base
>> address is not obvious from the name). Also if we decide to use a platform
>> agnostic naming scheme, it becomes even more complex.
> 
> This mechanism doesn't rely on the naming scheme - it exploits the
> "resource" interface exported for each amba device [1].  As such
> whether the component is discovered using ACPI or DT, we end up on the
> same amba bus and using the same interface.
> 
> [1]. https://elixir.bootlin.com/linux/latest/source/drivers/amba/bus.c#L128

Ok. The only problem with this approach would be if the devices doesn't appear
on the AMBA bus (btw, which is not true for the existing IPs).

> 
>>
>> We could assign a static "id/key" exported either via the device sysfs dir or
>> the "pmu" dir. I prefer the latter.
> 
> Not sure what you mean by "pmu" directory - would you mind expanding
> on that?  Using sysfs would be quite easy but I am reluctant to create
> a new id/key mechanism and introduce another entry when we have the
> component address that is unique and already available in the amba
> directory structure.

We could add another directory under :

/sys/bus/event_source/devices/<PMU>/
				\_ events/
				\_ format/
say :
		\_ drv_config/
		Or
		\_ sinks/

and list the sinks, eg:
# cd $sysfs_pmu_dir/sinks
# cat <name_of_the_sink>
ID_of_the_sink

Btw, I am always inclined to using some bits off one of the "config" fields
("config1" or "config2") for the sink configuration. But I understand that
you have explored that avenue and chose this approach as we have further
configurations required for complex ETM settings.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
