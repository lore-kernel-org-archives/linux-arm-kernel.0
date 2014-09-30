From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Sep 2014 18:39:28 +0100
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140930050923.GB29874@ulmo>
References: <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo>
Message-ID: <20140930173928.GH4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 07:09:24AM +0200, Thierry Reding wrote:
> On Mon, Sep 29, 2014 at 04:55:17PM +0100, Mark Brown wrote:

> > So long as we're ensuring that when we don't start supporting resources
> > without DT additions or at least require DT additions to actively manage
> > them (which can then include simplefb hookup) we should be fine.

> I'm not sure I understand what you mean. If we add a driver for the PMIC
> that exposes these regulators and then add a DT node for the PMIC, we'd
> still need to fix the firmware to generate the appropriate DT properties
> to allow simplefb to enable the regulators.

No, you don't.  It's only if you start describing the regulators in the
PMIC in DT that you run into problems.  Unconfigured regulators won't be
touched.

> So unless firmware is updated at the same time, regulators will get
> disabled because they are unused.

That won't happen unless the regulators are explicitly described, if
they are described as unused then this will of course happen.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/a8cd1e73/attachment.sig>
