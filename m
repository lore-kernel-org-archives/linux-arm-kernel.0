From: david@lechnology.com (David Lechner)
Date: Mon, 24 Oct 2016 20:12:59 -0500
Subject: [PATCH/RFT v2 13/17] USB: da8xx: use ohci priv data instead of
 globals
In-Reply-To: <20161024164634.4330-14-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-14-ahaslam@baylibre.com>
Message-ID: <0cf6f211-90ba-2f7b-978f-f1cfa1b11554@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 11:46 AM, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> >  static const struct ohci_driver_overrides da8xx_overrides __initconst = {
> -	.reset		= ohci_da8xx_reset
> +	.reset		= ohci_da8xx_reset,
> +	.extra_priv_size = sizeof(struct da8xx_ohci_hcd),

nit: since you are changing both lines anyway, you might as well make 
the ='s line up.

>  };
>
>  /*
>
