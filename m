From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 19 Mar 2012 23:36:31 +0530
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <201203191611.59064.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <201203191406.35064.arnd@arndb.de>
 <20120319153334.GF16389@n2100.arm.linux.org.uk>
 <201203191611.59064.arnd@arndb.de>
Message-ID: <CABb+yY3cJZO_A+Z5vtOkyt5XEX7exhPk5ZG8Mm35n3DFryBk5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 9:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Secondly, there are platforms (Samsung) where peripherals are connected
>> to more than one DMA controller, and either DMA controller can be used -
>> I'm told by Jassi that there's reasons why you'd want to select one or
>> other as the target at runtime.
>
> How common is that? If there are only a few drivers that have this
> requirement, we could have this represented in the driver binding, by
> listing multiple channels and giving the device the choice.
>
All Samsung SoCs (last ~4yrs) with PL330 have some peripherals
that could be served by more than one PL330 instance.
The requirement is not from any driver and it is nothing Samsung specific.
Any platform with 1:n client:dmac might want to do stuff like serving
a new channel request from an already active DMAC, rather than
invoking otherwise fully idle one.
Similarly for Mem->Mem, the PL330 distributes its cycles between
active channels, so a platform might want channel allocation uniformly
across PL330 instances.

-jassi
