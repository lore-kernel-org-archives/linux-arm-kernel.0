From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 14 Aug 2015 09:46:44 -0500
Subject: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
In-Reply-To: <20150812090449.GA22485@arm.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com>
 <007501d0d4ce$1d2dd9c0$57898d40$@samsung.com>
 <20150812090449.GA22485@arm.com>
Message-ID: <20150814144644.GC26431@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 10:04:50AM +0100, Will Deacon wrote:
> On Wed, Aug 12, 2015 at 08:11:29AM +0100, Pavel Fedin wrote:
> > > I dropped the acks and tested-by because of that change, but I'll happily
> > > add them back if Lorenzo and Pavel confirm.  
> > 
> >  Confirm.
> >  Tested-by: Pavel Fedin <p.fedin@samsung.com>
> > 
> >  I also added MSI support. Can i post it as patch on top of your branch?
> 
> There shouldn't be any need with the changes queued in tip/irq/core. Can
> you give the following branch a go, please (it doesn't look like Bjorn's
> stuff is in linux-next, unfortunately)?

We still have a build issue (undefined reference to pci_write_msi_msg
in imx_v6_v7_defconfig) to resolve before putting it in linux-next.
Hopefully we can resolve that today.
