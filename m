From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Aug 2018 11:25:36 +0200
Subject: [PATCH v4] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
 dmtimer platform data
In-Reply-To: <20180801141729.2840-1-drivshin@awxrd.com>
References: <20180801141729.2840-1-drivshin@awxrd.com>
Message-ID: <20180820092536.GA8242@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2018 at 10:17:29AM -0400, David Rivshin wrote:
> From: David Rivshin <DRivshin@allworx.com>
> 
> If a pwm-omap-dmtimer is probed before the dmtimer it uses, the platform
> data won't be set yet.
> 
> Fixes: ac30751df953 ("ARM: OMAP: pdata-quirks: Remove unused timer pdata")
> Cc: <stable@vger.kernel.org> # 4.17+
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Ladislav Michl <ladis@linux-mips.org>
> Tested-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v4:
> * Added Ladislav's Acked-by [2]
> * Added Andreas's Tested-by [3]
> Changes in v3:
> * Changed dev_info to dev_dbg
> Changes in v2:
> * Added Pavel's Acked-by/Tested-by [1]
> 
> [1] https://lkml.org/lkml/2018/7/16/346
> [2] https://www.spinics.net/lists/arm-kernel/msg668768.html
> [3] https://www.spinics.net/lists/arm-kernel/msg669302.html
> 
> drivers/pwm/pwm-omap-dmtimer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/d8b05dca/attachment.sig>
