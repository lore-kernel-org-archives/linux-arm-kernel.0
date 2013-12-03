From: mark.hambleton@broadcom.com (Mark Hambleton)
Date: Tue, 3 Dec 2013 13:14:44 +0000
Subject: [PATCH] arm64: dts: Add a virtio disk to the RTSM motherboard
In-Reply-To: <20131203114217.GF1169@mudshark.cambridge.arm.com>
References: <1386001475-20728-1-git-send-email-broonie@kernel.org>
 <20131203114217.GF1169@mudshark.cambridge.arm.com>
Message-ID: <D00A5DFD97C44C4D820FC3A847C5D575072F7EB7@IRVEXCHMB14.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will, 

This patch comes from the ATF: https://github.com/ARM-software/arm-trusted-firmware/blob/master/fdts/rtsm_ve-motherboard.dtsi

I suspect Achin Gupta has the answers to the questions...

Mark

-----Original Message-----
From: Will Deacon [mailto:will.deacon at arm.com] 
Sent: 03 December 2013 11:42
To: Mark Brown
Cc: Catalin Marinas; linaro-kernel at lists.linaro.org; Mark Hambleton; linux-arm-kernel at lists.infradead.org; Mark Brown; mark.rutland at arm.com
Subject: Re: [PATCH] arm64: dts: Add a virtio disk to the RTSM motherboard

On Mon, Dec 02, 2013 at 04:24:35PM +0000, Mark Brown wrote:
> From: Mark Hambleton <mahamble@broadcom.com>
> 
> Describe the virtio device so we can mount disk images in the simulator.
> 
> Signed-off-by: Mark Hambleton <mahamble@broadcom.com>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
> index b45e5f39f577..b3460961038f 100644
> --- a/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi
> @@ -183,6 +183,12 @@
>  				clocks = <&v2m_oscclk1>, <&v2m_clk24mhz>;
>  				clock-names = "clcdclk", "apb_pclk";
>  			};
> +
> +			virtio_block at 0130000 {
> +				compatible = "virtio,mmio";
> +				reg = <0x130000 0x1000>;

4k? That seems pretty big to me...

> +				interrupts = <0x2a>;

Any reason this is in hex?

Will
