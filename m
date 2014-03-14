From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Mar 2014 12:08:53 +0100
Subject: [PATCH v17 1/4] arm64: Add APM X-Gene SoC 15Gbps Multi-purpose
 PHY DTS entries
In-Reply-To: <1394655573-32645-2-git-send-email-lho@apm.com>
References: <1394655573-32645-1-git-send-email-lho@apm.com>
 <1394655573-32645-2-git-send-email-lho@apm.com>
Message-ID: <201403141208.53772.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 March 2014, Loc Ho wrote:
> +                       sataphy1clk: sataphy1clk at 1f21c000 {
> +                               compatible = "apm,xgene-device-clock";
> +                               #clock-cells = <1>;
> +                               clocks = <&socplldiv2 0>;
> +                               clock-names = "socplldiv2";

I think we still need to resolve the question regarding the
"clock-names" properties in your clock provider nodes. I've commented
on this in the past, since it shows up in all the x-gene drivers,
but it's very inconsistent.

The binding says

+- clock-names : shall be the name of the device clock. If missing, use the
+                device name.

which to me makes no sense. What will "use the device name", and
which device? Your clock driver doesn't actually use these strings,
so could you please fix the binding to remove this, and stop adding
the strings to any clock nodes?

Since nothing ever used these and they are marked "optional"
in the binding, I don't think there is a chance of breaking
anything by changing it now.

	Arnd
