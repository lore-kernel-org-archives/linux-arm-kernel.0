From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 9 Sep 2014 01:47:47 +1000
Subject: [PATCH] irq: gic-v3: Tag all low level accessors __maybey_unused
In-Reply-To: <20140907140255.GB30828@titan.lakedaemon.net>
References: <1406748194-21094-1-git-send-email-broonie@kernel.org>
 <20140817170453.GE12769@titan.lakedaemon.net>
 <20140906125412.GA32429@sirena.org.uk>
 <20140907140255.GB30828@titan.lakedaemon.net>
Message-ID: <20140909014747.0931d51e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Sun, 7 Sep 2014 10:02:55 -0400 Jason Cooper <jason@lakedaemon.net> wrote:
>
> On Sat, Sep 06, 2014 at 01:54:12PM +0100, Mark Brown wrote:
> > On Sun, Aug 17, 2014 at 01:04:53PM -0400, Jason Cooper wrote:
> > > On Wed, Jul 30, 2014 at 08:23:14PM +0100, Mark Brown wrote:
> > > > From: Mark Brown <broonie@linaro.org>
> > 
> > > > This is only really needed for gic_write_sgi1r in the !SMP case since it
> > > > is only referenced in the SMP initialisation code but it seems better to
> > > > have these functions all next to each other and declared consistently.
> > 
> > > > Signed-off-by: Mark Brown <broonie@linaro.org>
> > > > ---
> > > >  drivers/irqchip/irq-gic-v3.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > > Applied to irqchip/urgent
> > 
> > This appears to have disappeared from -next and the warning is back.
> 
> Hmm, interesting. Here's what I have in irqchip/for-next,irqchip/urgent:
> 
>   c44e9d77fd1c irqchip: gic-v3: Tag all low level accessors __maybe_unused
>   ddc86821ee2c irqchip: gic-v3: Only define gic_peek_irq() when building SMP
> 
> and:
> 
> $ git tag --contains c44e9d77fd1c | grep ^next | sort -V
> next-20140820
> next-20140822
> next-20140823
> next-20140825
> next-20140826
> next-20140827
> next-20140828
> next-20140829
> 
> To see whether I forgot to add /urgent to /for-next or if
> irqchip/for-next was dropped, I did the same search against the first
> commit I added to irqchip/core:
> 
> $ git tag --contains 1c36d42c4ffe | grep ^next | sort -V
> next-20140822
> next-20140823
> next-20140825
> next-20140826
> next-20140827
> next-20140828
> next-20140829
> 
> Also dropped on the 30th.  So, unless I really screwed up, -next is no
> longer pulling irqchip/for-next.
> 
> Stephen, could you please look and see if this is the case?

I am fetching it ok.  Unfortunately, in the hand over to Mark last week
he ended up with an old version of my control file and so that tree was
net being included.  Sorry about that, it should be fixed in
next-20140908.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/3c16b13b/attachment.sig>
