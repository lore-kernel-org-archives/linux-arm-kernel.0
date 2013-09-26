From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Sep 2013 17:29:47 -0300
Subject: device tree binding documentation outdated
In-Reply-To: <20130926195158.GS12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Sep 26, 2013 at 4:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Can someone please point me at the current documentation for the
> iMX6DL pinctrl bindings?

Best reference is the mx6dl reference manual (chapter 37 - IOMUXC):
http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6SDLRM.pdf

> I mean the stuff which looks like this:
>
> #define MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0           0x1e8 0x5b8 0x858 0x2 0x0

Let me try to decode it:

0x1e8: Offset of IOMUXC_SW_MUX_CTL_PAD_ENET_MDC register

0x5b8: Offset of IOMUXC_SW_PAD_CTL_PAD_ENET_MDC register

0x2: This means that the MUX_MODE field selects the ESAI_TX5_RX0 function
in this pad

0x0: SELECT_INPUT not used for this pad

> which clearly doesn't match:
>
> Required properties for pin configuration node:
> - fsl,pins: two integers array, represents a group of pins mux and config
>   setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is a
>   pin working on a specific function, which consists of a tuple of
>   <mux_reg conf_reg input_reg mux_val input_val>.  CONFIG is the pad setting
>   value like pull-up on this pin.
>
> I thought DT was supposed to make bringing up support on new hardware
> easier, but without documentation, I'm frankly stuffed with the cubox-i,
> because it's impossible to work out what the right pinctrl settings
> should be from what seems to be an undocumented pile of random numbers
> stuffed into DT.

Let me know if you need help with the iomux settings for cubox-i.

Regards,

Fabio Estevam
