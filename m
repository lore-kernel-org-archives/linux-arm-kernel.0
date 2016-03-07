From: eric@anholt.net (Eric Anholt)
Date: Mon, 07 Mar 2016 15:27:47 -0800
Subject: [PATCH] clk: bcm2835: fix check of error code returned by
 devm_ioremap_resource()
In-Reply-To: <1457227295-3093-1-git-send-email-vz@mleia.com>
References: <1457227295-3093-1-git-send-email-vz@mleia.com>
Message-ID: <87d1r5yiks.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir Zapolskiy <vz@mleia.com> writes:

> The change fixes potential oops while accessing iomem on invalid
> address, if devm_ioremap_resource() fails due to some reason.
>
> The devm_ioremap_resource() function returns ERR_PTR() and never
> returns NULL, which makes useless a following check for NULL.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Fixes: 5e63dcc74b30 ("clk: bcm2835: Add a driver for the auxiliary peripheral clock gates")

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160307/8e3b3375/attachment.sig>
