From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 13 May 2014 14:03:28 +0530
Subject: [PATCH 0/4] ARM/DT: edma: Get IP configuration from hardware
In-Reply-To: <1399967028-24757-1-git-send-email-peter.ujfalusi@ti.com>
References: <1399967028-24757-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <5371D8D8.8000003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 May 2014 01:13 PM, Peter Ujfalusi wrote:
> Hi,
> 
> We are requesting redundant information via DT for the driver since the very same
> data is available in the HW: by reading and decoding the content of CCCFG
> register we can get:
> Number of channels: NUM_DMACH
> Number of regions: NUM_REGN
> Number of slots (PaRAM sets): NUM_PAENTRY
> Number of TC/EQ: NUM_EVQUE
> 
> So these does not need to be provided by the DT binding.
> 
> The driver will no longer look for these properties from DT and they can be
> removed from the binding documentation and from the dtsi files as well.
> The change will not introduce regression when new kernel is booted using older
> DTB (since we just ignore the mentioned properties).

Peter, to which baseline do these patches apply? I tried applying them
to v3.15-rc5 but 1/4 doesn't apply cleanly.

Thanks,
Sekhar
