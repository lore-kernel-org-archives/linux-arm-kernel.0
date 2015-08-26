From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Aug 2015 17:51:49 +0100
Subject: [PATCH] arm: perf: Add event descriptions
In-Reply-To: <20150817205809.GA16506@dreric01-gentoo.localdomain>
References: <20150804001522.GA13214@dreric01-gentoo.localdomain>
 <20150817205809.GA16506@dreric01-gentoo.localdomain>
Message-ID: <20150826165148.GF30466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 09:58:09PM +0100, Drew Richardson wrote:
> On Tue, Aug 04, 2015 at 01:15:23AM +0100, Drew Richardson wrote:
> > Add additional information about hardware events to make counters self
> > describing. This makes the hardware PMUs easier to use as perf list
> > contains the possible events instead of users having to refer to
> > documentation like the ARM TRMs. This could also allow tools like
> > oprofile to support PMUs without requiring an update.
> > 
> > Signed-off-by: Drew Richardson <drew.richardson@arm.com>
> > ---
> >  arch/arm/kernel/perf_event.c    |   1 +
> >  arch/arm/kernel/perf_event_v7.c | 617 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 618 insertions(+)
> 
> Any concerns with merging this?

We should revisit this after the merge window (since the ARM perf code is
moving out to drivers/), but I do have reservations about putting all these
strings into the kernel. Why can't we put this into something like libpfm
instead?

Will
