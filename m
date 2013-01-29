From: mrugesh.mk@ti.com (Katepallewar, Mrugesh)
Date: Tue, 29 Jan 2013 07:35:07 +0000
Subject: [PATCH V2] ARM: davinci: da850: add RTC DT entries
In-Reply-To: <5106A105.6030004@ti.com>
References: <1359359268-9781-1-git-send-email-mrugesh.mk@ti.com>
 <5106A105.6030004@ti.com>
Message-ID: <4232EB8829679242B82E712C3DB3149D42355C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 21:32:13, Nori, Sekhar wrote:
> Hi Mrugesh,
> 
> On 1/28/2013 1:17 PM, Mrugesh Katepallewar wrote:
> > Add RTC DT entries in da850 dts file.
> > 
> > Signed-off-by: Mrugesh Katepallewar <mrugesh.mk@ti.com>
> > ---
> > Applies on top of v3.8-rc4 of linus tree.
> > 
> > This patch is depending on
> > "ARM: davinci: da850: add interrupt-parent property in soc node"
> > https://patchwork.kernel.org/patch/2044101/
> 
> > Tested on da850-evm device.
> > 
> > Test Procedure:
> > date 2013.01.28-10:00:00 (usage: date[YYYY.]MM.DD-hh:mm[:ss]) hwclock 
> > -w reset board and check system time.
> 
> Queuing this for v3.9. The testing information above is useful and should be part of the changelog. I moved it there while committing.
> 
> It will be nice to check the alarm functionality as well. Can you check that and let me know that works as well?

I tried to test RTC alarm using "rtcwake" command, however it is not working and returning following error 
"rtcwake: /dev/rtc0 not enabled for wakeup events"
This is coming because we have not registered RTC device as a wakeup source yet. 

For checking RTC alarm interrupt, I developed one simple program which opens RTC device, set alarm and exits.
Then by entering "cat /proc/interrupts" checked RTC interrupt count.

Using above test it confirms that RTC alarm functionality is working fine. 

> 
> Thanks,
> Sekhar
> 


Regards, 
Mrugesh
