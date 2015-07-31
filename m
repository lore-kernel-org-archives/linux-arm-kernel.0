From: broonie@kernel.org (Mark Brown)
Date: Fri, 31 Jul 2015 19:19:03 +0100
Subject: [RFC PATCH 4/5] ARM: dts: DRA7: Add memory map region entries
 for qspi
In-Reply-To: <1438072876-16338-5-git-send-email-vigneshr@ti.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-5-git-send-email-vigneshr@ti.com>
Message-ID: <20150731181903.GN20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 02:11:15PM +0530, Vignesh R wrote:
> Add qspi memory mapped region entries for DRA7xx based SoCs.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

>  		qspi: qspi at 47900000 {
>  			compatible = "ti,am4372-qspi";
> -			reg = <0x47900000 0x100>;
> +			reg = <0x47900000 0x100>,
> +			      <0x30000000 0x3ffffff>;
> +			reg-names = "qspi_base", "qspi_mmap";

The DT binding document for the controller needs to be extended to
document this change in the binding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/85f100cc/attachment-0001.sig>
