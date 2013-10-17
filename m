From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Oct 2013 09:10:31 -0400
Subject: [PATCH v2] PCI: mvebu - Support a bridge with no IO port window
In-Reply-To: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20131017131031.GD22434@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 02:16:22PM -0600, Jason Gunthorpe wrote:
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
>  drivers/pci/host/pci-mvebu.c | 64 +++++++++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 21 deletions(-)

Applied to mvebu/drivers

thx,

Jason.
