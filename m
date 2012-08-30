From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 30 Aug 2012 09:59:08 -0700
Subject: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree
 data
In-Reply-To: <20120829083129.GB3439@gmail.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
 <20120720113806.GW4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA01F1E@DBDE01.ent.ti.com>
 <20120723133400.GU4435@opensource.wolfsonmicro.com>
 <20120828112603.GC25786@gmail.com>
 <20120828172133.GH4534@opensource.wolfsonmicro.com>
 <20120829083129.GB3439@gmail.com>
Message-ID: <20120830165907.GC4356@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 09:31:31AM +0100, Lee Jones wrote:
> On Tue, Aug 28, 2012 at 10:21:33AM -0700, Mark Brown wrote:

> > > The regulator-name property is used to populate constrains->name. Are
> > > you sure you still want them all removed?

> > Yes, of course.  There's no way that a generic .dtsi used for any
> > possible board could come up with a sensible value.

> So how should constrains->name be populated then? Would you prefer
> regulator-names moved to the .dts file(s), or something else?

Of course, yes.  The sole purpose of that field is to give a board
specific name to the supply.  It can't usefully be set by anything
except the board.
