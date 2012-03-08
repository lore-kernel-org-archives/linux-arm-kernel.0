From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 8 Mar 2012 16:43:59 +0100
Subject: [PATCH 00/11] ARM: tegra: Add PCIe device tree support
In-Reply-To: <4F58CE9D.3070605@gmail.com>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <4F58CE9D.3070605@gmail.com>
Message-ID: <20120308154359.GA544@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring wrote:
> There is a whole bunch of PCI DT code sitting in the powerpc tree that
> probably needs to be moved to common location and used here.
> 
> This looks way too simple to be what's needed if I compare to PCI
> bindings in powerpc dts files.

My particular setup may be much simpler than the average PowerPC machine. The
patchset is only what I need to get PCIe running on the platform, which has
an FPGA connected to the Tegra via PCIe. For instance there is no legacy
interrupt support (only MSI), so interrupt remapping is not required. I also
know that OF nodes are not properly hooked up with the PCI devices yet, which
I will need, among other things, to provide platform data for an SPI flash
connected to an SPI master implemented within the FPGA. I also haven't looked
at specifying the memory ranges via the device tree.

So quite a lot may still be missing, but does that prevent any of this from
being added to mainline? Things can be added on an as-needed basis, can't
they?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/5c285597/attachment.sig>
