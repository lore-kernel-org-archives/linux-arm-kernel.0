From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Oct 2013 12:54:35 -0400
Subject: [PATCH RESEND] PCI: mvebu: Dynamically detect if the PEX link
 is up to enable hot plug
In-Reply-To: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20131008165435.GO5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 11:58:00AM -0600, Jason Gunthorpe wrote:
> Otherwise hotplugging the PEX doesn't work at all since the driver
> detects the link state at probe time. Simply replacing the two tests
> of haslink with a register read is enough to fix it.
> 
> Tested on kirkwood with repeated plug/unplug of the link partner.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

Applied to mvebu/drivers with Thomas' Ack and Tested-by.

thx,

Jason.
