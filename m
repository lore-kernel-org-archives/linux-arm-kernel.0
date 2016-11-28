From: slash.tmp@free.fr (Mason)
Date: Mon, 28 Nov 2016 20:32:13 +0100
Subject: Adding a .platform_init callback to sdhci_arasan_ops
In-Reply-To: <CAD=FV=XrJHFbpbhsJZAEE-HLMe47Ov=BgvHw8ZtfCazzT75pKQ@mail.gmail.com>
References: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
 <982d633b-e9c4-0f10-052b-e324f094d0f5@xilinx.com>
 <2a949ade-edd7-4690-cd6a-434ae1e663dc@intel.com>
 <66751ab5-59a4-ec30-07cd-44ca03694723@laposte.net>
 <d1801c1e-cd74-b79c-0280-8fb5dc377c91@intel.com>
 <e32d2a01-ba3c-6127-51ba-a1fd4176e32c@laposte.net>
 <485a747c-47e3-bc0e-093a-4ec9ab719987@laposte.net>
 <CAD=FV=XrJHFbpbhsJZAEE-HLMe47Ov=BgvHw8ZtfCazzT75pKQ@mail.gmail.com>
Message-ID: <9c783843-d0e4-92ef-d156-6826e38d9fa8@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/2016 18:46, Doug Anderson wrote:

> As argued in my original patch the field "corecfg_baseclkfreq" is
> documented in the generic Arasan document
> <https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf>
> and thus is unlikely to be Rockchip specific.

I downloaded the data sheet, which doesn't mention registers,
but "pins" and "signals". Does that mean it is up to every
platform to decide how to group these wires into individual
registers?

corecfg_baseclkfreq[7:0]
Base Clock Frequency for SD Clock.
This is the frequency of the xin_clk.

How can 8 bits encode a frequency?
Is there an implicit LUT? Is it a MHz count?

"For maximum efficiency this should be around 200 MHz for eMMC
or 208MHz (for SD3.0)"

Regards.
