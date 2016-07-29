From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Jul 2016 20:12:32 +0200
Subject: [PATCH v2 3/5] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner sun8i-emac
In-Reply-To: <20160729081519.GA31878@Red>
References: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
 <1469001800-11615-4-git-send-email-clabbe.montjoie@gmail.com>
 <20160721075519.GC5993@lukather> <20160728134031.GC7582@Red>
 <20160728184916.GF6682@lukather> <20160729081519.GA31878@Red>
Message-ID: <20160729181232.GF6215@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2016 at 10:15:19AM +0200, LABBE Corentin wrote:
> > > > > +See ethernet.txt in the same directory for generic bindings for ethernet
> > > > > +controllers.
> > > > > +
> > > > > +The device node referenced by "phy" or "phy-handle" should be a child node
> > > > > +of this node. See phy.txt for the generic PHY bindings.
> > > > > +
> > > > > +Optional properties:
> > > > > +- phy-supply: phandle to a regulator if the PHY needs one
> > > > > +- phy-io-supply: phandle to a regulator if the PHY needs a another one for I/O.
> > > > > +		 This is sometimes found with RGMII PHYs, which use a second
> > > > > +		 regulator for the lower I/O voltage.
> > > > > +- allwinner,tx-delay: The setting of the TX clock delay chain
> > > > > +- allwinner,rx-delay: The setting of the RX clock delay chain
> > > > 
> > > > In which unit? What is the default value?
> > > 
> > > The unit is unknown to me, but I have added a comment for the
> > > default and acceptable range value.
> > 
> > That's unfortunate. We'll see how the DT maintainers feel about that.
> > 
> 
> I have searched for txdelay in Documentation, and found a few driver
> that give the units (us/ps).
>
> But in that case, the value in ps/us must be found in a table
> indexed by the Xxdelay value.
>
> So the settings seems always a raw number, and for sun8i-emac
> nothing in user manual could help to find what each value is/related
> to.
> 
> So the good value is either found by "try and test" or "copy the
> value found in fex file".

What I meant was that, just like you found out already, most of the
time the properties should be in absolute units, so that it doesn't
depend on some clock rate most likely in that case.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160729/ab6e7f57/attachment.sig>
