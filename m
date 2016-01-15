From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 15 Jan 2016 17:38:07 -0600
Subject: [PATCH] arm64, pci, numa: Adding helper functions as required by
 pci
In-Reply-To: <CAFpQJXVVPMvj4AC9G7Gd71O_xFAKfxNkzWh1us4ENP77Do=ceA@mail.gmail.com>
References: <1450780730-13667-1-git-send-email-gkulkarni@caviumnetworks.com>
 <20160108180131.GB5354@localhost> <20160108180638.GF11228@arm.com>
 <CAFpQJXUaVS7tBqjQ4Dh201yrOWFxa3Bk2q-ZCFtK4mk-te=Q7w@mail.gmail.com>
 <20160109152422.GA30802@localhost>
 <CAFpQJXVBafgq864cNeOhccZAdr89EUfXdEdnW7jh1y66ModKAQ@mail.gmail.com>
 <5693E26C.2010501@suse.com>
 <CAFpQJXVVPMvj4AC9G7Gd71O_xFAKfxNkzWh1us4ENP77Do=ceA@mail.gmail.com>
Message-ID: <20160115233807.GD14080@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 10:56:59PM +0530, Ganapatrao Kulkarni wrote:
> Hi Bjorn, Will,
> 
> On Mon, Jan 11, 2016 at 10:42 PM, Matthias Brugger <mbrugger@suse.com> wrote:
> >
> >
> > On 09/01/16 16:35, Ganapatrao Kulkarni wrote:
> >>
> >> Hi Bjorn,
> >>
> >> On Sat, Jan 9, 2016 at 8:54 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>
> >>> On Sat, Jan 09, 2016 at 11:35:17AM +0530, Ganapatrao Kulkarni wrote:
> >>>>
> >>>> On Fri, Jan 8, 2016 at 11:36 PM, Will Deacon <will.deacon@arm.com>
> >>>> wrote:
> >>>>>
> >>>>> On Fri, Jan 08, 2016 at 12:01:31PM -0600, Bjorn Helgaas wrote:
> >>>>>>
> >>>>>> On Tue, Dec 22, 2015 at 04:08:50PM +0530, Ganapatrao Kulkarni wrote:
> >>>>>>>
> >>>>>>> Adding helper functions and necessary code to make
> >>>>>>> pci driver(pci-host-generic) numa aware.
> >>>>>>>
> >>>>>>> This patch is on top of arm64-numa v7.
> >>>>>>> http://www.spinics.net/lists/arm-kernel/msg460813.html
> >>>>>>>
> >>>>>>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> >>>>>>> ---
> >>>>>>>   arch/arm64/include/asm/numa.h       | 8 +++++---
> >>>>>>>   arch/arm64/kernel/pci.c             | 8 ++++++++
> >>>>>>>   drivers/pci/host/pci-host-generic.c | 1 +
> >
> >
> > set_dev_node() in pci-host-generic.c is missing in v8 of your numa patches.
> > Was this forgotten?
> i am not sure on adding numa required change(it is one line add) to
> pci-host-generic.c in numa patchset itself.
> Is it more appropriate to send as separate patch?
> please suggest.

I haven't seen the whole series, so I can't really give a suggestion.
If you want me to see it, please sent to linux-pci at vger.kernel.org or
helgaas at kernel.org.

Bjorn
