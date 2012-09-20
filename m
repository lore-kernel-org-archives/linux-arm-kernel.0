From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 20 Sep 2012 11:17:02 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1348136222.26501.19.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-09-19 at 18:44 +0100, Stefano Stabellini wrote:
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "XENVM-4.2";

Why the shouty caps?

Did you mean 4.3 here and throughout?

> +	compatible = "xen,xenvm-4.2", "arm,vexpress";

Is this second compatible thing actually true? We don't actually emulate
much (anything?) of what would be on a real vexpress motherboard.

"arm,vexpress" is used only in v2m.c and I don't think we want the
majority of that -- we don't provide any of the peripherals which it
registers.

I think the only things we might want out of that lot are the arch timer
and perhaps the uart0 (as a debug port).

I suspect we should have our own xen machine .c.

[...]
> +	gic: interrupt-controller at 2c001000 {
> +		compatible = "arm,cortex-a9-gic";

Don't we mean "arm,cortex-a15-gic" here? That's what we actually
provide. I'm not sure how the a9 and a15 differ.

> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0x2c001000 0x1000>,
> +		      <0x2c002000 0x100>;
> +	};
> +

Ian.
