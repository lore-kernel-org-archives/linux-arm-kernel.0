From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 16 Jul 2014 16:25:35 +0000
Subject: [PATCH RFCv3 08/14] arm64: introduce aarch64_insn_gen_movewide()
In-Reply-To: <20140716161715.GU29414@arm.com>
References: <1405405512-4423-1-git-send-email-zlim.lnx@gmail.com>
 <1405405512-4423-9-git-send-email-zlim.lnx@gmail.com>
 <20140716161715.GU29414@arm.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17274D55@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon
...
> > +	BUG_ON(imm < 0 || imm > 65535);
> 
> Do this check with masking instead?

The compiler will convert that to a single unsigned comparison.

...
> > +		BUG_ON(shift != 0 && shift != 16 && shift != 32 &&
> > +		       shift != 48);

OTOH I don't think it will convert that to:
		BUG_ON(shift & ~48);

	David
