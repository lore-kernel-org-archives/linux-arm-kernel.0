From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Aug 2013 08:23:35 +0530
Subject: [PATCH v2] dmaengine: sirf: add PM entries for sleep and runtime
In-Reply-To: <CAGsJ_4yPgXhUO65tAyU4ngMRUzqa6uZWqEM2NoD-HWy9DL-rnQ@mail.gmail.com>
References: <1375177474-27583-1-git-send-email-Baohua.Song@csr.com>
 <20130813113200.GE32147@intel.com>
 <CAGsJ_4yPgXhUO65tAyU4ngMRUzqa6uZWqEM2NoD-HWy9DL-rnQ@mail.gmail.com>
Message-ID: <20130814025335.GI32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 10:22:15AM +0800, Barry Song wrote:
> 2013/8/13 Vinod Koul <vinod.koul@intel.com>
> 
> > On Tue, Jul 30, 2013 at 05:44:34PM +0800, Barry Song wrote:
> > > this patch adds PM ops entries in sirf-dma drivers, so that this
> > > driver can support suspend/resume, hibernation and runtime PM.
> > >
> > > while suspending, sirf-dma will lose all registers, so we save
> > > them at suspend and restore in resume for active channels.
> > >
> > > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > > Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> > Applied, thanks
> >
> > Although putting runtime_get/put in submit and callback would be much more
> > better than alloc/free implementation
> >
> > i do agree. i did want to make the runtime pm happen in submit and finish
> callback. then i found it was buggy. and we need more work to make it
> really stable, then i moved to runtime PM with more coarse accuracy. that
> will lose some power saving. but i think we can have increased patches for
> that if we measure and find dma power consumption is large.
> BTW, where is the active dmaengine tree located  in now? it seems that
> https://git.kernel.org/cgit/linux/kernel/git/djbw/dmaengine.git/ is not
> active for a long time.
mine is at git.infradead.org/users/vkoul/slave-dma.git

Dan seem busy so he acks patches and I carry them

~Vinod
