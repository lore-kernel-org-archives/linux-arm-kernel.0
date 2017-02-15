From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 15 Feb 2017 10:26:05 +0100
Subject: [PATCH v2 1/4] dt-bindings: add multidomain support to i.MX GPC
 DT binding
In-Reply-To: <20170215070830.GA8398@dragon>
References: <20170127183728.26701-1-l.stach@pengutronix.de>
 <1486741439.3879.7.camel@pengutronix.de> <20170215070830.GA8398@dragon>
Message-ID: <1487150765.2304.65.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 15.02.2017, 15:08 +0800 schrieb Shawn Guo:
> On Fri, Feb 10, 2017 at 04:43:59PM +0100, Lucas Stach wrote:
> > Hi Shawn,
> > 
> > are you willing to take this series through your tree or do you think we
> > need to get this in via some other tree?
> 
> I'm willing to take it.  But I don't think it's been ready yet.  Since
> you insist on keeping the .remove hook for both imx_gpc_driver and
> imx_pgc_power_domain_driver, did you actually test it with manually
> bind/unbind the drivers?  I tested it a bit and found it doesn't work
> well for me.

It works as well as it could at this point. The driver unloads fine, but
obviously anything that depends on it is broken at that point. Try
unloading a regulator driver, it's the same experience.

This will get better once the functional dependency stuff is far enough
to either block unloading of drivers providing resources to other
devices, or unload the dependent drivers first.

> 
> Also, there is a comment from Andrey that is not responded.

Yes, I'll take care of this. Just didn't want to roll a new version of
this series before we know where it is going.

Regards,
Lucas
