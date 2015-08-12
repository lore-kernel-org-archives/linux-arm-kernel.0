From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 12 Aug 2015 15:01:21 +0000 (UTC)
Subject: [PATCH] [ARM][TEGRA] Fix AHB base address on tegra20, tegra30
 and tegra114
In-Reply-To: <1439042292-19912-1-git-send-email-kwizart@gmail.com>
References: <1439042292-19912-1-git-send-email-kwizart@gmail.com>
Message-ID: <alpine.DEB.2.02.1508121500300.7154@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 8 Aug 2015, Nicolas Chauvet wrote:

> Current base address is wrong by 0x04 bytes for AHB bus device as shown in dmesg:
>  tegra-ahb 6000c004.ahb: incorrect AHB base address in DT data - enabling workaround
> 
> To correct old dtbs,  the commit ce7a10b0ff3db63 checks for the low bit
> of the base address and removes theses 0x04 bytes at runtime.
> 
> This patch fix the original dts, so upstream version doesn't need
> the workaround of the base address.
> 
> As both addresses are valid, this patch doesn't break compatibility
> 
> Tested on tegra20-paz00 (aka ac100)
> 
> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
