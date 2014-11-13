From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 14 Nov 2014 00:45:09 +0100
Subject: [PATCH] clk: rockchip: ensure HCLK_VIO2_H2P and PCLK_VIO2_H2P
 stay enabled
In-Reply-To: <20141112213845.GA14153@dtor-ws>
References: <20141112213845.GA14153@dtor-ws>
Message-ID: <1483690.PjlKQiaGsb@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 12. November 2014, 13:38:45 schrieb Dmitry Torokhov:
> Currently there is no driver owning these clocks and they have to stay
> up for the system to function properly, so let's mark them as
> CLK_IGNORE_UNUSED.
> 
> Without this patch we have trouble with suspend/resume and we have
> trouble turning the eDP back on if it ever idles off.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

I've added this patch to my v3.19-clk/next branch.

After talking with Doug we agreed on replacing his Signed-Off with the Reviewed 
and Tested tags, because his prior involvement was "mostly because I tweaked 
the commit message and tested this" - making the new tags fit better.
