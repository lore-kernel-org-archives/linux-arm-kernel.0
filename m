From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Feb 2016 18:19:50 +0000
Subject: [PATCH] of/irq: Fix msi-map calculation for nonzero rid-base
In-Reply-To: <56BA111D.9050807@arm.com>
References: <9f6845195d03b0e0b0d187bb510fbf7bd497e836.1455015344.git.robin.murphy@arm.com>
 <56B9D62E.8080003@arm.com>
 <HE1PR04MB1641AF97F637BBCBB86BA4FE8DD60@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <20160209160812.GC9332@leverpostej> <56BA111D.9050807@arm.com>
Message-ID: <20160209181949.GC4348@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 04:17:33PM +0000, Robin Murphy wrote:
> On 09/02/16 16:08, Mark Rutland wrote:
> [...]
> 
> >>>>having msi-map-mask clash with a nonzero rid-base, as that's another
> >>>>thing one can easily get wrong.
> 
> [...]
> 
> >>>>+		if (rid_base & ~map_mask) {
> >>>>+			dev_err(parent_dev,
> >>>>+				"Invalid msi-map translation - msi-map-mask (0x%x) ignores rid-
> >>>base (0x%x)\n",
> >>>>+				map_mask, rid_base);
> >>>>+			return rid_out;
> >>>>+		}
> 
> [...]
> 
> >>                    msi-map = <0x0100 &its 0x11 0x1>;
> >>                    msi-map-mask = <0xff>;
> >>
> >
> >I'd say that this is an inconsistent set of properties, and it's
> >probably worth warning if we encounter this. There is no possible way
> >that rid-base can be encountered.
> 
> Indeed ;)

Ah!

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Though it would be nice if we could fail the translation entirely rather
than just logging an error and idmapping the rid.

Thanks,
Mark.
