From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Fri, 1 Mar 2013 17:12:47 -0300
Subject: [PATCH 12/14] ARM: OMAP2+: Add additional GPMC timing parameters
In-Reply-To: <CALF0-+VVmZHkRggN0Xj-6=gQ9Rm09qU4hKuLoD-iE6_jqPbm+g@mail.gmail.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-13-git-send-email-jon-hunter@ti.com>
 <CALF0-+VVmZHkRggN0Xj-6=gQ9Rm09qU4hKuLoD-iE6_jqPbm+g@mail.gmail.com>
Message-ID: <CALF0-+X4RR2YFAH-W64MV=xuXRnbx04hvYa694DiN8C8h5U_Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 1, 2013 at 5:11 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
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
>

Also, since this is somewhat large patchset: would you mind pushing it somewhere
so I can just pull a branch?

Thanks,
-- 
    Ezequiel
