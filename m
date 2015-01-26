From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 26 Jan 2015 20:01:07 +0100
Subject: [PATCH v2] ARM: at91: at91rm9200: set idle and restart from
 rm9200_dt_device_init()
In-Reply-To: <1422295713-26549-1-git-send-email-nicolas.ferre@atmel.com>
References: <1421359100-8930-12-git-send-email-alexandre.belloni@free-electrons.com>
 <1422295713-26549-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150126190107.GA11867@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/2015 at 19:08:33 +0100, Nicolas Ferre wrote :
> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Setup arm_pm_idle and arm_pm_restart function pointers from
> rm9200_dt_device_init() function to simplify the at91rm9200 initialization
> process.
> This same move is already done for the sam9s.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> [nicolas.ferre at atmel.com: adapt patch to newer series]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/mach-at91/at91rm9200.c      | 14 --------------
>  arch/arm/mach-at91/board-dt-rm9200.c | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)

I'm pretty sure Arnd wanted us to get rid of the board-dt-* files and
only keep the soc files. Anyway, board-dt doesn't mean anything anymore
since all the boards are dt enabled...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
