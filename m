From: haegar@sdinet.de (Sven-Haegar Koch)
Date: Tue, 13 Jun 2017 21:13:32 +0200 (CEST)
Subject: [Merge tag 'pci-v4.12-changes' of git] 857f864014: BUG: unable
 to handle kernel NULL pointer dereference at 00000000000000a8
In-Reply-To: <20170613163508.GA31961@kroah.com>
References: <5933fe2d.V33ODGPU9noDVuyF%fengguang.wu@intel.com>
 <20170606175552.GA12672@bhelgaas-glaptop.roam.corp.google.com>
 <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
 <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
 <20170613041842.GA13308@kroah.com>
 <f6322f70-7ca7-abf6-b947-4cbbfd598948@deltatee.com>
 <20170613043416.GB14217@kroah.com> <20170613043518.GA14621@kroah.com>
 <8462abee-0a7f-00fb-6111-1f78362ea3f7@deltatee.com>
 <20170613163508.GA31961@kroah.com>
Message-ID: <alpine.DEB.2.20.1706132106410.11042@aurora.sdinet.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jun 2017, Greg Kroah-Hartman wrote:

> On Tue, Jun 13, 2017 at 10:25:40AM -0600, Logan Gunthorpe wrote:
> > 
> > On 12/06/17 10:35 PM, Greg Kroah-Hartman wrote:
> > > Or better yet, just turn all char major allocations into dynamic, which
> > > would be really good for test systems.  I thought someone proposed
> > > patches for that a long time ago, but I can't find them anymore.  That
> > > would be the simplest solution here.
> > 
> > Would people not complain about that? I would not be surprised if some
> > crazy application is using hard coded major numbers in userspace. So
> > such a change could potentially break userspace...
> 
> For char devices, I doubt it, but we can't take the chance, which is why
> you make it an option.  Then, it's enabled for 'allmodconfig' builds,
> which helps testers out.

At least for /dev/null, /dev/zero, and perhaps /dev/tty it would 
definitely break things if the major+minor number is not static. I have 
multiple chroot environments having only some minimal needed static 
/dev subdir, with naturally no daemons or filesystem creating those 
on-demand. For the main /dev I use whatever the system sets up, so 
devtmpfs with udev.

c'ya
sven-haegar

-- 
Three may keep a secret, if two of them are dead.
- Ben F.
