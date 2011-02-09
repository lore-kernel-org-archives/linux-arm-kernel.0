From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 9 Feb 2011 08:46:18 +0100
Subject: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <19794.17994.381937.158944@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Shawn Guo writes:
> This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> The driver calls into mxs-dma via generic dmaengine api for both pio
> and data transfer.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/mmc.h |   15 +
>  drivers/mmc/host/Kconfig             |    9 +
>  drivers/mmc/host/Makefile            |    1 +
>  drivers/mmc/host/mxs-mmc.c           |  884 ++++++++++++++++++++++++++++++++++
>  4 files changed, 909 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/mmc.h
>  create mode 100644 drivers/mmc/host/mxs-mmc.c
> 
I've run the mmc-test kernel module with this driver on our TX28
module which fails in the following tests:
|mmc0: Test case 15. Correct xfer_size at write (start failure)...
|mmc0: Result: ERROR (-110)
|mmc0: Test case 16. Correct xfer_size at read (start failure)...
|mmc0: Result: ERROR (-110)
|mmc0: Test case 17. Correct xfer_size at write (midway failure)...
|mmc0: Result: ERROR (-110)
|mmc0: Test case 18. Correct xfer_size at read (midway failure)...
|mmc0: Result: ERROR (-110)

Could you try the test on your hardware?


Best regards,
Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
