From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 16 Aug 2011 23:19:45 +0100
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <1313526898-19920-3-git-send-email-robherring2@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
Message-ID: <20110816221945.GA4066@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Aug 16, 2011 at 03:34:54PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds basic support for the Calxeda Highbank platform.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
[...]
> +static void __init highbank_timer_init(void)
> +{
> +	int irq;
> +	struct device_node *np;
> +	void __iomem *timer_base;
> +
> +	/* Map system registers */
> +	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
> +	sregs_base = of_iomap(np, 0);

Should the return values be checked here?  I know that all valid device trees 
should have these nodes and valid a reg property, but I don't know if the 
error handling needs to be a bit more explicit.  For my platform I have put 
these checks and panics() if they fail, but I'm not sure if that's the right 
thing!

Jamie
