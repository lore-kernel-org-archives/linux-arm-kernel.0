From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Mar 2018 19:12:18 +0000
Subject: Regulator regression in next-20180305
In-Reply-To: <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk>
 <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
Message-ID: <20180306191218.GF13586@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 01:56:42PM -0300, Fabio Estevam wrote:
> On Tue, Mar 6, 2018 at 1:30 PM, Mark Brown <broonie@kernel.org> wrote:

> > -       for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
> > +       for (i = 1000; rdev; rdev = rdev_get_supply(rdev), i++)
> >                 mutex_lock_nested(&rdev->mutex, i);

> With this change the log is a bit different, but still get a kernel hang:
> https://pastebin.com/eF08TnuT

Yeah, that's what I expected.  What we really need to figure out I think
is what exactly is taking the lock that we end up colliding with, I
don't seem to be able to reproduce so I'm having to just go on staring
at the code here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180306/7015dd76/attachment.sig>
