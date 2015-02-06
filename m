From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 6 Feb 2015 09:16:11 +0100
Subject: [PATCH] drm: atmel-hlcdc: Atomic mode-setting conversion
In-Reply-To: <20150205163756.74a1bde0@bbrezillon>
References: <1423081251-11062-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150205130832.GU14009@phenom.ffwll.local>
 <20150205163756.74a1bde0@bbrezillon>
Message-ID: <20150206081611.GA14009@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 04:37:56PM +0100, Boris Brezillon wrote:
> On Thu, 5 Feb 2015 14:08:32 +0100
> Daniel Vetter <daniel@ffwll.ch> wrote:
> 
> > On Wed, Feb 04, 2015 at 09:20:51PM +0100, Boris Brezillon wrote:
> > > Convert the HLCDC driver to atomic mode-setting.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > 
> > Just a quick comment: dpms isn't yet converted over, and from experience
> > with tegra/msm that probably will yield some surprises. Since only with
> > dpms will it be obvious how strict the added requirements from the atomic
> > helpers are ;-)
> 
> Yes, I noticed I was not using the appropriate dpms helper in the
> connector funcs just after sending this patch.
> 
> Would this patch [1] address what you're talking about, or am I still
> missing something ?
> 
> Thanks,
> 
> Boris
> 
> [1]http://code.bulix.org/l70xf4-87827

You should be able to bin all your dpms implementations too, at least if
you switch to the new enable/disable hooks for crtc/encoder.
prepare/commit/dpms are all depcrecated (for both crtc and encoder) and
shouldn't be needed any more.  Same with crtc_funcs->mode_set.

But yeah the functional change should be all there is, if it still works
you're all set.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
