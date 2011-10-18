From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 Oct 2011 13:30:22 +0100
Subject: [PATCH] regulator: max8649 Convert max8649 to user regmap api
In-Reply-To: <CAN1soZywkpvcoXOHHwob=UnHwwEebBFAmCZVN18AH8uzX=q0wg@mail.gmail.com>
References: <1318922635-24703-1-git-send-email-jhbird.choi@samsung.com>
	<CAN1soZywkpvcoXOHHwob=UnHwwEebBFAmCZVN18AH8uzX=q0wg@mail.gmail.com>
Message-ID: <20111018123022.GB28501@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 05:58:57PM +0800, Haojian Zhuang wrote:
> On Tue, Oct 18, 2011 at 3:23 PM,  <jhbird.choi@samsung.com> wrote:
> > From: Jonghwan Choi <jhbird.choi@samsung.com>

> Comments?

There's not really much more to say than the changelog TBH.

> > +static struct regmap_config max8649_regmap_config = {
> > + ? ? ? .reg_bits = 8,
> > + ? ? ? .val_bits = 8,
> > +};
> > +

> Register CHIP_ID1 & CHIP_ID2 are only readable. But it isn't mentioned
> in your code.

This is optional unless the device is using the cache code, especially
given that not even max_register has been provided.  For a conversion
like this providing access information is not needed.
