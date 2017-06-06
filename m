From: joe@perches.com (Joe Perches)
Date: Tue, 06 Jun 2017 08:24:24 -0700
Subject: [PATCH 16/18] staging: fsl-dpaa2/eth: Errors checking update
In-Reply-To: <20170606150041.10955-17-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
 <20170606150041.10955-17-ruxandra.radulescu@nxp.com>
Message-ID: <1496762664.1968.17.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-06-06 at 10:00 -0500, Ioana Radulescu wrote:
> On the egress path, frame errors are reported using both a FD control
> field and the frame annotation status. The current code only handles
> FAS errors. Update to look at both fields when accounting Tx errors.

[]

> Note: Checkpatch complains about a macro(DPAA2_FAS_RX_ERR_MASK) being
> too complex. It's just a bitmask with all possible Rx FAS error bits
> and I'm not sure how the extra parantheses recommended by checkpatch
> would help, so leaving it as is.

Ignoring the checkpatch message is the right thing to do.

It's just a false positive caused by the incomplete context
around the macro definition.

> @@ -177,7 +190,7 @@ struct dpaa2_fas {
>  /* L4 csum error */
>  #define DPAA2_FAS_L4CE			0x00000001
>  /* Possible errors on the ingress path */
> -#define DPAA2_ETH_RX_ERR_MASK		(DPAA2_FAS_KSE		| \
> +#define DPAA2_FAS_RX_ERR_MASK		(DPAA2_FAS_KSE		| \
>  					 DPAA2_FAS_EOFHE	| \
>  					 DPAA2_FAS_MNLE		| \
>  					 DPAA2_FAS_TIDE		| \
> @@ -191,7 +204,7 @@ struct dpaa2_fas {
