From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 22 Sep 2015 15:59:25 +0200
Subject: [PATCH 3/3] power: reset: at91-shdwc: add new shutdown
 controller driver
In-Reply-To: <2e870dbb4c7728ad416360ff20b22c1a97ba88d9.1441881064.git.nicolas.ferre@atmel.com>
References: <bc6fb78ccf190a6e24f69d70036bc3cd3ec42673.1441881064.git.nicolas.ferre@atmel.com>
 <2e870dbb4c7728ad416360ff20b22c1a97ba88d9.1441881064.git.nicolas.ferre@atmel.com>
Message-ID: <20150922135925.GI23334@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 10, 2015 at 12:39:18PM +0200, Nicolas Ferre wrote:
> Sama5d2 SoC has a completely new shutdown controller with new
> features and register layout. It thus makes sense to add a new
> driver for this new peripheral.
> 
> This driver is Device Tree only and handles events from the
> wake-up pin and the RTC. As the register layout may change in the
> future, so some values are encoded in a configuration structure.
>
> [...]
>
> +static struct of_device_id at91_shdwc_of_match[] = {
> +	{
> +		.compatible = "atmel,sama5d2-shdwc",
> +                .data = &sama5d2_shdwc_config,
> +	}, {
> +		/*sentinel*/
> +	}
> +};

please add:

MODULE_DEVICE_TABLE(of, at91_shdwc_of_match);

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/8899835b/attachment.sig>
