From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 30 Sep 2013 17:31:08 +0200
Subject: [PATCH] ARM: shmobile: ape6evm: fix incorrect placement of
 __initdata tag
In-Reply-To: <1800955.Mbr9gmJOD4@avalon>
References: <26068642.Hn7T63a6ac@amdc1032> <1800955.Mbr9gmJOD4@avalon>
Message-ID: <1556252.bjXjV3hKBt@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, September 30, 2013 05:05:37 PM Laurent Pinchart wrote:
> Hi Bartlomiej,
> 
> Thank you for the patch.
> 
> On Monday 30 September 2013 15:07:47 Bartlomiej Zolnierkiewicz wrote:
> > __initdata tag should be placed between the variable name and equal
> > sign for the variable to be placed in the intended .init.data section.
> > 
> > In this particular case __initdata is incorrect as ape6evm_keys_pdata
> > can be used as a platform data for gpio-keys driver which can be
> > compiled as module.
> 
> A pointer to the ape6evm_keys_pdata structure is passed to the 
> platform_device_register_data() function, which makes a copy of the structure. 
> Marking it as __initdata is thus correct.

Thanks for catching this. I'll fix the patch and post v2.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/mach-shmobile/board-ape6evm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-ape6evm.c
> > b/arch/arm/mach-shmobile/board-ape6evm.c index 7627385..8954f55 100644
> > --- a/arch/arm/mach-shmobile/board-ape6evm.c
> > +++ b/arch/arm/mach-shmobile/board-ape6evm.c
> > @@ -86,7 +86,7 @@ static struct gpio_keys_button gpio_buttons[] = {
> >  	GPIO_KEY(KEY_VOLUMEDOWN,	329,	"S21"),
> >  };
> > 
> > -static struct __initdata gpio_keys_platform_data ape6evm_keys_pdata = {
> > +static struct gpio_keys_platform_data ape6evm_keys_pdata = {
> >  	.buttons	= gpio_buttons,
> >  	.nbuttons	= ARRAY_SIZE(gpio_buttons),
> >  };
