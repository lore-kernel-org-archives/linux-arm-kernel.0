From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 20 Jul 2015 18:42:42 +0200
Subject: [PATCH v2 1/2] power: reset: at91: add sama5d3 reset function
In-Reply-To: <1437384726-24927-1-git-send-email-josh.wu@atmel.com>
References: <1437384726-24927-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20150720164241.GA5930@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 20, 2015 at 05:32:05PM +0800, Josh Wu wrote:
> This patch introduces a new compatible string: "atmel,sama5d3-rstc" and
> new reset function for sama5d3 and later chips.
> 
> As in sama5d3 or later chips, we don't have to shutdown the DDR
> controller before reset. Shutdown the DDR controller before reset is a
> workaround to avoid DDR signal driving the bus, but since sama5d3 and
> later chips there is no such a conflict.
> 
> So in this patch:
>    1. the sama5d3 reset function only need to write the rstc register
> and return.
>    2. we can remove the code related with sama5d3 DDR controller as
> we don't use it at all.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/f587183e/attachment.sig>
