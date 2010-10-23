From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Fri, 22 Oct 2010 19:43:00 -0700
Subject: [PATCHv5 2/3] ARM: imx: Add gpio-keys to plat-mxc
In-Reply-To: <20101022194215.GB8554@pengutronix.de>
References: <1287766575-4092-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1287766575-4092-2-git-send-email-Dinh.Nguyen@freescale.com>
	<20101022182812.GA8554@pengutronix.de>
	<86A0E76937111F4C92FABEC0A2098851051D6090@az33exm21>
	<20101022194215.GB8554@pengutronix.de>
Message-ID: <86A0E76937111F4C92FABEC0A2098851051D6116@az33exm21>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

>-----Original Message-----
>From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
>Sent: Friday, October 22, 2010 2:42 PM
>To: Nguyen Dinh-R00091
>Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux at arm.linux.org.uk;
>s.hauer at pengutronix.de; valentin.longchamp at epfl.ch; daniel at caiaq.de; grant.likely at secretlab.ca;
>bryan.wu at canonical.com; amit.kucheria at canonical.com
>Subject: Re: [PATCHv5 2/3] ARM: imx: Add gpio-keys to plat-mxc
>
>Hello Dinh,
>
>On Fri, Oct 22, 2010 at 11:58:16AM -0700, Nguyen Dinh-R00091 wrote:
>> >-----Original Message-----
>> >From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
>> >Sent: Friday, October 22, 2010 1:28 PM
>> >To: Nguyen Dinh-R00091
>> >Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux at arm.linux.org.uk;
>> >s.hauer at pengutronix.de; valentin.longchamp at epfl.ch; daniel at caiaq.de; grant.likely at secretlab.ca;
>> >bryan.wu at canonical.com; amit.kucheria at canonical.com
>> >Subject: Re: [PATCHv5 2/3] ARM: imx: Add gpio-keys to plat-mxc
>> >
>> >On Fri, Oct 22, 2010 at 11:56:14AM -0500, Dinh.Nguyen at freescale.com wrote:
>> >> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
>> >>
>> >> Add imx_add_gpio_keys function to add gpio-keys in plat-mxc
>> >>
>> >> This patch is based on Sascha Hauer's imx/linux-2.6 for-rmk tree.
>> >(This information isn't interesting once the patch is in git, so it can
>> >better go after the tripple-dash below.)
>> >
>> >> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
>> >Patch 1 depends on this one, so you should swap their order.
>> >
>> >> ---
>> >I share the concerns of Arnaud.  MX51_GPIO_PAD_CTRL looks OK,
>> >PAD_CTL_PUS_100K_UP does not.
>>
>> How do you suggest I define this pin for Babbage board only? Do I add to iomux-mx51.h
>> #define MX51_BABBAGE_PAD_EIM_A27__GPIO_2_21             IOMUX_PAD(0x45c, 0x0c8, 1, 0x0,
>0,MX51_GPIO_PAD_CTRL | PAD_CTL_PUS_100K_UP) ?
>>
>> Or do I define the pin in the board file with a 100K_UP? Like how eukrea_mbimxsd-baseboard.c did for
>MBIMXSD_GPIO_3_31?
>I'd suggest something local to your machine file.  Unfortunately I don't
>see an easy way to reuse the generic MX51_PAD_EIM_A27__GPIO_2_21 to
>define your local symbol.  So I think something like you wrote above
>should be fine.
>
>Too bad that
>
>	#define MX51_BABBAGE_PAD_EIM_A27__GPIO_2_21 (MX51_PAD_EIM_A27__GPIO_2_21 | PAD_CTL_PUS_100K_UP)
>
>doesn't work.

Yes, I also wish I didn't have to redefine the pin just because of PAD setting change. I am going to send out another patch that basically sets the pad_desc.pad_ctrl=PAD_SETTING in mxc_init_board() function. I think it's a bit cleaner than having to redefine the pin.

>Best regards
>Uwe
>
>--
>Pengutronix e.K.                           | Uwe Kleine-K?nig            |
>Industrial Linux Solutions                 | http://www.pengutronix.de/  |

Thanks,
Dinh
