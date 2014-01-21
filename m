From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Tue, 21 Jan 2014 17:25:00 +0200
Subject: [PATCH RFC 4/6] net: rfkill: gpio: add device tree support
In-Reply-To: <CAAVeFuKFfAvSPYLmvWV5jjT-peZFJ8sJ2bbh4F=JAYoWLhjZpA@mail.gmail.com>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
 <CAAVeFuLP4MkfXGG1FMauvUw_J63zRXdhGwxqYy5W98L1wCQNbw@mail.gmail.com>
 <CACRpkdYiy+sya6NqRfAmsrFOXvaa3qX=qjRuTDW1vZVSaG1+Gg@mail.gmail.com>
 <201401211335.16885.arnd@arndb.de>
 <CAAVeFuKFfAvSPYLmvWV5jjT-peZFJ8sJ2bbh4F=JAYoWLhjZpA@mail.gmail.com>
Message-ID: <20140121152500.GN18029@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 11:53:13PM +0900, Alexandre Courbot wrote:
> > I think a unified kernel API makes more sense for some subsystems than
> > others, and it depends a bit on the rate of adoption of APCI for drivers
> > that already have a DT binding (or vice versa, if that happens).
> >
> > GPIO might actually be in the first category since it's commonly used
> > for off-chip components that will get shared across ARM and x86 (as
> > well as everything else), while a common kernel API would be less
> > important for things that are internal to an SoC where Intel is the
> > only company needing ACPI support.
> 
> I am afraid I don't have a good enough view of the ACPI landscape to
> understand how often drivers might be reused on both ACPI and DT. But
> I suppose nothing speaks against that, technically speaking. Maybe
> Mika would have comments to make here?

Well, we try to reuse existing drivers whenever possible. As an example
Intel LPSS devices (that exists on Haswell and Baytrail) are mostly
existing drivers from ARM world.

I would say that GPIO is one of such things where we would like to have an
unified interface definitely.
