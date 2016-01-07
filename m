From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 7 Jan 2016 08:42:47 -0600
Subject: [PATCH] arm: pci: mark the dra7xx driver as broken
In-Reply-To: <20160107092553.GA7378@localhost.localdomain>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com>
 <20160107081102.GA6243@localhost.localdomain> <568E2566.6000209@ti.com>
 <20160107092553.GA7378@localhost.localdomain>
Message-ID: <CAErSpo4HdsB0Rqj3P+GkLwLFDyajfRWOiV_LptGsZVrE7cGOow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 3:25 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Thu, Jan 07, 2016 at 02:14:22PM +0530, Kishon Vijay Abraham I wrote:
>> In my point of view the driver is not broken as such but an independent piece
>> (reset) which is missing, since this driver compiles and works fine if that
>> reset piece is added. You are right in that this shouldn't have been probed
>> since it's known that the reset piece is missing. Maybe we should just set
>> "status = disabled" in dra7.dtsi and when that reset piece is added enable it
>> back in dra7-evm.dts?
>
> That isn't strong enough, IMHO, since status=disabled is the default
> for most every DTS item.  Maybe you could comment the PCI block out or
> remove it and put a comment in about the missing piece and the lock up
> behavior.  It is really a nasty bug to have the machine freeze up with
> no output at all.  It took me some time to figure out what was going
> on, and it would be a shame if someone else sets status=okay in their
> board file and has to repeat the whole exercise.

It sounds like dra7xx is missing a piece of essential functionality.
If that's the case, what is the benefit of having it in the kernel at
all?  It makes work for everybody else (adapting to changes outside
the driver), but it sounds like nobody gets any benefit.

If somebody posts a patch to remove the driver entirely to
linux-pci at vger.kernel.org, we can discuss whether that's the right
thing to do.

Bjorn
