From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 09:34:19 -0600
Subject: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
In-Reply-To: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <51E4167B.4000208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 05:52 AM, Thomas Petazzoni wrote:
> Hello,
> 
> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform with an Intel e1000e PCIe network card that
> supports MSI.
> 
> This patch set is intended for merging in 3.12, so the respective
> maintainers of the different areas are invited to review/ack the
> patches, see below for the details. This set of patches applies on top
> of 3.11-rc1.

Thomas, who is going to merge this series?

I believe at least patches 1-8 (or perhaps just 1-5 plus 8; I /think/
all the other patches are MVEBU-specific) are dependencies for the new
Tegra PCIe driver which should be posted very soon for 3.12. As such,
I'd like to see these dependencies merged into a standalone stable (100%
non-rebasable) topic branch based on 3.11-rc1 so that the topic branch
is available for merging into whichever tree takes the new Tegra PCIe
driver (which I'm guessing will be the Tegra tree to reduce conflicts).
So, whoever merges these patches is going to need to know to set up that
topic branch.

Thierry, please correct me if I'm wrong here.
