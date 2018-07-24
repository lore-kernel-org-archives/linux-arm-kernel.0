From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 24 Jul 2018 14:35:03 +0930
Subject: [PATCH 3/3] ARM: config: multi_v5: Enable ASPEED drivers
In-Reply-To: <CACPK8Xd0ViuVAHgD4Nem5e_th0pf=4hmC=3d0XbLRGGzcDTMDg@mail.gmail.com>
References: <20180718135302.4927-1-joel@jms.id.au>
 <20180718135302.4927-4-joel@jms.id.au>
 <1532408201.2611907.1450747808.5F518C30@webmail.messagingengine.com>
 <CACPK8Xd0ViuVAHgD4Nem5e_th0pf=4hmC=3d0XbLRGGzcDTMDg@mail.gmail.com>
Message-ID: <1532408703.2614071.1450754744.7B42962B@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 24 Jul 2018, at 14:29, Joel Stanley wrote:
> On 24 July 2018 at 14:26, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> > On Wed, 18 Jul 2018, at 23:23, Joel Stanley wrote:
> >> This enables the devices used in the AST2400 family of BMC SoCs:
> >>
> >>  - VUART
> >>  - SPI NOR
> >>  - LPC controller
> >>  - LPC snoop (port 80)
> >>  - Ethernet
> >>  - GPIO
> >>  - ADC
> >>  - I2C
> >>  - Random number generator
> >>  - IPMI KCS
> >>  - IPMI BT
> >>  - Fan/Tach
> >>
> >> Signed-off-by: Joel Stanley <joel@jms.id.au>
> >> ---
> >>  arch/arm/configs/multi_v5_defconfig | 14 +++++++++++++-
> >>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/
> >> multi_v5_defconfig
> >> index b647e249908e..318b76fa26d1 100644
> >> --- a/arch/arm/configs/multi_v5_defconfig
> >> +++ b/arch/arm/configs/multi_v5_defconfig
> >> @@ -90,10 +90,14 @@ CONFIG_MTD_PHYSMAP=y
> >>  CONFIG_MTD_NAND=y
> >>  CONFIG_MTD_NAND_ATMEL=y
> >>  CONFIG_MTD_NAND_ORION=y
> >> +CONFIG_MTD_SPI_NOR=y
> >> +CONFIG_SPI_ASPEED_SMC=y
> >>  CONFIG_MTD_UBI=y
> >>  CONFIG_BLK_DEV_LOOP=y
> >>  CONFIG_ATMEL_TCLIB=y
> >>  CONFIG_ATMEL_SSC=m
> >> +CONFIG_ASPEED_LPC_CTRL=m
> >> +CONFIG_ASPEED_LPC_SNOOP=m
> >
> > Any reason that you switch between module and built-in throughout? It's not clear from the commit message.
> 
> I tried to follow what the existing config did. Some things are
> modules, but some subsystems aren't.
> 
> I figured there's no harm in getting some build coverage of our
> drivers being modules.

Righto.

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> 
> Cheers,
> 
> Joel
