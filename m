From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 15:20:49 +0200
Subject: [RFC] dw_apb_timer_of: use clocksource_of_init
In-Reply-To: <201306031415.29411.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de> <1822564.TIKVDZSzqK@wuerfel>
 <201306031415.29411.heiko@sntech.de>
Message-ID: <2776800.oNsvP2SGCJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013 14:15:28 Heiko St?bner wrote:
> dw_apb_timer_init used to search the devicetree for matching timer
> devices, making calls to it from board files necessary.
> 
> Change the dw_apb_timer_init to work with CLOCKSOURCE_OF_DECLARE.
> With this change the function gets called once for each timer node
> and tracks these number of calls to attach clockevent and clocksource
> devices to the nodes.
> 
> Also convert all previous users of dw_apb_timer_init to use
> clocksource_of_init.
> 
> Tested on the upcoming rk3066 code.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
