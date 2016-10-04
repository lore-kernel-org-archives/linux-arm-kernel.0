From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 4 Oct 2016 15:11:30 +0200
Subject: [PATCH v2 3/4] ARM: dts: dra72-evm-revc: fix correct phy delay
 and impedance settings
In-Reply-To: <20161004125607.10569-4-mugunthanvnm@ti.com>
References: <20161004125607.10569-1-mugunthanvnm@ti.com>
 <20161004125607.10569-4-mugunthanvnm@ti.com>
Message-ID: <20161004131130.GM11677@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 06:26:06PM +0530, Mugunthan V N wrote:
> The default impedance settings of the phy is not the optimal
> value, due to this the second ethernet is not working. Fix it
> with correct values which makes the second ethernet port to work.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
>  arch/arm/boot/dts/dra72-evm-revc.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
> index f9cfd3b..d626cd7 100644
> --- a/arch/arm/boot/dts/dra72-evm-revc.dts
> +++ b/arch/arm/boot/dts/dra72-evm-revc.dts
> @@ -62,6 +62,7 @@
>  		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>  		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_NS>;
>  		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
> +		ti,min-output-imepdance;

And there is my answer :-(

    Andrew
