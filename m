From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 1 Mar 2013 16:27:14 -0600
Subject: [PATCH 12/14] ARM: OMAP2+: Add additional GPMC timing parameters
In-Reply-To: <CALF0-+VVmZHkRggN0Xj-6=gQ9Rm09qU4hKuLoD-iE6_jqPbm+g@mail.gmail.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-13-git-send-email-jon-hunter@ti.com>
 <CALF0-+VVmZHkRggN0Xj-6=gQ9Rm09qU4hKuLoD-iE6_jqPbm+g@mail.gmail.com>
Message-ID: <51312B42.4090005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/01/2013 02:11 PM, Ezequiel Garcia wrote:
> Hi Jon,
> 
> On Tue, Feb 26, 2013 at 2:30 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> [...]
>>
>> +       if (!of_property_read_u32(np, "gpmc,bus-turnaround", &val))
>> +               gpmc_t->bus_turnaround = val;
>> +
> 
> AFAIK, you don't need to test if the property is defined.
> You can just read it straightforward, and if the property is not defined
> then nothing will be stored in your variable:
> 
> of_property_read_u32(np, "gpmc,bus-turnaround", &gpmc_t->bus_turnaround);
> 
> You can simplify *a lot* your patch with this, and I believe you could
> also clean
> existent code.

True. I was just being consistent with the existing code in
gpmc_read_timings_dt(). May be I can clean-up the entire function.

Cheers
Jon
