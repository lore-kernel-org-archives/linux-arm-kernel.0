From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 28 Jun 2018 13:07:59 +0300
Subject: [PATCH 1/2] ARM: dts: armada388-clearfog: enable spi flash
In-Reply-To: <20180628095113.GC17271@n2100.armlinux.org.uk>
References: <2bc87e3e365c460943730ded86c8fcb1ff55a533.1530170016.git.baruch@tkos.co.il>
 <20180628095113.GC17271@n2100.armlinux.org.uk>
Message-ID: <20180628100759.45clx3diuv6tk3e3@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for reviewing.

On Thu, Jun 28, 2018 at 10:51:14AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 28, 2018 at 10:13:35AM +0300, Baruch Siach wrote:
> > The SolidRun Armada 388 SOM has the SPI flash populated by default
> > unless the customer explicitly asks otherwise. Enable support by
> > default.
> 
> Are you sure about that - at least some of my boards do not have the
> SPI flash populated.
> 
> &spi1 {
>         /* The microsom has an optional W25Q32 on board, connected to CS0 */
> ...
> &spi1 {
>         /*
>          * Add SPI CS pins for clearfog:
>          * CS0: W25Q32 (not populated on uSOM)

I should update this line as well, I guess.

>          * CS1: PIC microcontroller (Pro models)
>          * CS2: mikrobus
>          */
> 
> I wouldn't have written "not populated on uSOM" without having first
> taken the uSOM off and physically checked.

Are these production SOMs or development/engineering samples?

Ilya Viten from the SolidRun commercial department told me that all production 
SOMs that were shipped to customers have the SPI flash populated.

This is just the default value for the common case.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
