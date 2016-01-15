From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 15 Jan 2016 17:56:26 +0100
Subject: [4.4-rt2 PATCH] ARM: highmem: take into account FIX_KMAP_BEGIN
 in switch_kmaps()
In-Reply-To: <1452867647-1410-1-git-send-email-grygorii.strashko@ti.com>
References: <1452867647-1410-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20160115165626.GE3781@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko | 2016-01-15 16:20:47 [+0200]:

>Now the random crashes are observed on ARM TI am437x-idk-evm used with
>-RT Kernel v4.4-rt2 and with Highmem enabled.
>
>The reason of issue is that, newly introduced switch_kmaps() does not
>take into account FIX_KMAP_BEGIN, which was re-added by
>commit a5f4c561b3b1 ("ARM: 8415/1: early fixmap support for earlycon")
>(K4.3) for ARM and since that the value of FIX_KMAP_BEGIN
>is not 0 any more.
>
>Hence update switch_kmaps() so it will take into FIX_KMAP_BEGIN while
>calculating fixmap idx. This patch also introduces fixmap_idx() to
>make code simpler and remove duplicated code.

Thank you debugging and fixing this. I will fold this into the initial
patch since it is a v4.1..v4.4 fallout. Regarding your "nobody else be
me" question in the other mail: once I managed something ARM+highmem I
I see this:

|Welcome to Debian GNU/Linux stretch/sid!
|
|[   11.738637] systemd[1]: Set hostname to <vexpress>.
|[   11.909949] ------------[ cut here ]------------
|[   11.909958] kernel BUG at arch/arm/mm/highmem.c:90!

So I did not get as far as a shell to start anything.

>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Sebastian
