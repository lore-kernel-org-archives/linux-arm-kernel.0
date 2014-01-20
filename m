From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 Jan 2014 15:16:21 -0500
Subject: [PATCH] ARM: mvebu: Fix kernel hang in mvebu_soc_id_init()
 when of_iomap failed
In-Reply-To: <1390229990-26450-1-git-send-email-gregory.clement@free-electrons.com>
References: <1390229990-26450-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140120201621.GX29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 03:59:50PM +0100, Gregory CLEMENT wrote:
> When pci_base is accessed whereas it has not been properly mapped by
> of_iomap() the kernel hang. The check of this pointer made an improper
> use of IS_ERR() instead of comparing to NULL. This patch fix this
> issue.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Jason,
> 
> As this is a fix on a fix which should be ported to the stable branch, I
> don't know how to handle the cc:stable flag

No problem, I added it.

>  arch/arm/mach-mvebu/mvebu-soc-id.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/fixes.

thx,

Jason.
