From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Nov 2014 12:17:16 +0100
Subject: [PATCH v5 5/6] Documentation: dt-bindings: Add binding info for
 X-Gene QMTM UIO driver
In-Reply-To: <1416220572-13381-6-git-send-email-ankit.jindal@linaro.org>
References: <1416220572-13381-1-git-send-email-ankit.jindal@linaro.org>
 <1416220572-13381-6-git-send-email-ankit.jindal@linaro.org>
Message-ID: <2279061.naADrHDgyn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 November 2014 16:06:11 Ankit Jindal wrote:
> +
> +       qmtm1_uio: qmtm_uio at 1f200000 {
> +               compatible = "apm,xgene-qmtm";
> +               status = "disabled";
> +               reg = <0x0 0x1f200000 0x0 0x10000>,
> +                     <0x0 0x1b000000 0x0 0x400000>;
> +               reg-names = "csr", "fabric";
> +               qpool-memory = <&qmtm1_uio_qpool>;
> +               clocks = <&qmtm1clk 0>;
> +               num-queues = <0x400>;
> +               devid = <1>;
> +       };
> +

To make my previous review comments clearer:

NAK

Do not create device nodes that are meant for a specific use case in
software and that are not usable for the common case. I don't think
it makes any sense to keep on submitting a UIO driver for this until
we have a proper network driver that uses this so we can make sure we
have a working binding.

	Arnd
