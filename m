From: crope@iki.fi (Antti Palosaari)
Date: Tue, 04 Nov 2014 17:55:31 +0200
Subject: [PATCH v2] ARM: imx: Fix the removal of CONFIG_SPI option
In-Reply-To: <20141104152646.GA8450@pengutronix.de>
References: <1415096927-4097-1-git-send-email-festevam@gmail.com>
 <20141104152646.GA8450@pengutronix.de>
Message-ID: <5458F6F3.8050007@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moikka!

On 11/04/2014 05:26 PM, Uwe Kleine-K?nig wrote:
> [Note, this is a resend of a mail I accidently only sent to Fabio
> before.]
>
> Hello,
>
> On Tue, Nov 04, 2014 at 08:28:47AM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Since 64546e9fe3a5b8c ("ARM: imx_v6_v7_defconfig updates") and commit
>> 0650f855d2e4b0b9 ("ARM: imx_v4_v5_defconfig: Select CONFIG_IMX_WEIM") CONFIG_SPI
>> selection was dropped by savedefconfig for imx_v4_v5_defconfig and
>> imx_v6_v7_defconfig.
>>
>> In order to keep the same behaviour as previous kernel versions and avoid
>> regressions, let's add CONFIG_SPI option back.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> Changes since v1:
>> - Add commit id's that caused the issue.
> on top of 64546e9fe3a5b8c doing
>
>          make imx_v6_v7_defconfig
>
> resulted in CONFIG_SPI=y. That's because MEDIA_SUBDRV_AUTOSELECT selects
> SPI and has default y.
>
> So the commit that really broke imx_v6_v7_defconfig is 7d24c514e8e0
> ([media] Kconfig: do not select SPI bus on sub-driver auto-select).
> On a side note I wonder how that commit sneaked into v3.17-rc6.
>
> I think people need to be more aware of the results of Kconfig changes

I added that SPI select patch for 3.17-rc1 and it was removed right 
after I got bug report it should not be there. But there was of course 
some delay and removal patch went to 3.17-rc6.

But all in all, it was all happening during 3.17 period and I wonder how 
it could affect you?

Here are related discussions:

[GIT PULL for 3.17-rc1] media updates for next
https://lkml.org/lkml/2014/8/5/646

Autoselecting SPI for MEDIA_SUBDRV_AUTOSELECT?
https://lkml.org/lkml/2014/8/22/325

[PATCH] Kconfig: do not select SPI bus on sub-driver auto-select
https://lkml.org/lkml/2014/8/22/452

[GIT PULL 3.17] FIX: remove SPI select from Kconfig
http://permalink.gmane.org/gmane.linux.drivers.video-input-infrastructure/81346

[GIT PULL for v3.17-rc6] media fixes
https://lkml.org/lkml/2014/9/21/44

regards
Antti

-- 
http://palosaari.fi/
