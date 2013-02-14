From: horms@verge.net.au (Simon Horman)
Date: Thu, 14 Feb 2013 13:42:22 +0900
Subject: [PATCH] ARM: shmobile: r8a7779: Correct TMU clock support again
In-Reply-To: <20130214043648.GA4773@verge.net.au>
References: <1360813381-3416-1-git-send-email-horms+renesas@verge.net.au>
 <87a9r7v8xd.wl%kuninori.morimoto.gx@renesas.com>
 <CANqRtoQtROi1cD3MmykhKLqY+1Y2=f+1Qkmw2bjAaP6yZRPW=Q@mail.gmail.com>
 <878v6rv8ij.wl%kuninori.morimoto.gx@renesas.com>
 <20130214042027.GD6036@verge.net.au>
 <87621vv7wa.wl%kuninori.morimoto.gx@renesas.com>
 <20130214043648.GA4773@verge.net.au>
Message-ID: <20130214044221.GB4773@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 01:36:49PM +0900, Simon Horman wrote:
> On Wed, Feb 13, 2013 at 08:25:45PM -0800, Kuninori Morimoto wrote:
> > 
> > Hi Simon
> > 
> > > > >>       CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
> > > > >> -     CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP015]), /* TMU01 */
> > > > >> +     CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
> > > > >>       CLKDEV_DEV_ID("sh_tmu.2", &mstp_clks[MSTP014]), /* TMU02 */
> > (snip)
> > > > This means that current TMU02 numbering seems doubtful too ?
> > > > How about just rever 58079fa7d54a0929d304054ee759187a2ccd3cdf ?
> > > 
> > > Perhaps that is a good idea.
> > > 
> > > The original motivation for this patch was to add the TMU02 line.
> > > And "fixing" TMU01 was an afterthought. However, I am also
> > > now doubtful about the correctness of the TMU02 line and thus
> > > the usefulness of the original patch.
> > 
> > I think this comment out is creating confusion ?
> > 
> > /* TMU00 */ -> /* TMU0 channel 0 */
> > /* TMU01 */ -> /* TMU0 channel 1 */
> > /* TMU02 */ -> /* TMU0 channel 2 */
> 
> That does make things a little clearer,
> but I for one wasn't confused by the existing comments.

Ok, now I think I see what you are getting at.

MSTP016 is for channel 0..n of TMU0
MSTP015 is for channel 1..n of TMU1
MSTP014 is for channel 2..n of TMU2

And all the TMU values set by CLKDEV_DEV_ID statements above
relate to channels of TMU0.

That does seem to be a valid interpretation of the documentation
now that I read it again.
