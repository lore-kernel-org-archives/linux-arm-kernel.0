From: tj@kernel.org (Tejun Heo)
Date: Mon, 5 Aug 2013 11:01:27 -0400
Subject: [PATCH] WIP: HACK: LPAE, BOOTMEM and NO_BOOTMEM
In-Reply-To: <51FC1F3A.8090201@ti.com>
References: <20130629175743.GA382@mtj.dyndns.org>
 <CAE9FiQXHuP-n0eZ9wN73V4nSvE+XEExDsx1t50_=YaW+V=LGLg@mail.gmail.com>
 <20130629195549.GE3353@n2100.arm.linux.org.uk>
 <CAE9FiQUoVNvWmmTV2+ZkU_nMxFToTHw6QLwp_Z_EjwMzqdLwuA@mail.gmail.com>
 <51D18DBA.6090608@ti.com> <51F1A7AA.8080700@ti.com>
 <20130725223658.GJ26107@mtj.dyndns.org> <51F1B17F.30902@ti.com>
 <20130726030812.GB30195@mtj.dyndns.org> <51FC1F3A.8090201@ti.com>
Message-ID: <20130805150127.GC19631@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Aug 02, 2013 at 05:06:02PM -0400, Santosh Shilimkar wrote:
> Looking at the situation, how about proceeding with patch updating
> the bootmem API signatures to use phys_addr_t  which can unblock me
> to get my machine working.

I'm not sure about that.  No matter how you play it, it'll end up
duplicating memblock interface.

> Introduction of new API, conversions of core kernel code and then

What new API are we talking about?  Wasn't the plan to convert core
kernel code to use memblock and let bootmem emulate bootmem API?
There's no new API.

> arches moving away from bootmem is going to take significant time

And arches moving away from bootmem doesn't have to happen now.

> anyways. I will continue my effort to get ARM port moved to no-bootmem
> and get that merged.

Thanks.

-- 
tejun
