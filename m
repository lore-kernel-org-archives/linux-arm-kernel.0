From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 May 2017 10:44:05 +0200
Subject: [PATCH] reset: hisilicon: Fix hi6220 module license
In-Reply-To: <20170525092232.27960-1-afaerber@suse.de>
References: <20170525092232.27960-1-afaerber@suse.de>
Message-ID: <CAK8P3a2qLxBNG61BX3g02cEXMg7LVA5ghxbW78n81c0+3ZKkXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 11:22 AM, Andreas F?rber <afaerber@suse.de> wrote:
> The hi6220_reset driver fails to load:
>
>   [   10.423640] hi6220_reset: module license 'unspecified' taints kernel.
>   [   10.423644] Disabling lock debugging due to kernel taint
>   [   10.423735] hi6220_reset: Unknown symbol regmap_write (err 0)
>   [   10.423747] hi6220_reset: Unknown symbol devm_kmalloc (err 0)
>   [   10.423759] hi6220_reset: Unknown symbol syscon_node_to_regmap (err 0)
>   [   10.423768] hi6220_reset: Unknown symbol reset_controller_register (err 0)
>   [   10.423784] hi6220_reset: Unknown symbol __platform_driver_register (err 0)
>
> Add a MODULE_LICENSE() to fix this.
>
> Fixes: 70b3590f639f ("reset: hi6220: fix modular build")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I wonder why I never ran into this in randconfig testing.
