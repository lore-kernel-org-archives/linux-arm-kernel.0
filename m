From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 12 Jan 2015 21:07:15 -0800
Subject: [PATCH v3 08/13] mtd: st_spi_fsm: Update the JEDEC probe to
 handle extended READIDs
In-Reply-To: <1418644760-18773-9-git-send-email-lee.jones@linaro.org>
References: <1418644760-18773-1-git-send-email-lee.jones@linaro.org>
 <1418644760-18773-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20150113050715.GQ9759@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 11:59:15AM +0000, Lee Jones wrote:
> The previous code was based on 3-byte JEDEC IDs, with a possible 2-byte
> extension.  However, devices are now emerging that return 6 or more bytes of
> READID data and the additional bytes are required to differentiate between
> variants or generations of similar devices.
> 
> This patch refactors the device table and JEDEC probe code to handle arbitrary
> length READIDs, with the standard JEDEC definition now becoming a special case.
> Functionally, there should be no change in behaviour.  A subsequent patch will
> update the table with extended READIDs where applicable.

BTW, how's that promise going, where you work on adapting this driver to
the spi-nor framework? We've already done some of this same work there.

> +#define RDID(...) __VA_ARGS__  /* Dummy macro to protect array argument. */

What? What needs "protected"?

...

Brian
