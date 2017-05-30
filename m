From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 May 2017 15:02:34 +0100
Subject: [PATCH 6/6] arm64: dts: marvell: enable GICP and ICU on Armada
 7K/8K
In-Reply-To: <1496135772-20694-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1fb18947-33e8-abc9-e78f-970e702af3ee@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/17 10:16, Thomas Petazzoni wrote:
> This commit modifies the Marvell EBU Armada 7K and 8K Device Tree files
> to describe the ICU and GICP units, and use ICU interrupts for all
> devices in the CP110 blocks.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  5 ++
>  .../boot/dts/marvell/armada-cp110-master.dtsi      | 60 +++++++++++++---------
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 54 ++++++++++---------
>  3 files changed, 71 insertions(+), 48 deletions(-)
> 

[...]

> @@ -221,13 +229,13 @@
>  			cps_crypto: crypto at 800000 {
>  				compatible = "inside-secure,safexcel-eip197";
>  				reg = <0x800000 0x200000>;
> -				interrupts = <GIC_SPI 34 (IRQ_TYPE_EDGE_RISING
> +				interrupts = <ICU_GRP_NSR 87 (IRQ_TYPE_EDGE_RISING
>  				| IRQ_TYPE_LEVEL_HIGH)>,

I've already mentioned this in a separate thread to Antoine, but it'd be
good to fix this non-sensical configuration.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
