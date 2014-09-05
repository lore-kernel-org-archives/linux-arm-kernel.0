From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 19:57:28 +0200
Subject: [PATCH RESEND v5 1/5] usb: host: ehci-st: Add EHCI support for ST
 STB devices
In-Reply-To: <1409937829-23708-2-git-send-email-peter.griffin@linaro.org>
References: <1409937829-23708-1-git-send-email-peter.griffin@linaro.org>
 <1409937829-23708-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <202755915.brE74x99uQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 18:23:45 Peter Griffin wrote:
> +struct st_platform_priv {
> +       struct clk *clks[USB_MAX_CLKS];
> +       struct clk *clk48;
> +       struct reset_control *rst;
> +       struct reset_control *pwr;
> +       struct phy *phy;
> +};

Any reason why this is in a shared header file? It looks like
duplicating the structure under two different names would
actually be shorter and keep the drivers more readable as they'd
be self-contained, even when they have the exact same structure.

Do both drivers use all fields?

	Arnd
