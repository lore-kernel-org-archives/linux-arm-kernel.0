From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 19 Jan 2011 18:07:08 -0200
Subject: [PATCH] usb: gadget/fsl_mxc_udc: Detect the CPU type in run-time
In-Reply-To: <20110119185444.GA7228@pengutronix.de>
References: <1295451164-3363-1-git-send-email-fabio.estevam@freescale.com>
	<4D37050E.6010009@eukrea.com> <4D371ABB.7000608@freescale.com>
	<20110119185444.GA7228@pengutronix.de>
Message-ID: <AANLkTi==6U3yv5g4FHF0o=nZdC=bxWiTzjmZS4itWyri@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Jan 19, 2011 at 4:54 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
...
> can you please fix up the position of the '&'?

The original patch had the '&' in the correct position. Looks like it
got shifted on some of the replies.

>
>> >> + ? ? ? ? ? ?v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
>> >> + ? ? ? ? ? ? ? ? ? ?USBPHYCTRL_OTGBASE_OFFSET));
>> >> + ? ? ? ? ? ?writel(v | USBPHYCTRL_EVDO,
>> >> + ? ? ? ? ? ? ? ?MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
>> >> + ? ? ? ? ? ? ? ? ? ?USBPHYCTRL_OTGBASE_OFFSET));
> I wonder if the address isn't mapped via ioremap in the driver and the
> cookie saved somewhere? ?(And no, I don't ask you to change that in this
> patch.) ?(If so, it this already problematic aliasing?)

This address is only used once here and it is related to the MX35 USB erratum.

>
>> >> + ? ? ? ?}
>> >> + ? ?}
>> >>
>> > are you sure this compiles when MX35 is not selected ?
>>
>> Including #include <mach/mx35.h> fixes the build for a non- mx35 kernel.
>>
>> Would this be acceptable? If so, I can send v2.
> If you keep the #if defined(CONFIG_ARCH_MX35) and only add the if
> (cpu_is_mx35()) it should work without a new #include.
> Doing that seems a tad cleaner to me.

Ok, will do as suggested in v2.

Thanks,

Fabio Estevam
