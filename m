From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 30 Jul 2010 23:33:29 -0700
Subject: [PATCH] Input: Make ADS7846 independent on regulator
In-Reply-To: <1280555108-27994-1-git-send-email-marek.vasut@gmail.com>
References: <1280555108-27994-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100731063329.GA23620@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sat, Jul 31, 2010 at 07:45:08AM +0200, Marek Vasut wrote:
> In case regulator was not found, ADS7846 failed to probe.
> 
> This fixes a problem on some Sharp Zaurus devices, where there is no regulator
> present and yet the touchscreen is used.
> 

Too many ifdefs to my taste... Can we have ads7846_regulator_enable()
and friends stubbed out in case !CONFIG_REGULATOR?

-- 
Dmitry
