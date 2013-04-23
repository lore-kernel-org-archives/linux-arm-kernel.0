From: olof@lixom.net (Olof Johansson)
Date: Tue, 23 Apr 2013 11:11:09 -0700
Subject: [PATCH 4/4] arm64: Add initial DTS for APM X-Gene Storm SOC and
 APM Mustang board
In-Reply-To: <1366442131-26094-5-git-send-email-vkale@apm.com>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
 <1366442131-26094-5-git-send-email-vkale@apm.com>
Message-ID: <20130423181109.GA6850@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 20, 2013 at 12:45:31PM +0530, Vinayak Kale wrote:

> +	gic: interrupt-controller at 78010000 {
> +		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x0 0x78010000 0x0 0x1000>,	/* GIC Dist */
> +		      <0x0 0x78020000 0x0 0x1000>,	/* GIC CPU */
> +		      <0x0 0x78040000 0x0 0x2000>,	/* GIC VCPU Control */
> +		      <0x0 0x78060000 0x0 0x2000>;	/* GIC VCPU */
> +		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
> +	};

Others have commented on other compatible fields, so it's my turn. :-)

Is this the exact same GIC that's used with A15? I don't think it is? It might
make more sense to use a new compatible field and add it to the driver.

Also, other platforms have removed the a9 fallback, so even if you happen to
have an a15-compatible gic, in this case you should at least take out the a9
string.


-Olof
