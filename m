From: gerg@snapgear.com (Greg Ungerer)
Date: Tue, 11 Jan 2011 23:25:41 +1000
Subject: [PATCH v4 05/10] net/fec: add dual fec support for mx28
In-Reply-To: <20110111130749.GQ24920@pengutronix.de>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>	<1294297998-26930-6-git-send-email-shawn.guo@freescale.com>	<20110111102717.GG26617@pengutronix.de>	<4D2C4BEC.1030003@snapgear.com>
	<20110111130749.GQ24920@pengutronix.de>
Message-ID: <4D2C5A55.7050502@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 11/01/11 23:07, Uwe Kleine-K?nig wrote:
> Hi Greg,
>
> On Tue, Jan 11, 2011 at 10:24:12PM +1000, Greg Ungerer wrote:
>> On 11/01/11 20:27, Sascha Hauer wrote:
>>> On Thu, Jan 06, 2011 at 03:13:13PM +0800, Shawn Guo wrote:
>>> This option is used nowhere and should be removed. Certainly it does not
>>> have the effect of enabling the second ethernet controller.
>>
>> It does for a ColdFire platform...
>>
>> grep -r CONFIG_FEC2 *
>>
>> arch/m68knommu/configs/m5275evb_defconfig:CONFIG_FEC2=y
>> arch/m68knommu/platform/527x/config.c:#ifdef CONFIG_FEC2
>> arch/m68knommu/platform/527x/config.c:#ifdef CONFIG_FEC2
> IMHO Sascha's comment[1] applies here, too.

I am not arguing that it doesn't :-)

Simply that removing that config option and doing nothing
else would not be the right thing to do.

Regards
Greg


> And someone might want to do what he suggested soon or the patch
> removing CONFIG_FEC2[2] needs to be commented accordingly.
>
> Best regards
> Uwe
>
> [1] http://thread.gmane.org/gmane.linux.network/182929/focus=183378
> [2] http://mid.gmane.org/1294747672-4433-1-git-send-email-shawn.guo at freescale.com
>


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
