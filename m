From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 22 Nov 2012 22:05:04 +0100
Subject: [PATCH v4 08/11] pwm: pwm-tiehrpwm: Adding TBCLK gating support.
In-Reply-To: <1353503469-18634-9-git-send-email-avinashphilip@ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-9-git-send-email-avinashphilip@ti.com>
Message-ID: <20121122210504.GF16716@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 06:41:05PM +0530, Philip, Avinash wrote:
> Some platforms (like AM33XX) requires clock gating from control module
> explicitly for TBCLK. Enabling of this clock required for the
> functioning of the time base sub module in EHRPWM module. So adding
> optional TBCLK handling if DT node populated with tbclkgating. This
> helps the driver can coexist for Davinci platforms.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> ---
> Changes since v2:
> 	- Remove DT property for tbclkgating
> 	- Use devm_clk_get instead of clk_get
> 
> Changes since v1:
> 	- Moved TBCLK enable from probe to .pwm_enable & disable from
> 	  remove to .pwm_disable
> 
> :100644 100644 23fd3c3... 6e90829... M	drivers/pwm/pwm-tiehrpwm.c
>  drivers/pwm/pwm-tiehrpwm.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Looks good.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/f590fe65/attachment.sig>
