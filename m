From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Aug 2013 19:31:43 +0100
Subject: [PATCHv5 01/31] CLK: clkdev: add support for looking up clocks
 from DT
In-Reply-To: <1375460751-23676-2-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <1375460751-23676-2-git-send-email-t-kristo@ti.com>
Message-ID: <20130803183143.GE23053@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 07:25:20PM +0300, Tero Kristo wrote:
> +
> +	if (cl)
> +		return cl;
> +
> +	/* If clock was not found, attempt to look-up from DT */
> +	node = of_find_node_by_name(NULL, con_id);

This is utterly broken if you're looking up purely by a connection ID.
Please, go back and read clk_get()'s documentation in linux/clk.h.
It's spelt out very plainly there.

NAK.
