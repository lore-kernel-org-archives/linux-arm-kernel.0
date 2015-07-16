From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Thu, 16 Jul 2015 15:43:20 -0700
Subject: [PATCH v1 1/2] ARM: keystone: dts: fix dt bindings for PCIe
In-Reply-To: <1437083492-28208-1-git-send-email-m-karicheri2@ti.com>
References: <1437083492-28208-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <55A83388.5040306@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/16/15 2:51 PM, Murali Karicheri wrote:
> Currently PCIe DT bindings are broken. PCIe driver can't function
> without having a SerDes driver that provide the phy configuration.
> On K2E EVM, this causes problem since the EVM has Marvell SATA
> controller present and with default values in the SerDes register,
> it seems to pass the PCIe link check, but causes issues since
> the configuration is not correct. The manifestation is that when
> EVM is booted with NFS rootfs, the boot hangs. We shouldn't enable
> PCIe on this EVM since to work, SerDes driver has to be present as
> well. So by default, the PCIe DT binding should be disabled in SoC
> specific DTS. It can be enabled in the board specific DTS when the
> SerDes device driver is also present.
>
> So fix the status of PCIe DT bindings in the SoC specific DTS to
> "disabled". To enable PCIe, the status should be set to "ok" in
> the EVM DTS file when SerDes driver support becomes available in
> the upstream tree.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>   - updated commit description to make it clear that it is fix
>     to be applied to v4.2-rc.

Just sent pull request with both of these patches from the series.

Regards,
Santosh
