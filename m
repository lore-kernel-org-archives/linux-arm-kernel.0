From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 1 Dec 2010 13:40:17 -0200
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <20101201111448.GF6017@pengutronix.de>
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
	<AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
	<20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
	<20101125091346.GS6017@pengutronix.de>
	<AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
	<20101129212446.GB6017@pengutronix.de>
	<AANLkTik6CScZ5uL2s_qf9q5w6i13mBk_0CLkLZHCKwSm@mail.gmail.com>
	<20101201111448.GF6017@pengutronix.de>
Message-ID: <AANLkTimofVgY4M7U+aLA1RUz0a2LOmPUFr6bwcj1vcZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Dec 1, 2010 at 9:14 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
...
> It seems the reason for the crash is that firmware_class registers in
> fs_initcall whereas the sdma driver uses it at subsys_initcall time.
> Solution is to either use module_init in the sdma driver or
> subsys_initcall in drivers/base/firmware_class.c.
>
> When given a firmware it works, when no firmware is given the kernel
> locks for some time because it waits for the firmware to appear which
> never happens. We should probably use request_firmware_nowait in the
> sdma driver.
>
> I put together a branch with sdma sound working on the babbage and
> mx35-3ds boards using mx3_defconfig/mx51_defconfig from this branch.
> The branch works with and without firmware with the mentioned wait time
> when the firmware is not available.
>
> BTW I changed the SDMA firmware repository to name the i.MX51 firmware
> *to3.bin instead of to1, because that's what it actually is.
>
> Sound support is a story with many frameworks and a lot of board
> specifics involved, but I hope we manage to sort this out for i.MX soon.
> Sorry for the inconvenience.
>
> It would be great if someone steps forward and mainlines this sgtl5000
> codec driver, that's currently the main showstopper for sound support on
> the Freescale boards.

Thanks a lot for setting up this branch. I can confirm that audio
works on MX51 Babbage on this branch.

I will check internally if someone is willing to mainline sgtl5000.

Thanks,

Fabio Estevam
