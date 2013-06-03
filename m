From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Jun 2013 18:11:48 -0400
Subject: [PATCH] clocksource: armada-xp: always register local_timer_ops
In-Reply-To: <3039627.dHjlxm4JCV@wuerfel>
References: <3039627.dHjlxm4JCV@wuerfel>
Message-ID: <20130603221148.GT3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 12:03:38AM +0200, Arnd Bergmann wrote:
> The call to local_timer_register is hidden behind an #ifdef, which
> turns the armada_370_xp_local_timer_ops into a potentially unused
> variable, causing this warning:
> 
> time-armada-370-xp.c:208:31: warning: 'armada_370_xp_local_timer_ops' defined but not used [-Wunused-variable]
>  static struct local_timer_ops armada_370_xp_local_timer_ops __cpuinitdata = {
>                                ^
> 
> Since local_timer_register() itself doesn't do anything, just removing
> the #ifdef makes the code look nicer and gets rid of the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> ---
> 
> Please apply for 3.11

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
