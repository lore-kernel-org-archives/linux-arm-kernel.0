From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Jul 2018 15:13:00 +0200
Subject: [PATCH v3 5/8] mailbox: tegra-hsp: Add support for shared
 mailboxes
In-Reply-To: <20180702114033.15654-6-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-6-mperttunen@nvidia.com>
Message-ID: <20180702131300.GG13096@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 02:40:30PM +0300, Mikko Perttunen wrote:
> The Tegra HSP block supports 'shared mailboxes' that are simple 32-bit
> registers consisting of a FULL bit in MSB position and 31 bits of data.
> The hardware can be configured to trigger interrupts when a mailbox
> is empty or full. Add support for these shared mailboxes to the HSP
> driver.
> 
> The initial use for the mailboxes is the Tegra Combined UART. For this
> purpose, we use interrupts to receive data, and spinning to wait for
> the transmit mailbox to be emptied to minimize unnecessary overhead.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> Notes:
>     v3:
>     - Added define HSP_INT0_IE_FULL_SHIFT
>     - Added Jon's Reviewed-by
>     
>     v2:
>     - Added defines for some register fields
>     - Simplified bit looping logic in interrupt handler
>     - Changed write done polling to use readl_poll_timeout
>     - Removed unnecessary zero assignments
>     - Fixed two error cases in probe to do proper cleanup
> 
>  drivers/mailbox/tegra-hsp.c | 211 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 191 insertions(+), 20 deletions(-)

Looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/58638bcb/attachment.sig>
