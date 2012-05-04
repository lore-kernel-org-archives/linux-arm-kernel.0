From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 4 May 2012 15:35:51 +0200
Subject: [PATCH] ARM: imx: rename uart and fec device tree nodes
In-Reply-To: <20120504133301.GJ2194@S2101-09.ap.freescale.net>
References: <1333350084-5993-1-git-send-email-shawn.guo@linaro.org>
 <4FA39D65.3020007@de.bosch.com>
 <20120504133301.GJ2194@S2101-09.ap.freescale.net>
Message-ID: <4FA3DB37.8080002@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.05.2012 15:33, Shawn Guo wrote:
> On Fri, May 04, 2012 at 11:12:05AM +0200, Dirk Behme wrote:
>> Having this patch on a 3.4-rc5 based test branch and booting it on
>> the SabreLite I get (with earlyprintk enabled):
>>
>> Serial: IMX driver
>> imx-uart: probe of 21e8000.serial failed with error -2
>>
>> resulting in no console output. Reverting this patch I get
>>
>> Serial: IMX driver
>> 21e8000.uart: ttymxc1 at MMIO 0x21e8000 (irq = 59) is a IMX
>>
>> and console works fine again.
>>
>> Have I missed anything?
>>
> The patch changes arch/arm/mach-imx/clock-imx6q.c as well.  Not sure
> if you have the changes incorporated in your testing branch.

Yes, I think so

https://github.com/dirkbehme/linux-imx6/commit/ebfac55f157425b5e063cdb2d9668b45a0a6515f#diff-14

> It reminds me that I should rebase my imx/dt branch on Sascha's clk
> series to save the conflict.

My test branch has Sascha's clk series, too. It's mainly based on

https://github.com/dirkbehme/linux-imx6/commits/linux-imx6-staging

Best regards

Dirk
