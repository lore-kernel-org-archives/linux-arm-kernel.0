From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 10:55:21 +0100
Subject: [PATCH 5/6] reset: hisilicon: Use new driver reset-hi6222
In-Reply-To: <0dcef3c7-7406-0728-5a18-c277bb8915ad@linaro.org>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
 <3837594.jmpXXfpk9Q@wuerfel>
 <0dcef3c7-7406-0728-5a18-c277bb8915ad@linaro.org>
Message-ID: <6136167.uxgaKz0PCj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 5:46:22 PM CET zhangfei wrote:
> On 2016?11?22? 16:49, Arnd Bergmann wrote:
> > On Tuesday, November 22, 2016 3:49:20 PM CET Zhangfei Gao wrote:
> >> -#define PERIPH_RSTDIS0_MMC0             0x000
> >> -#define PERIPH_RSTDIS0_MMC1             0x001
> >> -#define PERIPH_RSTDIS0_MMC2             0x002
> >> -#define PERIPH_RSTDIS0_NANDC            0x003
> >> -#define PERIPH_RSTDIS0_USBOTG_BUS       0x004
> >> -#define PERIPH_RSTDIS0_POR_PICOPHY      0x005
> >> -#define PERIPH_RSTDIS0_USBOTG           0x006
> >> -#define PERIPH_RSTDIS0_USBOTG_32K       0x007
> >> -#define PERIPH_RSTDIS1_HIFI             0x100
> >> -#define PERIPH_RSTDIS1_DIGACODEC        0x105
> >> +/* reset in sysctrl */
> >> +#define PERIPH_RSTDIS0_MMC0             0
> >> +#define PERIPH_RSTDIS0_MMC1             1
> >> +#define PERIPH_RSTDIS0_MMC2             2
> >> +#define PERIPH_RSTDIS0_NANDC            3
> >> +#define PERIPH_RSTDIS0_USBOTG_BUS       4
> >> +#define PERIPH_RSTDIS0_POR_PICOPHY      5
> >> +#define PERIPH_RSTDIS0_USBOTG           6
> >> +#define PERIPH_RSTDIS0_USBOTG_32K       7
> >> +#define PERIPH_RSTDIS1_HIFI             8
> > You can't redefined the binding here, this is part of the ABI.
> > You can however add new numbers as long as the old ones keep
> > working.
> The methods are different.
> The original define is offset | bit_shift, and driver has to parse 
> offset and bit shift.
> The new define is just index of array, which is defined in the reset-xxx.c

I understand that, what I mean is you have to find a way to let the new
driver still support the old binding, you can't change it.

	Arnd
