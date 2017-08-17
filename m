From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 10:10:25 -0500
Subject: [PATCH v4 05/12] Documentation: net: phy: Add phy-is-internal
 binding
In-Reply-To: <1bff1793-fe46-f263-fbf5-ef65ffbc5dc9@rock-chips.com>
References: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
 <1502280630-2254-1-git-send-email-david.wu@rock-chips.com>
 <778B0470-8ABD-46AD-A63D-F0CF4911C800@gmail.com>
 <20170810002041.GA10776@lunn.ch>
 <1bff1793-fe46-f263-fbf5-ef65ffbc5dc9@rock-chips.com>
Message-ID: <20170817151025.sdbusesfq7spy4fm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 06:57:40PM +0800, David.Wu wrote:
> Hi Andrew, Florian
> 
> ? 2017/8/10 8:20, Andrew Lunn ??:
> > Hi Florian, David.
> > 
> > I'm happy with the property name. But i think the text needs more
> > description. We deal with Ethernet switches with integrated PHYs. Yet
> > for us, this property is unneeded.
> > 
> > Seeing this property means some bit of software needs to ensure the
> > internal PHY should be used, when given the choice between an internal
> > and external PHY. So i would say something like:
> > 
> >      If set, indicates that the PHY is integrated into the same
> >      physical package as the Ethernet MAC. If needed, muxers should be
> >      configured to ensure the (internal) PHY is used. The absence of this
> >      property indicates the muxers should be configured so that the
> >      external PHY is used.
> 
> Are we supposed to replace the words "internal" with "integrated" here?
> So we have three kinds of PHY, they are intenal, external and integrated
> PHYs.

And you can have both a XAUI/serdes phy and the ethernet phy. It should 
be clear this is for the latter.

Rob
