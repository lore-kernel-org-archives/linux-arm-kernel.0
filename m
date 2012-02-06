From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 6 Feb 2012 15:16:00 -0800 (PST)
Subject: [regression] Re: Enabling runtime P2V by default
In-Reply-To: <20120206223147.GA3760@burratino>
References: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
 <20110810091635.GF1831@n2100.arm.linux.org.uk>
 <20110810092206.GE10121@e102144-lin.cambridge.arm.com>
 <20120206223147.GA3760@burratino>
Message-ID: <alpine.LFD.2.02.1202061514430.1656@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Feb 2012, Jonathan Nieder wrote:

> Will Deacon wrote:
> > On Wed, Aug 10, 2011 at 10:16:35AM +0100, Russell King - ARM Linux wrote:
> >> On Tue, Aug 09, 2011 at 09:41:38PM +0200, Linus Walleij wrote:
> 
> >>> From: Linus Walleij <linus.walleij@linaro.org>
> >>>
> >>> This works like a charm so I'll just default-select it.
> >>
> >> Well, we can remove the EXPERIMENTAL status of this option now.  This
> >> raises the question is whether we should now default it to 'y' - I
> >> think we should.  Anyone have any objections?
> >
> > I've been running with this option enabled for the collection of ARM boards
> > I have and the only problem I have encountered was related to u-boot loading
> > at the wrong address.
> 
> Hm, another u-boot problem was found[1].  On the affected machines it
> prevents booting a compressed kernel (but uncompressed kernels are
> fine) unless CONFIG_ARM_PATCH_PHYS_VIRT is disabled or u-boot is
> patched.
> 
> > So I'm all for enabling it by default, especially since it will force out
> > any remaining issues for boards where this hasn't been used extensively.
> 
> Looks like it worked. ;-)
> 
> So, what now?  Is there anything the kernel can do to work around
> this, or should we just live with the regression until people patch
> their u-boot?

You really do want to have uboot patched.  Who knows what other latent 
issues are there that you don't know about.


Nicolas
