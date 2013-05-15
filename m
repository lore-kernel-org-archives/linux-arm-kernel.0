From: jagarwal@nvidia.com (Jay Agarwal)
Date: Wed, 15 May 2013 22:58:22 +0530
Subject: [PATCH 4/4] ARM: tegra: pcie: Enable PCIe controller on Cardhu
In-Reply-To: <518A8596.7070702@wwwdotorg.org>
References: <1368010660-31465-1-git-send-email-jagarwal@nvidia.com>
 <1368010660-31465-4-git-send-email-jagarwal@nvidia.com>
 <518A8596.7070702@wwwdotorg.org>
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B4886B5D@BGMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 05/08/2013 04:57 AM, Jay Agarwal wrote:
> > - Enable PCIe controller on Cardhu
> > - Only port 2 is connected on this board
> > - Add regulators required for Tegra30
> > - Patch is based on remotes/gitorious_thierryreding_linux/tegra/next
> > - and should be applied on top of this.
> 
> > diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi
> > b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> 
> > +	pcie-controller {
> > +		status = "okay";
> > +		pex-clk-supply = <&pex_hvdd_3v3_reg>;
> > +		vdd-supply = <&ldo1_reg>;
> > +		avdd-supply = <&ldo2_reg>;
> > +
> > +		pci at 3,0 {
> > +			status = "okay";
> > +		};
> > +	};
> 
> So, if I apply this series, I do see the PCIe bridge and Ethernet device get
> enumerated, but I don't see the USB3 controller get enumerated. I believe
> that is a PCIe device behind the same bridge on the same Tegra PCIe port.
> Shouldn't this device show up?
[>]  I have also reproduced this problem. I see somehow no non-prefetchable memory is assigned to any of pcie devices.
Probably that is the reason for USB3 (pci 0000:04:00.0) not getting enumerated since it uses only non-prefetchable memory.
