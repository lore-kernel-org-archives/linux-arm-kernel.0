From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Apr 2012 19:55:53 +0800
Subject: [PATCH 2/7] of: add clock providers
In-Reply-To: <1331680947-29861-3-git-send-email-robherring2@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-3-git-send-email-robherring2@gmail.com>
Message-ID: <20120409115549.GB18692@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 06:22:22PM -0500, Rob Herring wrote:
...
> +==Clock consumers==
> +
> +Required properties:
> +clocks:		List of phandle and clock specifier pairs, one pair
> +		for each clock input to the device.  Note: if the
> +		clock provider specifies '0' for #clock-cells, then
> +		only the phandle portion of the pair will appear.

Per discussion[1], the parent of the clock could be reasonably
represented in C code instead of in device tree.  Then how can
this "clocks" property be "Required"?  Or to put it another way,
if this is "Required", the whole clock tree will have to be represented
in device tree, no?

> +
> +Optional properties:
> +clock-names:	List of clock input name strings sorted in the same
> +		order as the clocks property.  Consumers drivers
> +		will use clock-names to match clock input names
> +		with clocks specifiers.
> +clock-ranges:	Empty property indicating that child nodes can inherit named
> +		clocks from this node. Useful for bus nodes to provide a
> +		clock to their children.
> +
> +For example:
> +
> +    device {
> +        clocks = <&osc 1>, <&ref 0>;
> +        clock-names = "baud", "register";
> +    };

Regards,
Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/139414/focus=1216423
