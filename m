From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Aug 2016 11:40:02 +0100
Subject: [PATCH 3/9] regulator: core: Try full range when adjusting
 regulators to constraints
In-Reply-To: <CAGb2v67ZST-E++z5oobLRwCfHMZZR6HTss=MSqJLJArnQz3qMw@mail.gmail.com>
References: <20160821021125.1521-1-wens@csie.org>
 <20160821021125.1521-4-wens@csie.org>
 <20160822162907.GO22076@sirena.org.uk>
 <20160822175205.h76hurjaopnosymc@vip.cybercity.dk>
 <20160822180932.GW22076@sirena.org.uk>
 <CAGb2v67ZST-E++z5oobLRwCfHMZZR6HTss=MSqJLJArnQz3qMw@mail.gmail.com>
Message-ID: <20160823104002.GX22076@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 12:17:23PM +0800, Chen-Yu Tsai wrote:
> On Tue, Aug 23, 2016 at 2:09 AM, Mark Brown <broonie@kernel.org> wrote:

> > Sure, but the constraints also say that you can do 1.32V which the
> > system is not physically capable of delivering.  That's not a good sign
> > for the constraints, it suggests that at least the capabilities of the
> > regulator have not been taken into consideration when setting up the
> > constraints.

> So to be clear, the constraints should be the intersection of the
> recommended operating parameters of the consumer and the regulator's
> output, with the voltage/current steps taken in to consideration.

The constraints are there to say what the *system* can deliver.  That
includes the limitations of the consumers, the regulators and the
physical design of the board.  Just as one shouldn't just throw in the
maximum voltage range that the regulator can deliver one also shouldn't
just use the maximum voltage range a consumer can support for similar
reasons.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/346c4861/attachment.sig>
