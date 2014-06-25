From: robherring2@gmail.com (Rob Herring)
Date: Wed, 25 Jun 2014 07:21:17 -0500
Subject: [PATCH] arm/arm64: DT: Fix GICv2 CPU interface size
In-Reply-To: <1403692675-26503-1-git-send-email-marc.zyngier@arm.com>
References: <1403692675-26503-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAL_Jsq+rS3FE8_F-4qdUUTaJ6X9XNFP2d2h7CdU9hDRG0KG9uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 5:37 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> All the Cortex-{A7,A15} implementations are using a GICv2. Same for
> the current arm64 platforms.
>
> Turns out that most of these platforms have described their GIC CPU
> interface size as being 4kB. while it is actually 8kB (the GICC_DIR
> register lives at offset 0x1000).
>
> This was found when converting the GIC driver to use EOImode==1 on
> GICv2-based systems. It uses the GICC_DIR register, and the result
> is a very early firework...

What's your plan for making the kernel change? Updating the dts files
is good, but that doesn't immediately help you if you have old dtbs.

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/boot/dts/axm55xx.dtsi              | 2 +-
>  arch/arm/boot/dts/dra7.dtsi                 | 2 +-
>  arch/arm/boot/dts/ecx-2000.dts              | 2 +-

Acked-by: Rob Herring <robh@kernel.org>

Rob
