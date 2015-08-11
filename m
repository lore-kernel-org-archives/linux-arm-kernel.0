From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Aug 2015 14:53:30 +0200
Subject: [PATCH 0/2] drivers: PL061: Add platform driver probing support
In-Reply-To: <20150807022141.GD25067@kroah.com>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
 <20150803075848.GH7557@n2100.arm.linux.org.uk>
 <55BF33AD.5040502@huawei.com>
 <20150803094923.GI7557@n2100.arm.linux.org.uk>
 <20150803162623.GB30867@kroah.com>
 <20150803190935.GL7557@n2100.arm.linux.org.uk>
 <20150807022141.GD25067@kroah.com>
Message-ID: <CACRpkdYd_oWsx23h4-Hjk8rqcgnuMqd47SEg+4ubtR08jgQY9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 7, 2015 at 4:21 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Aug 03, 2015 at 08:09:35PM +0100, Russell King - ARM Linux wrote:

>> Right now, there seems to be a move to convert _all_ AMBA device drivers
>> to become dual-drivers: an amba bus driver and a platform driver.  Is
>> that something you really want to see, irrespective of ACPI issues?
>
> Ick, no, I don't think that's wise at all.  Why not just make the needed
> resources availble to _all_ bus drivers, then it doesn't matter if it's
> AMBA, or ACPI, or USB, or anything else?

Amen to that.

> I thought that is what some recent patches did to the acpi/of core, but
> maybe I was mistaken.

I think you're referring to the initiative to provide query functions that will
work the same on device trees and ACPI devices, that is to get a key/value
from a certain struct device * no matter if it came from a DT or ACPI.

This is about how the core hardware description spawns devices. While
DT will (correctly) spawn AMBA devices, the ACPI code apparently
doesn't. But it should. of_amba_device_create() even shows exactly
how to do it.

What I fear is that ACPI actually has no way to tell whether a device is
an AMBA device but rather thinks the whole world consists of
platform_devices, and then *THAT* needs to be fixed.

Yours,
Linus Walleij
