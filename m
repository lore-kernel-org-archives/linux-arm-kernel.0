Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9321CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:55:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3CF206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cMzZHaYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3CF206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3rwFnCnXoKCRRmyRRlv43q8p8GrDRkgoOPLzBhTw1bg=; b=cMzZHaYKTnD6ROotogjvXS8EC
	PtFefR68+fLR6xwRuKiPqnhWePHuc0UF3vz1QLKRkHX86dq+CYDH1cl2D8wLfvc1/o3dYMnjs4+QC
	PE9IVdYmzPMgbShfPXuEpXKcarKA9WXywunTupLpSoY6Zm1OdDPPHv8t94r3dQTkJhc0pXYDCrXWt
	DOB5NAs6s9w/3bC7SXmjgGKuEhPX3MU9DvmVYlxffyQgBZxrNWnMCskxMa0UuayCVmF5EgJc2WCEI
	lZL/TzNwcRzgIOaawA3RrQ0FWmVwvPJTQ2abX0DST54SAyex2Mrxnwwvko5nPho/FyzuRzU9XRqZC
	zbaIZT2tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghFGu-0007BF-EJ; Wed, 09 Jan 2019 14:55:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghFGq-0007AT-3F
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:55:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD80680D;
 Wed,  9 Jan 2019 06:55:49 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 909F23F694;
 Wed,  9 Jan 2019 06:55:46 -0800 (PST)
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
To: mathieu.poirier@linaro.org
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
 <CANLsYkyvq-K1M7jZ=rOEcGBySTktV_c7D4S2jBV_nS3cj8a8wg@mail.gmail.com>
 <bb313a2d-b5fc-9329-5db6-4bf661d278bb@arm.com>
 <CANLsYkx_-QHs=3syOXrazU_nA2x-QT9VjvzWubGjVGtz_01dAQ@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b082bf81-2148-2b43-5b1a-0bdf4b1e62c0@arm.com>
Date: Wed, 9 Jan 2019 14:55:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkx_-QHs=3syOXrazU_nA2x-QT9VjvzWubGjVGtz_01dAQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_065552_148058_1A0F600F 
X-CRM114-Status: GOOD (  27.99  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, Suzuki.Poulose@arm.com,
 peterz@infradead.org, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com,
 adrian.hunter@intel.com, acme@kernel.org, ast@kernel.org,
 alexander.shishkin@linux.intel.com, mingo@redhat.com, will.deacon@arm.com,
 hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 jolsa@redhat.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,

On 07/01/2019 18:18, Mathieu Poirier wrote:
> On Wed, 19 Dec 2018 at 02:40, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>>
>>
>> On 18/12/2018 17:34, Mathieu Poirier wrote:
>>> Good day Suzuki,
>>>
>>> On Tue, 18 Dec 2018 at 07:14, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

>>>> We could assign a static "id/key" exported either via the device sysfs dir or
>>>> the "pmu" dir. I prefer the latter.
>>>
>>> Not sure what you mean by "pmu" directory - would you mind expanding
>>> on that?  Using sysfs would be quite easy but I am reluctant to create
>>> a new id/key mechanism and introduce another entry when we have the
>>> component address that is unique and already available in the amba
>>> directory structure.
>>
>> We could add another directory under :
>>
>> /sys/bus/event_source/devices/<PMU>/
>>                                  \_ events/
>>                                  \_ format/
>> say :
>>                  \_ drv_config/
>>                  Or
>>                  \_ sinks/
>>
>> and list the sinks, eg:
>> # cd $sysfs_pmu_dir/sinks
>> # cat <name_of_the_sink>
>> ID_of_the_sink
> 
> There is merit to this idea.  Thinking along those lines simply using
> "sinks" is probably a better approach since we don't yet know how PMU
> configuration will unfold.  I'm also wondering if we have to
> explicitly list the ID of the sink.  The ID itself should be fetch
> from the device specific entries in sysfs like the "resource" property
> of sinks that show up on the AMBA bus.  Sinks that don't show up on
> the AMBA bus will likely have a "reg" property of something similar
> and that is where the ID should be taken from.

I would recommend this be done by the PMU driver and expose it, rather
than specifying what is expected. If we keep it simple like an integer,
which is then mapped to the sink-device, we could save some bits in the
config field for further use and a the complex set of rules for the ID.

> 
> Lastly it may be tricky to add a new directory structure to the PMU
> entry as it is generic for all PMUs in the system.  But that is up for
> investigation and I will look into doing something like that.

I don't think this is particularly problematic. The PMU driver can provide
a list of attribute_groups which should eventually appear in the device
directory under the "bus/event_source/devices/<PMU>/". And that provides
a central place for finding the SINK id for all the available sinks, rather
than scanning for a sink under all the buses (e.g, platform, amba) wherever
that might show up.

> 
>>
>> Btw, I am always inclined to using some bits off one of the "config" fields
>> ("config1" or "config2") for the sink configuration. But I understand that
>> you have explored that avenue and chose this approach as we have further
>> configurations required for complex ETM settings.
> 
> I've had a good conversation with myself over the holidays on that
> topic (hence the late-ish reply).  My original approach was to use the
> same ioctl() mechanism to do sink selection and complex PMU
> configuration.  But as Greg confirmed with his comment on the previous
> patch doing so requires to iron out how the latter will be done on ARM
> (and probably on Intel too), something that is a different deal
> altogether.
> 
> Taking a step back and forgetting about complex PMU configuration for
> a minute, the ID of a sink can easily be stuffed in one of the
> "config" fields of the perf_event_attr structure, something I alluded
> to in the patchset's cover letter.  That way we can move along with
> this feature and leave the discussion on complex PMU configuration for
> another day.

Cool ! I completely agree with this.

> 
> I'll do a respin with the above in mind.
> 
> A happy new year to you,

You too.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
