From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Oct 2012 18:15:49 +0530
Subject: [PATCH 02/13] clk: davinci - add PSC clock driver
In-Reply-To: <50756B96.1070008@ti.com>
References: <1348682889-9509-1-git-send-email-m-karicheri2@ti.com>
 <1348682889-9509-3-git-send-email-m-karicheri2@ti.com>
 <50756B96.1070008@ti.com>
Message-ID: <50756DFD.4070203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2012 6:05 PM, Sekhar Nori wrote:

>> +struct clk *clk_register_davinci_psc(struct device *dev, const char *name,
>> +			const char *parent_name,
>> +			struct clk_davinci_psc_data *psc_data,
>> +			spinlock_t *lock)
> 
> Why do you need the lock to be provided from outside of this file? You
> can initialize a lock for serializing writes to PSC registers within
> this file, no?

Looking again, it seems like the common clock framework defines an
"enable_lock" in drivers/clk/clk.c to serialize the clock enable/disable
calls. Unless I am missing something, this lock seems unnecessary.

Thanks,
Sekhar
