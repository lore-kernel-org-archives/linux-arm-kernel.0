From: james.morse@arm.com (James Morse)
Date: Thu, 02 Jul 2015 18:40:32 +0100
Subject: [PATCH v3 2/5] PCI: designware: Add ARM64 support
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D4EC38@lhreml503-mbs>
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
 <1435743817-19083-3-git-send-email-wangzhou1@hisilicon.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D4E4BB@lhreml503-mbs>
 <5593F899.6050306@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D4E6A2@lhreml503-mbs>
 <55942441.3050705@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D4EC38@lhreml503-mbs>
Message-ID: <55957790.9060802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/15 08:24, Gabriele Paoloni wrote:
>> It looks like the BAR containing the bridge window is not being assigned,
>> so no devices on bus 1 are discovered.
> 
> Can you confirm the dtsi you are using..."imx6qdl.dtsi" ?

Yes, that looks right.

The on-disk file was 'imx6q-sabrelite.dtb' when I received the board, I
replaced it with the one from the v4.1 kernel tree.

Decompiled from /sys/firmware/fdt (to eliminate bootloader trickery), the
pcie section reads:
pcie at 0x01000000 {
	compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
	reg = <0x1ffc000 0x4000 0x1f00000 0x80000>;
	reg-names = "dbi", "config";
	#address-cells = <0x3>;
	#size-cells = <0x2>;
	device_type = "pci";
	ranges = <0x800 0x0 0x1f00000 0x1f00000 0x0 0x80000 0x81000000 0x0 0x0
0x1f80000 0x0 0x10000 0x82000000 0x0 0x1000000 0x1000000 0x0 0xf00000>;
	num-lanes = <0x1>;
	interrupts = <0x0 0x78 0x4>;
	interrupt-names = "msi";
	#interrupt-cells = <0x1>;
	interrupt-map-mask = <0x0 0x0 0x0 0x7>;
	interrupt-map = <0x0 0x0 0x0 0x1 0x1 0x0 0x7b 0x4 0x0 0x0 0x0 0x2 0x1 0x0
0x7a 0x4 0x0 0x0 0x0 0x3 0x1 0x0 0x79 0x4 0x0 0x0 0x0 0x4 0x1 0x0 0x78 0x4>;
	clocks = <0x3 0x90 0x3 0xce 0x3 0xbd>;
	clock-names = "pcie", "pcie_bus", "pcie_phy";
	status = "okay";
};



James
