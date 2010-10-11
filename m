From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon, 11 Oct 2010 13:34:30 +0300
Subject: [PATCH 3/3] mx51: Move OTG initialisation for all boards to a
	single file
In-Reply-To: <20101007074853.GZ28242@pengutronix.de>
References: <cover.1286412080.git.amit.kucheria@linaro.org>
	<2306a14fec6647b68a4aee1743a75d040ec141b1.1286412080.git.amit.kucheria@linaro.org>
	<20101007074853.GZ28242@pengutronix.de>
Message-ID: <AANLkTimVo8uLHq4zCskBU4C_nWYiw89BxUw2FM_p3qhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 7, 2010 at 10:48 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Added Daniel to Cc as he might say something here aswell.

<snip>

> I have recently looked at the way the USB phy settings are handled on
> i.MX and it's coming to its limits. Currently the phy settings are coded
> into generic flags, passed to the usb driver which then calls
> mxc_initialize_usb_hw() which dispatches the different SoCs and translates
> the generic flags back into SoC specific ones. ?While this was doable
> until now it fails badly on i.MX51 as we see here.
> The phy settings are totally static to a given board, so we could simply
> let the board call a mx51_init_usb_phy() which gets a pointer to a
> struct with all relevant register settings. And we could pass this
> function SoC specific register settings without having to encode them
> into generic flags and decode them again later.
>
> Sascha

Sascha,

Do you think something like this will be better? It looks even more
scattered to me, the usb configuration information is scattered across
platform_data and phy_data.

Or did you want to get rid of platform_data->init too from the driver?

Regards,
Amit
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mxc-Stop-passing-usb-phy-configuration-to-the-ehci-d.patch
Type: text/x-patch
Size: 9144 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101011/0d8b79a1/attachment.bin>
