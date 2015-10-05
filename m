From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Oct 2015 11:44:24 +0200
Subject: [PATCH v3 5/5] clk: sunxi: mod1 clock support
In-Reply-To: <20151002204555.GA12338@codeaurora.org>
References: <1443512353-28073-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443512353-28073-6-git-send-email-maxime.ripard@free-electrons.com>
 <20151002204555.GA12338@codeaurora.org>
Message-ID: <20151005094424.GG2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 01:45:55PM -0700, Stephen Boyd wrote:
> On 09/29, Maxime Ripard wrote:
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> 
> Is this include used?

Fixed.

> > +	if (!gate)
> > +		goto err_free_mux;
> > +
> > +	of_property_read_string(node, "clock-output-names", &clk_name);
> > +
> > +	while (i < SUN4I_MOD1_MAX_PARENTS &&
> > +	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
> 
> Can we use of_clk_parent_fill() here?

We can, I switched to it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/2ca90072/attachment.sig>
