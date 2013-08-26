From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 26 Aug 2013 10:58:50 -0400
Subject: [PATCH for v3.12] ARM: dove: Declare symbol __init to avoid
 section mismatch
In-Reply-To: <1377293027-443-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377293027-443-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130826145850.GA24470@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 06:23:47PM -0300, Ezequiel Garcia wrote:
> Declare dove_mpp_gpio_mode() symbol as __init, since it's only called
> from __init functions. This removes the following warning:
> 
> vmlinux.o(.text.unlikely+0x894): Section mismatch in reference from the
> function dove_mpp_gpio_mode() to the function .init.text:orion_gpio_set_valid()
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-dove/mpp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

doh!  Sebastian beat you to it.  :)  In mvebu/fixes-non-critical:

  2746a7c ARM: dove: fix missing __init section of dove_mpp_gpio_mode

thx,

Jason.
