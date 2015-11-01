From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Nov 2015 10:52:05 +0100
Subject: [PATCH v4 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <1445964626-6484-6-git-send-email-jenskuske@gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-6-git-send-email-jenskuske@gmail.com>
Message-ID: <20151101095205.GS6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 05:50:25PM +0100, Jens Kuske wrote:
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <24000000>;
> +		arm,cpu-registers-not-fw-configured;
> +	};
> +
> +	memory {
> +		reg = <0x40000000 0x80000000>;
> +	};

What's the u-boot support like these days?

If it's ready, or at least some patches have been sent, you shouldn't
set both the memory node (that will be overriden anyway) and the
clock-frequency and arm,cpu-registers-not-fw-configured properties in
the timer node, that will prevent the kernel from booting there.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151101/5a99fcd9/attachment.sig>
