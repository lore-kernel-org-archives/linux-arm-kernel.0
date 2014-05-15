From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 15 May 2014 11:42:44 +0530
Subject: [PATCH] ARM: Don't ever downscale loops_per_jiffy in SMP systems#
In-Reply-To: <CAD=FV=XM2URyJjV9gaE=mrp7LAEGtvi9wQGhGJi3_HYp_XzYWg@mail.gmail.com>
References: <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
 <alpine.LFD.2.11.1405081149190.980@knanqh.ubzr>
 <CAD=FV=VtcLOh51LCmafzRMdqtDrwKXCqK6gE6V7OOOUe4gjwbA@mail.gmail.com>
 <alpine.LFD.2.11.1405081329010.980@knanqh.ubzr>
 <20140508192209.GH3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405081600260.980@knanqh.ubzr>
 <20140508205223.GI3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405082058130.980@knanqh.ubzr>
 <20140509091824.GL3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405091245070.980@knanqh.ubzr>
 <20140509182245.GM3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405091640090.980@knanqh.ubzr>
 <CAD=FV=UJK1nSPjH-au-KtbnOZk2nC7usLD8L9neMedj6WHUp8g@mail.gmail.com>
 <CAD=FV=XM2URyJjV9gaE=mrp7LAEGtvi9wQGhGJi3_HYp_XzYWg@mail.gmail.com>
Message-ID: <CAKohpokoov4yr_oKW=Nv3gG1tfQMR2Wifr1=cD5s6MbvoFOUpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2014 03:20, Doug Anderson <dianders@chromium.org> wrote:
> ...but then I found the true problem shows up when we transition
> between very low frequencies on exynos, like between 200MHz and
> 300MHz.  While transitioning between frequencies the system
> temporarily bumps over to the "switcher" PLL running at 800MHz while
> waiting for the main PLL to stabilize.  No CPUFREQ notification is
> sent for that.  That means there's a period of time when we're running
> at 800MHz but loops_per_jiffy is calibrated at between 200MHz and
> 300MHz.
>
>
> I'm welcome to any suggestions for how to address this.

I have attempted to fix this in a generic way and sent an RFC patch for
this. I have cc'd only few people from this list which I thought would be
interested in cpufreq stuff, sorry if I missed anyone.

https://lkml.org/lkml/2014/5/15/40
