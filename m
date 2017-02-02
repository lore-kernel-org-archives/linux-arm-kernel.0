From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 2 Feb 2017 07:42:36 +0000
Subject: [PATCH v2 00/10] serial: st-asc: Allow handling of RTS line
In-Reply-To: <20170127172804.23881-1-lee.jones@linaro.org>
References: <20170127172804.23881-1-lee.jones@linaro.org>
Message-ID: <20170202074236.ni3tozz3er4g3t64@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg, Jiri,

> When hardware flow-control is disabled, manual toggling of the UART's
> reset line (RTS) using userland applications (e.g. stty) is not
> possible, since the ASC IP does not provide this functionality in the
> same was as some other IPs do.  Thus, we have to do this manually.
> 
> This set ensures the correct Pinctrl groups are configured and
> obtained for both manual toggling of the RTS line and for the IP to
> take over the lines when HW flow-control is requested by the user. 
> 
> Lee Jones (10):
>   serial: st-asc: Ignore the parity error bit if 8-bit mode is enabled
>   serial: st-asc: Provide RTS functionality
>   serial: st-asc: Read in all Pinctrl states
>   serial: st-asc: (De)Register GPIOD and swap Pinctrl profiles
>   serial: st-asc: Use generic DT binding for announcing RTS/CTS lines
>   dt-bindings: serial: Update 'uart-has-rtscts' description
>   ARM: dts: STiH410-b2260: Identify the UART RTS line
>   ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW flow-control
>   ARM: dts: STiH407-family: Use new Pinctrl groups
>   ARM: dts: STiH410-b2260: Enable HW flow-control
> 
>  .../devicetree/bindings/serial/serial.txt          |   3 +-
>  arch/arm/boot/dts/stih407-family.dtsi              |   3 +-
>  arch/arm/boot/dts/stih407-pinctrl.dtsi             |  12 ++-
>  arch/arm/boot/dts/stih410-b2260.dts                |   5 +
>  drivers/tty/serial/st-asc.c                        | 101 +++++++++++++++++++--
>  5 files changed, 110 insertions(+), 14 deletions(-)

Looks like everyone is happy with the set.

Are you planning to merge it?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
