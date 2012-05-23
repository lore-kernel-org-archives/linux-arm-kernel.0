From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 23 May 2012 16:13:42 +0300
Subject: [PATCH v2 05/12] usb: chipidea: add imx driver binding
In-Reply-To: <20120523130928.GC1015@arwen.pp.htv.fi>
References: <1337592237-5090-6-git-send-email-richard.zhao@freescale.com>
 <201205220630.57007.marex@denx.de>
 <20120522045120.GL6206@b20223-02.ap.freescale.net>
 <87fwasbkt7.fsf@ashishki-desk.ger.corp.intel.com>
 <20120522100624.GP30559@arwen.pp.htv.fi>
 <20120522103139.GD32035@b20223-02.ap.freescale.net>
 <20120522103516.GR30559@arwen.pp.htv.fi>
 <8762bobiqt.fsf@ashishki-desk.ger.corp.intel.com>
 <20120522150616.GA2380@richard-laptop>
 <87wr439hk2.fsf@ashishki-desk.ger.corp.intel.com>
 <20120523130928.GC1015@arwen.pp.htv.fi>
Message-ID: <87sjer9h15.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> On Wed, May 23, 2012 at 04:02:21PM +0300, Alexander Shishkin wrote:
>> Richard Zhao <linuxzsc@gmail.com> writes:
>> 
>> > On Tue, May 22, 2012 at 01:41:30PM +0300, Alexander Shishkin wrote:
>> >> Felipe Balbi <balbi@ti.com> writes:
>> >> 
>> >> > On Tue, May 22, 2012 at 06:31:40PM +0800, Richard Zhao wrote:
>> >> >> On Tue, May 22, 2012 at 01:06:26PM +0300, Felipe Balbi wrote:
>> >> >> > Hi,
>> >> >> > 
>> >> >> > On Tue, May 22, 2012 at 12:56:52PM +0300, Alexander Shishkin wrote:
>> >> >> > > > Do you think it's a good idea to let user select binding driver directly
>> >> >> > > > and the binding driver config depends on chipidea config?
>> >> >> > > 
>> >> >> > > I don't have a strong opinion on this, although I prefer it the way it
>> >> >> > > is now, because, imo:
>> >> >> > > 
>> >> >> > >   * in case of =m (and that's the only sane way of compiling it anyway),
>> >> >> > >     these all are compiled as modules, which you simply don't install if
>> >> >> > >     you don't want them;
>> >> >> > >   * all of them get compile-tested every time you change something in
>> >> >> > >     the driver, which is a good thing;
>> >> >> > 
>> >> >> > only true for $(ARCH) builds. I would like to see these drivers being
>> >> >> > compile tested on linux-next on all arches. Thus the patches I just
>> >> >> > sent.
>> >> >> The idea is great. But
>> >> >> - how can I make sure it pass for all arch? There' 27 folder in arch/.
>> >> >> - it's hard to predict one driver depends on what.
>> >> >> - for embedded kernel, people like built-in drivers, and people will
>> >> >>   have things they don't need at all.
>> >> >
>> >> > that's true to some extent, but until we know for sure that all of that
>> >> > is compiling fine and all dependencies are properly handled, I wouldn't
>> >> > like to see Kconfig or Makefile being abused. That has happened before
>> >> > and will happen again if we allow it.
>> >> >
>> >> > My suggestion to Alex is to remove all dependencies for at least a
>> >> > couple of merge windows and only add dependencies for stuff which
>> >> > actually matters; like only building the PCI glue layer when CONFIG_PCI
>> >> > is defined instead of when ARCH_X86 is defined and so on.
>> >> 
>> >> That's what I mean to do as well. I wouldn't dream of making something
>> >> like this x86 specific. :)
>> > Alex, Have you made the decision that remove all dependencies and leave
>> > only ones that has to be there? If yes, I'll try the way, though I don't
>> > feel good about that.
>> 
>> Yes, I like Felipe's suggestion. Currently (with Felipe's patches from
>> yesterday), there is only one dependency (PCI for ci13xxx_pci, which is
>> ok). So let's try to keep it that way.
>> 
>> I'll push the patches to my tree on github [1] soon, which I propose to
>> use for all chipidea-related patches.
>> 
>> [1] git://github.com/virtuoso/linux-ci.git
>
> you should add it to MAINTAINERS file.
>
> T: git git://github.com/virtuoso/linux-ci.git

Sure.

Regrards,
--
Alex
