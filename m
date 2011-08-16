From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Aug 2011 15:09:16 +0200
Subject: [RFC PATCH v2 00/13] arm/tegra: Initialize GPIO & pinmux from DT
In-Reply-To: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
Message-ID: <201108161509.17157.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 August 2011, Stephen Warren wrote:
> v2:
> * Enhanced pinmux code to handle "drive pingroups" as well as "mux
>   pingroups". This altered the pinmux binding a little; shifting each
>   type of pingroup into a sub-node in the pinmux node.
> * Enumerate pingroups by enumerating DT child nodes, and mapping them to
>   pingroups, rather than the other way around. Hence also removed
>   modifications to <linux/of.h> and drivers/of/base.c.
> * Included documentation of the bindings.
> * Represent pingroup names and function names, as lower case in DT.
> * Used a better name for GPIO binding GPIO list.
> * Switched to boolean properties for pinmux pull-up/down.
> * s/dev_err/dev_dbg/ in DT parsing debug code.
> * Various minor cleanups (e.g. typos, white-space).
> 
> This patch modifies Tegra's device tree support to remove the dependency
> on harmony_pinmux_init(), thus making it completely board-independent.

I don't understand enough of the technical background to comment on
the contents, on the surface it all makes sense.

I do think that you should keep Linus Walleij on Cc in these emails, since
he first started pushing for a common pinmux layer, and we need to make
sure that the binding works for all SoCs, not just for tegra.

	Arnd
