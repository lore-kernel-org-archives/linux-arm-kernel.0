From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 22 Oct 2010 19:07:51 +0200
Subject: [PATCHv4 1/2] ARM: imx: Add gpio-keys to mx51 babbage board
In-Reply-To: <86A0E76937111F4C92FABEC0A2098851051D6045@az33exm21> (Nguyen
	Dinh-R's message of "Fri, 22 Oct 2010 09:32:00 -0700")
References: <1287687324-6101-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101021191018.GX19834@pengutronix.de>
	<86A0E76937111F4C92FABEC0A2098851051D6045@az33exm21>
Message-ID: <87aam6b1g8.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nguyen Dinh-R00091 <R00091@freescale.com> writes:

Hi,

[...]

>>> index e46b1c2..7ae27e8 100644
>>> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
>>> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
>>> @@ -114,7 +114,7 @@ typedef enum iomux_config {
>>>  #define MX51_PAD_EIM_A24__GPIO_2_18             IOMUX_PAD(0x450, 0x0bc, 1, 0x0,   0, NO_PAD_CTRL)
>>>  #define MX51_PAD_EIM_A25__GPIO_2_19             IOMUX_PAD(0x454, 0x0c0, 1, 0x0,   0, NO_PAD_CTRL)
>>>  #define MX51_PAD_EIM_A26__GPIO_2_20             IOMUX_PAD(0x458, 0x0c4, 1, 0x0,   0, NO_PAD_CTRL)
>>> -#define MX51_PAD_EIM_A27__GPIO_2_21             IOMUX_PAD(0x45c, 0x0c8, 1, 0x0,   0, NO_PAD_CTRL)
>>> +#define MX51_PAD_EIM_A27__GPIO_2_21             IOMUX_PAD(0x45c, 0x0c8, 1, 0x0,   0,
>>MX51_GPIO_PAD_CTRL | PAD_CTL_PUS_100K_UP)
>>Is this a generic change valid for all mx51 machines or only for the
>>babbage board?
>
> This is a change that is probably valid for all mx51 machines, but I have only tested on Babbage. 

While I agree to change from NO_PAD_CTRL to MX51_GPIO_PAD_CTRL, I
believe that adding PAD_CTRL_PUS_100K_UP is not valid for all
machines. For instance, one may want PAD_CTL_PUS_47K_UP or no
pull-up at all because one has been added on the board.
Also, if it's generic, I'll be happy to understand why it has not been
added to MX51_GPIO_PAD_CTRL when MX51_GPIO_PAD_CTRL was added.

Regards,
Arnaud
