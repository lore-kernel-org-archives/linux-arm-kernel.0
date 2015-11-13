From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 14 Nov 2015 00:38:50 +0100
Subject: [PATCH v2 10/11] PM / Hibernate: clean cached pages on
 architectures that require it
In-Reply-To: <20151112114705.GA2657@red-moon>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <2039611.PJaFlk1sMi@vostro.rjw.lan> <20151112114705.GA2657@red-moon>
Message-ID: <3180507.pKM8OzKjXO@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 12, 2015 11:47:05 AM Lorenzo Pieralisi wrote:
> On Thu, Nov 12, 2015 at 01:48:32AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, November 11, 2015 11:40:39 AM Lorenzo Pieralisi wrote:
> > > Hi Pavel, Rafael,
> > > 
> > > Do you have any feedback on this patch ?
> > > 
> > > It is fundamental to this series and affects Hibernate core code so if you
> > > have any feedback that would be much appreciated.
> > 
> > I'm really not familiar with the flush_icache_range() interface.
> > 
> > What exactly does it do?
> 
> It is used to sync a memory range that is written into (eg loading
> modules, copying from snapshot is basically the same thing, reads from
> storage and restore pages that might well be executable code), in particular
> to sync the I-cache and the D-cache, eg on arm64 the page that the snapshot
> code is copying might be executable code that has to be cleaned from the
> D-cache so that it is made visible to the I-cache.
> 
> On x86 it is a NOP AFAIK.

If that's the case, I have no problems with this change as long as the code
works on architectures with non-trivial flush_icache_range().

Thanks,
Rafael
