From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 28 Nov 2016 08:32:36 +0100
Subject: Adding a .platform_init callback to sdhci_arasan_ops
In-Reply-To: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
References: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
Message-ID: <982d633b-e9c4-0f10-052b-e324f094d0f5@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Sai for Xilinx perspective.

On 25.11.2016 16:24, Sebastian Frias wrote:
> Hi,
> 
> When using the Arasan SDHCI HW IP, there is a set of parameters called
> "Hardware initialized registers"
> 
> (Table 7, Section "Pin Signals", page 56 of Arasan "SD3.0/SDIO3.0/eMMC4.4
> AHB Host Controller", revision 6.0 document)
> 
> In some platforms those signals are connected to registers that need to
> be programmed at some point for proper driver/HW initialisation.
> 
> I found that the 'struct sdhci_ops' contains a '.platform_init' callback
> that is called from within 'sdhci_pltfm_init', and that seems a good
> candidate for a place to program those registers (*).
> 
> Do you agree?
> 
> Best regards,
> 
> Sebastian
> 
> 
> (*): This has been prototyped on 4.7 as working properly.
> However, upstream commit:
> 
> commit 3ea4666e8d429223fbb39c1dccee7599ef7657d5
> Author: Douglas Anderson <dianders@chromium.org>
> Date:   Mon Jun 20 10:56:47 2016 -0700
> 
>     mmc: sdhci-of-arasan: Properly set corecfg_baseclkfreq on rk3399
> ...
> 
> could affect this solution because of the way the 'sdhci_arasan_of_match'
> struct is used after that commit.
> 
