From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 16 Jun 2016 12:00:56 +0200
Subject: [PATCH] ARM: Kirkwood: make
 kirkwood_disable_mbus_error_propagation() static
In-Reply-To: <1465473145-20826-1-git-send-email-ben.dooks@codethink.co.uk>
 (Ben Dooks's message of "Thu, 9 Jun 2016 12:52:25 +0100")
References: <1465473145-20826-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <87ziqla1wn.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,
 
 On jeu., juin 09 2016, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The kirkwood_disable_mbus_error_propagation is not exported or declared
> elsewhere, so make it static to avoid the following warning:
>
> arch/arm/mach-mvebu/kirkwood.c:153:6: warning: symbol 'kirkwood_disable_mbus_error_propagation' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied on mvebu/cleanup

Thanks,

Gregory

> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-mvebu/kirkwood.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
> index f9d8e1e..a3f4029 100644
> --- a/arch/arm/mach-mvebu/kirkwood.c
> +++ b/arch/arm/mach-mvebu/kirkwood.c
> @@ -150,7 +150,7 @@ eth_fixup_skip:
>   * causes mbus errors (which can occur for example for PCI aborts) to
>   * throw CPU aborts, which we're not set up to deal with.
>   */
> -void kirkwood_disable_mbus_error_propagation(void)
> +static void kirkwood_disable_mbus_error_propagation(void)
>  {
>  	void __iomem *cpu_config;
>  
> -- 
> 2.8.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
