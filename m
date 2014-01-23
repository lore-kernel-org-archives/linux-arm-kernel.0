From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 22 Jan 2014 17:46:13 -0800
Subject: [PATCH v4 00/36] mtd: st_spi_fsm: Add new driver
In-Reply-To: <20140122125049.GA8586@lee--X1>
References: <1389188840-14306-1-git-send-email-lee.jones@linaro.org>
 <20140108143316.GA14575@lee--X1> <20140122125049.GA8586@lee--X1>
Message-ID: <20140123014613.GX8919@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Jan 22, 2014 at 12:50:49PM +0000, Lee Jones wrote:
> > Version 4:
> >   Tended to Brian's previous review comments
> >     - Checkpatch acceptance
> >     - MODULE_DEVICE_TABLE() name slip correction
> >     - Timeout issue(s) resolved
> >     - Potential infinite loop mitigated
> >     - Code clarity suggests heeded
> >     - Duplication with MTD core code removed
> >     - Upgraded to using ROUND_UP() helper
> >     - Moved non-shared header code into main driver
> >     - Relocated dynamic msg sequence stores into main struct
> >     - Averted adaption of static (table) data
> >     - Basic whitespace/spelling/data type/dev_err suggestions accepted
> > 
> > Version 3:
> >   Okay, this thing should be fully functional now. Identify a chip
> >   based on it's JEDEC ID, Read, Write, Erase (all or by sector).
> >   Support for various chip quirks added too.
> >  
> > Version 2:
> >   The first bunch of these patches have been on the MLs before, but
> >   didn't receive a great deal of attention for the most part. We are
> >   a little more featureful this time however. We can now successfully
> >   setup and configure the N25Q256. We still can't read/write/erase
> >   it though. I'll start work on that next week and will provide it in
> >   the next instalment.
> >  
> > Version 1:
> >   First stab at getting this thing Mainlined. It doesn't do a great deal
> >   yet, but we are able to initialise the device and dynamically set it up
> >   correctly based on an extracted JEDEC ID.
> > 
> >  Documentation/devicetree/bindings/mtd/st-fsm.txt |   26 ++
> >  arch/arm/boot/dts/stih416-b2105.dts              |   14 +
> >  arch/arm/boot/dts/stih416-pinctrl.dtsi           |   12 +
> >  drivers/mtd/devices/Kconfig                      |    8 +
> >  drivers/mtd/devices/Makefile                     |    1 +
> >  drivers/mtd/devices/serial_flash_cmds.h          |   81 ++++
> >  drivers/mtd/devices/st_spi_fsm.c                 | 2124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  7 files changed, 2266 insertions(+)
> 
> Can you confirm receipt of this set, or would you like me to resend?

Well, I personally have the patch set but haven't had a chance to review
it. Can you resend with MTD in the CC, since we haven't had any comments
anyway? I believe MTD people are much less likely to look at it if you
forget the CC :)

You can just title it [PATCH RESEND v4 X/Y], possibly with a LKML
link back to the original v4, if you want to help avoid confusion.

Brian
