From: shiraz.linux.kernel@gmail.com (shiraz hashim)
Date: Sat, 12 Feb 2011 23:07:21 +0530
Subject: reboot not working on linux-2.6.37 for ARMv7
In-Reply-To: <20110212173216.GC22402@n2100.arm.linux.org.uk>
References: <AANLkTi=FCJr-0aF0LG92PC4Q7J4R5PDU7xobnvCgDHy8@mail.gmail.com>
	<20110211120305.GD23404@n2100.arm.linux.org.uk>
	<AANLkTikvBRJyDJb4=puFzbTCXNYGSEXDRkAZ=1PZuneD@mail.gmail.com>
	<20110212162148.GA22402@n2100.arm.linux.org.uk>
	<AANLkTimbQMrYqKj_FcfiOaYV=MJGpX=HvSvt-AVMdv0G@mail.gmail.com>
	<20110212173216.GC22402@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik8dPh8XJu4PF3GZ-CSmW+u5b9aKiaOakTt7ruO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 11:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Feb 12, 2011 at 10:53:54PM +0530, shiraz hashim wrote:
>> Thanks, we got it. This was missing in linux-2.6.37 where the code was
>>
>> ?void smp_send_stop(void)
>> ?{
>> ? ? ? ? ?cpumask_t mask = cpu_online_map;
>> ? ? ? ? ?cpu_clear(smp_processor_id(), mask);
>> ? ? ? ? ?if (!cpus_empty(mask))
>> ? ? ? ? ? ? ? ? ?send_ipi_message(&mask, IPI_CPU_STOP);
>> ?}
>>
>> I would try this change and see if it works for me.
>
> Probably best to pull the patch out of latest git, which is:
>
> 28e18293cf0f8d23a0950d7b1d2212d11af494dc

Sure, thanks again.

-- 
regards
Shiraz Hashim
