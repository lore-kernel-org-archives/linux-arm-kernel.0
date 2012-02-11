From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 11 Feb 2012 13:17:19 +0000
Subject: [PATCH v4 2/2] Regulator: Add Anatop regulator driver
In-Reply-To: <20120211063637.GC2198@r65073-Latitude-D630>
References: <1324980994-18462-1-git-send-email-paul.liu@linaro.org>
 <1328734286-30091-1-git-send-email-paul.liu@linaro.org>
 <1328734286-30091-2-git-send-email-paul.liu@linaro.org>
 <20120211063637.GC2198@r65073-Latitude-D630>
Message-ID: <20120211131718.GA31887@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2012 at 10:36:38PM -0800, Shawn Guo wrote:
> On Thu, Feb 09, 2012 at 04:51:26AM +0800, Ying-Chun Liu (PaulLiu) wrote:

> > +	rval = of_get_property(np, "min-voltage", NULL);
> > +	if (rval)
> > +		sreg->rdata->min_voltage = be32_to_cpu(*rval);
> > +	rval = of_get_property(np, "max-voltage", NULL);
> > +	if (rval)
> > +		sreg->rdata->max_voltage = be32_to_cpu(*rval);

> We need a sensible binding document to understand those.  But at least,
> shouldn't min-voltage and max-voltage be retrieved as the common
> regulator binding documented in
> Documentation/devicetree/bindings/regulator/regulator.txt?

Normally this would be a bad idea as the set of voltages that can safely
be used on a given board might differ from those which are supported by
the device.  However in this case you might be OK as this is all
internal to the SoC and so presumably won't vary from board to board.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120211/f42da0ce/attachment.sig>
