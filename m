From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Apr 2012 19:37:54 +0000
Subject: [PATCH v2 3/8] net: Add device tree support to LPC32xx
In-Reply-To: <1333391587-26290-4-git-send-email-stigge@antcom.de>
References: <1333391587-26290-1-git-send-email-stigge@antcom.de>
 <1333391587-26290-4-git-send-email-stigge@antcom.de>
Message-ID: <201204021937.54567.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 April 2012, Roland Stigge wrote:
> 
> +       if (pdev->dev.of_node && of_get_property(pdev->dev.of_node,
> +                                                "use-iram", NULL))
> +               pldat->use_iram = true;
> +       else
> +               pldat->use_iram = false;
> +

One more thing I just noticed:

this is equivalent to the much shorter 

	pldat->use_iram = of_property_read_bool(pdev->dev.of_node, "use-iram");

Everything else looks good here.

	Arnd
