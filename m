From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 26 Aug 2013 16:46:05 -0400
Subject: [PATCH v4 3/3] pinctrl: mvebu: Convert to use
 devm_ioremap_resource
In-Reply-To: <1377517018-7716-4-git-send-email-jszhang@marvell.com>
References: <1377517018-7716-1-git-send-email-jszhang@marvell.com>
 <1377517018-7716-4-git-send-email-jszhang@marvell.com>
Message-ID: <20130826204605.GE24470@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 07:36:58PM +0800, Jisheng Zhang wrote:
> The resource mapped by of_iomap() isn't unmapped in error path. This
> patch fix the resource leakage by using devm_ioremap_resource() instead
> of of_iomap().
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Reviewed-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
