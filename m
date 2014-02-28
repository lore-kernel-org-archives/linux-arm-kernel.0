From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Feb 2014 17:36:36 +0000
Subject: [RFC v2 PATCH 1/1] ARM64: KGDB: Add FP/SIMD debug support
In-Reply-To: <CALicx6v12DWQSqpP=pa_gJmyOqm4LmFHWc_9=n8Rt7M=krB+dQ@mail.gmail.com>
References: <1384776417-29076-1-git-send-email-vijay.kilari@gmail.com>
 <1384776417-29076-2-git-send-email-vijay.kilari@gmail.com>
 <CAKv+Gu_yMFE7YLKG=KuiW-vCjbjkpWDjyBx+43PW4t32M7P22g@mail.gmail.com>
 <CALicx6t+V8Vt7u-8saV=e1KzK99D=_O_UsSvPrdMY3j9xR3opw@mail.gmail.com>
 <CAKv+Gu9-XqLmvZ1HhCKvgM5=BvZWbR8SSnb7oJzMqGja_LHbAw@mail.gmail.com>
 <CALicx6uRtxhj0+Fj98WtFAXssbV5G6sNQjkWikxaZnbMkBmWhA@mail.gmail.com>
 <CALicx6v12DWQSqpP=pa_gJmyOqm4LmFHWc_9=n8Rt7M=krB+dQ@mail.gmail.com>
Message-ID: <20140228173636.GG30996@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 11:08:58AM +0000, Vijay Kilari wrote:
> On Fri, Nov 29, 2013 at 3:27 PM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> >>> KGDB, being kernel debugger it was thought that allow
> >>> debugging only if kernel mode is supported.
> >>> In fact, I proposed (previous email)  to remove this condition and
> >>> allow to reading neon
> >>> registers always and allow write only if neon is in kernel mode.
> >>>
> >>
> >> I think KGDB is a special case here and should not considered as a
> >> user of kernel mode NEON. So even writing the registers should
> >> allowable regardless of this setting imo.
> >>
> 
>  Can we avoid checking on NEON state and allow debugger to
> access NEON registers irrespective of state to keep it simple?
> and just compile config is enough?

I'm afraid I don't follow... I think we *do* need to do the relevant
flush/sync operations, I just don't think it should be predicated on
KERNEL_MODE_NEON.

Will
