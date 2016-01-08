From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 8 Jan 2016 12:25:34 +0530
Subject: [PATCH] arm: pci: mark the dra7xx driver as broken
In-Reply-To: <CAErSpo4HdsB0Rqj3P+GkLwLFDyajfRWOiV_LptGsZVrE7cGOow@mail.gmail.com>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com> <20160107081102.GA6243@localhost.localdomain>
 <568E2566.6000209@ti.com> <20160107092553.GA7378@localhost.localdomain>
 <CAErSpo4HdsB0Rqj3P+GkLwLFDyajfRWOiV_LptGsZVrE7cGOow@mail.gmail.com>
Message-ID: <568F5D66.4000109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Thursday 07 January 2016 08:12 PM, Bjorn Helgaas wrote:
> On Thu, Jan 7, 2016 at 3:25 AM, Richard Cochran
> <richardcochran@gmail.com> wrote:
>> On Thu, Jan 07, 2016 at 02:14:22PM +0530, Kishon Vijay Abraham I wrote:
>>> In my point of view the driver is not broken as such but an independent piece
>>> (reset) which is missing, since this driver compiles and works fine if that
>>> reset piece is added. You are right in that this shouldn't have been probed
>>> since it's known that the reset piece is missing. Maybe we should just set
>>> "status = disabled" in dra7.dtsi and when that reset piece is added enable it
>>> back in dra7-evm.dts?
>>
>> That isn't strong enough, IMHO, since status=disabled is the default
>> for most every DTS item.  Maybe you could comment the PCI block out or
>> remove it and put a comment in about the missing piece and the lock up
>> behavior.  It is really a nasty bug to have the machine freeze up with
>> no output at all.  It took me some time to figure out what was going
>> on, and it would be a shame if someone else sets status=okay in their
>> board file and has to repeat the whole exercise.
> 
> It sounds like dra7xx is missing a piece of essential functionality.
> If that's the case, what is the benefit of having it in the kernel at
> all?  It makes work for everybody else (adapting to changes outside
> the driver), but it sounds like nobody gets any benefit.

During the time pci-dra7xx driver was merged, the reset controller driver was
already being discussed in the list. And I didn't think it'll take this long
for it to be merged. And I didn't want pci driver development to be hampered by
these external pieces. That's why I sent the pci-dra7xx patches for merging.

IMHO merging pci-dra7xx helped to keep active development of the driver, though
I agree we should have kept mechanisms to keep the driver disabled either from
dt or in Kconfig and a way to tell that reset piece is missing if someone has
to enable the driver.
> 
> If somebody posts a patch to remove the driver entirely to
> linux-pci at vger.kernel.org, we can discuss whether that's the right
> thing to do.

I think that's not required now since Tony agreed to have pdata approach to
perform reset till reset controller is merged. I'll be posting patch for it soon.

Thanks
Kishon
