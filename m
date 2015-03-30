From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Mar 2015 15:23:11 -0700
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <55169622.5070007@gmail.com>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com>
Message-ID: <20150330222311.GY23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 28, 2015 at 11:53:06AM +0000, Iain Paton wrote:
> On 27/03/15 11:02, Hans de Goede wrote:
> > Hi Iain,
> > 
> > On 27-03-15 11:58, Iain Paton wrote:
> >> add pmic regulator definitions matching the manufacturers 3.4.x fex
> >> file.
> >>
> >> Signed-off-by: Iain Paton <ipaton0@gmail.com>
> >> ---
> >>
> >> As this file belongs to Hans and he decided not to use axp209.dtsi in
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315612.html
> >> then I won't add it here.
> > 
> > That was because using it was breaking stuff, but now that we know better
> > which regulators are used for what, and which one we most add an always-on;
> > property too, I would greatly prefer you to acually use axp209.dtsi, see
> > e.g. the sun5i-a13-utoo-p66.dts file where I'm using it.
> > 
> > Can you please respin this patch using axp209.dtsi?
> > 
> > Also please do not add nodes for unused regulators, like the ldo-s for the csi-s.
> 
> You would prefer that the csi is broken on the lime then? 

CSI is not usable (no driver for it), neither it is actually used by
default on the lime, so disabling the regulator is the right thing to
do.

> Unlike the cubieboards, ldo3 & ldo4 really are used on the olimex
> boards. So it seems that as yet you still don't know enough about
> which regulators are used, or you wouldn't be asking for that.

They are not used. They are connected to something that is not usable
in itself, so leaving them enabled is just useless.

> That's the major disadvantage of axp209.dtsi, the regulator node
> isn't describing the pmic at all. Instead it's describing the stuff
> connected to the pmic outputs, which is undeniably board specific
> and therefore totally unsuitable for a generic file. Leading to
> every board needing to override everything regardless.

No, it's defining which regulators are provided by the regulator, and
the voltage boundaries they have. It doesn't make any assumption with
regards to what is connected to what, and if a particular regulator is
connected to something. That's something that the board DTS should
describe as accurately as possible.

> So no, I'm not going to respin the patch. I strongly believe using
> axp209.dtsi is the wrong thing to do here.  If that means the patch
> doesn't make it in, then so be it.

Too bad.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150330/7474f066/attachment.sig>
