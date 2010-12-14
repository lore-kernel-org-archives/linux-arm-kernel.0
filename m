From: liu.y.victor@gmail.com (Liu Ying)
Date: Tue, 14 Dec 2010 14:47:08 +0800
Subject: [PATCH 9/9] ARM i.MX51 babbage: Add framebuffer support
In-Reply-To: <20101213114332.GF6017@pengutronix.de>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-10-git-send-email-s.hauer@pengutronix.de>
	<AANLkTi=vT8pX1QQ6DjzQatceO-tQb3Zu90CRAVi2DcpZ@mail.gmail.com>
	<20101213114332.GF6017@pengutronix.de>
Message-ID: <AANLkTimPpo5nJ2Bg_wZohgTuB1ypfqGJxvQSu5_2fKz2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/13 Sascha Hauer <s.hauer@pengutronix.de>:
> On Sun, Dec 12, 2010 at 09:37:38AM +0800, Liu Ying wrote:
>> Hello, Sascha,
>>
>> I have following 3 comments to this patch:
>> 1) I think DISP1_DATx pins need not be set specially, as they keep the
>> default register values.
>
> We do not want to depend on default register values in the Linux Kernel.
[LY] Ok. Please add disp1 related pins configuration, including
DISP1_HSYNC, DISP1_VSYNC and DISP1_CLK.
       It will be fine to add disp2 related pins configuration also.
>
>> 2) Please define 'MX51_PAD_DI_GP4__IPU_DI2_PIN15' in
>> arch/arm/plat-mxc/include/mach/iomux-mx51.h, and rename the pin to be
>> 'MX51_PAD_DI_GP4__DI2_PIN15', as we name it according to the MX51
>> iomux reference manual.
>
> I'm not sure. Normally it's good practice to code the unit into the
> name. Otherwise we end up with names like MX51_PAD_xyz__TX which could
> be the tx pin of just about any unit.
>
>
>> 3) It is better to exchange the following two lines or just remove the
>> first line:
>> + ? ? ? gpio_set_value(GPIO_DVI_RESET, 0);
>> + ? ? ? gpio_direction_output(GPIO_DVI_RESET, 0);
>
> ok.
>
> Sascha
>
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
