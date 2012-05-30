From: nm@ti.com (Menon, Nishanth)
Date: Wed, 30 May 2012 10:18:12 -0500
Subject: [PATCHv2 17/19] ARM: OMAP4: put cpu1 back to sleep if no wake
 request
In-Reply-To: <CAMQu2gy0Lwga0gDhT7+iOFM6ZLPnW4Q0qo_r4=cW6L4s5fbLZw@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-18-git-send-email-t-kristo@ti.com> <87396z3axv.fsf@ti.com>
 <1337595695.28274.32.camel@sokoban>
 <CAMQu2gy0Lwga0gDhT7+iOFM6ZLPnW4Q0qo_r4=cW6L4s5fbLZw@mail.gmail.com>
Message-ID: <CAOMWX4fnrKCMyZZ7S=vMcQ+9npiq2WDhTj=7Asyq=+B3dcMujw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 5:40 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>
>>>
> Not sure what you mean wakeup issue on GP device.
>
> IIUC, the issue is:
> Wakeup from device OFF, hardware releases the reset for both CPUs,
> This is special case and applicable only for device OFF. The reason
> CPU1 needs to be hold back, because the security SW is affined with
> CPU0 which needs to be up and running for any of the ROM code APIs
> to work. Like setting up SMP bit, AUX control etc. Without CPU0 booted,
> CPU1 won't be able to execute those ROM functions and hence won't be
> able to boot properly.
>
> I think the limitation is applicable to all OMAP4 devices as well as OMAP5
> devices.
yes, the stagger of CPU1 behind CPU0 has a few factors:
HS devices with an older PPA release has a bug where caches can be
messed up and GP devices
need slightly different WA. with the older PPA, we put CPU1 back to
OFF when we detect that CPU0 is not ready for action
you can find the details and documentation in the link below:
http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/sleep44xx.S;h=0c28def8f644e9803564bb66c8cfe8c580898978;hb=p-android-omap-3.0#l342


Regards,
Nishanth Menon
