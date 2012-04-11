From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 10 Apr 2012 20:54:37 -0400
Subject: [PULL] generic irq chip and pl061 irqdomain support
In-Reply-To: <20120407041155.196043E25B3@localhost>
References: <4F3ADFE7.4090409@gmail.com> <4F5437FE.2000306@gmail.com>
 <4F5FD037.5000703@gmail.com> <20120313231834.8B6AE3E050F@localhost>
 <4F79A3B3.9040209@gmail.com> <20120407041155.196043E25B3@localhost>
Message-ID: <20120411005436.GC14790@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2012 at 09:11:55PM -0700, Grant Likely wrote:
> On Mon, 02 Apr 2012 08:03:47 -0500, Rob Herring <robherring2@gmail.com> wrote:
> > Grant,
> > 
> > On 03/13/2012 06:18 PM, Grant Likely wrote:
> > > On Tue, 13 Mar 2012 17:54:47 -0500, Rob Herring <robherring2@gmail.com> wrote:
> > >> On 03/04/2012 09:50 PM, Rob Herring wrote:
> > >>> Grant,
> > >>>
> > >>> On 02/14/2012 04:27 PM, Rob Herring wrote:
> > >>>> Grant,
> > >>>>
> > >>>> Please pull. This is based on your current branch which you have said
> > >>>> you plan to rebase, so feel free to rebase these as you need to. This
> > >>>> has been tested on highbank and i.MX5.
> > >>>>
> > >>>
> > >>> Ping.
> > >>>
> > >>> I've rebased onto your current tree. Updated pull request:
> > >>>
> > >>> The following changes since commit 280ad7fda5f95211857fda38960f2b6fdf6edd3e:
> > >>>
> > >>>   mfd: twl-core: Add IRQ_DOMAIN dependency (2012-02-26 16:48:06 -0700)
> > >>>
> > >>> are available in the git repository at:
> > >>>   git://sources.calxeda.com/kernel/linux.git irqdomain-for-grant
> > >>>
> > >>> Rob Herring (3):
> > >>>       ARM: kconfig: always select IRQ_DOMAIN
> > >>>       irq: add irq_domain support to generic-chip
> > >>>       gpio: pl061: enable interrupts with DT style binding
> > >>>
> > >>>  .../devicetree/bindings/gpio/pl061-gpio.txt        |   15 ++
> > >>>  arch/arm/Kconfig                                   |    2 +-
> > >>>  arch/arm/common/Kconfig                            |    2 -
> > >>>  drivers/gpio/gpio-pl061.c                          |   48 ++++---
> > >>>  include/linux/irq.h                                |   15 ++
> > >>>  kernel/irq/generic-chip.c                          |  152
> > >>> +++++++++++++++++---
> > >>>  6 files changed, 186 insertions(+), 48 deletions(-)
> > >>>
> > >>
> > >> Ping again...
> > > 
> > > Okay, I've pulled this in.  I need to do some compile testing before I push
> > > it out.
> > 
> > What happened to this? It's not in rc1.
> 
> I kept looking at it and planning to send Linus a pull request, but I
> just couldn't make myself comfortable with the state of the patch.  It
> seems to me that there is too much bleeding of irq_domain state into
> irq_generic_chip and it doesn't return any meaningful context to the
> caller that can be used to tear it back down.
> 
> I think for the domain+generic_chip use case the API needs refining so
> that it returns a container structure with both the irq_domain and the
> array of generic chips.  Plus there needs to be a remove function
> (there also needs to be an irq_domain remove function; I also realized
> that was a missing piece when I looked at it).
> 
> I had really hoped to get fixup patches sorted out in time to still
> get Linus to merge it even though it hadn't been through Linux next,
> but given that I couldn't even find time to email you properly about
> it, it seems I was doomed.  :-(  There weren't any other users of it
> in linux-next though, so in the end I just didn't sent the pull req.

I have several patches for kirkwood/orion which depend on this.  I'd be
lying if I said they were ready for submission, but getting this merged
would sure help move things along.  ;-)

thx,

Jason.
