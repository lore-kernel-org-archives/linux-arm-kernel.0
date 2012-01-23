From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 23 Jan 2012 07:29:00 +0100
Subject: [PATCH 0/7] at91 : pm.h cleanups
In-Reply-To: <201201111523.57368.arnd.bergmann@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <201201111523.57368.arnd.bergmann@linaro.org>
Message-ID: <20120123062900.GP25622@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:23 Wed 11 Jan     , Arnd Bergmann wrote:
> On Wednesday 11 January 2012, Daniel Lezcano wrote:
> > 
> > This patchset is the first series to cleanup some code around pm.h, pm.c and
> > cpuidle. The next series will bring more cleanups and finally the third series
> > will change the different functions into ops where we can export the structure
> > definition in order to encapsulate the code and move the at91's cpuidle driver
> > to the drivers/cpuidle directory.
> 
> Hi Daniel,
> 
> These all look like useful cleanups. You don't really have to split them
> up into so small units, but it doesn't hurt if you do. Patch 5 seems to
> actually fix a bug, but probably a harmless one.
> 
> It's not clear where you're headed though, I hope that becomes more obvious
> in the next patches. The tricky bit that will have to be done is to turn
> all the #ifdef checks into runtime here. You have moved the #include for the
> memory controller into a new header, but that is not actually progress
> on this larger problem. It would be nice to move the
> sdram_selfrefresh_enable/disable functions into a .c file that uses
> cpu_is_at91...() to do runtime detection, but AFAICT that won't work
> because you have to guarantee that all the code between these is
> in the cache, right?
we may have much simple way move it to sram as done in slow clock

Best Regards,
J.
