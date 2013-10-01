From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 12:44:09 -0400
Subject: [PATCH v2] bus: mvebu-mbus: Fix optional pcie-mem/io-aperture
 properties
In-Reply-To: <20130917201104.GA5209@obsidianresearch.com>
References: <20130917201104.GA5209@obsidianresearch.com>
Message-ID: <20131001164409.GC31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 02:11:04PM -0600, Jason Gunthorpe wrote:
> If the property was not specified then then the returned resource
> had a resource_size(..) == 1, rather than 0. The PCI-E driver checks
> for 0 so it blindly continues on with a corrupted resource.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/bus/mvebu-mbus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to mvebu/drivers since you didn't mention a specific regression.
If there is one, please let me know shortly and I'll try to queue it up
for v3.12 instead.

thx,

Jason.
