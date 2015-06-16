From: joshc@ni.com (Josh Cartwright)
Date: Tue, 16 Jun 2015 13:45:22 -0500
Subject: [PATCHv4 1/2] dts: Adding docs for Xilinx LogiCORE IP mailbox
 driver.
In-Reply-To: <1433175507-3833-2-git-send-email-moritz.fischer@ettus.com>
References: <1433175507-3833-1-git-send-email-moritz.fischer@ettus.com>
 <1433175507-3833-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <20150616184522.GU633@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 09:18:26AM -0700, Moritz Fischer wrote:
> Changes from v3:
> - Changed reg size to 0x100
> 
> Changes from v2:
> - Addressed Michal's stylistic comments
> - Fixed typo in compatible string
> 
> Changes from v1:
> - Added common clock framework support
> 
> Changes from v0:
> - Fixed example bindings
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  .../bindings/mailbox/xilinx-mailbox.txt         | 44 ++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> new file mode 100644
> index 0000000..f9ec46d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> @@ -0,0 +1,44 @@
> +Xilinx Mailbox Driver
> +=====================
> +
> +Required properties:
> +- compatible       : "xlnx,mailbox-2.1".
> +- reg              :  physical base address of the mailbox and length of
> +                      memory mapped region.
> +- #mbox-cells      :  common mailbox binding property to identify the number
> +                      of cells required for the mailbox specifier, should be 1

It seems strange to me to require #mbox-cells = <1>, when this hardware
only supports a single channel.  Why not #mbox-cells = <0>; ?

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150616/c4ba30ba/attachment.sig>
