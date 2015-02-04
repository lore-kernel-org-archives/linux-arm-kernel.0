From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Feb 2015 10:13:17 +0100
Subject: [PATCH v2 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <1422284164-16867-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1422284164-16867-1-git-send-email-maxime.ripard@free-electrons.com>
 <1422284164-16867-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150204091317.GA5492@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Mon, Jan 26, 2015 at 03:56:03PM +0100, Maxime Ripard wrote:
> The NDDB register holds the data that are needed by the read and write
> commands.
> 
> However, during a read PIO access, the datasheet specifies that after each 32
> bits read in that register, when BCH is enabled, we have to make sure that the
> RDDREQ bit is set in the NDSR register.
> 
> This fixes an issue that was seen on the Armada 385, and presumably other mvebu
> SoCs, when a read on a newly erased page would end up in the driver reporting a
> timeout from the NAND.
> 
> Cc: <stable@vger.kernel.org> # v3.14
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Any chance for this fix to come in 3.19?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150204/4b55a865/attachment.sig>
