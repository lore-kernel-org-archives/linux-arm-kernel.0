From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 09:48:50 -0700
Subject: [PATCH 1/2] irqchip: sirf: move from legacy mode to linear
 irqdomain
In-Reply-To: <CAGsJ_4yfme9pF7AD=uaz-KsXirwK+isfc_yVrWX82LzV8Jf+6w@mail.gmail.com>
References: <1375767434-19842-1-git-send-email-Baohua.Song@csr.com>
 <CAGsJ_4yfme9pF7AD=uaz-KsXirwK+isfc_yVrWX82LzV8Jf+6w@mail.gmail.com>
Message-ID: <20130829164850.GB18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 05:30:31PM +0800, Barry Song wrote:
> 2013/8/6 Barry Song <21cnbao@gmail.com>:
> > the series of patches for irqdomain core in 3.11 has broken sirf
> > irq which uses legacy mapping. all users fail in the new kernel
> > while setupping irq.
> >
> > this patch moves to linear irqdomain and drop old legacy irqdomain
> > codes since we don't need it any more, and at the same time, it
> > also fixes the broken interrupts of sirfsoc in 3.11.
> >
> > on the other hand, we actually only have 64 interrupt sources for
> > prima2 and atlas6, but there are 128 interrupt souces for marco
> > which uses GIC. in the legacy codes, sirf gpio also uses legacy
> > irqdomain, so to make gpio interrupt mapping not depend on the
> > prima2/atlas6/marco an use unified marco,we enlarge prima2/atlas6
> > interrupt number to 128. here we don't need this workaround any
> > more as sirf gpio also moved to linear mode before. so we move
> > SIRFSOC_NUM_IRQS back to 64 too.
> >
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> 
> ping, this should touch 3.11 as sirfsoc interrupts break in 3.11.

Yeah, apologies for missing this -- applied now and will send up shortly.


-Olof
