From: c.jayachandran@gmail.com (Jayachandran C.)
Date: Wed, 22 Mar 2017 11:06:36 +0530
Subject: [PATCH 14/15] arm64: dts: broadcom: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-14-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-14-robh@kernel.org>
Message-ID: <CA+7sy7DKf8DXVVHS22_E1wStoxMPHpufaHi83OaKg4LKS+JbUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Mar 22, 2017 at 7:33 AM, Rob Herring <robh@kernel.org> wrote:
> dtc recently added PCI bus checks. Fix these warnings.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: "Jayachandran C." <c.jayachandran@gmail.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> ---
> Sub-arch maintainers, please apply to your trees unless arm-soc wants
> to take the whole lot.
>
>  arch/arm64/boot/dts/broadcom/vulcan.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/broadcom/vulcan.dtsi b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> index 34e11a9db2a0..71fea7fdc68d 100644
> --- a/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> @@ -117,6 +117,7 @@
>                 ranges =
>                   <0x02000000    0 0x40000000    0 0x40000000    0 0x20000000
>                    0x43000000 0x40 0x00000000 0x40 0x00000000 0x20 0x00000000>;
> +               bus-range = <0x00 0xff>;
>                 interrupt-map-mask = <0 0 0 7>;
>                 interrupt-map =
>                       /* addr  pin  ic   icaddr  icintr */


There is a patch posted to move this from broadcom/vulcan.dtsi to
cavium/thunder2-99xx.dtsi
https://www.spinics.net/lists/arm-kernel/msg568464.html

That might go in thru the arm-soc tree, and there might be a conflict here.

JC.
