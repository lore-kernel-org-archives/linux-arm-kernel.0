From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Nov 2012 16:56:09 +0000
Subject: [PATCH 1/1] regulator: gpio-regulator: fix crash when no states
 property in dt
In-Reply-To: <1352450076-22682-1-git-send-email-Frank.Li@freescale.com>
References: <1352450076-22682-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20121109165609.GV23807@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 04:34:36PM +0800, Frank Li wrote:

>  	/* Fetch states. */
>  	prop = of_find_property(np, "states", NULL);
> -	proplen = prop->length / sizeof(int);
> +	proplen = prop ? prop->length / sizeof(int) : 0;

Aren't states mandatory for this driver, in which case shouldn't the
probe fail here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/32576d25/attachment.sig>
