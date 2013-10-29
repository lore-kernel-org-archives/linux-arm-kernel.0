From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 29 Oct 2013 05:34:08 -0300
Subject: [PATCH 2/2] dma: mv_xor: Use high_base mmio where appropriate
In-Reply-To: <CAPcyv4iQVoYCXz16T3N4MbdVJV7MoKKeL0wq9t9WF1Kf3gz3Bw@mail.gmail.com>
References: <1383000855-8377-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383000855-8377-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAPcyv4iQVoYCXz16T3N4MbdVJV7MoKKeL0wq9t9WF1Kf3gz3Bw@mail.gmail.com>
Message-ID: <20131029083407.GA2416@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 04:47:20PM -0700, Dan Williams wrote:
> [ adding dmaengine ]
> 
> On Mon, Oct 28, 2013 at 3:54 PM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > Despite requesting two memory resources, called 'base' and 'high_base', the
> > driver uses explicitly only the former. The latter is being used implicitly
> > by addressing at offset +0x200, which in practice accesses high_base.
> >
> > Instead of relying in such trick, let's define the registers with the
> > offset from high_base, and use high_base explicitly where appropriate.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/dma/mv_xor.c |  3 ++-
> >  drivers/dma/mv_xor.h | 25 +++++++++++++------------
> >  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> Since it's unused I'd prefer a patch that just deletes xor_high_base.
> 

It's wrongly *unused*, the mmio high_base is actually being used
implicitly by always addressing at an offset that addresses +200.

Deleting high_base would actually make it worse, for that region
will no longer be ioremaped. Maybe the commit message is not clear
about it?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
