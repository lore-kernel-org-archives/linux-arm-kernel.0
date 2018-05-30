From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 30 May 2018 09:56:50 -0500
Subject: [PATCH] PCI: Add pci=safemode option
In-Reply-To: <6dfe2db8f974d94c9867f30ec83d9333@codeaurora.org>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
 <20180530073735.GA28793@infradead.org>
 <6dfe2db8f974d94c9867f30ec83d9333@codeaurora.org>
Message-ID: <20180530145650.GA39853@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 12:44:29AM -0700, okaya at codeaurora.org wrote:
> On 2018-05-30 00:37, Christoph Hellwig wrote:
> > On Tue, May 29, 2018 at 09:41:33PM -0700, Sinan Kaya wrote:
> > > Bjorn and I discussed the need for such a "safe" mode feature when you
> > > want to bring up PCI for a platform. You want to turn off everything
> > > as
> > > a starter and just stick to bare minimum.
> > 
> > Can we please make it a config option the instead of adding code
> > to every kernel?  Also maybe the bringup should be in the name
> > to make this more clear?
> 
> One other requirement was to have a runtime option rather than compile time
> option.
> 
> When someone reported a problem, we wanted to be able to say "use this
> option and see if system boots" without doing any bisects or recompilation.
> 
> This would be the first step in troubleshooting a system to see if
> fundamental features are working.
> 
> I don't mind changing the name
> Bjorn mentioned safe option. I made it safemode. I am looking at Bjorn for
> suggestions at this moment.

This *was* my idea, but I'm starting to think it was a bad idea.

I don't want people to use pci= parameters as the normal way to get a
system to boot.  That would be a huge support hassle (putting things
in release notes, diagnosing problems when people forget it, etc).

But the parameters *are* useful for debugging.  If we had a
"pci=safemode" and it avoided some problem, the next step would be to
narrow it down by using the more specific flags (pci=nomsi, pci=noari,
pci=no_ext_tags, etc).  So I think 95% of the value is in the specific
flags, and a "pci=safemode" might add a little bit of value but at the
cost of a small but nagging maintenance concern and code clutter.

Bjorn
