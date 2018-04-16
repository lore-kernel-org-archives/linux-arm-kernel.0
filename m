From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 16 Apr 2018 10:17:14 +0200
Subject: [PATCH] ARM: dts: imx6ull: add UART5 input select register
 definition
In-Reply-To: <4f010fbd-9f6a-1f4e-efb5-564fba1b6cf6@i2se.com>
References: <1522189496-27837-1-git-send-email-gerg@linux-m68k.org>
 <CAOMZO5CB=JkNqtkSf+QE_rjwNsOutfsS4=nWW0uVZdV63Op+eA@mail.gmail.com>
 <4f010fbd-9f6a-1f4e-efb5-564fba1b6cf6@i2se.com>
Message-ID: <0977332f-fb45-6d6d-8643-6efdce5d14a2@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 29.03.2018 um 17:35 schrieb Stefan Wahren:
> Am 28.03.2018 um 00:45 schrieb Fabio Estevam:
>> On Tue, Mar 27, 2018 at 7:24 PM, Greg Ungerer <gerg@linux-m68k.org> 
>> wrote:
>>> The iMX6ULL UART5_RX_DATA_SELECT_INPUT DAISY Register has some 
>>> different
>>> bit definitions to that same register in the iMX6UL.
>>>
>>> The bits for the iMX6UL:
>>>
>>> 000 CSI_DATA00_ALT8 ? Selecting Pad: CSI_DATA00 for Mode: ALT8
>>> 001 CSI_DATA01_ALT8 ? Selecting Pad: CSI_DATA01 for Mode: ALT8
>>> 010 GPIO1_IO04_ALT8 ? Selecting Pad: GPIO1_IO04 for Mode: ALT8
>>> 011 GPIO1_IO05_ALT8 ? Selecting Pad: GPIO1_IO05 for Mode: ALT
>>> 100 UART5_TX_DATA_ALT0 ? Selecting Pad: UART5_TX_DATA for Mode: ALT
>>> 101 UART5_RX_DATA_ALT0 ? Selecting Pad: UART5_RX_DATA for Mode: ALT
>>>
>>> But for the iMX6ULL:
>>>
>>> 000 CSI_DATA00_ALT8 ? Selecting Pad: CSI_DATA00 for Mode: ALT8
>>> 001 CSI_DATA01_ALT8 ? Selecting Pad: CSI_DATA01 for Mode: ALT8
>>> 010 GPIO1_IO04_ALT8 ? Selecting Pad: GPIO1_IO04 for Mode: ALT8
>>> 011 GPIO1_IO05_ALT8 ? Selecting Pad: GPIO1_IO05 for Mode: ALT
>>> 100 UART1_TX_DATA_ALT9 ? Selecting Pad: UART1_TX_DATA for Mode: ALT9
>>> 101 UART1_RX_DATA_ALT9 ? Selecting Pad: UART1_RX_DATA for Mode: ALT9
>>> 110 UART5_TX_DATA_ALT0 ? Selecting Pad: UART5_TX_DATA for Mode: ALT0
>>> 111 UART5_RX_DATA_ALT0 ? Selecting Pad: UART5_RX_DATA for Mode: ALT0
>>>
>>> Specifically for a board I am working on with the serial console on 
>>> UART5
>>> I need to be able to enable UART5_RX_DATA_ALT0 mode. There is no 
>>> definition
>>> for the iMX6ULL version of that in imx6ul-pinfunc.h or 
>>> imx6ull-pinfunc.h.
>>>
>>> Create a new definition specific to the iMX6ULL so that is settable.
>>>
>>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>
> I'm okay with the second version of the patch, but i noticed that at 
> least UART5_RTS_B_SELECT_INPUT is also affected.
>
> The bits for the iMX6UL:
>
> 000 CSI_DATA03_ALT8 ? Selecting Pad: CSI_DATA03 for Mode: ALT8
> 001 GPIO1_IO08_ALT8 ? Selecting Pad: GPIO1_IO08 for Mode: ALT8
> 010 GPIO1_IO09_ALT8 ? Selecting Pad: GPIO1_IO09 for Mode: ALT8
> 011 ENET1_RX_EN_ALT1 ? Selecting Pad: ENET1_RX_EN for Mode: ALT1
> 100 ENET1_TX_DATA0_ALT1 ? Selecting Pad: ENET1_TX_DATA0 for Mode: ALT1
> 101 CSI_DATA02_ALT8 ? Selecting Pad: CSI_DATA02 for Mode: ALT8
>
> But for the iMX6ULL:
>
> 000 CSI_DATA03_ALT8 ? Selecting Pad: CSI_DATA03 for Mode: ALT8
> 001 GPIO1_IO08_ALT8 ? Selecting Pad: GPIO1_IO08 for Mode: ALT8
> 010 GPIO1_IO09_ALT8 ? Selecting Pad: GPIO1_IO09 for Mode: ALT8
> 011 UART1_CTS_B_ALT9 ? Selecting Pad: UART1_CTS_B for Mode: ALT9
> 100 UART1_RTS_B_ALT9 ? Selecting Pad: UART1_RTS_B for Mode: ALT9
> 101 ENET1_RX_EN_ALT1 ? Selecting Pad: ENET1_RX_EN for Mode: ALT1
> 110 ENET1_TX_DATA0_ALT1 ? Selecting Pad: ENET1_TX_DATA0 for Mode: ALT1
> 111 CSI_DATA02_ALT8 ? Selecting Pad: CSI_DATA02 for Mode: ALT8
>
> Comparing the datasheets isn't fun ...
>
> Should i provide a patch for this or is there a easier way to figure 
> out all the differences?

gentle ping ...
