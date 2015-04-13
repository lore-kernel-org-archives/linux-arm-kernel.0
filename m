From: sophian.yoma@gmail.com (yoma sophian)
Date: Mon, 13 Apr 2015 09:30:39 +0800
Subject: how to mapping device memory in head.S
In-Reply-To: <20150412191420.GP12732@n2100.arm.linux.org.uk>
References: <CADUS3onGVjDd3Mquda2bgeLFvmxZUUYdiwzJ4nd7XjhyyudiDw@mail.gmail.com>
 <20150412191420.GP12732@n2100.arm.linux.org.uk>
Message-ID: <CADUS3o=utaLKTO-kOZmegcxcs0SU+ex7n4PhpdNqvwM9sykzuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Russell

2015-04-13 3:14 GMT+08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Apr 12, 2015 at 08:23:59PM +0800, yoma sophian wrote:
>> hi all:
>> I need to map peripheral address in head.S for early usage.
>
> Basically, you do not.
>
> Please explain in detail what you're trying to do.
We try to calculate and record the booting time from head.S,
start_kernel to rest_init.
so we need to mapping the memory for getting count of counter quite early.
it seems quite waist memory mapping if we use short-descriptor
1st-level section descriptor formats.
And we want to get fix mapping such that the va of counter will be the
same and the va of get counter API doesn't need to change.

>
>> 1. CONFIG_DEBUG_LL is  using short-descriptor 1st-level section
>> descriptor formats. Is it possible to use short-descriptor 2nd-level
>> small page descriptor in head.S?
>
> Definitely not, there is no memory management at that stage to allocate
> a 2nd level descriptor table.
>
>> 2. The peripheral mapping virtual address created in head.S is need to
>> access even after paging_init. Is it possible to put the mapping in
>> the persistent mapping in head.S?
>
> No, we don't support that.
>
Appreciate your kind help,
