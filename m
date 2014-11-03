From: msalter@redhat.com (Mark Salter)
Date: Mon, 03 Nov 2014 13:45:57 -0500
Subject: [PATCH 1/2] [usb] make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <7145110.be3vG56Rvi@wuerfel>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <13596133.Pde5jAKbQO@wuerfel> <1415024151.3641.18.camel@deneb.redhat.com>
 <7145110.be3vG56Rvi@wuerfel>
Message-ID: <1415040357.3641.42.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-11-03 at 18:14 +0100, Arnd Bergmann wrote:
> On Monday 03 November 2014 09:15:51 Mark Salter wrote:
> > On Thu, 2014-10-30 at 22:05 +0100, Arnd Bergmann wrote:
> > > You should definitely make sure that this also works with DT, as
> > > I don't think it's possible to support X-Gene with ACPI. I know
> > > that Al Stone has experimented with it in the past, but he never
> > > came back with any results, so I assume the experiment failed.
> > > 
> > > Note that the discussions about merging ACPI support on ARM64
> > > are based on the assumption that we'd only ever support SBSA-like
> > > platforms, not something like X-Gene that looks more like an
> > > embedded SoC. Your XHCI patches still obviously make sense for
> > > other platforms, so that's not a show-stopper.
> > 
> > But for some misconfiguration, the arm64 kernels in fedora arm
> > koji would boot using ACPI on Mustang, the Foundation model,
> > and AMD Seattle platforms. All very much a work in progress,
> > but the tree from which the fedora patches are taken is the
> > devel branch of:
> > 
> >   git.fedorahosted.org/git/kernel-arm64.git
> > 
> > The configuration will be fixed this week and then you can
> > just grab an arm64 fedora kernel and boot with acpi=force.
> 
> It's not as bad as I had feared, but it still does a lot of
> the things that in previous discussions were said that ACPI
> would avoid doing, and that were used as arguments against
> just using DT on all arm64 servers:

As I said, this is very much a work in progress. The point of the
fedorahosted tree is to have *something* that will boot with ACPI
and have working disk and network as a minimum for the few existing
early platforms. It is certainly not an example of what an ACPI/SBSA
server should look like. At least not yet. And it isn't a big secret.
Linaro, Arm, and other folk are aware of that fedorahosted tree. I
wouldn't read too much into any given patch in that tree as it stands
right now.
