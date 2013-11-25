From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 25 Nov 2013 18:10:08 +0100
Subject: [PATCH v3 2/2] PCI: mvebu - Support a bridge with no IO port
 window
In-Reply-To: <1383262380-6984-2-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1383262380-6984-2-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20131125181008.158b5b09@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 31 Oct 2013 17:33:00 -0600, Jason Gunthorpe wrote:
> Make pcie-io-aperture and the IO port MBUS ID in ranges optional.
> If not provided the bridge reports to Linux that IO space mapping is
> not supported and refuses to configure an IO mbus window.
> 
> This allows both complete disable (do not specify pcie-io-aperture) and
> per-port disable (do not specify a IO target ranges entry for the port)
> 
> Most PCIE devices these days do not require IO support to function,
> so having an option to disable it in the driver is useful.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 63 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 20 deletions(-)

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks, and sorry again for the huge time it took me to test this
version of your patches.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
