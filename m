From: shawn.gsc@gmail.com (Shawn Guo)
Date: Wed, 12 Jan 2011 20:33:03 +0800
Subject: [PATCH] mxcmmc: use dmaengine API
In-Reply-To: <20110112122541.GA6569@freescale.com>
References: <1294826996-13764-1-git-send-email-s.hauer@pengutronix.de>
	<1294826996-13764-2-git-send-email-s.hauer@pengutronix.de>
	<20110112122541.GA6569@freescale.com>
Message-ID: <AANLkTim8Uc7h-GDEitGNC1k56twLF9313FkokbQsqKdf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 8:25 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> It seems all the tabs were turned into spaces.
>
My problem.  Sorry for the noise.

> On Wed, Jan 12, 2011 at 11:09:56AM +0100, Sascha Hauer wrote:
>> This switches the mxcmmc driver to use the dmaengine API. Unlike
>> the old one this one is always present in the tree, even if no DMA
>> is implement, hence we can remove all the #ifdefs in from the driver.
>> The driver automatically switches to PIO mode if no DMA support or no
>> suitable channel is available.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>> ?drivers/mmc/host/mxcmmc.c | ?172 +++++++++++++++++++++++++--------------------
>> ?1 files changed, 97 insertions(+), 75 deletions(-)
>>
> [...]
>
> --
> Regards,
> Shawn
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Regards,
Shawn
