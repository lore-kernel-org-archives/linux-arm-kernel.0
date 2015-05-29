From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 May 2015 22:03:06 +0200
Subject: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
In-Reply-To: <20150529194955.GV2026@saruman.tx.rr.com>
References: <201505241444.41039@pali> <20150527132545.GA23434@amd>
 <20150527133311.GJ30798@pali> <20150527143722.GA28108@amd>
 <20150527145837.GA13223@earth> <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd> <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
Message-ID: <20150529200306.GB17267@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 02:49:55PM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Fri, May 29, 2015 at 09:32:11PM +0200, Pavel Machek wrote:
> > Fix dts to match what the Linux kernel expects. This works around
> > touchscreen problems in 4.1 linux on Nokia n900.
> >     
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > index 4b641c7..09089a6 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> > @@ -32,8 +32,8 @@ Example:
> >  		touchscreen-fuzz-x = <4>;
> >  		touchscreen-fuzz-y = <7>;
> >  		touchscreen-fuzz-pressure = <2>;
> > -		touchscreen-max-x = <4096>;
> > -		touchscreen-max-y = <4096>;
> > +		touchscreen-size-x = <4096>;
> > +		touchscreen-size-y = <4096>;
> 
> IMHO, the older binding needs to be supported as well. It's fine to
> update the DTS for the new binding, but even Documentation says
> touchscreen-max-[xy] and if the driver changed that, the driver should
> be fixed too. Besides, it seems like this has been in tree since v3.16:
> 
> $ git describe a38cfebb56898633687ab337fd53710e63a0aedd
> v3.15-rc5-72-ga38cfebb5689
> 
> So, because this has been wrongly documented for so long, we should
> support both bindings. Sure, deprecate touchscreen-max-[xy], but they
> must still be supported, IMO.

This property has never been anything but a typo in a documentation of
a single driver.

Feel free to fix that in that driver, but I don't see why the core
code should handle that isolated typo.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/0eb41258/attachment.sig>
