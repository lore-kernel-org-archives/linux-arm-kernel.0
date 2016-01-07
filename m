From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 7 Jan 2016 10:25:53 +0100
Subject: [PATCH] arm: pci: mark the dra7xx driver as broken
In-Reply-To: <568E2566.6000209@ti.com>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com>
 <20160107081102.GA6243@localhost.localdomain>
 <568E2566.6000209@ti.com>
Message-ID: <20160107092553.GA7378@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 02:14:22PM +0530, Kishon Vijay Abraham I wrote:
> In my point of view the driver is not broken as such but an independent piece
> (reset) which is missing, since this driver compiles and works fine if that
> reset piece is added. You are right in that this shouldn't have been probed
> since it's known that the reset piece is missing. Maybe we should just set
> "status = disabled" in dra7.dtsi and when that reset piece is added enable it
> back in dra7-evm.dts?

That isn't strong enough, IMHO, since status=disabled is the default
for most every DTS item.  Maybe you could comment the PCI block out or
remove it and put a comment in about the missing piece and the lock up
behavior.  It is really a nasty bug to have the machine freeze up with
no output at all.  It took me some time to figure out what was going
on, and it would be a shame if someone else sets status=okay in their
board file and has to repeat the whole exercise.

Thanks,
Richard
