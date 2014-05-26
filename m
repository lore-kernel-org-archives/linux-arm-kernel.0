From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 May 2014 14:58:58 -0700
Subject: [GIT PULL 01/02] DaVinci EDMA clean-up for v3.16
In-Reply-To: <20140526214307.GR27093@quad.lixom.net>
References: <1400924613-24451-1-git-send-email-nsekhar@ti.com>
 <20140526214307.GR27093@quad.lixom.net>
Message-ID: <20140526215858.GU27093@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 02:43:07PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Sat, May 24, 2014 at 03:13:32PM +0530, Sekhar Nori wrote:
> > Hi Olof, Kevin, Arnd,
> > 
> > These patches introduce a change to EDMA bindings. They
> > deprecate some bindings but new kernel will continue
> > to work with older DTBs since the information is now
> > read from hardware instead. I have not been able to
> > get an Ack/response from DT folks on this. Since it
> > has been close to two weeks since the patches were first
> > posted, I am asking for the patches to be merged so
> > we dont miss the merge window.
> 
> That should be fine. I also noticed that the bindings file still describes the
> properties but under a deprecated section, that's good practice.
> 
> > This pull request is on top of Vinod's topic/edma branch
> > which he has guaranteed will not be rebased before going
> > to Linus. This was needed because of dependency with some
> > patches he has queued.
> 
> Ok, I've created a depends/vinod-edma to track the dependency, starting at
> SHA b0cce4ca3e74. I've also cc:d him on this reply so he's aware of this.
> 
> > This series introduces a trivial merge conflict with
> > Linux-next because of a bug fix which went in after
> > Vinod's branch was built.
> > 
> > Thanks,
> > Sekhar
> > 
> > The following changes since commit b0cce4ca3e740b5224d75634aa9d9abe9dfceabb:
> > 
> >   dmaengine: edma: update DMA memcpy to use new param element (2014-04-30 10:36:57 +0530)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.16/edma
> > 
> > for you to fetch changes up to 903ed4913c7fe78d2746445564634264291c7493:
> > 
> >   ARM: edma: Remove redundant/unused parameters from edma_soc_info (2014-05-22 14:55:25 +0530)
> 
> Merged into next/drivers.

This had a conflict with the fix from Thomas that fixes the binding. To
avoid this, you could have merged Vinod's branch in on top of the fix branch
you had, then build your new contents on top.

Anyway, not a huge deal, but something to tweak in the future.


-Olof
