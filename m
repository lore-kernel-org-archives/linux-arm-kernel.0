From: mhowe@cwlinux.com (Morgan Howe)
Date: Thu, 17 Jun 2010 16:33:40 +0800
Subject: mxcmmc driver hangs on sync
In-Reply-To: <20100615072237.GW17833@buzzloop.caiaq.de>
References: <20100615112936.5d03ce92@morgan>
	<20100615063142.GU17833@buzzloop.caiaq.de>
	<20100615152051.26e4589c@morgan>
	<20100615072237.GW17833@buzzloop.caiaq.de>
Message-ID: <20100617163340.69409a3f@morgan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Tue, 15 Jun 2010 09:22:37 +0200
Daniel Mack <daniel@caiaq.de> wrote:
> On Tue, Jun 15, 2010 at 03:20:51PM +0800, Morgan Howe wrote:
> > On Tue, 15 Jun 2010 08:31:43 +0200
> > Daniel Mack <daniel@caiaq.de> wrote:
> > > On Tue, Jun 15, 2010 at 11:29:36AM +0800, Morgan Howe wrote:
> > > > With the older kernel this would hang on sync after a few
> > > > thousand loops, and much sooner if you ran 2 or 3 of these
> > > > processes at a time. I tried last night with the newer kernel
> > > > and kicking off 3 processes and after ~100-150 loops per
> > > > process I get this:
> > > 
> > > Which 'newer kernel' did you try?
> > 
> > Hey Daniel,
> > 
> > Sorry, I said current mainline, but actually it's 2.6.35-rc1.
> 
> Could you try two things:
> 
> a) build a kernel without MX2 DMA support
> b) try 2.6.34, as there were some updates to the mxcmmc driver after
>    2.6.34 which could be related

I have just been able to confirm using the final release of the 2.6.34
kernel that the problem also exists, with the same behavior as
described for 2.6.35.

Regards,
Morgan
