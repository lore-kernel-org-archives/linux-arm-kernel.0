From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 27 Dec 2014 19:29:23 +0100
Subject: [PATCH] pinctrl: rockchip: Avoid losing interrupts when
 supporting both edges
In-Reply-To: <1419274049-5069-1-git-send-email-dianders@chromium.org>
References: <1419274049-5069-1-git-send-email-dianders@chromium.org>
Message-ID: <6699676.mHhQhT5KAT@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 22. Dezember 2014, 10:47:29 schrieb Doug Anderson:
> I was seeing cases where I was losing interrupts when inserting and
> removing SD cards.  Sometimes the card would get "stuck" in the
> inserted state.
> 
> I believe that the problem was related to the code to handle the case
> where we needed both rising and falling edges.  This code would
> disable the interrupt as the polarity was switched.  If an interrupt
> came at the wrong time it could be lost.
> 
> We'll match what the gpio-dwapb.c driver does upstream and change the
> interrupt polarity without disabling things.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
on a rk3188 board with the edge triggered power-button
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko
