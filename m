From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Apr 2012 16:26:05 -0600
Subject: [PATCH V2 3/4] pinctrl: Add SPEAr3xx pinctrl drivers
In-Reply-To: <2a78bbfab59b531adef0820f34f683dd736d3a3a.1333538870.git.viresh.kumar@st.com>
References: <cover.1333538869.git.viresh.kumar@st.com>
 <2a78bbfab59b531adef0820f34f683dd736d3a3a.1333538870.git.viresh.kumar@st.com>
Message-ID: <4F7CCA7D.7070601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2012 05:35 AM, Viresh Kumar wrote:
> This adds pinctrl driver for SPEAr3xx family. SPEAr3xx family supports three
> families: SPEAr300, SPEAr310 and SPEAr320.

> +++ b/Documentation/devicetree/bindings/pinmux/pinmux_spear.txt

> +- st,pinmux-mode: Mandatory for SPEAr300 and SPEAr320
> +	- Its values for SPEAr300:
> +		- NAND_MODE		: <0>
> +		- NOR_MODE		: <1>
> +		- PHOTO_FRAME_MODE	: <2>
> +		- LEND_IP_PHONE_MODE	: <3>
> +		- HEND_IP_PHONE_MODE	: <4>
> +		- LEND_WIFI_PHONE_MODE	: <5>
> +		- HEND_WIFI_PHONE_MODE	: <6>
> +		- ATA_PABX_WI2S_MODE	: <7>
> +		- ATA_PABX_I2S_MODE	: <8>
> +		- CAML_LCDW_MODE	: <9>
> +		- CAMU_LCD_MODE		: <10>
> +		- CAMU_WLCD_MODE	: <11>
> +		- CAML_LCD_MODE		: <12>
> +	- Its values for SPEAr320:
> +		- AUTO_NET_SMII_MODE	: <0>
> +		- AUTO_NET_MII_MODE	: <1>
> +		- AUTO_EXP_MODE		: <2>
> +		- SMALL_PRINTERS_MODE	: <3>
> +		- EXTENDED_MODE		: <4>

I'm not sure what this is. Is it representing packaging options on the
SoC or something like that? I'd personally expect the pinctrl driver to
expose the raw pinmux HW module's capabilities and each board's .dts
file to pick how to configure each option, rather than providing canned
options, but I guess not everyone agrees. Looking at the data in the
rest of the patch though, it looks like you have plenty of
pin/group/function definitions in the driver files though, so this
probably isn't a problem.
