From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 17 Jul 2014 09:51:33 +0000
Subject: [PATCH RFCv3 08/14] arm64: introduce aarch64_insn_gen_movewide()
In-Reply-To: <20140717094101.GD21153@arm.com>
References: <1405405512-4423-1-git-send-email-zlim.lnx@gmail.com>
 <1405405512-4423-9-git-send-email-zlim.lnx@gmail.com>
 <20140716161715.GU29414@arm.com> <20140716220422.GB18109@gup76>
 <20140717094101.GD21153@arm.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1727697D@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon
...
> > > > +	BUG_ON(imm < 0 || imm > 65535);
> > >
> > > Do this check with masking instead?
> >
> > Ok, if you prefer, I can change it to:
> >
> > 	BUG_ON(imm & ~GENMASK(15, 0));

Gah - then anyone reading the code has to look up another define.
There isn't a prize for the most complicated method of defining
a constant that can never change.

> Sure, that or use a named constant for the upper-bound (SZ_64K - 1).

There is nothing wrong with the original code.
Maybe use 0xffff for those people (are there any) that don't know
their powers of two.

These are strong constants, they aren't going to be changed to any
other value, and it is unlikely that anyone will want to search for
their uses.

I presume that SZ_64K is defined somewhere to 0x10000u.
But IMHO using it (instead of the literal) doesn't make code
any more readable.

	David
