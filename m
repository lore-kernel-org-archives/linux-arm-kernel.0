From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 04 Jul 2012 08:52:01 +0200
Subject: [PATCH v4] mm: cma: add a simple kernel module as the helper to
 test CMA
In-Reply-To: <op.wgvfgmm03l0zgt@mpn-glaptop>
References: <1331120259-30780-1-git-send-email-Barry.Song@csr.com>
 <03e601cd58ec$5b8177b0$12846710$%szyprowski@samsung.com>
 <CAGsJ_4yjV+HDXdYraJ6CdJrSz1EPGgE6BRvO-_9n+6_UWfxqww@mail.gmail.com>
 <op.wgvfgmm03l0zgt@mpn-glaptop>
Message-ID: <000301cd59b1$87094eb0$951bec10$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, July 03, 2012 2:54 PM Michal Nazarewicz wrote:

> > 2012/7/3 Marek Szyprowski <m.szyprowski@samsung.com>:
> >> IMHO the right place for such code is in drivers/misc instead of tools/cma.
> >>
> >> This patch contains a kernel module source code so it should be put with other kernel
> >> modules. tools/ directory is aimed to contain user space code useful for developing and
> >> testing Linux kernel.
> 
> On Tue, 03 Jul 2012 09:39:34 +0200, Barry Song <21cnbao@gmail.com> wrote:
> > this one is aiming to test CMA, it should be in tools/ as Michal
> > Nazarewicz and i have talked about that.
> > it is not a real driver at all.
> 
> Yeah, I feel like it's better placed in tools/ not to pollute other directories with
> drivers that are of no use to regular users.  I don't have strong feelings about it
> though, so I'm fine either way.

Other test devices/drivers are in drivers directory (drivers/usb/misc/usbtest.c for
example), I don't see any good reason for polluting tools/ directory with kernel code. 

IMHO the right person to decide if it makes sense to have such drivers in drivers/mics/
or tools/cma/ is Greg KH. Barry, please resend it and ask Greg for the decision.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
