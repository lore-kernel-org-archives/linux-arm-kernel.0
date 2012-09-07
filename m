From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2012 15:29:54 -0700
Subject: [PATCH v3 1/8] ARM/dts: omap2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
In-Reply-To: <1346846336-27321-2-git-send-email-peter.ujfalusi@ti.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
 <1346846336-27321-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120907222953.GS1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120905 04:59]:
> +
> +	ocp {
> +		mcbsp1: mcbsp at 48074000 {
> +			compatible = "ti,omap2420-mcbsp";
> +			reg = <0x48074000 0xff>;
> +			reg-names = "mpu";
> +			interrupts = <59>, /* TX interrupt */
> +				     <60>; /* RX interrupt */
> +			interrupt-names = "tx", "rx";
> +			interrupt-parent = <&intc>;
> +			ti,hwmods = "mcbsp1";
> +		};
> +
> +		mcbsp2: mcbsp at 48076000 {
> +			compatible = "ti,omap2420-mcbsp";
> +			reg = <0x48076000 0xff>;
> +			reg-names = "mpu";
> +			interrupts = <62>, /* TX interrupt */
> +				     <63>; /* RX interrupt */
> +			interrupt-names = "tx", "rx";
> +			interrupt-parent = <&intc>;
> +			ti,hwmods = "mcbsp2";
> +		};
> +	};

Hmm don't you need to specify the interrupt chip and offset for
the interrupts here?

Regards,

Tony
