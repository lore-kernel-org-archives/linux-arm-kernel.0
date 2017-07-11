From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 11 Jul 2017 16:16:23 -0400
Subject: [PATCH V3 1/2] PCI: Add Extended Tags quirk for Broadcom HT2100
 Root Port
In-Reply-To: <20170711195853.GA14614@bhelgaas-glaptop.roam.corp.google.com>
References: <1499786735-25782-1-git-send-email-okaya@codeaurora.org>
 <20170711195853.GA14614@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <ae4dca5b-30cf-3a14-1707-380a3660badf@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/11/2017 3:58 PM, Bjorn Helgaas wrote:
> I'm trying to avoid pci_walk_bus() because it's such a minefield as
> far as hot-added devices.  I don't think we can avoid one in the
> quirk, to turn off extended tags for any devices we've already found,
> but I think we *can* avoid adding more i

Jike Song asked what if you attach a PCIe endpoint that has an extended
tags quirk to think about the reverse direction. That's why, I was walking
the entire bus. 

We can maybe hold onto putting such a generic code until such a device
with quirk actually shows up.

I'll pull your suggestion into a patch, give it a try and then post the
next version.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
