From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Sep 2015 13:12:32 +0100
Subject: [LINUX RFC v2 1/4] spi: add support of two chip selects & data
 stripe
In-Reply-To: <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <20150903121232.GW12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 11:56:04AM +0530, Ranjit Waghmode wrote:

> To support dual parallel mode operation of ZynqMP GQSPI controller
> following API's are added inside the core:

As covered in SubmittingPatches please try to make each patch a single
change rather than having multiple separate changes in one commit.

> +	/* Controller may support more than one chip.
> +	 * This flag will enable that feature.
> +	 */
> +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both chips */

This isn't saying that the controller supports more than one chip, it's
saying that the controller supports asserting more than one chip select
at once which isn't the same thing.  I'm also not entirely sure that
this makes sense as a separate feature to the data striping one - I'm
struggling to think of a way to use this sensibly separately to that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150903/3c3c8b6c/attachment-0001.sig>
