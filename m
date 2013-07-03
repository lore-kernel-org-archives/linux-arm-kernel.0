From: olof@lixom.net (Olof Johansson)
Date: Wed, 3 Jul 2013 11:27:12 -0700
Subject: amba-pl08x and 'get_signal' namespace collision/build error
In-Reply-To: <20130627094650.GC4283@n2100.arm.linux.org.uk>
References: <51C97F40.5030101@arm.com>
 <20130625184539.GB2718@n2100.arm.linux.org.uk>
 <20130626044842.GR23141@intel.com>
 <20130626081909.GD2718@n2100.arm.linux.org.uk>
 <20130626103930.GS23141@intel.com>
 <20130627094650.GC4283@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMgSPNggnBm=E3B774m7Ad_QMXdqvcGqRMxhap6dtpNtCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Thu, Jun 27, 2013 at 2:46 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jun 26, 2013 at 04:09:30PM +0530, Vinod Koul wrote:
>> On Wed, Jun 26, 2013 at 09:19:09AM +0100, Russell King - ARM Linux wrote:
>> > On Wed, Jun 26, 2013 at 10:18:42AM +0530, Vinod Koul wrote:
>> > > Yup. This is fixed in slave-dma tree by a patch from mark by renaming it.
>> > >
>> > > This should not show in the -next tree
>> >
>> > Except, that change probably is probably responsible for this new error:
>> >
>> > drivers/dma/amba-pl08x.c: In function 'pl08x_request_mux':
>> > drivers/dma/amba-pl08x.c:304:13: error: expected identifier before '(' token
>> This was pushed four days ago and havent seen any error report expect this.
>>
>> Anyway I rebuild my -next and looks fine for me
>>
>>   CC      drivers/dma/dmaengine.o
>>   CC      drivers/dma/virt-dma.o
>>   CC      drivers/dma/iovlock.o
>>   CC [M]  drivers/dma/dmatest.o
>>   CC      drivers/dma/amba-pl08x.o
>>   LD      drivers/dma/built-in.o
>>
>> Can you share your config which failed for you?
>>
>> Mark, I believe you are testing for this, have you seen above error?
>
> Right, what's going on is that I have a commit in my tree which adds an
> include to asm/pgtable.h which introduces a #define for get_signal.
> This becomes visible to amba-pl08x.c.
>
> However, my build test tree fails *every* time because what I'm building
> is Linus' tree, my tree plus arm-soc, and it doesn't include your tree.
> This makes my build testing for the next merge window impossible.
>
> So, I need the fix to pl08x.c merged into my tree.

This has now hit the mainline kernel, and several defconfigs (nhk815,
lpc32xx and the spear ones) are broken there.

Vinod, when are you sending up your pull request with the fix? It'd be
good to see it go in soon.


-Olof
