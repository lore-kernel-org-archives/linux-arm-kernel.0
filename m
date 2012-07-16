From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Mon, 16 Jul 2012 13:58:14 +0530
Subject: [RFC PATCH v2 1/2] drivers: misc: omap: add a new driver for
 ocp2scp
In-Reply-To: <20120716081204.GI7955@arwen.pp.htv.fi>
References: <1340370942-23201-1-git-send-email-kishon@ti.com>
 <CAAe_U6+dkiQw-i93pFapt6qKrArzaQoE8X3GjDzUDraziG8B2Q@mail.gmail.com>
 <20120625122449.GA30463@arwen.pp.htv.fi>
 <201206251626.09666.arnd@arndb.de>
 <20120716081204.GI7955@arwen.pp.htv.fi>
Message-ID: <CAAe_U6JMGP3jEkkd=vqpR5KTeOnY51AOcb65zqKRRa8MtnWjzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 16, 2012 at 1:42 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Jun 25, 2012 at 04:26:08PM +0000, Arnd Bergmann wrote:
>> On Monday 25 June 2012, Felipe Balbi wrote:
>> > > > Can't this live where the scp drivers live?  Actually, where is that at?
>> > > > Do we have scp drivers?
>> > > AFAIK, there isn't any driver for scp. But we have a driver for ocp
>> > > and it is present at arch/arm/mach-omap2/omap_l3_noc.c
>> >
>> > I don't think this deserves a directory of its own. Maybe
>> > drivers/platform/arm/omap/ ?? the l3_noc is an OMAP-specific
>> > interconnect and the SCP bus is also an OMAP-specific bus. I don't know
>> > of any other arch/soc who uses the same interconnect IP as OMAP and the
>> > same ocp2scp bridge. That bridge was created by TI for all I know.
>> >
>> > Greg, would drivers/platform/arm/omap/ work for you ? We could also move
>> > the interconnect drivers there.
>>
>> I really don't like the idea of introducing drivers/platform/arm/ because
>> very little of the stuff that one would put in there are actually ARM
>> specific.
>>
>> I have suggested a drivers/bus/ before and people did not see the need
>> back then, and we agreed to continue having a directory for each bus,
>> as we have for the big ones (pci, usb, i2c, spi, ...) and a lot of
>> simple (amba, rapidio, bcma, ...) or obscure (tc,  vlynq, nubus, ...)
>> ones.
>>
>> I think we should reconsider the idea of drivers/bus/ with a file per
>> bus in there at least for new buses, but doing a new drivers/scp/
>> would be ok for me if there is enough opposition against the idea
>> of drivers/bus aggregating different buses.
>
> I don't mind either way. The fact is that this ocp-to-scp bridge is
> really a TI/OMAP thing. Not sure it deserves a directory of its own.

Ok. Then I'll have a file in drivers/bus/ for ocp2scp driver.

Thanks
Kishon
