From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 May 2014 16:31:41 -0700
Subject: [GIT PULL] at91: cleanup for 3.16 #1
In-Reply-To: <20140516232635.GB6423@quad.lixom.net>
References: <1399484042-27432-1-git-send-email-nicolas.ferre@atmel.com>
 <536A6FD7.40402@atmel.com> <20140516232635.GB6423@quad.lixom.net>
Message-ID: <20140516233141.GC6423@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 04:26:35PM -0700, Olof Johansson wrote:
> On Wed, May 07, 2014 at 07:39:35PM +0200, Nicolas Ferre wrote:
> > On 07/05/2014 19:34, Nicolas Ferre :
> > > Arnd, Olof, Kevin,
> > > 
> > > This is the first cleanup pull-request for 3.16. It is pretty big because it
> > > integrates the work from Boris about CCF and Alexandre about IIO/ADC. I
> > > integrated them in this cleanup topic because they both touch the core at91
> > > code, the clk and IIO drivers as well as the DT. The concerned maintainers
> > > added their tags.
> > > 
> > > The patch by Linus is a move of at91 specific GPIO definitions out of the
> > > include/mach directory which is an step towards single zImage.
> > > 
> > > Thanks, best regards,
> > > 
> > > The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:
> > > 
> > >   Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://github.com/at91linux/linux-at91.git tags/at91-cleanup
> > 
> > There is a little conflict with at91-3.16-dt that you already pulled in
> > arm-soc: here is the branch that resolves it:
> > 
> > https://github.com/at91linux/linux-at91/commits/at91-3.16-resolved
> 
> That resolution looks odd. Why is one clock under clocks { } and two of them
> are at the top level? Shouldn't they all be under the clocks subnode?
> 
> I've merged in now with your resolution, but I think this needs revisiting.

Oh, and also: The branch was named cleanup, but it really contains mostly new
driver and new contents, so I merged it under next/soc instead. In the future,
for releases when you have more contents, please split it up a bit more (dt
updates separately, driver updates separately) if it can be done without too
much hassle. For now it's not a huge deal to do it this way though.


-Olof
