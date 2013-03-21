From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 21 Mar 2013 16:57:09 -0300
Subject: [PATCH 05/16] thermal: mvebu: Fix valid check for thermal register
In-Reply-To: <20130321152400.GX13280@titan.lakedaemon.net>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321143539.GV13280@titan.lakedaemon.net>
 <20130321151609.GA24246@localhost>
 <20130321152400.GX13280@titan.lakedaemon.net>
Message-ID: <20130321195708.GA2648@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 11:24:00AM -0400, Jason Cooper wrote:
> On Thu, Mar 21, 2013 at 12:16:10PM -0300, Ezequiel Garcia wrote:
> > Hi Jason,
> > 
> > On Thu, Mar 21, 2013 at 10:35:39AM -0400, Jason Cooper wrote:
> > > On Wed, Mar 20, 2013 at 07:36:26PM -0300, Ezequiel Garcia wrote:
> > > > The correct value is obtain by first shifting the register by the offset,
> > > > later applying the valid mask and finally invert the result.
> > > > This check was lacking an extra parenthesis to be strictly correct.
> > > > 
> > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > > ---
> > > >  drivers/thermal/mvebu_thermal.c |    4 ++--
> > > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > For the next version of this series, could you please put this fix first
> > > in the series?  In this state, it can't be applied to v3.9-rcX, nor
> > > -stable.
> > > 
> > 
> > Given we're still discussing the aproach of this patchset.
> > I think I prefer to send the fixes now, not as part of the
> > current series but as independent patches.
> > 
> > What do you think?
> 
> I agree.
> 

I have a question about this though: Who should pick patches for
drivers/thermal/{dove,kirkwood,mvebu} ? You or Zhang?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
