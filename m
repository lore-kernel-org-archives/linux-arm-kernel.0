From: balbi@ti.com (Felipe Balbi)
Date: Wed, 22 Apr 2015 09:20:02 -0500
Subject: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
In-Reply-To: <1429632533-23285-1-git-send-email-tony@atomide.com>
References: <1429632533-23285-1-git-send-email-tony@atomide.com>
Message-ID: <20150422142002.GA22596@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 09:08:53AM -0700, Tony Lindgren wrote:
> Looks like omap_gpio_irq_type can return early at several places
> leaving a GPIO bank enabled without doing pm_runtime_put if wrong
> GPIO arguments are passed.
> 
> Instead of adding more complicated BANK_USED macros, let's fix the
> issue properly. We can pass is_irq flag to omap_enable_gpio_module
> and omap_disble_gpio_module. And with that we can remove all the
> similar code elsewhere to get rid of most BANK_USED macros.
> 
> Note that the reason for the BANK_USED macro is that we need to manage
> PM runtime on per GPIO bank basis. In the long run we want to move to
> using PM runtime counts for each GPIO line to determine if a GPIO
> bank is used. Once we have a solution for omap_enable_gpio_module
> and omap_disable_gpio_module, we can remove the remaining BANK_USED
> macros.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Javier Martinez Canillas <jmartinez@softcrates.net>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

looks ok to my eyes.

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150422/b25463d0/attachment.sig>
