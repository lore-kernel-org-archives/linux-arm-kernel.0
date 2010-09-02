From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 02 Sep 2010 17:41:57 +0300
Subject: Colibri PXA320 Power management question
In-Reply-To: <20100902142203.GA8381@sirena.org.uk>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
	<20100902142203.GA8381@sirena.org.uk>
Message-ID: <4C7FB7B5.2010301@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Thu, Aug 12, 2010 at 02:02:17PM +0400, Yuri Ludkevich wrote:
> 
>> I have a question about power management of Colibri PXA320 module:
>> I found that bits PVE and FVE in PVCR register are disabled,
>> so at frequency change voltage will not change.
> 
>> If I turn on PVE and FVE with pxaregs tool - voltage changes just fine.
>> Where are suitable place in the kernel for PVCR initialization?
> 
> The expectation in Linux is that voltage scaling will be done in
> software using cpufreq rather than autonomously by the CPU.

PXA3xx has ability to automatically control certain regulators (almost) without 
software intervention. Setting the bits Yuri is talking about should enable CPU 
initiated i2c transactions upon frequency scaling events.

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Sincerely yours,
Mike.
