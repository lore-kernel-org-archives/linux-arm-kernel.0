From: j-keerthy@ti.com (Keerthy)
Date: Thu, 9 Nov 2017 09:55:25 +0530
Subject: [PATCH v2 2/7] arm: omap: Move dmtimer.h out of plat-omap
In-Reply-To: <20171108164221.GV28152@atomide.com>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-3-git-send-email-j-keerthy@ti.com>
 <20171108164221.GV28152@atomide.com>
Message-ID: <6ca9c73a-95a1-2466-151e-cdba64c3c478@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 08 November 2017 10:12 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [171108 12:31]:
>> The header file is currently under plat-omap directory
>> under arch/omap. Move this out to an accessible place.
>>
>> No Code changes done to the header file.
> 
> Some of the dmtimer functions are in this header to optimize the
> size of the system timer code. Can you please check if some of them
> can be left out of dmtimer.h and be made private to mach-omap1/timer.c
> and mach-omap2/timer.c?

Okay. I will try to clean that as well.

> 
> Again, we don't want driver code to start mis-using these as that's
> immediately going to be big mess out of control.

Sure.

> 
> Regards,
> 
> Tony
> 
