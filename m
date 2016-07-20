From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Jul 2016 12:50:14 +0200
Subject: [PATCH v3] thermal: tango: add resume support
In-Reply-To: <578CC9C9.3050806@free.fr>
References: <57726196.5060909@free.fr>
 <578CC9C9.3050806@free.fr>
Message-ID: <20160720105014.GA17170@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2016 at 02:21:29PM +0200, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> When this platform is suspended, firmware powers the entire SoC down,
> except a few hardware blocks waiting for wakeup events. And there is
> no context to save for this particular block.
> 
> Therefore, there is nothing useful for the driver to do on suspend;
> so we define a NULL suspend hook. On resume, the driver initializes
> the block exactly as is done in the probe callback.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> Changes in v3
> Drop the DEV_PM_OPS macro, which caused some confusion.
> Note: tango_thermal_pm struct only exists when CONFIG_PM_SLEEP is defined
> @Kevin, can I add your Reviewed-by tag back?
> ---
>  drivers/thermal/tango_thermal.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160720/37477eea/attachment.sig>
