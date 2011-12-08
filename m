From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Thu, 8 Dec 2011 15:37:04 +0000
Subject: [RFC PATCH 0/8] Add common ARM cpuidle init code
In-Reply-To: <20111208145653.GF7913@S2100-06.ap.freescale.net>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
 <20111208145653.GF7913@S2100-06.ap.freescale.net>
Message-ID: <201112081537.04789.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 December 2011, Shawn Guo wrote:
> > 
> With many drivers are being moved into drivers/* from arch/arm/mach-*
> and arch/arm/plat-*, I'm wondering if we have any problem with doing
> the same thing on cpuidle.  If we can move these cpuidle drivers into
> drivers/cpuidle (or drivers/idle, I'm not sure why two folders), that
> will be the best place for such consolidation to me.
> 
> Cc-ed linux-pm and Len Brown for helping understand.

I think we should definitely move them into one of the two directories.
The one thing making this a bit nasty is that many SoC implementation
need to access some global registers for this and don't have a "device"
that can be used for cpuidle with its own register ranges, but it's
still better to have the code in a single place IMHO.

	Arnd
