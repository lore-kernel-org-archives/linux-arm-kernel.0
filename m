From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Jul 2014 09:39:40 +0200
Subject: [PATCH v2 1/2] ARM: topology: Use a clock if possible to get the
 CPU frequency
In-Reply-To: <CAKfTPtBPR9QA9h4bF3EkCZufpF+X84N7JzjU88CptR1RtiNrdg@mail.gmail.com>
References: <20140630124919.GC28647@lukather>
 <CAKfTPtCgpc1J888hbqxoaF5UfcUoRwcpokme32WHPpsPAAawUQ@mail.gmail.com>
 <20140630140146.GD28647@lukather>
 <CAKfTPtAu+mSVO8dvg_Z6w_nYWndap+FY5VGKeg-0pae_4JqR=A@mail.gmail.com>
 <20140630145847.GE28647@lukather>
 <CAKfTPtDvQJ5i=t8FN0gLQex0yAC4NNgewTnGKdiCeGk7nQwZYg@mail.gmail.com>
 <20140703071016.GB31996@lukather>
 <CAKfTPtBonwH0PoEkKazUS9bPaR631Vu7p7qZ0AF1whmXq_53wg@mail.gmail.com>
 <20140704080255.GO31996@lukather>
 <CAKfTPtBPR9QA9h4bF3EkCZufpF+X84N7JzjU88CptR1RtiNrdg@mail.gmail.com>
Message-ID: <20140708073940.GH13423@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 11:22:33AM +0200, Vincent Guittot wrote:
> >>  I still think that using the current rate with clk_get_rate is not a
> >> good solution.
> >
> > Well, it's just as good as using clock-frequency, really. If you want
> > the CPU max frequency, it's not the right property (plus, since the
> > changed behaviour is not documented in Linux anywhere, the only
> > reference we have is the ePAPR on this).
> >
> >> Could you give us more details about why you nee to use current clock ?
> >
> > Honestly, I just want to remove that big warning at boot on the
> > A7-based SoCs we have :)
> 
> so Why not changing the log message ? It's clearly not an error to not
> have clock-frequency

Because the next SoCs we're going to support will be HMP, so we're
only delaying the issue by a few month if we're doing so.

It doesn't fix the underlying issue where you're using a standard
property for a (slightly) different usage.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140708/32eb41b8/attachment.sig>
