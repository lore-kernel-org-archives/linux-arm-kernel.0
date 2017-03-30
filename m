From: anurupvasu@gmail.com (Anurup M)
Date: Thu, 30 Mar 2017 15:18:44 +0530
Subject: [PATCH v6 07/11] drivers: perf: hisi: Add support for Hisilicon
 SoC event counters
In-Reply-To: <20170321165252.GA29116@leverpostej>
References: <1489127311-112778-1-git-send-email-anurup.m@huawei.com>
 <20170321165252.GA29116@leverpostej>
Message-ID: <58DCD47C.2010501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 21 March 2017 10:22 PM, Mark Rutland wrote:
> +static int hisi_hw_perf_event_init(struct perf_event *event)
> >+{
> >+	struct hw_perf_event *hwc = &event->hw;
> >+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
> >+	struct device *dev = hisi_pmu->dev;
>> +
>> >+	/*
>> >+	 * We must NOT create groups containing mixed PMUs, although
>> >+	 * software events are acceptable
>> >+	 */
>> >+	if (event->group_leader->pmu != event->pmu &&
>> >+	    !is_software_event(event->group_leader))
>> >+		return -EINVAL;
>> >+
>> >+	list_for_each_entry(sibling, &event->group_leader->sibling_list,
>> >+			    group_entry)
>> >+		if (sibling->pmu != event->pmu && !is_software_event(sibling))
>> >+			return -EINVAL;
> Please also check the number of counters.

Sorry, I could not follow this comment correctly. Could you please explain ?
I check the available counters and update used mask in pmu_add --> 
get_event_index

Thanks,
Anurup

> [...]
>
