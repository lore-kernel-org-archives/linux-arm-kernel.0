From: msalter@redhat.com (Mark Salter)
Date: Fri, 10 Jan 2014 08:50:02 -0500
Subject: [PATCH v3 4/6] arm: add early_ioremap support
In-Reply-To: <20140110113415.GH27432@n2100.arm.linux.org.uk>
References: <1389325833-16535-1-git-send-email-msalter@redhat.com>
 <1389325833-16535-5-git-send-email-msalter@redhat.com>
 <20140110113415.GH27432@n2100.arm.linux.org.uk>
Message-ID: <1389361802.2591.57.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-01-10 at 11:34 +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 09, 2014 at 10:50:31PM -0500, Mark Salter wrote:
> > +#define FIXMAP_PAGE_NORMAL (L_PTE_MT_WRITEBACK | L_PTE_YOUNG | L_PTE_PRESENT)
> > +#define FIXMAP_PAGE_IO (L_PTE_MT_DEV_NONSHARED | L_PTE_YOUNG | L_PTE_PRESENT)
> 
> Doesn't this also want L_PTE_XN for at least IO mappings - maybe for the
> normal too if no code is expected to be run from it.

Yes is both cases. I also need to fix arm64 mem mapping for same reason.
Thanks!
