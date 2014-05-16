From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 May 2014 09:19:58 +0200
Subject: [PATCHv3 3/3] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <20140515153150.GP27822@titan.lakedaemon.net>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400145519-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140515132118.GK27822@titan.lakedaemon.net>
 <20140515155008.1dcca042@free-electrons.com>
 <20140515153150.GP27822@titan.lakedaemon.net>
Message-ID: <20140516091958.3991a822@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Thu, 15 May 2014 11:31:50 -0400, Jason Cooper wrote:

> > > iiuc, this patch depends on 1/3.  So how would you like to handle it?
> > 
> > Seems like my long cover letters are not always read in their
> > entirety :-)
> 
> It was, the 'u' comes from 'u'nderstanding the coverletter _and_ the
> code. ;-)

Hehe :-)

> One a side note, I should mention I find your detailed coverletters
> extremely helpful for getting up to speed quickly on what the intention
> of a series is.  Even better, the Link tag that's added to the commit
> message allows future devs to be three clicks away from that
> information.  Thanks for setting that standard.

Thanks, I appreciate. I intentionally do some efforts to write detailed
cover letters, especially for the most complicated topics, I believe
it's needed to "sell" the patches to the appropriate maintainers.

> Which makes me think, in a lot of cases, it's better to start at the top
> of the thread when researching a patch.  The Message-Id of the
> coverletter is always the first address in the References header.
> Perhaps I should link to that instead, or add both.

Maybe. In any case, the cover letter is never far away for the patch
e-mails, so it isn't that complicated to get back to the cover letter.

Sometimes, it's a bit difficult to decide how to balance the
information between the cover letter and the commit logs. The
explanation in the cover letter has the nice property that it covers
the entire patch series, so it's very convenient to explain the overall
goal of the patch series, the global architecture of the solution being
proposed. But on the other hand, the contents of the cover letter do
not become part of the Git history. On the other side, commit logs
become part of the Git history (so people are more likely to see them
in the future), but are more difficult to use to convey the overall
design, since they are only per-patch.

> > So the only course of action I see right now is to work with Russell to
> > have him pull patches 1 and 2, and then provide a stable branch/tag
> > that you can merge as a dependency in whatever branch you decide to
> > merge patch 3/3. Would that work?
> 
> Dunno.  I have a 100% failure rate getting Russell to create a stable
> topic branch to resolve dependencies like these.  Unfortunately, I think
> the answer is going to be resubmit 3/3 once 3.16-rc1 lands with 1/3 and
> 2/3.

Let's go for the solution you've chosen: merge PATCH 3/3 of the v4.
This one does not have build dependency on PATCH 1/3, and already
solves most of the problems: MT_UNCACHED mappings for PCI memory
mappings, and avoidance of outer cache sync operations when hardware
I/O coherency is used. The only thing that remains to solve is the PCI
I/O mappings, but they are a lot less frequently used so it is not as
important as the other aspects of the problem. And this aspect can
indeed be solved as a followup patch.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
