From: robert.richter@cavium.com (Robert Richter)
Date: Wed, 19 Sep 2018 08:57:02 +0200
Subject: [PATCH RESEND 3/6] arm64: add sysfs vulnerability show for
 spectre v1
In-Reply-To: <20180918171550.GN16498@arm.com>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-4-ykaukab@suse.de>
 <20180917172206.GA3795@rric.localdomain>
 <20180918083805.GB14404@arm.com>
 <20180918095226.GJ3795@rric.localdomain>
 <20180918171550.GN16498@arm.com>
Message-ID: <20180919065701.GK3795@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.09.18 18:15:51, Will Deacon wrote:
> On Tue, Sep 18, 2018 at 11:52:27AM +0200, Robert Richter wrote:
> > On 18.09.18 09:38:05, Will Deacon wrote:
> > > On Mon, Sep 17, 2018 at 07:22:07PM +0200, Robert Richter wrote:
> > > > On 27.08.18 16:33:07, Mian Yousaf Kaukab wrote:
> > > > > Hard-coded since patches are merged and there are no configuration
> > > > > options.
> > > >
> > > > Could you add a list of upstream patches to the description that are
> > > > required to solve this? This would be a strict definition for the
> > > > mitigation being enabled and makes it easier to check if backports are
> > > > affected or not. A build-time check would be ideal (e.g. checking for
> > > > certain macros).
> > >
> > > Hmm, I don't grok what you're proposing here. Why do we need a build-time
> > > check (and to check what?)
> >
> > My concern is, that for kernel backports (esp. distro kernels) there
> > could be various interpretations of what "Mitigation: __user pointer
> > sanitization" means. So a list of upstream patches that need to be
> > backported in addition to this patch as a requirement would be good to
> > agree on. That should be documented in the patch description.
> >
> > If these mitigations are available in a kernel backport, that could be
> > even checked at build time. E.g. we could have a sanity check if the
> > macro array_index_nospec() is defined. But such a check does not
> > replace a code review of a kernel backport.
> >
> > I hope that makes sense?
> 
> Ok, I see what you mean now, thanks. However, it doesn't sound much
> different than backporting a patch with dependencies, so I'd rather
> avoid adding additional code to treat this case specially.

A pointer to the patches would be helpful as the dependencies are not
obvious. This is different to just backport a complete series of
patches.

-Robert
