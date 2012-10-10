From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Wed, 10 Oct 2012 14:19:30 +0000
Subject: [PATCH 02/13] clk: davinci - add PSC clock driver
In-Reply-To: <50756DFD.4070203@ti.com>
References: <1348682889-9509-1-git-send-email-m-karicheri2@ti.com>
 <1348682889-9509-3-git-send-email-m-karicheri2@ti.com>
 <50756B96.1070008@ti.com> <50756DFD.4070203@ti.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7041FB6AA@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> -----Original Message-----
>> From: Nori, Sekhar
>> Sent: Wednesday, October 10, 2012 8:46 AM
>> To: Nori, Sekhar
>> Cc: Karicheri, Muralidharan; Hilman, Kevin; davinci-linux-open-
>> source at linux.davincidsp.com; mturquette at linaro.org; linux-c6x-dev at linux-c6x.org;
>> arnd at arndb.de; linus.walleij at linaro.org; linux-kernel at vger.kernel.org;
>> rob.herring at calxeda.com; linux-keystone at list.ti.com - Linux developers for Keystone
>> family of devices (May contain non-TIers); viresh.linux at gmail.com;
>> linux at arm.linux.org.uk; akpm at linux-foundation.org; shawn.guo at linaro.org; linux-arm-
>> kernel at lists.infradead.org
>> Subject: Re: [PATCH 02/13] clk: davinci - add PSC clock driver
>> 
>> On 10/10/2012 6:05 PM, Sekhar Nori wrote:
>> 
>> >> +struct clk *clk_register_davinci_psc(struct device *dev, const char *name,
>> >> +			const char *parent_name,
>> >> +			struct clk_davinci_psc_data *psc_data,
>> >> +			spinlock_t *lock)
>> >
>> > Why do you need the lock to be provided from outside of this file? You
>> > can initialize a lock for serializing writes to PSC registers within
>> > this file, no?
>> 
>> Looking again, it seems like the common clock framework defines an "enable_lock" in
>> drivers/clk/clk.c to serialize the clock enable/disable calls. Unless I am missing something,
>> this lock seems unnecessary.
>> 

I think you are right. For enable() api, enable_lock is sufficient and I will remove this.

>> Thanks,
>> Sekhar
