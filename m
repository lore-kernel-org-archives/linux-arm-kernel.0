From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 May 2014 16:26:35 -0700
Subject: [GIT PULL] at91: cleanup for 3.16 #1
In-Reply-To: <536A6FD7.40402@atmel.com>
References: <1399484042-27432-1-git-send-email-nicolas.ferre@atmel.com>
 <536A6FD7.40402@atmel.com>
Message-ID: <20140516232635.GB6423@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 07:39:35PM +0200, Nicolas Ferre wrote:
> On 07/05/2014 19:34, Nicolas Ferre :
> > Arnd, Olof, Kevin,
> > 
> > This is the first cleanup pull-request for 3.16. It is pretty big because it
> > integrates the work from Boris about CCF and Alexandre about IIO/ADC. I
> > integrated them in this cleanup topic because they both touch the core at91
> > code, the clk and IIO drivers as well as the DT. The concerned maintainers
> > added their tags.
> > 
> > The patch by Linus is a move of at91 specific GPIO definitions out of the
> > include/mach directory which is an step towards single zImage.
> > 
> > Thanks, best regards,
> > 
> > The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:
> > 
> >   Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://github.com/at91linux/linux-at91.git tags/at91-cleanup
> 
> There is a little conflict with at91-3.16-dt that you already pulled in
> arm-soc: here is the branch that resolves it:
> 
> https://github.com/at91linux/linux-at91/commits/at91-3.16-resolved

That resolution looks odd. Why is one clock under clocks { } and two of them
are at the top level? Shouldn't they all be under the clocks subnode?

I've merged in now with your resolution, but I think this needs revisiting.


-Olof
