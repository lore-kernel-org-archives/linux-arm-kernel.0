From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Oct 2016 22:09:23 -0700
Subject: [PATCH] ARM: dts: lpc32xx: add device node for IRAM on-chip memory
In-Reply-To: <1467931601-25067-1-git-send-email-vz@mleia.com>
References: <1467931601-25067-1-git-send-email-vz@mleia.com>
Message-ID: <20161003050923.GA4403@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 01:46:41AM +0300, Vladimir Zapolskiy wrote:
> The change adds a new device node with description of generic SRAM
> on-chip memory found on NXP LPC32xx SoC series and connected to AHB
> matrix slave port 3.
> 
> Note that NXP LPC3220 SoC has 128KiB of SRAM memory, the other
> LPC3230, LPC3240 and LPC3250 SoCs all have 256KiB SRAM space,
> in the shared DTSI file this change specifies 128KiB SRAM size.
> 
> Also it's worth to mention that the SRAM area contains of 64KiB banks,
> 2 banks on LPC3220 and 4 banks on the other SoCs from the series, and
> all SRAM banks but the first one have independent power controls,
> the description of this feature will be added with the introduction of
> power domains for the SoC series.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> ---
> 
> Hi Arnd, Olof, Kevin,
> 
> please consider to include this NXP LPC32xx DT change directly to
> ARM tree for v4.8.
> 
> The SRAM device node will be utilized to store PM resume code
> and to store MAC buffers.

Hi,

When sweeping my inbox looking for patches we had missed, this still showed
up from back in July. I've now applied it, it'll make it into 4.9 (in
next/late). Sorry for missing it earlier.


-Olof
