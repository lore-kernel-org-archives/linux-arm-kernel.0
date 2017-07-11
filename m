From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 11 Jul 2017 15:39:57 -0500
Subject: [PATCH V3 1/2] PCI: Add Extended Tags quirk for Broadcom HT2100
 Root Port
In-Reply-To: <ae4dca5b-30cf-3a14-1707-380a3660badf@codeaurora.org>
References: <1499786735-25782-1-git-send-email-okaya@codeaurora.org>
 <20170711195853.GA14614@bhelgaas-glaptop.roam.corp.google.com>
 <ae4dca5b-30cf-3a14-1707-380a3660badf@codeaurora.org>
Message-ID: <20170711203957.GB14614@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 04:16:23PM -0400, Sinan Kaya wrote:
> On 7/11/2017 3:58 PM, Bjorn Helgaas wrote:
> > I'm trying to avoid pci_walk_bus() because it's such a minefield as
> > far as hot-added devices.  I don't think we can avoid one in the
> > quirk, to turn off extended tags for any devices we've already found,
> > but I think we *can* avoid adding more i
> 
> Jike Song asked what if you attach a PCIe endpoint that has an extended
> tags quirk to think about the reverse direction. That's why, I was walking
> the entire bus. 

My proposal handles endpoints, too.  The pci_walk_bus() in the quirk
handles all devices we've already enumerated, and all devices we'll
enumerate in the future are handled in pci_configure_device().

> We can maybe hold onto putting such a generic code until such a device
> with quirk actually shows up.
> 
> I'll pull your suggestion into a patch, give it a try and then post the
> next version.
> 
> -- 
> Sinan Kaya
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
