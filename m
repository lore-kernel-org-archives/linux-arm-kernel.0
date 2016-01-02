From: pshelar@nicira.com (Pravin Shelar)
Date: Fri, 1 Jan 2016 18:58:10 -0800
Subject: [PATCH] ip_tunnel: make ip6tunnel_xmit definition conditional
In-Reply-To: <12586917.ah4bPMnYUH@wuerfel>
References: <12586917.ah4bPMnYUH@wuerfel>
Message-ID: <CALnjE+ptYadm5btYd3jFvd7h70-FJAh1Bm0nS4fRTa+5w8j+mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 1, 2016 at 5:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> From 433df301cf49624871346fa63f3fc65033caeda3 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 1 Jan 2016 13:18:48 +0100
> Subject: [PATCH] net: make ip6tunnel_xmit definition conditional
>
> Moving the caller of iptunnel_xmit_stats causes a build error in
> randconfig builds that disable CONFIG_INET:
>
> In file included from ../net/xfrm/xfrm_input.c:17:0:
> ../include/net/ip6_tunnel.h: In function 'ip6tunnel_xmit':
> ../include/net/ip6_tunnel.h:93:2: error: implicit declaration of function 'iptunnel_xmit_stats' [-Werror=implicit-function-declaration]
>   iptunnel_xmit_stats(dev, pkt_len);
>
> The reason is that the iptunnel_xmit_stats definition is hidden
> inside #ifdef CONFIG_INET but the caller is not. We can change
> one or the other to fix it, and this patch adds a second #ifdef
> around ip6tunnel_xmit() to avoid seeing the invalid call.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 039f50629b7f ("ip_tunnel: Move stats update to iptunnel_xmit()")

Thanks for the fix.
Acked-by: Pravin B Shelar <pshelar@nicira.com>
