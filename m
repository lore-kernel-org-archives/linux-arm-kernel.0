From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 17:32:16 +0000
Subject: reboot not working on linux-2.6.37 for ARMv7
In-Reply-To: <AANLkTimbQMrYqKj_FcfiOaYV=MJGpX=HvSvt-AVMdv0G@mail.gmail.com>
References: <AANLkTi=FCJr-0aF0LG92PC4Q7J4R5PDU7xobnvCgDHy8@mail.gmail.com>
	<20110211120305.GD23404@n2100.arm.linux.org.uk>
	<AANLkTikvBRJyDJb4=puFzbTCXNYGSEXDRkAZ=1PZuneD@mail.gmail.com>
	<20110212162148.GA22402@n2100.arm.linux.org.uk>
	<AANLkTimbQMrYqKj_FcfiOaYV=MJGpX=HvSvt-AVMdv0G@mail.gmail.com>
Message-ID: <20110212173216.GC22402@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 10:53:54PM +0530, shiraz hashim wrote:
> Thanks, we got it. This was missing in linux-2.6.37 where the code was
> 
>  void smp_send_stop(void)
>  {
>          cpumask_t mask = cpu_online_map;
>          cpu_clear(smp_processor_id(), mask);
>          if (!cpus_empty(mask))
>                  send_ipi_message(&mask, IPI_CPU_STOP);
>  }
> 
> I would try this change and see if it works for me.

Probably best to pull the patch out of latest git, which is:

28e18293cf0f8d23a0950d7b1d2212d11af494dc
