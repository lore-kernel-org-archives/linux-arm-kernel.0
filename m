From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 6 Dec 2016 14:18:35 -0600
Subject: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
In-Reply-To: <aac9391d-8803-f5e8-f4e4-d7e56d54c05c@redhat.com>
References: <1480620053.4751.30.camel@redhat.com>
 <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
 <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLND=Ss8d-jv7wffbrtytrjj=SUnjDn9bognKUszhKguRV1A@mail.gmail.com>
 <d77e403c-81e9-114e-6ec6-bbffaa4ac36f@redhat.com>
 <20161202233943.GF9903@bhelgaas-glaptop.roam.corp.google.com>
 <62dd5462-4d68-b89f-2b45-0d58bbd96bcd@redhat.com>
 <20161205212140.GA18259@bhelgaas-glaptop.roam.corp.google.com>
 <aac9391d-8803-f5e8-f4e4-d7e56d54c05c@redhat.com>
Message-ID: <20161206201835.GA19700@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 02:46:00PM -0500, Jon Masters wrote:
> On 12/05/2016 04:21 PM, Bjorn Helgaas wrote:
> > On Fri, Dec 02, 2016 at 07:33:46PM -0500, Jon Masters wrote:
> 
> >>> Even without this patch, I don't think it's a show-stopper to have
> >>> Linux mistakenly thinking this region is routed to PCI, because the
> >>> driver does reserve it and the PCI core will never try to use it.
> >>
> >> Ok. So are you happy with pulling in Duc's v4 patch and retaining
> >> status quo on the bridge resources for 4.10?
> > 
> > Yes, I think it looks good.  I'll finish packaging things up and
> > repost the current series.
> 
> Ok, great. So you're still pretty confident we'll have "out of the box"
> booting on these machines for 4.10? :)

I just merged pci/ecam into my "next" branch, so as long as tomorrow's
linux-next boots out of the box, we should be set.  I made the following
changes compared to v11:

  - dropped the x86 change to use acpi_resource_consumer()
  - added parens around macro args used in arithmetic expressions
  - renamed "seg" to "node" in THUNDER_PEM_RES and THUNDER_PEM_QUIRK
  - incorporated (u64) cast and dropped "UL" postfix for THUNDER_PEM_QUIRK

Let me know if you see any issues.

Bjorn
