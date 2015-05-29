From: joe@perches.com (Joe Perches)
Date: Fri, 29 May 2015 02:51:13 -0700
Subject: [PATCH] fixup! dmaengine: pxa_dma: add debug information
In-Reply-To: <1617548760.717381111.1432891749082.JavaMail.root@zimbra1-e1.priv.proxad.net>
References: <1617548760.717381111.1432891749082.JavaMail.root@zimbra1-e1.priv.proxad.net>
Message-ID: <1432893073.29807.15.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-05-29 at 11:29 +0200, robert.jarzmik at free.fr wrote:
> ----- Mail original -----
> De: "Vinod Koul" <vinod.koul@intel.com>
> On Wed, May 27, 2015 at 11:23:40PM +0200, Robert Jarzmik wrote:
> > This fixes the following error:
[]
> And with a a bit closer look check this commit, especially the date :
> commit 0bac33653b06a5f80a5c04e275eb33db9493b85a
> Author: Joe Perches <joe@perches.com>
> Date:   Sat May 23 12:00:38 2015 +1000
> 
>     fs/seq_file: convert int seq_vprint/seq_printf/etc... returns to void

Hello Robert.

The return value of that dbg_show_requester_chan function
was incorrect and the increment of pos was an example of
why the seq_printf return value was changed to void.

It was a pretty common error and easy to understand given
the expectation that seq_printf should work like printf.

It's a pity it bit you. but this type of patch collision
should be a bit more difficult to reoccur in the future.

cheers, Joe
