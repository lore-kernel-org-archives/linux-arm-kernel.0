From: christian.koenig@amd.com (=?windows-1252?Q?Christian_K=F6nig?=)
Date: Mon, 1 Jun 2015 11:51:10 +0200
Subject: [PATCH 05/98] exynos_drm.h: use __u64 from linux/types.h
In-Reply-To: <20150601093808.GP2067@n2100.arm.linux.org.uk>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
 <1433000370-19509-6-git-send-email-mikko.rapeli@iki.fi>
 <20150530164655.GM2067@n2100.arm.linux.org.uk> <556C15BA.7000909@amd.com>
 <20150601085605.GN2067@n2100.arm.linux.org.uk> <556C2105.2090607@amd.com>
 <20150601093808.GP2067@n2100.arm.linux.org.uk>
Message-ID: <556C2B0E.8000001@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.06.2015 11:38, Russell King - ARM Linux wrote:
> On Mon, Jun 01, 2015 at 11:08:21AM +0200, Christian K?nig wrote:
>> Yeah, completely agree with Linus on the visibility problem and that's
>> exactly the reason why we don't include <stdint.h> in the kernel header and
>> expect userspace to define the ISO types somewhere.
>>
>> But using the types from "include/linux/types.h" and especially including it
>> into the uapi headers doesn't make the situation better, but rather worse.
>>
>> With this step we not only make the headers depend on another header that
>> isn't part of the uapi, but also pollute the user space namespace with __sXX
>> and __uXX types which aren't defined anywhere else.
> 1) Header files are permitted to pollute userspace with __-defined stuff.
>
> 2) __[su]XX types are defined as part of the kernel's uapi.
>     include/uapi/linux/types.h includes asm/types.h, which in userspace
>     picks up include/uapi/asm-generic/types.h.  That picks up
>     asm-generic/int-ll64.h, which defines these types.
>
> Moreover, this is done throughout the kernel headers _already_ (as you
> would expect for a policy set 10+ years ago).
>
> Please, I'm not interested in this discussion, so please don't argue
> with me - I may agree with your position, but what you think and what
> I think are really not relevant here.  If you have a problem, take it
> up with Linus - I made that clear in my email.
>
In this case I'm fine with the changes, but I'm still not sure if that's 
a good idea or not.

Sticking to ISO C still sounds better than doing something on our own. 
And it now looks a bit different than it was in 2004, stdint.h is widely 
adopted in userspace if I'm not completely mistaken.

Anyway you're perfectly right that Linus need to decide and I'm not in 
the mod to argue with him either (got way to much other things to do as 
well).

Regards,
Christian.
