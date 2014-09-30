From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 30 Sep 2014 07:09:24 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140929155517.GR16977@sirena.org.uk>
References: <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
Message-ID: <20140930050923.GB29874@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 04:55:17PM +0100, Mark Brown wrote:
> On Mon, Sep 29, 2014 at 03:47:15PM +0200, Thierry Reding wrote:
[...]
> > The same thing is going to happen with simplefb for your device. If you
> > later realize that you need a regulator to keep the panel going, you'll
> > have to add code to your firmware to populate the corresponding
> > properties, otherwise the regulator will end up unused and will be
> > automatically disabled. At the same time you're going to break upstream
> > for all users of your old firmware because it doesn't add that property
> > yet.
> 
> > And the same will continue to happen for every new type of resource
> > you're going to add.
> 
> So long as we're ensuring that when we don't start supporting resources
> without DT additions or at least require DT additions to actively manage
> them (which can then include simplefb hookup) we should be fine.

I'm not sure I understand what you mean. If we add a driver for the PMIC
that exposes these regulators and then add a DT node for the PMIC, we'd
still need to fix the firmware to generate the appropriate DT properties
to allow simplefb to enable the regulators.

So unless firmware is updated at the same time, regulators will get
disabled because they are unused.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/4f9e4be0/attachment.sig>
