From: omycle@gmail.com (Li Haifeng)
Date: Sat, 13 Oct 2012 00:47:22 -0000
Subject: When flush all dcache, why the increasing step is 2?
In-Reply-To: <20121012120946.GB17525@arm.com>
References: <CAFNq8R7f41O3fHgOu7_XHkrOw44gujjGgVekS3anzdYwVgmZww@mail.gmail.com>
 <20121012120946.GB17525@arm.com>
Message-ID: <CAFNq8R41duY51+ZuYDMAv24DPb9DR6Wdbgp6zmAz=-xzG=YRDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/12 Catalin Marinas <catalin.marinas@arm.com>

> On Fri, Oct 12, 2012 at 11:51:07AM +0100, Li Haifeng wrote:
> > For flush all data cache, the flush action begins from Level 0, then
> increase
> > cache level by 1.
> >
> > But in function v7_flush_dcache_all, the step is 2. IOW, it will just
> flush
> > 0,2,4,6 level cache.
> > As the following code, the step is stored in r10, and the increase line
> is "add
> >     r10, r10, #2".
>
> That's because the cache level is written in the CSSELR bits 3:1 (so no
> bit 0). When the levels of cache is calculated (r3), it is also 2x.
>

Great, Thanks very much.


>
> --
> Catalin
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121013/125a1cb6/attachment-0001.html>
