From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 4 Mar 2015 18:17:58 +0100
Subject: [PATCH v3 4/9] power: reset: Add AT91RM9200 reset driver
In-Reply-To: <1425478897-27322-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425478897-27322-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150304171758.GA8717@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 04, 2015 at 03:21:32PM +0100, Alexandre Belloni wrote:
> AT91RM9200 uses the watchdog from the system timer to reset.
> [...]
> +	regmap_write(regmap_st, AT91_ST_WDMR,
> +		     AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
> +	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
> +
> +	mdelay(2000);

At pity that you have to write into two registers, otherwise you
could have used the syscon-reboot driver.

> [...]
> +module_platform_driver(at91rm9200_reset_driver);

Apart from missing module metadata (MODULE_AUTHOR(),
MODULE_LICENSE(), ...) the driver looks fine to me.

-- Sebastian

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/a22bafa2/attachment.sig>
