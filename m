From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 27 Feb 2012 18:27:24 +0100
Subject: [PATCH 07/15] ARM: at91: clean-up mach/io.h
In-Reply-To: <4F4BB591.4070708@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-8-git-send-email-robherring2@gmail.com>
 <4F3A2797.7000402@atmel.com> <4F3A6097.2030606@gmail.com>
 <20120216074300.GA19779@game.jcrosoft.org>
 <4F3D0DCB.6090403@gmail.com>
 <20120216142351.GC19779@game.jcrosoft.org>
 <4F4676C8.5000909@atmel.com> <4F4BB591.4070708@gmail.com>
Message-ID: <20120227172724.GE3318@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:55 Mon 27 Feb     , Rob Herring wrote:
> On 02/23/2012 11:26 AM, Nicolas Ferre wrote:
> > On 02/16/2012 03:23 PM, Jean-Christophe PLAGNIOL-VILLARD :
> >> On 08:08 Thu 16 Feb     , Rob Herring wrote:
> >>> On 02/16/2012 01:43 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>> On 07:24 Tue 14 Feb     , Rob Herring wrote:
> >>>>> On 02/14/2012 03:21 AM, Nicolas Ferre wrote:
> >>>>>> On 02/13/2012 10:43 PM, Rob Herring :
> >>>>>>> From: Rob Herring <rob.herring@calxeda.com>
> >>>>>>>
> >>>>>>> Move most of io.h into at91_io.h and update includes.
> >>>>>>>
> >>>>>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> >>>>>>> ---
> >>>>>>>  arch/arm/mach-at91/at91cap9.c                     |    1 +
> >>>>>>>  arch/arm/mach-at91/at91cap9_devices.c             |    1 +
> >>>>>>
> >>>>>> Please do not touch the "*cap9*" files anymore: They are scheduled for
> >>>>>> removal for 3.4 kernel:
> >>>>>> Documentation/feature-removal-schedule.txt
> >>>>>
> >>>>> Okay.
> >>>>>
> >>>>>>
> >>>>>>>  arch/arm/mach-at91/at91rm9200.c                   |    1 +
> >>>>>>>  arch/arm/mach-at91/at91rm9200_devices.c           |    1 +
> >>>>>>>  arch/arm/mach-at91/at91rm9200_time.c              |    1 +
> >>>>>>>  arch/arm/mach-at91/at91sam9260.c                  |    1 +
> >>>>>>>  arch/arm/mach-at91/at91sam9260_devices.c          |    1 +
> >>>>>>>  arch/arm/mach-at91/at91sam9261.c                  |    1 +
> >>>>>>>  arch/arm/mach-at91/at91sam9261_devices.c          |    1 +
> >>>>>>>  arch/arm/mach-at91/at91sam9263.c                  |    1 +
> >>>>>>>  arch/arm/mach-at91/at91sam9263_devices.c          |    1 +
> >>>>>>>  arch/arm/mach-at91/at91sam9g45.c                  |    1 +
> >>>>>>>  arch/arm/mach-at91/at91sam9g45_devices.c          |    1 +
> >>>>>>>  arch/arm/mach-at91/at91sam9rl.c                   |    1 +
> >>>>>>>  arch/arm/mach-at91/at91sam9rl_devices.c           |    1 +
> >>>>>>>  arch/arm/mach-at91/at91x40.c                      |    1 +
> >>>>>>>  arch/arm/mach-at91/at91x40_time.c                 |    1 +
> >>>>>>>  arch/arm/mach-at91/board-cap9adk.c                |    1 +
> >>>>>>>  arch/arm/mach-at91/board-cpu9krea.c               |    1 +
> >>>>>>>  arch/arm/mach-at91/board-eco920.c                 |    1 +
> >>>>>>>  arch/arm/mach-at91/board-yl-9200.c                |    1 +
> >>>>>>>  arch/arm/mach-at91/clock.c                        |    1 +
> >>>>>>>  arch/arm/mach-at91/include/mach/at91_io.h         |   44 +++++++++++++++++++++
> >>>>>>>  arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h |    2 +
> >>>>>>>  arch/arm/mach-at91/include/mach/at91sam9_sdramc.h |    2 +
> >>>>>>>  arch/arm/mach-at91/include/mach/uncompress.h      |    1 +
> >>>>>>>  arch/arm/mach-at91/pm.c                           |    1 +
> >>>>>>>  arch/arm/mach-at91/pm.h                           |    2 +
> >>>>>>>  arch/arm/mach-at91/setup.c                        |    1 +
> >>>>>>>  drivers/pcmcia/at91_cf.c                          |    1 +
> >>>>>>>  drivers/rtc/rtc-at91sam9.c                        |    2 +-
> >>>>>>>  drivers/usb/gadget/at91_udc.c                     |    1 +
> >>>>>>>  drivers/watchdog/at91rm9200_wdt.c                 |    1 +
> >>>>>>>  drivers/watchdog/at91sam9_wdt.c                   |    1 +
> >>>>>>>  34 files changed, 80 insertions(+), 1 deletions(-)
> >>>>>>>  create mode 100644 arch/arm/mach-at91/include/mach/at91_io.h
> >>>>>>>
> >>>>>
> >>>>> snip
> >>>>>
> >>>>>>> diff --git a/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h b/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
> >>>>>>> index e2f8da8..0427212 100644
> >>>>>>> --- a/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
> >>>>>>> +++ b/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
> >>>>>>> @@ -12,6 +12,8 @@
> >>>>>>>  #ifndef AT91SAM9_DDRSDR_H
> >>>>>>>  #define AT91SAM9_DDRSDR_H
> >>>>>>>  
> >>>>>>> +#include <mach/at91_io.h>
> >>>>>>
> >>>>>> Do we need this include in header files?
> >>>>>
> >>>>> Yes, for at91_sys_write/read used at the bottom.
> >>>> no need I droped the at91_sys_read/write for 3.4
> >>>>
> >>>
> >>> Everywhere or just this header? Is this in a stable branch somewhere?
> >> everywhere
> >>
> >> I'm preparing it
> > 
> > Jean and I have worked on this for the last two weeks... and I think
> > that we have something you can take as an example:
> >   git://github.com/at91linux/linux-at91.git at91-3.4-base2+cleanup
> > 
> > I will not qualify this branch as "stable" as it is not yet included in
> > arm-soc git tree (pull request sent at the very moment). But I think
> > that you will be able to rely on it once it will be included in arm-soc.
> > On the other hand, if it sound too late for you, we can adapt your work
> > on top of that new branch of ours.
> 
> With this branch and io.h removed, I just get 1 error with uncompress.h
> needing an explicit include:
> 
> In file included from
> /home/rob/proj/git/linux-2.6/arch/arm/boot/compressed/misc.c:28:0:
> /home/rob/proj/git/linux-2.6/arch/arm/mach-at91/include/mach/uncompress.h:
> In function ?putc?:
> /home/rob/proj/git/linux-2.6/arch/arm/mach-at91/include/mach/uncompress.h:55:39:
> error: ?AT91_BASE_DBGU0? undeclared (first use in this function)
> /home/rob/proj/git/linux-2.6/arch/arm/mach-at91/include/mach/uncompress.h:55:39:
> note: each undeclared identifier is reported only once for each function
> it appears in
> /home/rob/proj/git/linux-2.6/arch/arm/mach-at91/include/mach/uncompress.h:
> In function ?flush?:
> /home/rob/proj/git/linux-2.6/arch/arm/mach-at91/include/mach/uncompress.h:66:39:
> error: ?AT91_BASE_DBGU0? undeclared (first use in this function)
> make[3]: *** [arch/arm/boot/compressed/misc.o] Error 1
>   CC      arch/arm/boot/compressed/decompress.o
> In file included from
> /home/rob/proj/git/linux-2.6/arch/arm/boot/compressed/misc.c:28:0:
> /home/rob/proj/git/linux-2.6/arch/arm/mach-at91/include/mach/uncompress.h:
> In function ?putc?:
> /home/rob/proj/git/linux-2.6/arch/arm/mach-at91/include/mach/uncompress.h:55:39:
> error: ?AT91_BASE_DBGU0? undeclared (first use in this function)
> /home/rob/proj/git/linux-2.6/arch/arm/mach-at91/include/mach/uncompress.h:55:39:
> note: each undeclared identifier is reported only once for each function
> it appears in
> /home/rob/proj/git/linux-2.6/arch/arm/mach-at91/include/mach/uncompress.h:
> In function ?flush?:
> /home/rob/proj/git/linux-2.6/arch/arm/mach-at91/include/mach/uncompress.h:66:39:
> error: ?AT91_BASE_DBGU0? undeclared (first use in this function)
> 
so you need to include mach/hardware.h

as io.h was including it

Best Regards,
J.
