From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Mon, 10 Sep 2018 23:49:56 +0200
Subject: [PATCH v2 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for
 MODEM
In-Reply-To: <20180909234419.31261-1-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
 <20180909234419.31261-1-jmkrzyszt@gmail.com>
Message-ID: <2690911.AdkODg5D9b@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 10, 2018 1:44:16 AM CEST Janusz Krzysztofik wrote:
> 
> Convert modem related GPIO setup from integer space to GPIO descriptors.
> Also, restore original initialization order of the MODEM device and its
> related GPIO pins.
> 
> Cleanup of MODEM relaated regulator setup is postponed while waiting for
> upcoming conversion of fixed regulator API to GPIO descriptors.
> 
> 
> Janusz Krzysztofik (3):
>       ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
>       ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
>       ARM: OMAP1: ams-delta: register MODEM device earlier
> 
> 
> Changelog:
> v2:
> - rebased on v4.19-rc1

Hi Tony,

I forgot to mention: please apply on top of "[PATCH v3 0/3] ARM: OMAP1: ams-
delta: Complete driver gpiod migration" series. Sorry.

Thanks,
Janusz

> - added Reviewed-by: obtained from Linus Walleij
> 
> Please ignore the patch "ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO"
> sent alone on 2018-07-17.
> 
> Thanks,
> Janusz
> 
> 
> diffstat:
>  board-ams-delta.c |  121 ++++++++++++++++++++++++++++++++++++++
+---------------
>  board-ams-delta.h |    7 ---
>  2 files changed, 88 insertions(+), 40 deletions(-)
> 
> 
