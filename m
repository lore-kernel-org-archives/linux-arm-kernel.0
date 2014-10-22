From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 Oct 2014 15:51:58 +0200
Subject: [PATCH 2/4] watchdog: orion: Use the reference clock on Armada
 375 SoC
In-Reply-To: <1413984884-20273-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413984884-20273-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141022155158.47f3b637@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 22 Oct 2014 10:34:42 -0300, Ezequiel Garcia wrote:
> The 25 MHz reference clock has better stability so its use is preferred over the
> core clock. Changes the Armada 375 clock initialization to use this reference
> clock. To ensure the driver is compatible with an old devicetree, also provide
> a fallback path which will silently return to the previous behavior.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/watchdog/orion_wdt.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)

The Armada 375 case should be similar to the Armada XP case, so can't
we use the existing armadaxp_wdt_clock_init() function ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
