From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Mar 2017 16:54:33 +0100
Subject: [PATCH] ARM: dts: rockchip: setup DMA-channels for mmc0 and emmc
 for rk3188
In-Reply-To: <1490109227-4006-1-git-send-email-al.kochet@gmail.com>
References: <1490109227-4006-1-git-send-email-al.kochet@gmail.com>
Message-ID: <11123239.Wc863F7R2R@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Am Dienstag, 21. M?rz 2017, 18:13:47 CET schrieb Alexander Kochetkov:
> This commit enable DMA-based transfers for SD/eMMC card adapters
> and reduce number of interrupts produced by SD-card/eMMC-card
> adapters.
> 
> Sometimes interrupts from SD-card/eMMC-card adapters running in
> PIO mode blocks execution of hrtimers and I2S DMA callbacks for
> a long periods (100 ms or more).
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

I've applied a slightly different variant in [0] with your commit message and
moved the dma properties to the mmc/emmc nodes in rk3xxx.dtsi - as the dma
channels are the same on both rk3188 and rk3066.

While at it, I've also added the sdio dma as there is no need to leave it out.


Also when changing the devicetree, please do not append stuff at the bottom
but instead sort new nodes (the &mmc &emmc in this case) and properties
alphabetically.


Thanks
Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=94bbdd77247d8c16eed5f55dddcf1cbc38d06cc4
