From: sebastian.reichel@collabora.com (Sebastian Reichel)
Date: Sun, 16 Sep 2018 12:43:01 +0200
Subject: [PATCH 0/6] shutdown procedure verification for SAMA5D2
In-Reply-To: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20180916104301.dcrm333ydo5kh5bj@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 30, 2018 at 02:50:05PM +0300, Claudiu Beznea wrote:
> Hi,
> 
> Patch 1 from this series implement a fix for shutdown procedure
> for SAMA5D2.
> 
> The rest of the patch are improvements as follows:
> patch 2 - use only one function for poweroff
> patches 3-6 - cosmetic improvements
> 
> The patches are based on latest sys-reset/for-next [1].
> 
> Thank you,
> Claudiu Beznea
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git

Thanks, queued.

-- Sebastian

> 
> Claudiu Beznea (6):
>   power: reset: at91-poweroff: switch to slow clock before shutdown
>   power: reset: at91-poweroff: use only one poweroff function
>   power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
>   power: reset: at91-poweroff: make sclk part of struct shdwc
>   power: reset: at91-poweroff: rename at91_shdwc_base member of struct
>     shdwc
>   power: reset: at91-poweroff: do not procede if at91_shdwc is allocated
> 
>  arch/arm/mach-at91/pm_suspend.S          |   8 +++
>  drivers/power/reset/at91-sama5d2_shdwc.c | 119 +++++++++++++++++++++----------
>  2 files changed, 88 insertions(+), 39 deletions(-)
> 
> -- 
> 2.7.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180916/39626260/attachment.sig>
