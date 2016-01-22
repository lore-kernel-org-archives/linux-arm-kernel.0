From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 22 Jan 2016 13:38:59 -0500
Subject: [PATCH V12 3/7] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <20160115152257.GK3262@leverpostej>
References: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
 <1452523550-8920-4-git-send-email-okaya@codeaurora.org>
 <20160115145629.GI3262@leverpostej> <56990C40.4050407@codeaurora.org>
 <20160115152257.GK3262@leverpostej>
Message-ID: <56A27743.40008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/15/2016 10:22 AM, Mark Rutland wrote:
> Typically VFIO-platform also comes with a corresponding reset driver.
> You don't need one?

Digging this further, I do need a HIDMA reset driver. The reset driver is useful if HIDMA 
operation is aborted in the middle and guest machine is shutdown. 

I'm preparing a reset driver and I'll post it soon. 

In the meantime, I have observed a lack of ACPI HID support in the platform reset interface
vfio_platform_lookup_reset and vfio_platform_probe_common specifically.

The interface is querying objects with "compatible" string. Of course on a true ACPI system
with proper named HIDs except PRP001, "compatible" attribute does not exist. I'm also preparing a
patch for this too.

Since VFIO patches go through another branch and the reset driver also needs to go through vfio along 
with the ACPI object querying support, would you like this to be addressed independently with a different series 
or have it reviewed altogether here then figure out the merge path later?

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
