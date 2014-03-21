From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 18:51:17 +0100
Subject: stmmac-socfpga breakage in arm-soc
In-Reply-To: <5329CA2A.8030309@elopez.com.ar>
References: <201403191333.01095.arnd@arndb.de> <29079107.ja9Hu9mMY0@wuerfel>
 <5329CA2A.8030309@elopez.com.ar>
Message-ID: <201403211851.17955.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014, Emilio L?pez wrote:
> El 19/03/14 11:58, Arnd Bergmann escribi?:
> (snip)
> > diff --git a/Documentation/devicetree/bindings/net/stmmac.txt b/Documentation/devicetree/bindings/net/stmmac.txt
> > index 5748351..19d5648 100644
> > --- a/Documentation/devicetree/bindings/net/stmmac.txt
> > +++ b/Documentation/devicetree/bindings/net/stmmac.txt
> > @@ -31,6 +31,10 @@ Optional properties:
> >   - reset-names: Should contain the reset signal name "stmmaceth", if a
> >       reset phandle is given
> >   - max-frame-size: See ethernet.txt file in the same directory
> > +- clocks: If present, the first clock should be the GMAC main clock,
> > +  further clocks may be specified in derived bindings
> > +- clock-names: One name for each entry in the clocks property, the
> > +  first one should be "stmmaceth".
> >
> >   Examples:
> >
> > @@ -43,4 +47,6 @@ Examples:
> >               mac-address = [000000000000]; /* Filled in by U-Boot */
> >               max-frame-size = <3800>;
> >               phy-mode = "gmii";
> > +             clocks = <&clock>;
> > +             clock-names = "stmmaceth">
> 
> There's a small typo there on the ;

Fixed the typo locally. However, now we have another problem: I tried
to apply the update patch to arm-soc and found that I originally based
it on linux-next, which has a number of conflicting changes that are
not in arm-soc.

It's probably better if I remove the driver entirely from the arm-soc
tree and instead send the modified version to David Miller for him
to put it into the net tree.

	Arnd
