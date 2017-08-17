From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Thu, 17 Aug 2017 10:30:23 +0800
Subject: [PATCH v4 1/6] Documentation: perf: hisi: Documentation for
 HiSilicon SoC PMU driver
In-Reply-To: <20170815095005.GB6090@leverpostej>
References: <1500984642-204676-1-git-send-email-zhangshaokun@hisilicon.com>
 <1500984642-204676-2-git-send-email-zhangshaokun@hisilicon.com>
 <20170815095005.GB6090@leverpostej>
Message-ID: <bc9920c7-bea4-6f45-7cde-477e0fe21078@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for your comments.

On 2017/8/15 17:50, Mark Rutland wrote:
> Hi,
> 
> On Tue, Jul 25, 2017 at 08:10:37PM +0800, Shaokun Zhang wrote:
>> This patch adds documentation for the uncore PMUs on HiSilicon SoC.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>
>> ---
>>  Documentation/perf/hisi-pmu.txt | 52 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/perf/hisi-pmu.txt
>>
>> diff --git a/Documentation/perf/hisi-pmu.txt b/Documentation/perf/hisi-pmu.txt
>> new file mode 100644
>> index 0000000..f45a03d
>> --- /dev/null
>> +++ b/Documentation/perf/hisi-pmu.txt
>> @@ -0,0 +1,52 @@
>> +HiSilicon SoC uncore Performance Monitoring Unit (PMU)
>> +======================================================
>> +The HiSilicon SoC chip comprehends various independent system device PMUs
> 
> Nit: s/comprehends/comprises/ would be easier to read.
> 

Ok.

>> +such as L3 cache (L3C), Hydra Home Agent (HHA) and DDRC. These PMUs are
>> +independent and have hardware logic to gather statistics and performance
>> +information.
>> +
>> +HiSilicon SoC encapsulates multiple CPU and IO dies. Each CPU cluster
> 
> Nit: The Hisilicon SoC
> 

Ok.

>> +(CCL) is made up of 4 cpu cores sharing one L3 cache; Each CPU die is
> 
> Nit: s/Each/each/
> 

Ok.

>> +called Super CPU cluster (SCCL) and is made up of 6 CCLs. Each SCCL has
>> +two HHAs (0 - 1) and four DDRCs (0 - 3), respectively.
>> +
>> +HiSilicon SoC uncore PMU driver
>> +---------------------------------------
>> +Each device PMU has separate registers for event counting, control and
>> +interrupt, and the PMU driver shall register perf PMU drivers like L3C,
>> +HHA and DDRC etc. The available events and configuration options shall
>> +be described in the sysfs, see /sys/devices/hisi_* 
> 
> What exactly its exposed under /sys/devices/hisi_* ?
> 

Apologies that i shall list /sys/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>/ and
will change it in next version.

>> or /sys/bus/
>> +event_source/devices/hisi_*.
> 
> Please don't wrap paths; keep this on one line.
> 

Ok.

>> +The "perf list" command shall list the available events from sysfs.
>> +
>> +Each L3C, HHA and DDRC in one SCCL are registered as an separate PMU with perf.
>> +The PMU name will appear in event listing as hisi_module <index-id>_<sccl-id>.
>> +where "index-id" is the index of module and "sccl-id" is the identifier of
>> +the SCCL.
>> +e.g. hisi_l3c0_1/rd_hit_cpipe is READ_HIT_CPIPE event of L3C index #0 and SCCL
>> +ID #1.
>> +e.g. hisi_hha0_1/rx_operations is RX_OPERATIONS event of HHA index #0 and SCCL
>> +ID #1.
> 
> It would make more sense for this to be hierarichal, e.g. hisi_sccl{X}_l3c{Y}.
> 

Surely, it is nicer.

Thanks.
Shaokun

> Other than the above nits, this documentation is very useful. Thanks for
> putting this together.
> 
> Thanks,
> Mark.
> _______________________________________________
> linuxarm mailing list
> linuxarm at huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
> 
> .
> 
