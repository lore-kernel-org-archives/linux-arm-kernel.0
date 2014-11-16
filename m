From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 16 Nov 2014 18:13:52 +0100
Subject: [PATCH] clk: sunxi: gmac-tx-clk mux is not a CLK_MUX_INDEX_BIT mux
In-Reply-To: <1416142617-4094-1-git-send-email-hdegoede@redhat.com>
References: <1416142617-4094-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20141116171352.GO6414@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 01:56:57PM +0100, Hans de Goede wrote:
> A CLK_MUX_INDEX_BIT mux has one bit per parent, but the sun7i-a20-gmac-clk
> has 2 bits selecting between 3 possible parents using values of 0, 1, 2,
> which makes it a regular mux which should not have CLK_MUX_INDEX_BIT set in
> its flag.
> 
> However we do not support parent 1 (an external clock), so use a table to
> select parent 0 or 2, which are the 2 parents we support.
> 
> Note this has not been causing any issues sofar, because we start with a
> parent setting of parent 0, and only ever re-parent to parent 2 (for which
> we use an index of 1 as we skip parent 1) and with CLK_MUX_INDEX_BIT set
> we write a value of 2 for index 1.
> 
> Tested on both a cubietruck (which uses rgmii mode) as well as a cs908
> (an a31s board which uses mii mode).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141116/52e0c7d9/attachment-0001.sig>
