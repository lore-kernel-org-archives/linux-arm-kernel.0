From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Jun 2015 12:12:40 +0200
Subject: [PATCHv2 5/5] dmaengine: mv_xor: de-duplicate mv_chan_set_mode*()
In-Reply-To: <1434557086-9520-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434557086-9520-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1434557086-9520-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150619101240.GA11732@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 06:04:46PM +0200, Thomas Petazzoni wrote:
> When commit 6f166312c6ea2 ("dmaengine: mv_xor: add support for a38x
> command in descriptor mode") added support for the descriptor mode
> available in Marvell Armada 38x and later SoCs, it added a new
> function mv_chan_set_mode_to_desc() which allows to configure a XOR
> channel to get the specific operation to be done from each individual
> DMA descriptor.
> 
> However, this function was mainly a duplicate of the existing
> mv_chan_set_mode(), with just the operation being different.
> 
> This commit re-organizes the code into a single mv_chan_set_mode()
> function, which takes the operation mode as argument, and the
> mv_xor_channel_add() function decides whether to use
> XOR_OPERATION_MODE_IN_DESC or XOR_OPERATION_MODE_XOR.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150619/f21a6895/attachment.sig>
