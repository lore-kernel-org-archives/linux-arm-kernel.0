From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Aug 2011 10:27:10 +0100
Subject: [PATCH 1/6] ARM: highbank: add devicetree source
In-Reply-To: <1313526898-19920-2-git-send-email-robherring2@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-2-git-send-email-robherring2@gmail.com>
Message-ID: <000101cc5cbf$d71b20d0$85516270$@rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Rob Herring
> Sent: 16 August 2011 21:35
> To: linux-arm-kernel at lists.infradead.org
> Cc: Rob Herring
> Subject: [PATCH 1/6] ARM: highbank: add devicetree source
> 
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds the devicetree source and documentation for the Calxeda
> highbank
> platform.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  Documentation/devicetree/bindings/arm/calxeda.txt |    8 +
>  arch/arm/boot/dts/highbank.dts                    |  212
> +++++++++++++++++++++
>  2 files changed, 220 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
>  create mode 100644 arch/arm/boot/dts/highbank.dts

...

> +		L2: l2-cache {
> +			compatible = "arm,pl310-cache";
> +			reg = <0xfff12000 0x1000>;
> +			interrupts = <102>;
> +			cache-unified;
> +			cache-level = <2>;
> +		};

Currently, the binding documentation sitting in Russell's for-next branch
doesn't have the interrupts property we discussed previously:
http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-August/007301.html

I posted a patch to add it to the documentation, but no-one responded:
http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-August/007349.html

Can I take your use of the property as an ack?

How do we get this merged?

Thanks,
Mark.
